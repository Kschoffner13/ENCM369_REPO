# Functions.asm
# ENCM 369 Winter 2023
# This program has complete start-up and clean-up code, and a "stub"
# main function.

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


# int procA(int first, int second, int third, int fourth)

	.text
	.global procA
procA:
	# we have 8 total words: first, second, third, fourth, alpha, beta, gamma, and ra 
	# that neeed to be saved. 10 * 4 = 32
	
	# prologue
	addi 	sp, sp -32	# shrink sp by 8 words
	sw	ra, 28(sp)	# saved ra for return to caller
	sw	s6, 24(sp)	# saved s6 for some other procedure(used for gamma in function)
	sw	s5, 20(sp)	# saved s5, used for beta in function
	sw	s4, 16(sp)	# saved s4, used for alpha in function
	sw 	s3, 12(sp)	# saved s3, used for fourth in function
	sw	s2, 8(sp)	# saved s2, used for third in function
	sw	s1, 4(sp)	# saved s1, used for second in function
	sw	s0, 0(sp)	# saved s0, used for first in function
	add	s0, a0, zero	# copy first from a0, s0
	add	s1, a1, zero	# copy second from a1 to s1
	add	s2, a2, zero	# copy third from a2 to s2
	add	s3, a3, zero	# copy fourth from a3 to s3
	
	
	# body
	add	a0, s3, zero	# a0 = fourth
	add	a1, s2, zero	# a1 = third
	jal	procB		# calls procB(fourth, third)
	add	s5, a0, zero	# beta  = procB(fourth, third)
	
	add	a0, s1, zero	# a0 = second
	add	a1, s0, zero	# a1 = first
	jal 	procB		# calls procB(second, first)
	add 	s6, a0, zero	# gamma = procB(second, first)
	
	add	a0, s2, zero	# a0 = third
	add	a1, s3, zero	# a1 = fourth
	jal	procB		# calls procB(third, fourth)
	add	s4, a0, zero	# alpha = procB(third, fourth) 
	
	add	t0, s4, s5	# t0 = alpha + beta
	add	a0, t0, s6	# r.v of procA = alpha + beta + gamma
	
	# epilogue
	lw	s0, 0(sp)	# recover old s0 value
	lw 	s1, 4(sp)	# recover old s1 value
	lw	s2, 8(sp)	# recover old s2 value
	lw	s3, 12(sp)	# recover old s3 value
	lw	s4, 16(sp)	# recover old s4 value
	lw	s5, 20(sp)	# recover old s5 value
	lw	s6, 24(sp)	# recover old s6 value
	lw	ra, 28(sp)	# recover backed-up ra for correct return
	
	addi	sp, sp 32	# grow sp by 8 words
	jr 	ra		# return answer in a0 to caller
	

# int procB(int cat, int dog)
	.text
	.global procB
procB:
	slli	t0, a0, 8	# cat * 256 (which is 2^8) and store in t0
	add	a0, t0, a1	# t0 + dog ( (cat*256)+ dog) and load into a0
	jr 	ra		# return answer in ao to caller



# int train = 0x20000 (131072 in base 10)
# train = 0x2790b (162059) by the end of main
	.data
	.globl	train
train:	.word	0x20000		


# int main(void)
	.text
	.globl	main
main:
	# need have 3 words, therefor need to shrink sp by 12, and s-regs s0-s2
	

	# prologue
	addi	sp, sp, -16	# Shrink sp by 4 words
	sw	s0, 0(sp)	# save old s0, used for plane
	sw	s1, 4(sp)	# save old s1, used for boat
	sw	s2, 8(sp)	# save old s2, used for train
	sw	ra, 12(sp)	# saved old ra
	
	
	# body
	li	s1, 0xa000	# boat = 0xa000 (
	li	s0, 0x3000	# plane = 0x3000

	
	addi	a0, zero, 6	# load 6 into a0
	addi	a1, zero, 4	# load 4 into a1
	addi	a2, zero, 3	# load 3 into a2
	addi	a3, zero, 2	# load 2 into a2
	
	jal	procA		# call procA(6, 4, 3, 2)
	add	s1, s1, a0	# boat += procA(6, 4, 3, 2)
	
	la	s2, train	# puts address of train into s3
	lw	t0, (s2)	# put the value of train in t0	
	sub	t1, s1, s0	# t1 = (boat - plane)
	add	t0, t0, t1	# t0 = valueof(train) + (boat-plane)
	sw	t0, (s2)	# store back in train
	
	# epilouge
	lw	s0, 0(sp)	# restore old s0
	lw	s1, 4(sp)	# restore old s1
	lw	s2, 8(sp)	# restore old s2
	lw	ra, 12(sp)	#restore old ra
	addi	sp, sp 12	# grow sp by 3 words
	
	li      a0, 0  		# return value from main = 0
	jr	ra
