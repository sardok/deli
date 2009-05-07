.section .text
.globl _start
_start:
	call c_main
	cli
	hlt
