# ex3D.asm
# ENCM 369 Winter 2023 Lab 3 Exercise D

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

# int procC(int x)
	.text
	.globl	procC
procC:
	# POINT ONE

	slli	t0, a0, 3
	slli	t1, a0, 1
	add	a0, t0, t1
	jr	ra
	
# void procB(int *p, int *q)
	.text
	.globl	procB
procB:
	addi	sp, sp, -32
	sw	ra, 8(sp)
	sw	s1, 4(sp)
	sw	s0, 0(sp)
	add	s0, a0, zero
	add	s1, a1, zero
	
L1:
	beq	s0, s1, L2
	lw	a0, (s0)
	jal	procC
	sw  	a0, (s0)
	addi	s0, s0, 4
	j	L1
L2:
	lw	s0, 0(sp)
	lw	s1, 4(sp)
	lw	ra, 8(sp)
	addi	sp, sp, 32
	jr	ra
	
# void procA(int s, int *a, int n)
	.text
	.globl	procA
procA:
	addi	sp, sp, -32
	sw	ra, 16(sp)
	sw	s3, 12(sp)
	sw	s2, 8(sp)
	sw	s1, 4(sp)
	sw	s0, 0(sp)
	add	s0, a0, zero
	add	s1, a1, zero
	add	s2, a2, zero
	
	addi	s3, s2, -1
	add	a0, s1, zero
	slli	t0, s2, 2
	add	a1, s1, t0
	jal	procB
L3:
	blt	s3, zero, L4
	slli	t1, s3, 2
	add	t2, s1, t1
	lw	t3, (t2)
	add	s0, s0, t3
	addi	s3,	s3, -1
	j	L3
L4:
	add	a0, s0, zero
	
	lw	s0, 0(sp)
	lw	s1, 4(sp)
	lw	s2, 8(sp)
	lw	s3, 12(sp)
	lw	ra, 16(sp)
	addi	sp, sp, 32
	jr	ra

# int gg[] = { 2, 3, 4 }
	.data
	.globl	gg
gg:	.word	2, 3, 4

# int main(void)
	.text
	.globl	main
main:
	addi	sp, sp, -32
	sw	ra, 4(sp)
	sw	s0, 0(sp)
	
	addi	s0, zero, 1000
	addi	a0, zero, 200
	la	a1, gg
	addi	a2, zero, 3
	jal	procA
	add	s0, s0, a0
	add	a0, zero, zero
	
	lw	s0, 0(sp)
	lw	ra, 4(sp)
	addi	sp, sp, 32
	jr	ra
