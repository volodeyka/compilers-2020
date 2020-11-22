	.global	main
	.data
global_i:	.int	0
global_n:	.int	0
	.text
# LABEL main
main:
# BEGIN main, 0, 0
	pushl	%ebp
	movl	%esp,	%ebp
	subl	$main_SIZE,	%esp
# GLOBAL n
# GLOBAL i
# LDA n
	leal	global_n,	%eax
	movl	%eax,	%ebx
# BUILTIN read, 0
	pushl	%ebx
	call	Lread
	addl	$0,	%esp
	popl	%ebx
	movl	%eax,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# LDA i
	leal	global_i,	%eax
	movl	%eax,	%ebx
# LD n
	movl	global_n,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# JMP L1
	jmp	L1
# LABEL L0
L0:
# LD i
	movl	global_i,	%ebx
# BUILTIN write, 1
	pushl	%ebx
	call	Lwrite
	addl	$4,	%esp
	movl	%eax,	%ebx
# DROP
# LD i
	movl	global_i,	%ebx
# CALL Lfact, 1
	pushl	%ebx
	call	Lfact
	addl	$4,	%esp
	movl	%eax,	%ebx
# BUILTIN write, 1
	pushl	%ebx
	call	Lwrite
	addl	$4,	%esp
	movl	%eax,	%ebx
# DROP
# LDA i
	leal	global_i,	%eax
	movl	%eax,	%ebx
# LD i
	movl	global_i,	%ecx
# CONST 1
	movl	$1,	%esi
# BINOP -
	movl	%ecx,	%eax
	subl	%esi,	%eax
	movl	%eax,	%ecx
# STI
	movl	%ebx,	%eax
	movl	%ecx,	(%eax)
	movl	%ecx,	%ebx
# DROP
# LABEL L1
L1:
# LD i
	movl	global_i,	%ebx
# CONST 1
	movl	$1,	%ecx
# BINOP >=
	movl	%ecx,	%edx
	cmpl	%edx,	%ebx
	movl	$0,	%eax
	setge	%al
	movl	%eax,	%ebx
# CJMP nz, L0
	movl	%ebx,	%eax
	cmpl	$0,	%eax
	jne	L0
# END
	movl	%ebp,	%esp
	popl	%ebp
	xorl	%eax,	%eax
	ret
	.set	main_SIZE,	0
# LABEL Lfact
Lfact:
# BEGIN Lfact, 1, 0
	pushl	%ebp
	movl	%esp,	%ebp
	subl	$Lfact_SIZE,	%esp
# LD arg[0]
	movl	8(%ebp),	%ebx
# CONST 1
	movl	$1,	%ecx
# BINOP <=
	movl	%ecx,	%edx
	cmpl	%edx,	%ebx
	movl	$0,	%eax
	setle	%al
	movl	%eax,	%ebx
# CJMP z, L2
	movl	%ebx,	%eax
	cmpl	$0,	%eax
	je	L2
# CONST 1
	movl	$1,	%ebx
# JMP L3
	jmp	L3
# DUP
# LABEL L2
L2:
# LD arg[0]
	movl	8(%ebp),	%ebx
# LD arg[0]
	movl	8(%ebp),	%ecx
# CONST 1
	movl	$1,	%esi
# BINOP -
	movl	%ecx,	%eax
	subl	%esi,	%eax
	movl	%eax,	%ecx
# CALL Lfact, 1
	pushl	%ebx
	pushl	%ecx
	call	Lfact
	addl	$4,	%esp
	popl	%ebx
	movl	%eax,	%ecx
# BINOP *
	movl	%ebx,	%eax
	imull	%ecx,	%eax
	movl	%eax,	%ebx
# LABEL L3
L3:
# END
	movl	%ebp,	%esp
	popl	%ebp
	movl	%ebx,	%eax
	ret
	.set	Lfact_SIZE,	0