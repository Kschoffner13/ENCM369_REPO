	.file	"main.c"
	.text
	.comm	arr,400000,32
	.globl	timespec2ns
	.type	timespec2ns, @function
timespec2ns:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC0(%rip), %xmm1
	mulsd	%xmm0, %xmm1
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm1, %xmm0
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	timespec2ns, .-timespec2ns
	.section	.rodata
.LC1:
	.string	"run %d\n"
	.align 8
.LC2:
	.string	"    max from use_pointers: %d\n"
	.align 8
.LC3:
	.string	"    time for use_pointers, in ns: %.2f\n"
.LC4:
	.string	"    max from use_indexes: %d\n"
	.align 8
.LC5:
	.string	"    time for use_indexes, in ns: %.2f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -60(%rbp)
	jmp	.L4
.L5:
	movl	-60(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	leaq	arr(%rip), %rax
	movl	-60(%rbp), %edx
	movl	%edx, (%rcx,%rax)
	addl	$1, -60(%rbp)
.L4:
	cmpl	$99999, -60(%rbp)
	jle	.L5
	movl	$1, -56(%rbp)
	jmp	.L6
.L7:
	movl	-56(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$3, %edi
	call	clock_gettime@PLT
	movl	$100000, %esi
	leaq	arr(%rip), %rdi
	call	use_pointers@PLT
	movl	%eax, -52(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$3, %edi
	call	clock_gettime@PLT
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	timespec2ns
	movsd	%xmm0, -72(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	timespec2ns
	movsd	-72(%rbp), %xmm1
	subsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	leaq	.LC3(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	movl	$3, %edi
	call	clock_gettime@PLT
	movl	$100000, %esi
	leaq	arr(%rip), %rdi
	call	use_indexes@PLT
	movl	%eax, -52(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$3, %edi
	call	clock_gettime@PLT
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	timespec2ns
	movsd	%xmm0, -72(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	timespec2ns
	movsd	-72(%rbp), %xmm2
	subsd	%xmm0, %xmm2
	movapd	%xmm2, %xmm0
	leaq	.LC5(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	addl	$1, -56(%rbp)
.L6:
	cmpl	$10, -56(%rbp)
	jle	.L7
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
