	.file	"start_avx512.c"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"sizeof(__m512) = %d\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"Memory alignment failed. Exists."
	.section	.rodata.str1.1
.LC3:
	.string	"LOOP start..."
.LC4:
	.string	"LOOP end..."
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB4757:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp
	movl	$64, %esi
	movl	$.LC0, %edi
	xorl	%eax, %eax
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x78,0x6
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x70
	xorl	%ebx, %ebx
	subq	$288, %rsp
	call	printf
.L2:
	call	rand
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2ss	%eax, %xmm0, %xmm0
	vmulss	.LC1(%rip), %xmm0, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, -240(%rbp,%rbx)
	call	rand
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2ss	%eax, %xmm0, %xmm0
	vmulss	.LC1(%rip), %xmm0, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, -176(%rbp,%rbx)
	call	rand
	vxorps	%xmm0, %xmm0, %xmm0
	vcvtsi2ss	%eax, %xmm0, %xmm0
	vmulss	.LC1(%rip), %xmm0, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, -112(%rbp,%rbx)
	addq	$4, %rbx
	cmpq	$64, %rbx
	jne	.L2
	leaq	-248(%rbp), %rdi
	movl	$640000000, %edx
	movl	$16, %esi
	call	posix_memalign
	testl	%eax, %eax
	je	.L13
.L3:
	movl	$.LC2, %edi
	xorl	%eax, %eax
	call	printf
.L5:
	addq	$288, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L13:
	.cfi_restore_state
	movq	-248(%rbp), %rbx
	testq	%rbx, %rbx
	je	.L3
	movl	$.LC3, %edi
	call	puts
	vmovaps	-240(%rbp), %zmm3
	leaq	639999936(%rbx), %rdx
	movl	$100, %ecx
	vmovaps	-176(%rbp), %zmm5
	vmovaps	-112(%rbp), %zmm6
	vaddps	%zmm5, %zmm3, %zmm4
	.p2align 4,,10
	.p2align 3
.L8:
	vmovaps	%zmm4, (%rbx)
	vmovaps	%zmm4, %zmm0
	movq	%rbx, %rax
	vmovaps	%zmm6, %zmm2
	vmovaps	%zmm5, %zmm1
	.p2align 4,,10
	.p2align 3
.L7:
	vaddps	%zmm1, %zmm3, %zmm1
	addq	$64, %rax
	vmulps	%zmm1, %zmm2, %zmm2
	vaddps	%zmm2, %zmm0, %zmm0
	vmovaps	%zmm0, (%rax)
	vaddps	-64(%rax), %zmm0, %zmm1
	cmpq	%rax, %rdx
	jne	.L7
	subl	$1, %ecx
	jne	.L8
	movl	$.LC4, %edi
	call	puts
	movq	%rbx, %rdi
	call	free
	jmp	.L5
	.cfi_endproc
.LFE4757:
	.size	main, .-main
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	805306368
	.ident	"GCC: (GNU) 7.2.1 20170829 (Red Hat 7.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
