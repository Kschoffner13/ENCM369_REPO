# add-ints2C.asm
# ENCM 369 Winter 2023 Lab 2 Exercise C Part 2

# Start-up and clean-up code copied from stub1.asm

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

# Global variables.
	.data
	.globl	foo
foo:	.word	0x15
	.globl	bar
bar:	.word	0x2d
	.globl	quux
quux:	.word	0


# Instructions for main	
	.text
	.globl	main
main:
	la	t0, foo		        # t0 = &foo
	lw	t1, (t0)		# t1 = foo
	la	t2, bar		        # t2 = &bar
	lw	t3, (t2)		# t3 = bar
	add	t4, t1, t3		# t4 = t1 + t3
	la	t5, quux		# t5 = &quux
	sw	t4, (t5)		# quux = t4 
	mv	a0, zero
	jr	ra
