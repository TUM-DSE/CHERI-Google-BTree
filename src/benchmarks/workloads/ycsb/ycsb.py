#!/usr/bin/env python3
"""
*   @author: Cristian Sandu <cristian.sandu@tum.de>
"""
from collections import defaultdict
import tempfile, os, subprocess, json, os
from src.benchmarks.benchmarks import IBenchmarks
import math


class YCSB(object):
    NAME_EXECUTABLE  = f'{os.path.dirname(os.path.abspath(__file__))}/ycsb'

    def __init__(self, config: dict):
        self.__config = config
    
    def perform_perf(self, libso_path: str, output_path: str):
        # ths is not implemented for YCSB, no needed.
        print(libso_path, output_path)
        
    def __perform_workload(self, libso_path: str, config_path: str, workload: str):
        process_args = [YCSB.NAME_EXECUTABLE, '-P', f'{config_path}', '-run']
        if self.__config['phase_load']: process_args += ['-load']
        
        print(' '.join(process_args))
        process = subprocess.Popen(process_args, stdout=subprocess.PIPE)
        exit_code = process.wait()
        if exit_code != 0:
            os.system(f"cp {config_path} .")
            raise Exception(f'YCSB filed during execution, exit-code: {exit_code} for workload {workload}')
        return [line.decode().rstrip() for line in process.stdout]
        
    def __extract_results(self, results: str) -> dict:
        return {
            'run_operations':  int  (results[4].split(': ')[1]),
            'run_thoroughput': float(results[5].split(': ')[1])
        }

    def perform_benchmark(self, libso_path: str, output_path: str):
        os.makedirs(output_path, exist_ok=True)

        bresults = defaultdict(lambda: [])
        for workload, config_workload in self.__config['workloads'].items():
            with tempfile.NamedTemporaryFile(mode='w') as temp:
                for key, value in config_workload.items():
                    temp.write(f'{key}={value}\n')
                temp.write(f'libpath={os.getcwd()}/{libso_path}')
                temp.flush()

                for _ in range(self.__config['repetitions']):
                    results = self.__perform_workload(libso_path=libso_path, config_path=temp.name, workload=workload)
                    bresults[workload].append(
                        self.__extract_results(results)
                    )

                # calculate the variance for thoroughput
                values = [x['run_thoroughput'] for x in bresults[workload]]
                mean_value = sum(values) / self.__config['repetitions']
                squared_diffs = math.sqrt(sum([(x - mean_value)**2 for x in values]))
                bresults[workload] = {
                    'run_operations':   sum([x['run_operations']  for x in bresults[workload]]) / self.__config['repetitions'],
                    'run_thoroughput':  sum([x['run_thoroughput'] for x in bresults[workload]]) / self.__config['repetitions'],
                    'run_thoroughput_var':  squared_diffs / self.__config['repetitions']
                }
            
        json.dump(bresults, open(f'{output_path}/workload.json', 'w'))
