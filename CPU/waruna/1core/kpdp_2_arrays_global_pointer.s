	.file	"kpdp_2_arrays_global_pointer.c"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.type	_mm_malloc.constprop.1, @function
_mm_malloc.constprop.1:
.LFB2248:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rdx
	movl	$32, %esi
	leaq	8(%rsp), %rdi
	call	posix_memalign
	xorl	%edx, %edx
	testl	%eax, %eax
	cmove	8(%rsp), %rdx
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	movq	%rdx, %rax
	ret
	.cfi_endproc
.LFE2248:
	.size	_mm_malloc.constprop.1, .-_mm_malloc.constprop.1
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	oneThread
	.type	oneThread, @function
oneThread:
.LFB2245:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	movq	comb(%rip), %rax
	andq	$-32, %rsp
	movslq	%edi, %rdx
	testl	%edi, %edi
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x60,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x78
	.cfi_escape 0x10,0xd,0x2,0x76,0x70
	.cfi_escape 0x10,0xc,0x2,0x76,0x68
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
	movq	(%rax,%rdx,8), %r8
	movq	8(%rax,%rdx,8), %r9
	jne	.L6
	movq	cur(%rip), %rdi
	movq	pre(%rip), %rsi
.L7:
	movl	N(%rip), %eax
	xorl	%r10d, %r10d
	xorl	%ecx, %ecx
	testl	%eax, %eax
	jle	.L26
	.p2align 4,,10
	.p2align 3
.L25:
	movq	p(%rip), %rax
	xorl	%ebx, %ebx
	vbroadcastss	(%rax,%r10), %ymm0
	movq	w(%rip), %rax
	movslq	(%rax,%r10), %r11
	xorl	%eax, %eax
	testl	%r11d, %r11d
	jle	.L12
	.p2align 4,,10
	.p2align 3
.L21:
	movl	w_max(%rip), %edx
	imull	%ecx, %edx
	addl	%ebx, %edx
	addl	$32, %ebx
	movslq	%edx, %rdx
	leaq	0(,%rdx,4), %r12
	vpaddd	(%r8,%rdx,4), %ymm0, %ymm4
	vpmaxsd	(%rsi,%rax), %ymm4, %ymm4
	vpaddd	32(%r8,%r12), %ymm0, %ymm3
	vpaddd	64(%r8,%r12), %ymm0, %ymm2
	vpmaxsd	32(%rsi,%rax), %ymm3, %ymm3
	vpmaxsd	64(%rsi,%rax), %ymm2, %ymm2
	vpaddd	96(%r8,%r12), %ymm0, %ymm1
	vpmaxsd	96(%rsi,%rax), %ymm1, %ymm1
	vmovdqa	%ymm4, (%rdi,%rax)
	vmovdqa	%ymm3, 32(%rdi,%rax)
	vmovdqa	%ymm2, 64(%rdi,%rax)
	vmovdqa	%ymm1, 96(%rdi,%rax)
	subq	$-128, %rax
	cmpl	%ebx, %r11d
	jg	.L21
.L12:
	movl	C(%rip), %r14d
	movl	%r14d, %eax
	subl	%r11d, %eax
	cmpl	%eax, %r11d
	jge	.L11
	movslq	%r11d, %rdx
	movq	%rsi, %r12
	movl	%r11d, %r13d
	salq	$2, %rdx
	leaq	(%rsi,%rdx), %rbx
	addq	%rdi, %rdx
	.p2align 4,,10
	.p2align 3
.L13:
	vpaddd	(%r12), %ymm0, %ymm4
	vpaddd	32(%r12), %ymm0, %ymm3
	vpaddd	64(%r12), %ymm0, %ymm2
	vpaddd	96(%r12), %ymm0, %ymm1
	vpmaxsd	(%rbx), %ymm4, %ymm4
	vpmaxsd	32(%rbx), %ymm3, %ymm3
	vpmaxsd	64(%rbx), %ymm2, %ymm2
	vpmaxsd	96(%rbx), %ymm1, %ymm1
	vmovdqa	%ymm4, (%rdx)
	vmovdqa	%ymm3, 32(%rdx)
	addl	$32, %r13d
	subq	$-128, %r12
	vmovdqa	%ymm2, 64(%rdx)
	subq	$-128, %rbx
	subq	$-128, %rdx
	vmovdqa	%ymm1, -32(%rdx)
	movl	C(%rip), %r14d
	movl	%r14d, %eax
	subl	%r11d, %eax
	cmpl	%r13d, %eax
	jg	.L13
.L11:
	cmpl	%r14d, %eax
	jge	.L18
	movslq	%eax, %rdx
	movq	%rdx, %rbx
	salq	$2, %rdx
	subq	%r11, %rbx
	leaq	(%rsi,%rdx), %r11
	addq	%rdi, %rdx
	leaq	(%rsi,%rbx,4), %rbx
	.p2align 4,,10
	.p2align 3
