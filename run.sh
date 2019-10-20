#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./run.sh num_cores"
  exit 1
fi
echo "======= intrinsic C code ======="
python gflops.py -s "./start_avx512.out" -n $1
echo "========== kernel code ========="
python gflops.py -s "./start_avx512_a.out" -n $1 -k
