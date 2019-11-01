	.file	"avx512_inline_asm_pthread.cc"
	.text
	.type	_Z41__static_initialization_and_destruction_0ii, @function
_Z41__static_initialization_and_destruction_0ii:
.LFB3186:
	.cfi_startproc
	cmpl	$1, %edi
	je	.L7
.L4:
	rep ret
.L7:
	cmpl	$65535, %esi
	jne	.L4
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$_ZStL8__ioinit, %edi
	call	_ZNSt8ios_base4InitC1Ev
	movl	$__dso_handle, %edx
	movl	$_ZStL8__ioinit, %esi
	movl	$_ZNSt8ios_base4InitD1Ev, %edi
	call	__cxa_atexit
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE3186:
	.size	_Z41__static_initialization_and_destruction_0ii, .-_Z41__static_initialization_and_destruction_0ii
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"WARNING: Could not set CPU affinity, continuing..."
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Bind process #"
.LC2:
	.string	" to CPU #"
.LC3:
	.string	"Process #"
.LC4:
	.string	" ended.\n"
	.text
	.globl	_Z13do_cpu_stressi
	.type	_Z13do_cpu_stressi, @function
_Z13do_cpu_stressi:
.LFB2721:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$152, %rsp
	.cfi_def_cfa_offset 176
	movl	%edi, %ebp
	movl	$0, %ebx
.L10:
	leal	-1(%rbp), %eax
	cmpl	%ebx, %eax
	jle	.L9
	call	fork
	testl	%eax, %eax
	je	.L9
	addl	$1, %ebx
	jmp	.L10
.L9:
	movl	%ebp, %edx
	shrl	$31, %edx
	addl	%ebp, %edx
	sarl	%edx
	leal	-1(%rdx), %eax
	cmpl	%ebx, %eax
	jge	.L18
	addl	%ebx, %edx
.L11:
	movl	%edx, 140(%rsp)
	movq	%rsp, %rsi
	movl	$16, %ecx
	movl	$0, %eax
	movq	%rsi, %rdi
	rep stosq
	movslq	%edx, %rax
	cmpq	$1023, %rax
	ja	.L12
	shrq	$6, %rax
	movl	$1, %esi
	movl	%edx, %ecx
	salq	%cl, %rsi
	orq	%rsi, (%rsp,%rax,8)
.L12:
	movq	%rsp, %rdx
	movl	$128, %esi
	movl	$0, %edi
	call	sched_setaffinity
	cmpl	$-1, %eax
	je	.L20
	movl	$14, %edx
	movl	$.LC1, %esi
	movl	$_ZSt4cout, %edi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movl	%ebx, %esi
	movl	$_ZSt4cout, %edi
	call	_ZNSolsEi
	movq	%rax, %rbx
	movl	$9, %edx
	movl	$.LC2, %esi
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movl	140(%rsp), %esi
	movq	%rbx, %rdi
	call	_ZNSolsEi
	movq	%rax, %rbp
	movq	(%rax), %rax
	movq	%rbp, %rcx
	addq	-24(%rax), %rcx
	movq	240(%rcx), %rbx
	testq	%rbx, %rbx
	je	.L21
	cmpb	$0, 56(%rbx)
	je	.L16
	movzbl	67(%rbx), %eax
.L17:
	movsbl	%al, %esi
	movq	%rbp, %rdi
	call	_ZNSo3putEc
	movq	%rax, %rdi
	call	_ZNSo5flushEv
.L14:
#APP
# 50 "avx512_inline_asm_pthread.cc" 1
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
	  movl 140(%rsp), %ebx
# 0 "" 2
#NO_APP
	movl	$9, %edx
	movl	$.LC3, %esi
	movl	$_ZSt4cout, %edi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movl	%ebx, %esi
	movl	$_ZSt4cout, %edi
	call	_ZNSolsEi
	movl	$8, %edx
	movl	$.LC4, %esi
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	addq	$152, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L18:
	.cfi_restore_state
	movl	%ebx, %edx
	jmp	.L11
.L20:
	movl	$50, %edx
	movl	$.LC0, %esi
	movl	$_ZSt4cout, %edi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	jmp	.L14
.L21:
	call	_ZSt16__throw_bad_castv
.L16:
	movq	%rbx, %rdi
	call	_ZNKSt5ctypeIcE13_M_widen_initEv
	movq	(%rbx), %rax
	movl	$10, %esi
	movq	%rbx, %rdi
	call	*48(%rax)
	jmp	.L17
	.cfi_endproc
.LFE2721:
	.size	_Z13do_cpu_stressi, .-_Z13do_cpu_stressi
	.section	.rodata.str1.1
.LC5:
	.string	"This device has "
.LC6:
	.string	" cores.\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2722:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	call	_ZNSt6thread20hardware_concurrencyEv
	shrl	%eax
	movl	%eax, %ebx
	movl	$16, %edx
	movl	$.LC5, %esi
	movl	$_ZSt4cout, %edi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l
	movl	%ebx, %esi
	movl	$_ZSt4cout, %edi
	call	_ZNSolsEi
	movl	$.LC6, %esi
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc
	movl	%ebx, %edi
	call	_Z13do_cpu_stressi
	movl	$0, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE2722:
	.size	main, .-main
	.type	_GLOBAL__sub_I__Z13do_cpu_stressi, @function
_GLOBAL__sub_I__Z13do_cpu_stressi:
.LFB3187:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$65535, %esi
	movl	$1, %edi
	call	_Z41__static_initialization_and_destruction_0ii
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE3187:
	.size	_GLOBAL__sub_I__Z13do_cpu_stressi, .-_GLOBAL__sub_I__Z13do_cpu_stressi
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z13do_cpu_stressi
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.hidden	__dso_handle
	.ident	"GCC: (GNU) 7.2.1 20170829 (Red Hat 7.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
