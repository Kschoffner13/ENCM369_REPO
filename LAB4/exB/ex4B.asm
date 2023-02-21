=# ex4B.asm
# ENCM 369 Winter 2023 Lab 4 Exercise B

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
	li	a7, 4
	ecall
	lw	a0, main_rv
	li	a7, 1
	ecall
	la	a0, exit_msg_2
	li	a7, 4
	ecall
	lw	a0, main_rv
	addi	a7, zero, 93	# call for program exit with exit status that is in a0
	ecall
# END of start-up & clean-up code.

#	void my_strcpy(char *dest, const char *src)
#	  Leaf procedure: dest is $a0, src is $a1.
#
	.text
	.globl	my_strcpy
my_strcpy:
L1:	lbu	t0, (a1)		# t0 = *src
	beq	t0, zero, L2		# if (t0 == '\0') goto L2
	sb	t0, (a0)		# *dest = bits 7-0 of t0
	addi	a0, a0, 1		# src++
	addi	a1, a1, 1		# dest++
	j	L1
L2:	sb	zero, (a0)		# *dest = '\0'
	jr	ra

# char my_dest[32];	
	.data
	.align	5	# Align next data at address that is a multiple of 32.
	.globl	my_dest
my_dest:
	.space 32
	
#	int main(void)
#
	.data
	.align	5	# Align next data at address that is a multiple of 32.
str1:	.asciz	"This is Lab 4 Exercise B."
	.text
	.globl	main
main:
	# Prologue only needs to save ra
	addi	sp, sp, -32
	sw	ra, 0(sp)
	
	# Body is AL for my_strcpy(my_dest, "This is Lab 4 Exercise B.")
	la	a0, my_dest		# a0 = my_dest
	la	a1, str1		# a1 = "This is [...]"
	jal	my_strcpy

	mv	a0, zero		# r.v. from main = 0
	
	# Epilogue
	lw	ra, 0(sp)
	addi	sp, sp, 32
	jr	ra
