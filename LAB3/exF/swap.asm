# swap.asm
# ENCM 369 Winter 2023 Lab 3 Exercise F

# BEGINNING of start-up & clean-up code.  Do NOT edit this code.
	.data
exit_msg_1:
	.asciz	"***About to exit. main returned "
exit_msg_2:
	.asciz	".***\n"
main_rv:
	.word	0
	
	.text
	# adjust sp, then call main
	andi	sp, sp, -32		# round sp down to multiple of 32
	jal	main
	
	# when main is done, print its return value, then halt the program
	sw	a0, main_rv, t0	
	la	a0, exit_msg_1
	li      a7, 4
	ecall
	lw	a0, main_rv
	li	a7, 1
	ecall
	la	a0, exit_msg_2
	li	a7, 4
	ecall
        lw      a0, main_rv
	addi	a7, zero, 93	# call for program exit with exit status that is in a0
	ecall
# END of start-up & clean-up code.

# int foo[] =  { 0x600, 0x500, 0x400, 0x300, 0x200, 0x100 }
	.data
        .globl	foo
foo:	.word	0x600, 0x500, 0x400, 0x300, 0x200, 0x100

# int main(void)
#
        .text
        .globl  main
main:
	addi	sp, sp, -32
 	sw 	ra, 0(sp)

	la	t0, foo	# t0 = &foo[0]
	addi	a0, t0, 20	# a0 = &foo[5]
	addi	a1, t0, 0	# a1 = &foo[0]
	jal	swap

	# Students: Replace this comment with code to correctly
	# implement the next two calls to swap in main in swap.c.

	add	a0, zero, zero		
	lw	ra, 0(sp)
	addi	sp, sp, 32
	jr	ra

# void swap(int *left, int *right)
#
	.text
	.globl  swap
swap:
	# Students: Replace this comment with code to make swap
	# do its job correctly.

	jr	ra