.L17:
	vpaddd	(%rbx), %ymm0, %ymm4
	vpaddd	32(%rbx), %ymm0, %ymm3
	vpaddd	64(%rbx), %ymm0, %ymm2
	vpaddd	96(%rbx), %ymm0, %ymm1
	vpmaxsd	(%r11), %ymm4, %ymm4
	vpmaxsd	32(%r11), %ymm3, %ymm3
	vpmaxsd	64(%r11), %ymm2, %ymm2
	vpmaxsd	96(%r11), %ymm1, %ymm1
	vmovdqa	%ymm4, (%rdx)
	vmovdqa	%ymm3, 32(%rdx)
	subq	$-128, %rbx
	subq	$-128, %r11
	vmovdqa	%ymm2, 64(%rdx)
	subq	$-128, %rdx
	vmovdqa	%ymm1, -32(%rdx)
	movl	w_max(%rip), %r12d
	imull	%ecx, %r12d
	addl	%eax, %r12d
	movslq	%r12d, %r12
	vmovdqa	%ymm4, (%r9,%r12,4)
	movl	w_max(%rip), %r12d
	imull	%ecx, %r12d
	addl	%eax, %r12d
	movslq	%r12d, %r12
	vmovdqa	%ymm3, 32(%r9,%r12,4)
	movl	w_max(%rip), %r12d
	imull	%ecx, %r12d
	addl	%eax, %r12d
	movslq	%r12d, %r12
	vmovdqa	%ymm2, 64(%r9,%r12,4)
	movl	w_max(%rip), %r12d
	imull	%ecx, %r12d
	addl	%eax, %r12d
	addl	$32, %eax
	movslq	%r12d, %r12
	vmovdqa	%ymm1, 96(%r9,%r12,4)
	cmpl	%eax, C(%rip)
	jg	.L17
.L18:
	addl	$1, %ecx
	addq	$4, %r10
	cmpl	%ecx, N(%rip)
	movq	%rsi, %rax
	movq	%rdi, %rsi
	jle	.L29
	movq	%rax, %rdi
	jmp	.L25
.L29:
	vzeroupper
.L26:
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L6:
	.cfi_restore_state
	leal	-1(%rdi), %esi
	imull	c_per_thread(%rip), %esi
	addl	c_per_first_thread(%rip), %esi
	movslq	%esi, %rsi
	salq	$2, %rsi
	movq	%rsi, %rdi
	addq	pre(%rip), %rsi
	addq	cur(%rip), %rdi
	jmp	.L7
	.cfi_endproc
.LFE2245:
	.size	oneThread, .-oneThread
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.unlikely
.LCOLDB2:
	.text
.LHOTB2:
	.p2align 4,,15
	.globl	mykernel
	.type	mykernel, @function
mykernel:
.LFB2244:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	xorl	%edi, %edi
	call	oneThread
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE2244:
	.size	mykernel, .-mykernel
	.section	.text.unlikely
.LCOLDE2:
	.text
.LHOTE2:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"r"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"[ERROR] : Failed to read file named '%s'.\n"
	.align 8
.LC5:
	.string	"USAGE : %s [num threads] [filename].\n"
	.section	.rodata.str1.1
.LC6:
	.string	"%d %d"
	.section	.rodata.str1.8
	.align 8
.LC7:
	.string	"The number of objects is %d, and the capacity is %d.\n"
	.align 8
.LC8:
	.string	"[ERROR] : Failed to allocate memory for weights/profits."
	.align 8
.LC9:
	.string	"[ERROR] : Input file is not well formatted."
	.section	.rodata.str1.1
.LC10:
	.string	"w_max actual: %d\n"
.LC11:
	.string	"w_max padded: %d\n"
	.section	.rodata.str1.8
	.align 8
.LC12:
	.string	"c_per_thread: %d c_per_first_thread: %d \n"
	.section	.rodata.str1.1
.LC13:
	.string	"run1: %d\n"
.LC14:
	.string	"run2: %d\n"
	.section	.rodata.str1.8
	.align 8
.LC18:
	.string	"Threads: %d ArraySize: %d time: %.2f s GOPS: %.2f time01: %.2f s GOPS01: %.2f N: %d, BW: %.2f max_wi: %d\n"
	.section	.rodata.str1.1
.LC19:
	.string	"run3: %d\n"
	.section	.text.unlikely
.LCOLDB20:
	.section	.text.startup,"ax",@progbits
.LHOTB20:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB2243:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	movq	%rsi, %r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	pushq	%rbx
	subq	$32, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	cmpl	$2, %edi
	movl	$1, tds(%rip)
	movl	$17777770, N(%rip)
	movl	$1152, C(%rip)
	jle	.L33
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol
	movq	16(%r12), %rdi
	movl	$.LC3, %esi
	movl	%eax, tds(%rip)
	call	fopen
	testq	%rax, %rax
	movq	%rax, %rbx
	je	.L173
	movl	$C, %ecx
	movq	%rax, %rdi
	movl	$N, %edx
	movl	$.LC6, %esi
	xorl	%eax, %eax
	call	__isoc99_fscanf
	movl	C(%rip), %edx
	movl	N(%rip), %esi
	movl	$.LC7, %edi
	xorl	%eax, %eax
	call	printf
	movslq	N(%rip), %rdi
	salq	$2, %rdi
	call	_mm_malloc.constprop.1
	movslq	N(%rip), %rdi
	movq	%rax, w(%rip)
	salq	$2, %rdi
	call	_mm_malloc.constprop.1
	movq	%rax, %rcx
	movq	%rax, p(%rip)
	movq	w(%rip), %rax
	testq	%rcx, %rcx
	je	.L35
	testq	%rax, %rax
	je	.L35
	movl	N(%rip), %edx
	testl	%edx, %edx
	jle	.L36
	xorl	%r12d, %r12d
	jmp	.L37
	.p2align 4,,10
	.p2align 3
.L175:
	movq	p(%rip), %rcx
	movq	w(%rip), %rax
