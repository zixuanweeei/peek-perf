#include <stdio.h>
#include "./start_avx512_a.h"

int main() {
  printf("Start kernel...\n");
  kernel_avx512_fp32();
  printf("Kernel finished...\n");

  return 0;
}