#include <stdio.h>
#include <stdlib.h>

int main() {

  asm volatile (
    "  mov $0xF0000000, %%rax \n\t"
    ".LOOP: \n\t"
    "  vfmadd132ps %%zmm11, %%zmm11, %%zmm12 \n\t"
    "  vfmadd132ps %%zmm12, %%zmm12, %%zmm13 \n\t"
    "  vfmadd132ps %%zmm13, %%zmm13, %%zmm14 \n\t"
    "  vfmadd132ps %%zmm14, %%zmm14, %%zmm15 \n\t"
    "  vfmadd132ps %%zmm15, %%zmm15, %%zmm16 \n\t"
    "  vfmadd132ps %%zmm17, %%zmm17, %%zmm18 \n\t"
    "  vfmadd132ps %%zmm18, %%zmm18, %%zmm19 \n\t"
    "  vfmadd132ps %%zmm19, %%zmm19, %%zmm20 \n\t"
    "  vfmadd132ps %%zmm20, %%zmm20, %%zmm21 \n\t"
    "  sub $0x1, %%rax \n\t"
    "  jne .LOOP \n\t"
    "  ret"
    :
  );

  return 0;
}