.L37:
	leaq	0(,%r12,4), %rdx
	movl	$.LC6, %esi
	movq	%rbx, %rdi
	addq	%rdx, %rcx
	addq	%rax, %rdx
	xorl	%eax, %eax
	call	__isoc99_fscanf
	cmpl	$2, %eax
	jne	.L174
	leal	1(%r12), %eax
	addq	$1, %r12
	cmpl	%eax, N(%rip)
	jg	.L175
.L36:
	movq	%rbx, %rdi
	call	fclose
	movl	N(%rip), %r8d
	xorl	%edx, %edx
	movq	w(%rip), %rdi
	testl	%r8d, %r8d
	jle	.L39
	movq	%rdi, %rax
	andl	$31, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$7, %eax
	cmpl	%r8d, %eax
	cmova	%r8d, %eax
	cmpl	$10, %r8d
	jg	.L176
	movl	%r8d, %eax
.L90:
	cmpl	$0, (%rdi)
	movl	$0, %edx
	cmovns	(%rdi), %edx
	cmpl	$1, %eax
	je	.L95
	movl	4(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	cmpl	$2, %eax
	je	.L96
	movl	8(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	cmpl	$3, %eax
	je	.L97
	movl	12(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	cmpl	$4, %eax
	je	.L98
	movl	16(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	cmpl	$5, %eax
	je	.L99
	movl	20(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	cmpl	$6, %eax
	je	.L100
	movl	24(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	cmpl	$7, %eax
	je	.L101
	movl	28(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	cmpl	$8, %eax
	je	.L102
	movl	32(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	cmpl	$10, %eax
	jne	.L103
	movl	36(%rdi), %ecx
	cmpl	%ecx, %edx
	cmovl	%ecx, %edx
	movl	$10, %ecx
.L43:
	cmpl	%eax, %r8d
	je	.L39
.L42:
	movl	%r8d, %r10d
	leal	-1(%r8), %r9d
	movl	%eax, %ebx
	subl	%eax, %r10d
	leal	-8(%r10), %esi
	subl	%eax, %r9d
	shrl	$3, %esi
	addl	$1, %esi
	cmpl	$6, %r9d
	leal	0(,%rsi,8), %r11d
	jbe	.L45
	movl	%edx, -72(%rbp)
	leaq	(%rdi,%rbx,4), %r9
	xorl	%eax, %eax
	vbroadcastss	-72(%rbp), %ymm0
.L46:
	movq	%rax, %rdx
	addq	$1, %rax
	salq	$5, %rdx
	cmpl	%eax, %esi
	vpmaxsd	(%r9,%rdx), %ymm0, %ymm0
	ja	.L46
	vperm2i128	$1, %ymm0, %ymm0, %ymm1
	addl	%r11d, %ecx
	cmpl	%r11d, %r10d
	vpmaxsd	%ymm1, %ymm0, %ymm0
	vpsrldq	$8, %ymm0, %ymm1
	vpmaxsd	%ymm1, %ymm0, %ymm0
	vpsrldq	$4, %ymm0, %ymm1
	vpmaxsd	%ymm1, %ymm0, %ymm0
	vmovd	%xmm0, %edx
	je	.L162
	vzeroupper
.L45:
	movslq	%ecx, %rax
	movl	(%rdi,%rax,4), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	leal	1(%rcx), %eax
	cmpl	%eax, %r8d
	jle	.L39
	cltq
	movl	(%rdi,%rax,4), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	leal	2(%rcx), %eax
	cmpl	%eax, %r8d
	jle	.L39
	cltq
	movl	(%rdi,%rax,4), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	leal	3(%rcx), %eax
	cmpl	%eax, %r8d
	jle	.L39
	cltq
	movl	(%rdi,%rax,4), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	leal	4(%rcx), %eax
	cmpl	%eax, %r8d
	jle	.L39
	cltq
	movl	(%rdi,%rax,4), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	leal	5(%rcx), %eax
	cmpl	%eax, %r8d
	jle	.L39
	cltq
	movl	(%rdi,%rax,4), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	leal	6(%rcx), %eax
	cmpl	%eax, %r8d
	jle	.L39
	cltq
	movl	(%rdi,%rax,4), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
.L39:
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	movl	$.LC10, %esi
	movl	%edx, w_max(%rip)
	call	fprintf
	movl	w_max(%rip), %edx
	testb	$31, %dl
	jne	.L177
.L51:
	movq	stderr(%rip), %rdi
	movl	$.LC11, %esi
	xorl	%eax, %eax
	movl	%edx, w_max(%rip)
	call	fprintf
	movslq	C(%rip), %rdi
	salq	$2, %rdi
	call	_mm_malloc.constprop.1
	movslq	C(%rip), %rdi
	movq	%rax, cur(%rip)
	salq	$2, %rdi
	call	_mm_malloc.constprop.1
	movl	tds(%rip), %r12d
	movq	%rax, pre(%rip)
	leal	1(%r12), %edi
	movslq	%edi, %rdi
	salq	$3, %rdi
	call	malloc
	testl	%r12d, %r12d
	movq	%rax, comb(%rip)
	js	.L56
	movslq	w_max(%rip), %r13
	movslq	N(%rip), %rdx
	xorl	%ebx, %ebx
	xorl	%r14d, %r14d
	imulq	%rdx, %r13
	salq	$2, %r13
	jmp	.L57
	.p2align 4,,10
	.p2align 3
.L178:
	movq	comb(%rip), %rax
.L57:
	leaq	-56(%rbp), %rdi
	movq	%r13, %rdx
	movl	$32, %esi
	leaq	(%rax,%rbx,8), %r15
	call	posix_memalign
	testl	%eax, %eax
	movq	%r14, %rax
	cmove	-56(%rbp), %rax
	addq	$1, %rbx
	cmpl	%ebx, %r12d
	movq	%rax, (%r15)
	jge	.L178
.L56:
	movl	C(%rip), %ecx
	movl	$.LC12, %edi
	movl	%ecx, %eax
	cltd
	idivl	%r12d
	movl	$1, %edx
	subl	%r12d, %edx
	imull	%eax, %edx
	movl	%eax, %esi
	movl	%eax, c_per_thread(%rip)
	xorl	%eax, %eax
	addl	%ecx, %edx
	movl	%edx, c_per_first_thread(%rip)
	call	printf
	movl	w_max(%rip), %edx
	movq	comb(%rip), %rdi
	xorl	%esi, %esi
	imull	N(%rip), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	call	memset
	movslq	C(%rip), %rdx
	movq	pre(%rip), %rdi
	xorl	%esi, %esi
	salq	$2, %rdx
	call	memset
	call	initialize_timer
	call	start_timer
	xorl	%edi, %edi
	call	oneThread
	call	stop_timer
	movl	C(%rip), %edi
	xorl	%edx, %edx
	testl	%edi, %edi
	jle	.L54
	movq	cur(%rip), %rcx
	movq	pre(%rip), %rsi
	movq	%rcx, %rax
	andl	$31, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$7, %eax
	cmpl	%edi, %eax
	cmova	%edi, %eax
	cmpl	$13, %edi
	jg	.L179
	movl	%edi, %eax
.L91:
	movl	(%rsi), %edx
	addl	(%rcx), %edx
	cmpl	$1, %eax
	je	.L106
	movl	4(%rsi), %r8d
	addl	4(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$2, %eax
	je	.L107
	movl	8(%rsi), %r8d
	addl	8(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$3, %eax
	je	.L108
	movl	12(%rsi), %r8d
	addl	12(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$4, %eax
	je	.L109
	movl	16(%rsi), %r8d
	addl	16(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$5, %eax
	je	.L110
	movl	20(%rsi), %r8d
	addl	20(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$6, %eax
	je	.L111
	movl	24(%rsi), %r8d
	addl	24(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$7, %eax
	je	.L112
	movl	28(%rsi), %r8d
	addl	28(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$8, %eax
	je	.L113
	movl	32(%rsi), %r8d
	addl	32(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$9, %eax
	je	.L114
	movl	36(%rsi), %r8d
	addl	36(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$10, %eax
	je	.L115
	movl	40(%rsi), %r8d
	addl	40(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$11, %eax
	je	.L116
	movl	44(%rsi), %r8d
	addl	44(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$13, %eax
	jne	.L117
	movl	48(%rsi), %r8d
	addl	48(%rcx), %r8d
	addl	%r8d, %edx
	movl	$13, %r8d
.L60:
	cmpl	%eax, %edi
	je	.L54
.L59:
	movl	%edi, %r9d
	leal	-1(%rdi), %r12d
	movl	%eax, %r11d
	subl	%eax, %r9d
	leal	-8(%r9), %ebx
	subl	%eax, %r12d
	shrl	$3, %ebx
	addl	$1, %ebx
	cmpl	$6, %r12d
	leal	0(,%rbx,8), %r10d
	jbe	.L62
	leaq	0(,%r11,4), %rax
	vpxor	%xmm0, %xmm0, %xmm0
	xorl	%r11d, %r11d
	leaq	(%rcx,%rax), %r13
	addq	%rsi, %rax
.L63:
	movq	%r11, %r12
	addq	$1, %r11
	salq	$5, %r12
	cmpl	%r11d, %ebx
	vmovdqu	(%rax,%r12), %xmm1
	vinserti128	$0x1, 16(%rax,%r12), %ymm1, %ymm1
	vpaddd	0(%r13,%r12), %ymm1, %ymm1
	vpaddd	%ymm1, %ymm0, %ymm0
	ja	.L63
	vmovdqa	%xmm0, %xmm1
	addl	%r10d, %r8d
	vextracti128	$0x1, %ymm0, %xmm0
	vpextrd	$1, %xmm1, %r11d
	vmovd	%xmm1, %eax
	addl	%r11d, %eax
	vpextrd	$2, %xmm1, %r11d
	addl	%r11d, %eax
	vpextrd	$3, %xmm1, %r11d
	addl	%r11d, %eax
	vmovd	%xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$1, %xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$2, %xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$3, %xmm0, %r11d
	addl	%r11d, %eax
	addl	%eax, %edx
	cmpl	%r10d, %r9d
	je	.L163
	vzeroupper
.L62:
	movslq	%r8d, %r9
	movl	(%rsi,%r9,4), %eax
	addl	(%rcx,%r9,4), %eax
	addl	%eax, %edx
	leal	1(%r8), %eax
	cmpl	%eax, %edi
	jle	.L54
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	2(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L54
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	3(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L54
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	4(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L54
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	5(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L54
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	6(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L54
	cltq
	movl	(%rsi,%rax,4), %esi
	addl	(%rcx,%rax,4), %esi
	addl	%esi, %edx
.L54:
	movq	stderr(%rip), %rdi
	movl	$.LC13, %esi
	xorl	%eax, %eax
	call	fprintf
	call	elapsed_time
	vmovsd	%xmm0, -72(%rbp)
	call	reset_timer
	movl	w_max(%rip), %edx
	xorl	%esi, %esi
	imull	N(%rip), %edx
	movq	comb(%rip), %rdi
	movslq	%edx, %rdx
	salq	$2, %rdx
	call	memset
	movslq	C(%rip), %rdx
	movq	pre(%rip), %rdi
	xorl	%esi, %esi
	salq	$2, %rdx
	call	memset
	call	start_timer
	xorl	%edi, %edi
	call	oneThread
	call	stop_timer
	movl	C(%rip), %edi
	testl	%edi, %edi
	jle	.L118
	movq	cur(%rip), %rcx
	movq	pre(%rip), %rsi
	movq	%rcx, %rax
	andl	$31, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$7, %eax
	cmpl	%edi, %eax
	cmova	%edi, %eax
	cmpl	$13, %edi
	jg	.L180
	movl	%edi, %eax
.L92:
	movl	(%rsi), %edx
	addl	(%rcx), %edx
	cmpl	$1, %eax
	je	.L120
	movl	4(%rsi), %r8d
	addl	4(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$2, %eax
	je	.L121
	movl	8(%rsi), %r8d
	addl	8(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$3, %eax
	je	.L122
	movl	12(%rsi), %r8d
	addl	12(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$4, %eax
	je	.L123
	movl	16(%rsi), %r8d
	addl	16(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$5, %eax
	je	.L124
	movl	20(%rsi), %r8d
	addl	20(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$6, %eax
	je	.L125
	movl	24(%rsi), %r8d
	addl	24(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$7, %eax
	je	.L126
	movl	28(%rsi), %r8d
	addl	28(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$8, %eax
	je	.L127
	movl	32(%rsi), %r8d
	addl	32(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$9, %eax
	je	.L128
	movl	36(%rsi), %r8d
	addl	36(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$10, %eax
	je	.L129
	movl	40(%rsi), %r8d
	addl	40(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$11, %eax
	je	.L130
	movl	44(%rsi), %r8d
	addl	44(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$13, %eax
	jne	.L131
	movl	48(%rsi), %r8d
	addl	48(%rcx), %r8d
	addl	%r8d, %edx
	movl	$13, %r8d
.L71:
	cmpl	%edi, %eax
	je	.L68
.L70:
	movl	%edi, %r9d
	leal	-1(%rdi), %r12d
	movl	%eax, %r11d
	subl	%eax, %r9d
	leal	-8(%r9), %ebx
	subl	%eax, %r12d
	shrl	$3, %ebx
	addl	$1, %ebx
	cmpl	$6, %r12d
	leal	0(,%rbx,8), %r10d
	jbe	.L73
	leaq	0(,%r11,4), %rax
	vpxor	%xmm0, %xmm0, %xmm0
	xorl	%r11d, %r11d
	leaq	(%rcx,%rax), %r13
	addq	%rsi, %rax
.L74:
	movq	%r11, %r12
	addq	$1, %r11
	salq	$5, %r12
	cmpl	%r11d, %ebx
	vmovdqu	(%rax,%r12), %xmm1
	vinserti128	$0x1, 16(%rax,%r12), %ymm1, %ymm1
	vpaddd	0(%r13,%r12), %ymm1, %ymm1
	vpaddd	%ymm1, %ymm0, %ymm0
	ja	.L74
	vmovdqa	%xmm0, %xmm1
	addl	%r10d, %r8d
	vextracti128	$0x1, %ymm0, %xmm0
	vpextrd	$1, %xmm1, %r11d
	vmovd	%xmm1, %eax
	addl	%r11d, %eax
	vpextrd	$2, %xmm1, %r11d
	addl	%r11d, %eax
	vpextrd	$3, %xmm1, %r11d
	addl	%r11d, %eax
	vmovd	%xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$1, %xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$2, %xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$3, %xmm0, %r11d
	addl	%r11d, %eax
	addl	%eax, %edx
	cmpl	%r10d, %r9d
	je	.L164
	vzeroupper
.L73:
	movslq	%r8d, %r9
	movl	(%rsi,%r9,4), %eax
	addl	(%rcx,%r9,4), %eax
	addl	%eax, %edx
	leal	1(%r8), %eax
	cmpl	%eax, %edi
	jle	.L68
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	2(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L68
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	3(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L68
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	4(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L68
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	5(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L68
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	6(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L68
	cltq
	movl	(%rsi,%rax,4), %esi
	addl	(%rcx,%rax,4), %esi
	addl	%esi, %edx
.L68:
	movq	stderr(%rip), %rdi
	movl	$.LC14, %esi
	xorl	%eax, %eax
	call	fprintf
	call	elapsed_time
	movl	N(%rip), %r8d
	vxorpd	%xmm3, %xmm3, %xmm3
	vmovapd	%xmm0, %xmm2
	movl	C(%rip), %ecx
	movl	tds(%rip), %edx
	vxorpd	%xmm1, %xmm1, %xmm1
	vcvtsi2sd	%r8d, %xmm3, %xmm3
	vaddsd	%xmm3, %xmm3, %xmm5
	vxorpd	%xmm0, %xmm0, %xmm0
	vmovsd	-72(%rbp), %xmm6
	movl	w_max(%rip), %r9d
	vcvtsi2sd	%ecx, %xmm1, %xmm1
	movq	stdout(%rip), %rdi
	movl	$.LC18, %esi
	vcvtsi2sd	%edx, %xmm0, %xmm0
	movl	$5, %eax
	vmulsd	%xmm1, %xmm5, %xmm5
	vmulsd	%xmm0, %xmm1, %xmm1
	vmulsd	%xmm0, %xmm5, %xmm5
	vmovapd	%xmm6, %xmm0
	vmulsd	.LC15(%rip), %xmm1, %xmm1
	vmulsd	.LC16(%rip), %xmm1, %xmm1
	vmulsd	%xmm1, %xmm3, %xmm1
	vdivsd	%xmm2, %xmm5, %xmm3
	vdivsd	%xmm2, %xmm1, %xmm4
	vdivsd	%xmm6, %xmm5, %xmm5
	vmovsd	.LC17(%rip), %xmm1
	vdivsd	%xmm1, %xmm4, %xmm4
	vdivsd	%xmm1, %xmm3, %xmm3
	vdivsd	%xmm1, %xmm5, %xmm1
	call	fprintf
	movl	w_max(%rip), %edx
	movq	comb(%rip), %rdi
	xorl	%esi, %esi
	imull	N(%rip), %edx
	movslq	%edx, %rdx
	salq	$2, %rdx
	call	memset
	movslq	C(%rip), %rdx
	movq	pre(%rip), %rdi
	xorl	%esi, %esi
	salq	$2, %rdx
	call	memset
	movl	$mykernel, %edi
	call	my_papi_profile
	movl	C(%rip), %edi
	testl	%edi, %edi
	jle	.L132
	movq	cur(%rip), %rcx
	movq	pre(%rip), %rsi
	movq	%rcx, %rax
	andl	$31, %eax
	shrq	$2, %rax
	negq	%rax
	andl	$7, %eax
	cmpl	%edi, %eax
	cmova	%edi, %eax
	cmpl	$13, %edi
	jg	.L181
	movl	%edi, %eax
.L93:
	movl	(%rsi), %edx
	addl	(%rcx), %edx
	cmpl	$1, %eax
	je	.L134
	movl	4(%rsi), %r8d
	addl	4(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$2, %eax
	je	.L135
	movl	8(%rsi), %r8d
	addl	8(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$3, %eax
	je	.L136
	movl	12(%rsi), %r8d
	addl	12(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$4, %eax
	je	.L137
	movl	16(%rsi), %r8d
	addl	16(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$5, %eax
	je	.L138
	movl	20(%rsi), %r8d
	addl	20(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$6, %eax
	je	.L139
	movl	24(%rsi), %r8d
	addl	24(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$7, %eax
	je	.L140
	movl	28(%rsi), %r8d
	addl	28(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$8, %eax
	je	.L141
	movl	32(%rsi), %r8d
	addl	32(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$9, %eax
	je	.L142
	movl	36(%rsi), %r8d
	addl	36(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$10, %eax
	je	.L143
	movl	40(%rsi), %r8d
	addl	40(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$11, %eax
	je	.L144
	movl	44(%rsi), %r8d
	addl	44(%rcx), %r8d
	addl	%r8d, %edx
	cmpl	$13, %eax
	jne	.L145
	movl	48(%rsi), %r8d
	addl	48(%rcx), %r8d
	addl	%r8d, %edx
	movl	$13, %r8d
.L82:
	cmpl	%eax, %edi
	je	.L79
.L81:
	movl	%edi, %r9d
	leal	-1(%rdi), %r12d
	movl	%eax, %r11d
	subl	%eax, %r9d
	leal	-8(%r9), %ebx
	subl	%eax, %r12d
	shrl	$3, %ebx
	addl	$1, %ebx
	cmpl	$6, %r12d
	leal	0(,%rbx,8), %r10d
	jbe	.L84
	leaq	0(,%r11,4), %rax
	vpxor	%xmm0, %xmm0, %xmm0
	xorl	%r11d, %r11d
	leaq	(%rcx,%rax), %r13
	addq	%rsi, %rax
.L85:
	movq	%r11, %r12
	addq	$1, %r11
	salq	$5, %r12
	cmpl	%r11d, %ebx
	vmovdqu	(%rax,%r12), %xmm1
	vinserti128	$0x1, 16(%rax,%r12), %ymm1, %ymm1
	vpaddd	0(%r13,%r12), %ymm1, %ymm1
	vpaddd	%ymm1, %ymm0, %ymm0
	ja	.L85
	vmovdqa	%xmm0, %xmm1
	addl	%r10d, %r8d
	vextracti128	$0x1, %ymm0, %xmm0
	vpextrd	$1, %xmm1, %r11d
	vmovd	%xmm1, %eax
	addl	%r11d, %eax
	vpextrd	$2, %xmm1, %r11d
	addl	%r11d, %eax
	vpextrd	$3, %xmm1, %r11d
	addl	%r11d, %eax
	vmovd	%xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$1, %xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$2, %xmm0, %r11d
	addl	%r11d, %eax
	vpextrd	$3, %xmm0, %r11d
	addl	%r11d, %eax
	addl	%eax, %edx
	cmpl	%r9d, %r10d
	je	.L165
	vzeroupper
.L84:
	movslq	%r8d, %r9
	movl	(%rsi,%r9,4), %eax
	addl	(%rcx,%r9,4), %eax
	addl	%eax, %edx
	leal	1(%r8), %eax
	cmpl	%eax, %edi
	jle	.L79
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	2(%r8), %eax
	addl	%r9d, %edx
	cmpl	%edi, %eax
	jge	.L79
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	3(%r8), %eax
	addl	%r9d, %edx
	cmpl	%edi, %eax
	jge	.L79
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	4(%r8), %eax
	addl	%r9d, %edx
	cmpl	%edi, %eax
	jge	.L79
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	5(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L79
	cltq
	movl	(%rsi,%rax,4), %r9d
	addl	(%rcx,%rax,4), %r9d
	leal	6(%r8), %eax
	addl	%r9d, %edx
	cmpl	%eax, %edi
	jle	.L79
	cltq
	movl	(%rsi,%rax,4), %esi
	addl	(%rcx,%rax,4), %esi
	addl	%esi, %edx
.L79:
	movq	stderr(%rip), %rdi
	movl	$.LC19, %esi
	xorl	%eax, %eax
	call	fprintf
	addq	$32, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L177:
	.cfi_restore_state
	movl	%edx, %eax
	movl	$32, %ecx
	cltd
	idivl	%ecx
	leal	1(%rax), %edx
	sall	$5, %edx
	jmp	.L51
.L180:
	xorl	%edx, %edx
	xorl	%r8d, %r8d
	testl	%eax, %eax
	je	.L70
	jmp	.L92
.L176:
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	testl	%eax, %eax
	je	.L42
	jmp	.L90
.L179:
	xorl	%edx, %edx
	xorl	%r8d, %r8d
	testl	%eax, %eax
	je	.L59
	jmp	.L91
.L181:
	xorl	%edx, %edx
	xorl	%r8d, %r8d
	testl	%eax, %eax
	je	.L81
	jmp	.L93
.L163:
	vzeroupper
	jmp	.L54
.L164:
	vzeroupper
	jmp	.L68
.L165:
	vzeroupper
	jmp	.L79
.L162:
	vzeroupper
	jmp	.L39
.L132:
	xorl	%edx, %edx
	jmp	.L79
.L118:
	xorl	%edx, %edx
	jmp	.L68
.L103:
	movl	$9, %ecx
	jmp	.L43
.L97:
	movl	$3, %ecx
	jmp	.L43
.L102:
	movl	$8, %ecx
	jmp	.L43
.L95:
	movl	$1, %ecx
	jmp	.L43
.L98:
	movl	$4, %ecx
	jmp	.L43
.L99:
	movl	$5, %ecx
	jmp	.L43
.L100:
	movl	$6, %ecx
	jmp	.L43
.L101:
	movl	$7, %ecx
	jmp	.L43
.L96:
	movl	$2, %ecx
	jmp	.L43
.L120:
	movl	$1, %r8d
	jmp	.L71
.L121:
	movl	$2, %r8d
	jmp	.L71
.L141:
	movl	$8, %r8d
	jmp	.L82
.L142:
	movl	$9, %r8d
	jmp	.L82
.L122:
	movl	$3, %r8d
	jmp	.L71
.L123:
	movl	$4, %r8d
	jmp	.L71
.L124:
	movl	$5, %r8d
	jmp	.L71
.L125:
	movl	$6, %r8d
	jmp	.L71
.L126:
	movl	$7, %r8d
	jmp	.L71
.L127:
	movl	$8, %r8d
	jmp	.L71
.L128:
	movl	$9, %r8d
	jmp	.L71
.L129:
	movl	$10, %r8d
	jmp	.L71
.L130:
	movl	$11, %r8d
	jmp	.L71
.L131:
	movl	$12, %r8d
	jmp	.L71
.L113:
	movl	$8, %r8d
	jmp	.L60
.L114:
	movl	$9, %r8d
	jmp	.L60
.L115:
	movl	$10, %r8d
	jmp	.L60
.L116:
	movl	$11, %r8d
	jmp	.L60
.L145:
	movl	$12, %r8d
	jmp	.L82
.L134:
	movl	$1, %r8d
	jmp	.L82
.L143:
	movl	$10, %r8d
	jmp	.L82
.L144:
	movl	$11, %r8d
	jmp	.L82
.L109:
	movl	$4, %r8d
	jmp	.L60
.L110:
	movl	$5, %r8d
	jmp	.L60
.L111:
	movl	$6, %r8d
	jmp	.L60
.L112:
	movl	$7, %r8d
	jmp	.L60
.L107:
	movl	$2, %r8d
	jmp	.L60
.L108:
	movl	$3, %r8d
	jmp	.L60
.L106:
	movl	$1, %r8d
	jmp	.L60
.L117:
	movl	$12, %r8d
	jmp	.L60
.L135:
	movl	$2, %r8d
	jmp	.L82
.L136:
	movl	$3, %r8d
	jmp	.L82
.L137:
	movl	$4, %r8d
	jmp	.L82
.L138:
	movl	$5, %r8d
	jmp	.L82
.L139:
	movl	$6, %r8d
	jmp	.L82
.L140:
	movl	$7, %r8d
	jmp	.L82
.L174:
	movl	$.LC9, %edi
	call	puts
	movl	$1, %edi
	call	exit
.L173:
	movq	16(%r12), %rsi
	movl	$.LC4, %edi
	xorl	%eax, %eax
	call	printf
	movl	$1, %edi
	call	exit
.L33:
	movq	(%rsi), %rsi
	movl	$.LC5, %edi
	xorl	%eax, %eax
	call	printf
	movl	$1, %edi
	call	exit
.L35:
	movl	$.LC8, %edi
	call	puts
	movl	$1, %edi
	call	exit
	.cfi_endproc
.LFE2243:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE20:
	.section	.text.startup
.LHOTE20:
	.section	.text.unlikely
.LCOLDB21:
	.text
.LHOTB21:
	.p2align 4,,15
	.globl	max_of_array
	.type	max_of_array, @function
max_of_array:
.LFB2246:
	.cfi_startproc
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	testl	%esi, %esi
	pushq	-8(%r10)
	pushq	%rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	movq	%rsp, %rbp
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x78,0x6
	pushq	%rbx
	.cfi_escape 0x10,0x3,0x2,0x76,0x70
	jle	.L195
	movq	%rdi, %rdx
	andl	$31, %edx
	shrq	$2, %rdx
	negq	%rdx
	andl	$7, %edx
	cmpl	%esi, %edx
	cmova	%esi, %edx
	cmpl	$10, %esi
	jg	.L213
	movl	%esi, %edx
.L194:
	movl	(%rdi), %eax
	testl	%eax, %eax
	movl	$0, %eax
	cmovns	(%rdi), %eax
	cmpl	$1, %edx
	je	.L197
	movl	4(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	cmpl	$2, %edx
	je	.L198
	movl	8(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	cmpl	$3, %edx
	je	.L199
	movl	12(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	cmpl	$4, %edx
	je	.L200
	movl	16(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	cmpl	$5, %edx
	je	.L201
	movl	20(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	cmpl	$6, %edx
	je	.L202
	movl	24(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	cmpl	$7, %edx
	je	.L203
	movl	28(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	cmpl	$8, %edx
	je	.L204
	movl	32(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	cmpl	$10, %edx
	jne	.L205
	movl	36(%rdi), %ecx
	cmpl	%ecx, %eax
	cmovl	%ecx, %eax
	movl	$10, %ecx
.L186:
	cmpl	%edx, %esi
	je	.L210
.L185:
	movl	%esi, %r10d
	leal	-1(%rsi), %r9d
	movl	%edx, %ebx
	subl	%edx, %r10d
	leal	-8(%r10), %r8d
	subl	%edx, %r9d
	shrl	$3, %r8d
	addl	$1, %r8d
	cmpl	$6, %r9d
	leal	0(,%r8,8), %r11d
	jbe	.L188
	movl	%eax, -20(%rbp)
	leaq	(%rdi,%rbx,4), %rdx
	xorl	%eax, %eax
	vbroadcastss	-20(%rbp), %ymm0
.L189:
	addl	$1, %eax
	vpmaxsd	(%rdx), %ymm0, %ymm0
	addq	$32, %rdx
	cmpl	%eax, %r8d
	ja	.L189
	vperm2i128	$1, %ymm0, %ymm0, %ymm1
	addl	%r11d, %ecx
	cmpl	%r11d, %r10d
	vpmaxsd	%ymm1, %ymm0, %ymm0
	vpsrldq	$8, %ymm0, %ymm1
	vpmaxsd	%ymm1, %ymm0, %ymm0
	vpsrldq	$4, %ymm0, %ymm1
	vpmaxsd	%ymm1, %ymm0, %ymm0
	vmovd	%xmm0, %eax
	je	.L209
	vzeroupper
.L188:
	movslq	%ecx, %rdx
	movl	(%rdi,%rdx,4), %edx
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	leal	1(%rcx), %edx
	cmpl	%edx, %esi
	jle	.L210
	movslq	%edx, %rdx
	movl	(%rdi,%rdx,4), %edx
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	leal	2(%rcx), %edx
	cmpl	%edx, %esi
	jle	.L210
	movslq	%edx, %rdx
	movl	(%rdi,%rdx,4), %edx
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	leal	3(%rcx), %edx
	cmpl	%edx, %esi
	jle	.L210
	movslq	%edx, %rdx
	movl	(%rdi,%rdx,4), %edx
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	leal	4(%rcx), %edx
	cmpl	%edx, %esi
	jle	.L210
	movslq	%edx, %rdx
	movl	(%rdi,%rdx,4), %edx
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	leal	5(%rcx), %edx
	cmpl	%edx, %esi
	jle	.L210
	movslq	%edx, %rdx
	movl	(%rdi,%rdx,4), %edx
	cmpl	%edx, %eax
	cmovl	%edx, %eax
	leal	6(%rcx), %edx
	cmpl	%edx, %esi
	jle	.L210
	movslq	%edx, %rdx
	movl	(%rdi,%rdx,4), %edx
	cmpl	%edx, %eax
	cmovl	%edx, %eax
.L210:
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L213:
	.cfi_restore_state
	testl	%edx, %edx
	jne	.L194
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	jmp	.L185
	.p2align 4,,10
	.p2align 3
.L209:
	vzeroupper
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L195:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L205:
	movl	$9, %ecx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L199:
	movl	$3, %ecx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L200:
	movl	$4, %ecx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L203:
	movl	$7, %ecx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L204:
	movl	$8, %ecx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L201:
	movl	$5, %ecx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L202:
	movl	$6, %ecx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L197:
	movl	$1, %ecx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L198:
	movl	$2, %ecx
	jmp	.L186
	.cfi_endproc
.LFE2246:
	.size	max_of_array, .-max_of_array
	.section	.text.unlikely
.LCOLDE21:
	.text
.LHOTE21:
	.comm	w_max,4,4
	.comm	c_per_first_thread,4,4
	.comm	c_per_thread,4,4
	.comm	comb,8,8
	.comm	pre,8,8
	.comm	cur,8,8
	.comm	C,4,4
	.comm	N,4,4
	.comm	p,8,8
	.comm	w,8,8
	.comm	tds,4,4
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC15:
	.long	0
	.long	1074790400
	.align 8
.LC16:
	.long	0
	.long	1074266112
	.align 8
.LC17:
	.long	0
	.long	1104006501
	.ident	"GCC: (GNU) 4.9.2 20150212 (Red Hat 4.9.2-6)"
	.section	.note.GNU-stack,"",@progbits
