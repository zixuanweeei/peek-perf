	.file	"avx512_inline_asm.c"
	.text
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB20:
	.cfi_startproc
#APP
# 7 "avx512_inline_asm.c" 1
	  mov $0xF0000000, %rax 
	.LOOP: 
	  vfmadd132ps %zmm0, %zmm0, %zmm1 
	  vfmadd132ps %zmm1, %zmm1, %zmm2 
	  vfmadd132ps %zmm2, %zmm2, %zmm3 
	  vfmadd132ps %zmm3, %zmm3, %zmm4 
	  vfmadd132ps %zmm4, %zmm4, %zmm5 
	  vfmadd132ps %zmm5, %zmm5, %zmm6 
	  vfmadd132ps %zmm7, %zmm7, %zmm8 
	  vfmadd132ps %zmm8, %zmm8, %zmm9 
	  vfmadd132ps %zmm9, %zmm9, %zmm0 
	  sub $0x1, %rax 
	  jne .LOOP 
	  ret
# 0 "" 2
#NO_APP
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE20:
	.size	main, .-main
	.ident	"GCC: (GNU) 7.3.1 20180303 (Red Hat 7.3.1-5)"
	.section	.note.GNU-stack,"",@progbits
