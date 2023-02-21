# do_output.asm
# ENCM 369 Winter 2023 Lab 4 Exercise A

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
	
	.data
myword:
	.word 0x00216948

# int main(void)
	.text
	.globl	main
main:
	# Attention: ecalls are NOT function calls, so this particular
	# main is leaf. No prologue is needed.

	# Body of main ...

	# Demonstrate some RARS system calls ...
	li	a0, 'E'			# a0 = 'E'
	addi	a7, zero, 11		# code 11: print character
	ecall 
	li	a0, '\n'		# a0 = '\n'
	li	a7, 11		# code 11: print character
	ecall 

	la	t0, myword		# t0 = &myword
					# RARS ecalls DON'T touch t-registers, 
					# so we can use the address in t0 many times.

	lw	a0, (t0)		# a0 = myword, assuming myword is an int													
	li	a7, 1			# code 1: print int
	ecall 
	li	a0, '\n'
	li	a7, 11
	ecall 

	lbu	a0, (t0)		# a0 = myword[0], assuming myword is a 4-char array													
	li	a7, 11			# code 11: print character
	ecall 
	li	a0, '\n'
	li	a7, 11
	ecall 

	mv	a0, t0			# a0 = &myword
	li	a7, 4			# code 4: print string
	ecall 
	li	a0, '\n'
	li	a7, 11
	ecall 
	
	mv	a0, t0			# a0 = &myword
	li	a7, 34			# code 34: print word in hex
	ecall 
	li	a0, '\n'
	li	a7, 11
	ecall 
	
	lw	a0, (t0)		# a0 = myword, assuming myword is an int
	li	a7, 34			# code 34: print word in hex
	ecall 
	li	a0, '\n'
	li	a7, 11
	ecall 
	
	lw	a0, (t0)		# a0 = myword, assuming myword is an int
	li	a7, 35			# code 35: print word in binary
	ecall 
	li	a0, '\n'
	li	a7, 11
	ecall 
	
	mv	a0, zero		# return value from main = 0
	
	# No epilogue needed.
	jr	ra
