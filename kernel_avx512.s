.globl kernel_avx512_fp32

kernel_avx512_fp32:
    mov $0xF0000000, %rax
    vpxord %zmm0, %zmm0, %zmm0
    vpxord %zmm1, %zmm1, %zmm1
    vpxord %zmm2, %zmm2, %zmm2
    vpxord %zmm3, %zmm3, %zmm3
    vpxord %zmm4, %zmm4, %zmm4
    vpxord %zmm5, %zmm5, %zmm5
    vpxord %zmm6, %zmm6, %zmm6
    vpxord %zmm7, %zmm7, %zmm7
    vpxord %zmm8, %zmm8, %zmm8
    vpxord %zmm9, %zmm9, %zmm9
.kernel.avx512.fp32.L1:
    vaddps %zmm0, %zmm0, %zmm0
    vaddps %zmm1, %zmm1, %zmm1
    vaddps %zmm2, %zmm2, %zmm2
    vaddps %zmm3, %zmm3, %zmm3
    vaddps %zmm4, %zmm4, %zmm4
    vaddps %zmm5, %zmm5, %zmm5
    vaddps %zmm6, %zmm6, %zmm6
    vaddps %zmm7, %zmm7, %zmm7
    vaddps %zmm8, %zmm8, %zmm8
    vaddps %zmm9, %zmm9, %zmm9
    sub $0x1, %rax
    jne .kernel.avx512.fp32.L1
    ret
