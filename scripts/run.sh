#! /usr/bin/env bash

# on Non-Nixos machines replace with classic /bin/bash


# This script should take as parameter (cli or experiment file) the workload(s) and the data structure(s) to run the experiment on.
# We consider a run as one execution of one workload with given parameters. Run should be replicated at least 3 if not 5 times to account for variability in the results.
# This script should store the output of the run as-is. Another script should take care of transforming the raw data into plots.
