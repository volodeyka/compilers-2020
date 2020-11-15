	.global	main
	.data
global_fib:	.int	0
global_fib_1:	.int	0
global_fib_2:	.int	0
global_n:	.int	0
	.text
# LABEL main
main:
# BEGIN main, 0, 1
	pushl	%ebp
	movl	%esp,	%ebp
	subl	$4,	%esp
# GLOBAL n
# GLOBAL fib_1
# GLOBAL fib_2
# GLOBAL fib
# LDA fib_1
	leal	global_fib_1,	%eax
	movl	%eax,	%ebx
# CONST 1
	movl	$1,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# LDA fib_2
	leal	global_fib_2,	%eax
	movl	%eax,	%ebx
# CONST 1
	movl	$1,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# LDA fib
	leal	global_fib,	%eax
	movl	%eax,	%ebx
# CONST 1
	movl	$1,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# READ
	call	Lread
	movl	%eax,	%ebx
# ST n
	movl	%ebx,	global_n
# LDA loc[0]
	leal	-4(%ebp),	%eax
	movl	%eax,	%ebx
# CONST 2
	movl	$2,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# JMP L1
	jmp	L1
# LABEL L0
L0:
# LDA fib
	leal	global_fib,	%eax
	movl	%eax,	%ebx
# LD fib_1
	movl	global_fib_1,	%ecx
# LD fib_2
	movl	global_fib_2,	%esi
# BINOP +
	movl	%ecx,	%eax
	addl	%esi,	%eax
	movl	%eax,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# LDA fib_2
	leal	global_fib_2,	%eax
	movl	%eax,	%ebx
# LD fib_1
	movl	global_fib_1,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# LDA fib_1
	leal	global_fib_1,	%eax
	movl	%eax,	%ebx
# LD fib
	movl	global_fib,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# LDA loc[0]
	leal	-4(%ebp),	%eax
	movl	%eax,	%ebx
# LD loc[0]
	movl	-4(%ebp),	%ecx
# CONST 1
	movl	$1,	%esi
# BINOP +
	movl	%ecx,	%eax
	addl	%esi,	%eax
	movl	%eax,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# LABEL L1
L1:
# LD loc[0]
	movl	-4(%ebp),	%ebx
# LD n
	movl	global_n,	%ecx
# BINOP <
	movl	%ecx,	%edx
	cmpl	%edx,	%ebx
	movl	$0,	%eax
	setl	%al
	movl	%eax,	%ebx
# CJMP nz, L0
	movl	%ebx,	%eax
	cmpl	$0,	%eax
	jne	L0
# LD fib
	movl	global_fib,	%ebx
# WRITE
	pushl	%ebx
	call	Lwrite
	popl	%eax
# END
	movl	%ebp,	%esp
	popl	%ebp
	xorl	%eax,	%eax
	ret
