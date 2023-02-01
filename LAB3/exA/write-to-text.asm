# write-to-text.asm
# Part of ENCM 369 Winter 2023 Lab 3 Exercise A

# Here RARS works like many real operating system.  Programs are normally
# not allowed to modify their own instructions.

	.text
code:	
	la	t0, code
	sw	zero, (t0)
	addi	a7, zero, 10		# a7 = ecall code for exit
	ecall