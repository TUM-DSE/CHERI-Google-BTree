#!/usr/bin/env python3
"""
*   @author: Cristian Sandu <cristian.sandu@tum.de>
"""
from collections import defaultdict
import tempfile, os, subprocess, json, os

class YCSB(object):
    NAME_EXECUTABLE  = f'{os.path.dirname(os.path.abspath(__file__))}/ycsb'

    def __init__(self, config: dict):
        self.__config = config
    
    def __perform_workload(self, libso_path: str, config_path: str, workload: str):
        process_args = [YCSB.NAME_EXECUTABLE, '-P', f'{config_path}', '-run']
        if self.__config['phase_load']: process_args += ['-load']
        
        process = subprocess.Popen(process_args, stdout=subprocess.PIPE)
        exit_code = process.wait()
        if exit_code != 0: raise Exception(f'YCSB filed during execution, exit-code: {exit_code} for workload {workload}')
        return [line.decode().rstrip() for line in process.stdout]
        
    def __extract_results(self, results: str) -> dict:
        return {
            'run_runtime':     float(results[0].split(': ')[1]),
            'run_operations':  int  (results[1].split(': ')[1]),
            'run_thoroughput': float(results[2].split(': ')[1])
        }

    def perform_workload(self, libso_path: str):
        with tempfile.NamedTemporaryFile(mode='w') as temp:     
            self.__bresults = defaultdict(lambda: [])
            for workload, config_workload in self.__config['workloads'].items():
                for key, value in config_workload.items():
                    temp.write(f'{key}={value}\n')
                temp.write(f'libpath={os.getcwd()}/{libso_path}')
                temp.flush()

                for _ in range(self.__config['repetitions']):
                    results = self.__perform_workload(libso_path=libso_path, config_path=temp.name, workload=workload)
                    self.__bresults[workload].append(
                        self.__extract_results(results)
                    )
                self.__bresults[workload] = {
                    'run_runtime':      sum([x['run_runtime']     for x in self.__bresults[workload]]) / self.__config['repetitions'],
                    'run_operations':   sum([x['run_operations']  for x in self.__bresults[workload]]) / self.__config['repetitions'],
                    'run_thoroughput':  sum([x['run_thoroughput'] for x in self.__bresults[workload]]) / self.__config['repetitions']
                }

    def save_results(self):
        for workload in self.__config['workloads']:
            outputpath = f'{self.__config["output_path"]}'
            os.makedirs(outputpath, exist_ok=True)
            json.dump(self.__bresults[workload], open(f'{outputpath}/{workload}.json', 'w'), indent=4)