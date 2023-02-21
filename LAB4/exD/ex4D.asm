# ex4D.asm
# ENCM 369 Winter 2023 Lab 4 Exercise D

	.text
	# Put some bit patterns into a0 and a1
	lui	a0, 0x57000
	addi	a0, a0, 0x0ad
	lui	a1, 0x3c018
	addi	a1, a1, 0x074
	
	# Use various logical instruction to give values to t0-t5.
	or	t0, a0, a1
	and	t1, a0, a1
	xor	t2, a0, a1
	xori	t3, a0, -1
	slli	t4, a0, 4
	srli	t5, a1, 2
	
	# Terminate the program.
	li	a7, 10
	ecall
