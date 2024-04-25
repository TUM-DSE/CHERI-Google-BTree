#!/usr/bin/env python3
"""
    Benchmarks Interface
"""
class IPlotter(object):
    def plot_results(self):
        raise NotImplemented()
    
    def evaluate_statics(self, config: dict, dir: str):
        raise NotImplemented()