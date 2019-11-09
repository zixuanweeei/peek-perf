	.file	"tt.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4757:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	addq	$-128, %rsp
	.cfi_def_cfa_offset 160
	movl	$0, %ebp
	jmp	.L2
.L3:
	call	rand
	movl	%eax, %esi
	movl	$1717986919, %ebx
	imull	%ebx
	sarl	$2, %edx
	movl	%esi, %eax
	sarl	$31, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	leal	(%rcx,%rcx,4), %edx
	leal	(%rdx,%rdx), %eax
	subl	%eax, %esi
	movl	%esi, %ecx
	movl	%esi, %eax
	imull	%ebx
	sarl	%edx
	sarl	$31, %ecx
	subl	%ecx, %edx
	movslq	%ebp, %r12
	pxor	%xmm0, %xmm0
	cvtsi2ss	%edx, %xmm0
	movss	%xmm0, 64(%rsp,%r12,4)
	call	rand
	movl	%eax, %esi
	imull	%ebx
	sarl	$2, %edx
	movl	%esi, %eax
	sarl	$31, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	leal	(%rcx,%rcx,4), %edx
	leal	(%rdx,%rdx), %eax
	subl	%eax, %esi
	movl	%esi, %ecx
	movl	%esi, %eax
	imull	%ebx
	movl	%edx, %ebx
	sarl	%ebx
	sarl	$31, %ecx
	subl	%ecx, %ebx
	pxor	%xmm0, %xmm0
	cvtsi2ss	%ebx, %xmm0
	movss	%xmm0, (%rsp,%r12,4)
	addl	$1, %ebp
.L2:
	cmpl	$15, %ebp
	jle	.L3
#APP
# 16 "tt.c" 1
	  vmovaps %zmm0, 64(%rsp) 
	  vmovaps %zmm1, (%rsp) 
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
	  vfmadd132ps %zmm9, %zmm9, %zmm10 
	  sub $0x1, %rax 
	  jne .LOOP 
	  ret
# 0 "" 2
#NO_APP
	movl	$0, %eax
	subq	$-128, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE4757:
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.1 20170829 (Red Hat 7.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
