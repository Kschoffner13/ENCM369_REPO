# null-ptr.asm
# Part of ENCM 369 Winter 2023 Lab 3 Exercise A

# Note that the first lw attempted here is like a C or C++ attempt to
# read data via a null pointer.
#
# The address 0x00000000 is not part of the set of addresses
# accessible to RARS programs.

	.data
		# int words[] = { 0x11223344, 0x55667788 };
words:	.word	0x11223344, 0x55667788

	.text
	add	t0, zero, zero		# t0 = 0
	lw	t1, (t0)		# attempt lw using 0 as address
	la	t2, words		# t2 = &words[0] ... will the program get this far?
	lw	t3, 4(t2)		# t3 = words[1]
	addi	a7, zero, 10		# a7 = ecall code for exit
	ecall