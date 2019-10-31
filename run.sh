#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./run.sh num_cores"
  exit 1
fi
echo "======= intrinsic C code ======="
python gflops.py -s "./avx512_inline_asm.out" -n $1 -k
echo "========== kernel code ========="
python gflops.py -s "./start_avx512_a.out" -n $1 -k
