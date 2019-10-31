	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -84(%rbp)
	## InlineAsm Start
	movabsq	$4026531840, %rax       ## imm = 0xF0000000
.LOOP:
	vfmadd132ps	%zmm0, %zmm0, %zmm1 ## zmm1 = (zmm1 * zmm0) + zmm0
	vfmadd132ps	%zmm1, %zmm1, %zmm2 ## zmm2 = (zmm2 * zmm1) + zmm1
	vfmadd132ps	%zmm2, %zmm2, %zmm3 ## zmm3 = (zmm3 * zmm2) + zmm2
	vfmadd132ps	%zmm3, %zmm3, %zmm4 ## zmm4 = (zmm4 * zmm3) + zmm3
	vfmadd132ps	%zmm4, %zmm4, %zmm5 ## zmm5 = (zmm5 * zmm4) + zmm4
	vfmadd132ps	%zmm5, %zmm5, %zmm6 ## zmm6 = (zmm6 * zmm5) + zmm5
	vfmadd132ps	%zmm7, %zmm7, %zmm8 ## zmm8 = (zmm8 * zmm7) + zmm7
	vfmadd132ps	%zmm8, %zmm8, %zmm9 ## zmm9 = (zmm9 * zmm8) + zmm8
	vfmadd132ps	%zmm9, %zmm9, %zmm0 ## zmm0 = (zmm0 * zmm9) + zmm9
	subq	$1, %rax
	jne	.LOOP
	vmovaps	(%rax), %zmm0
	retq
	## InlineAsm End
	movq	%rax, -80(%rbp)
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	cmpq	%rcx, %rax
	jne	LBB0_2
## %bb.1:
	xorl	%eax, %eax
	addq	$96, %rsp
	popq	%rbp
	retq
LBB0_2:
	callq	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
