	.file	"stdlib.c"
	.section	.rodata
.LC1:
	.string	"len of 1234567 : %s\n"
	.align 4
.LC2:
	.string	"verdigim numara 1204567, gelen : %s\n"
	.align 4
.LC3:
	.string	"verdigim numara 1204657, gelen : %s\n"
	.align 4
.LC4:
	.string	"verdigim numara 1234657, gelen : %s\n"
.LC0:
	.string	"1234567"
	.text
.globl main
	.type	main, @function
main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ecx
	subl	$36, %esp
	movl	%gs:20, %eax
	movl	%eax, -8(%ebp)
	xorl	%eax, %eax
	movl	.LC0, %eax
	movl	.LC0+4, %edx
	movl	%eax, -16(%ebp)
	movl	%edx, -12(%ebp)
	leal	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	reverse_str
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	printf
	movl	$10, 4(%esp)
	movl	$1204567, (%esp)
	call	num_to_str
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	movl	$16, 4(%esp)
	movl	$1204567, (%esp)
	call	num_to_str
	movl	%eax, 4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	$8, 4(%esp)
	movl	$1234567, (%esp)
	call	num_to_str
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	movl	$0, %eax
	movl	-8(%ebp), %edx
	xorl	%gs:20, %edx
	je	.L3
	call	__stack_chk_fail
.L3:
	addl	$36, %esp
	popl	%ecx
	popl	%ebp
	leal	-4(%ecx), %esp
	ret
	.size	main, .-main
.globl itoa
	.type	itoa, @function
itoa:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$10, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	num_to_str
	leave
	ret
	.size	itoa, .-itoa
.globl strlen
	.type	strlen, @function
strlen:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	.L7
.L8:
	addl	$1, -4(%ebp)
.L7:
	movl	-4(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L8
	movl	-4(%ebp), %eax
	leave
	ret
	.size	strlen, .-strlen
.globl reverse_str
	.type	reverse_str, @function
reverse_str:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen
	movl	%eax, -8(%ebp)
	subl	$1, -8(%ebp)
	movl	$0, -12(%ebp)
	jmp	.L11
.L12:
	movl	-12(%ebp), %edx
	movl	-8(%ebp), %eax
	subl	%edx, %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, -1(%ebp)
	movl	-12(%ebp), %edx
	movl	-8(%ebp), %eax
	subl	%edx, %eax
	movl	%eax, %edx
	addl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, (%edx)
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	addl	8(%ebp), %edx
	movzbl	-1(%ebp), %eax
	movb	%al, (%edx)
	addl	$1, -12(%ebp)
.L11:
	movl	-12(%ebp), %eax
	cmpl	-8(%ebp), %eax
	jl	.L12
	movl	8(%ebp), %eax
	leave
	ret
	.size	reverse_str, .-reverse_str
.globl num_to_str
	.type	num_to_str, @function
num_to_str:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$buff, -4(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	$0, -12(%ebp)
	jmp	.L15
.L17:
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	12(%ebp)
	movl	%edx, -8(%ebp)
	cmpl	$0, -16(%ebp)
	jg	.L16
	movl	-4(%ebp), %eax
	movb	$0, (%eax)
	movl	$buff, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	jmp	.L18
.L16:
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-8(%ebp), %eax
	movl	%eax, (%esp)
	call	num_to_char
	movl	%eax, %edx
	movl	-4(%ebp), %eax
	movb	%dl, (%eax)
	addl	$1, -4(%ebp)
	movl	-16(%ebp), %edx
	movl	%edx, -32(%ebp)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	12(%ebp)
	movl	%eax, -16(%ebp)
	addl	$1, -12(%ebp)
.L15:
	cmpl	$11, -12(%ebp)
	jle	.L17
.L18:
	leave
	ret
	.size	num_to_str, .-num_to_str
.globl num_to_char
	.type	num_to_char, @function
num_to_char:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	12(%ebp), %eax
	movl	%eax, -8(%ebp)
	cmpl	$10, -8(%ebp)
	je	.L21
	cmpl	$16, -8(%ebp)
	je	.L22
	cmpl	$8, -8(%ebp)
	je	.L21
	jmp	.L20
.L22:
	cmpl	$9, 8(%ebp)
	jle	.L21
	cmpl	$15, 8(%ebp)
	jg	.L21
	movl	8(%ebp), %eax
	addl	$55, %eax
	movb	%al, -1(%ebp)
	jmp	.L23
.L21:
	cmpl	$0, 8(%ebp)
	js	.L20
	cmpl	$9, 8(%ebp)
	jg	.L20
	movl	8(%ebp), %eax
	addl	$48, %eax
	movb	%al, -1(%ebp)
	jmp	.L23
.L20:
	movb	$0, -1(%ebp)
.L23:
	movzbl	-1(%ebp), %eax
	leave
	ret
	.size	num_to_char, .-num_to_char
	.comm	buff,12,1
	.ident	"GCC: (Ubuntu 4.3.3-3ubuntu5) 4.3.3"
	.section	.note.GNU-stack,"",@progbits
