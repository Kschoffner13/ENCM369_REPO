		.data
greeting:	.asciz		"Hello ENCM 369!!\n"

		.text
		la	a0, greeting
		addi	a7, zero, 4
		ecall
		
		addi 	a7, zero, 10
		ecall
