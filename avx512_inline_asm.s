	.file	"avx512_inline_asm.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
#APP
# 6 "avx512_inline_asm.c" 1
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
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.1 20170829 (Red Hat 7.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
