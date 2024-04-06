#!/usr/bin/env python3
"""
*   @details:
*       1. Generate 64bit keys and 64bit values from an uniform random distribution to be inserted, removed or queried.
*       2. Evaluation of Insertion: from 0% -> 95% of the total capacity.
*       3. Evaluation of Queries: Positive and Negative questions (50/50).
*       4. Evaluation of Deletion: Remove a selections of keys until the usage reaches ~50%.
*
*   @author: Cristian Sandu <cristian.sandu@tum.de>
"""
import matplotlib.pyplot as plt
from collections import defaultdict

import subprocess, json, tempfile, os

class MBench_1:
    NAME_EXECUTABLE  = f'{os.path.dirname(os.path.abspath(__file__))}/mbench_1'
    RESULT_FILE_NAME = 'generic_output.out'

    def __init__(self, config: dict):
        self.__config     = config
        self.__bresults   = []
    
    def __prepare_dir(self):
        os.makedirs(self.__outputpath, exist_ok=True)

    def __parse_results(self, lines: list[str]) -> dict:
        data = defaultdict(lambda: [])
        for line in lines:
            function_name, thread_id, key_num, key, value, status, start_time, end_time = line.split(' ')
            data[function_name].append(int(int(end_time) - int(start_time)))
        return data

    def __perform_bechmark(self, libso_path: str, config_path: str) -> list[str]:
        process = subprocess.Popen([MBench_1.NAME_EXECUTABLE, libso_path,
                                    config_path, MBench_1.RESULT_FILE_NAME])
        exit_code = process.wait()
        if exit_code != 0: raise Exception(f'MBench_1 filed during execution, exit-code: {exit_code}')
        return self.__parse_results(open(MBench_1.RESULT_FILE_NAME, 'r').readlines())

    def perform_benchmark(self, libso_path: str):
        with tempfile.NamedTemporaryFile(mode='w') as temp:
            json.dump(self.__config, temp)
            temp.flush()
            
            self.__bresults = []
            for _ in range(self.__config['repetitions']):
                self.__bresults.append(self.__perform_bechmark(libso_path=libso_path, config_path=temp.name))

    def plot_results(self, result_name: str):
        self.__outputpath = f"{self.__config['output_path']}/{result_name}"
        self.__prepare_dir()

        self.__plot_dataset_performfill()
        self.__plot_dataset_performquery()

    def __plot_dataset_performfill(self):
        capacity       = self.__config['capacity']
        granularity    = self.__config['granularity']
        repetitions    = self.__config['repetitions']
        filling_factor = self.__config['performfill']['filling_factor']

        average_data = [0] * granularity
        for dataset in self.__bresults:
            data = dataset['dataset_performfill']
            data_index, size_data = [], len(data)
            for i in range(0, granularity): 
                if i == 0:  data_index.append(0)
                else:       data_index.append(size_data * 100 / (capacity) * i/granularity)
                left_range  = int(len(data) * i    /granularity)
                right_range = int(len(data) * (i+1)/granularity)
                average_data[i] += sum(data[left_range : right_range]) / len(data[left_range : right_range])
        average_data = [x/granularity for x in average_data]

        plt.plot(data_index, average_data, marker='o', label='Program Duration')
        plt.xlabel('percentage of ds. usage %')
        plt.ylabel('latency (ns)')
        plt.title(f'[dataset_performfill] latency ds_insert (rep.: {repetitions}, gran.: {granularity}, cap.: {capacity}, fill fact.: {filling_factor})')
        plt.grid(True)
        plt.legend()

        plt.savefig(f'{self.__outputpath}/performfill.png', dpi=300, bbox_inches = "tight")
        plt.show()
        plt.clf()

    def __plot_dataset_performquery(self):
        capacity       = self.__config['capacity']
        granularity    = self.__config['granularity']
        repetitions    = self.__config['repetitions']
        query_factor   = self.__config['performquery']['query_factor']
        success_factor = self.__config['performquery']['success_factor']

        data_index, data_len = [], len(self.__bresults[0]['dataset_performqueries'])
        for i in range(0, granularity): 
            if i == 0:  data_index.append(0)
            else:       data_index.append(data_len * i/granularity)

        average_data = [0] * granularity
        for dataset in self.__bresults:
            data  = dataset['dataset_performqueries']
            for i in range(0, granularity): 
                left_range  = int(len(data) * i    /granularity)
                right_range = int(len(data) * (i+1)/granularity)
                if  len(data[left_range : right_range]) == 0: continue
                average_data[i] += sum(data[left_range : right_range]) / len(data[left_range : right_range])
        average_data = [x/granularity for x in average_data]

        plt.plot(data_index, average_data, marker='o', label='Program Duration')
        plt.xlabel('number of queries')
        plt.ylabel('latency (ns)')
        plt.title(f'[dataset_performquery] latency ds_read (rep.: {repetitions}, gran.: {granularity}, cap.: {capacity}, rate: {query_factor}, succ.: {success_factor*100}%)')
        plt.grid(True)
        plt.legend()

        plt.savefig(f'{self.__outputpath}/performquery.png', dpi=300, bbox_inches = "tight")
        plt.show()
        plt.clf()

    def plot_dataset_performdeletion(data: dict[list], config: dict) -> list[str]:
        data = data['dataset_performdeletion']
        capacity       = config['capacity']

        data_normalized = []
        data_index, size_data = [], len(data)
        for i in range(0, 20): 
            if i == 0:  data_index.append(0)
            else:       data_index.append(size_data * 100 / (capacity) * i/20)
            left_range  = int(len(data) * i/20)
            right_range = int(len(data) * (i+1)/20)
            data_normalized.append(sum(data[left_range : right_range]) / len(data[left_range : right_range]))

        plt.plot(data_index, data_normalized, marker='o', label='Program Duration')
        plt.xlabel('percentage of ds. usage %')
        plt.ylabel('latency (ns)')
        plt.title('[dataset_performfill] latency ds_insert')
        plt.grid(True)
        plt.legend()

        plt.savefig(f'{INITIAL_STR}_performdeletion.png')
        plt.show()
        plt.clf()
