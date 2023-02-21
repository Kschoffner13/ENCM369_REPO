# ENCM 369 Winter 2023 Lab 5
# Code fragment for use in Exercise B.

	.data
foo:	.word	0, 0, 0, 0
alpha:	.word	0x123
beta:	.word	0x456

	.text
	lw	t1, alpha
	li	t2, 0x789
	sw	t2, beta, t3