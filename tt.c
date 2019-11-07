#include <stdio.h>
#include <stdlib.h>
#include <immintrin.h>

int main() {
  float a[16];
  float b[16];
  for (int i = 0; i < 16; ++i) {
    a[i] = rand() % 10 / 5;
    b[i] = rand() % 10 / 5;
  }
  int end = 0;

  // __m512 __a = _mm512_load_ps(a);
  // __m512 __b = _mm512_load_ps(b);

  asm volatile (
    "  vmovups %1, %%zmm0 \n\t"
    "  vmovups %2, %%zmm1 \n\t"
    "  vmovups %0, %%zmm11 \n\t"
    "  vmovups %1, %%zmm12 \n\t"
    "  mov $0xF0000000, %%rax \n\t"
    ".LOOP: \n\t"
    "  vfmadd132ps %%zmm0, %%zmm0, %%zmm1 \n\t"
    "  vfmadd132ps %%zmm1, %%zmm1, %%zmm2 \n\t"
    "  vfmadd132ps %%zmm2, %%zmm2, %%zmm3 \n\t"
    "  vfmadd132ps %%zmm3, %%zmm3, %%zmm4 \n\t"
    "  vfmadd132ps %%zmm4, %%zmm4, %%zmm5 \n\t"
    "  vfmadd132ps %%zmm5, %%zmm5, %%zmm6 \n\t"
    "  vfmadd132ps %%zmm7, %%zmm7, %%zmm8 \n\t"
    "  vfmadd132ps %%zmm8, %%zmm8, %%zmm9 \n\t"
    "  vfmadd132ps %%zmm9, %%zmm9, %%zmm10 \n\t"
    "  vfmadd132ps %%zmm11, %%zmm11, %%zmm12 \n\t"
    "  vfmadd132ps %%zmm12, %%zmm12, %%zmm13 \n\t"
    "  vfmadd132ps %%zmm13, %%zmm13, %%zmm14 \n\t"
    "  vfmadd132ps %%zmm14, %%zmm14, %%zmm15 \n\t"
    "  vfmadd132ps %%zmm15, %%zmm15, %%zmm16 \n\t"
    "  vfmadd132ps %%zmm16, %%zmm16, %%zmm17 \n\t"
    "  vfmadd132ps %%zmm17, %%zmm17, %%zmm18 \n\t"
    "  vfmadd132ps %%zmm18, %%zmm18, %%zmm19 \n\t"
    "  vfmadd132ps %%zmm19, %%zmm19, %%zmm20 \n\t"
    "  vfmadd132ps %%zmm20, %%zmm20, %%zmm21 \n\t"
    "  sub $0x1, %%rax \n\t"
    "  jne .LOOP \n\t"
    "  movw $0x0F, %0"
    : "=m" (end)
    : "m" (a), "m" (b)
  );
  printf("end is %d\n", end);

  return 0;
}
