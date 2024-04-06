#!/usr/bin/env python3
import argparse, json
from src.services import Benchmark

def fetch_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--config', help='path to the configuration file.',
                        required=True, type=str)
    return parser.parse_args()

def read_config(filename: str) -> dict:
    return json.load(open(filename))

def perform_benchmarks(config: dict):
    if 'mbench_1' in config:
        from src.benchmarks.microbenchmarks import MBench_1
        mbench1 = MBench_1(config=config['mbench_1'])
        for ds, path in config['target'].items():
            if ds.startswith('__'): continue
            mbench1.perform_benchmark(libso_path=path)
            mbench1.plot_results(result_name=ds)

def main():
    args   = fetch_args()
    config = read_config(filename=args.config)
    perform_benchmarks(config=config)

if __name__ == '__main__':
    main()