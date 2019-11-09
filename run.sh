#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./run.sh num_cores"
  exit 1
fi
python gflops.py -s "./single_thread" -n $1 -k
