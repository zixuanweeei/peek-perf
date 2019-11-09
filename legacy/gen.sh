#!/bin/bash
as -o kernel_avx512.out kernel_avx512.s
/opt/intel/bin/icc -o start_avx512_a.out start_avx512_a.c kernel_avx512.out -O2
/opt/intel/bin/icc -o start_avx512.out start_avx512.c -O2
