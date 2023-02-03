# lab3exE.asm
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

# int clamp(int bound, int x)
# bound = a0, x = a1
	.text
	.global clamp
clamp:
	sub 	t0, zero, a0		# t0 = -bound
	bgt	a1, t0, elif		# if(x> -bound) goto elif
	add	a0, t0, zero		# load -bound into a0 to be returned
	j	return			# go straight to the return 
elif:	
	blt	a1, a0, else		# if(x < bound) goto else
	add	a0, a0, zero		# a0 = bound (I know a0 =bound already, just making sure it does)
	j	return			# got stright to the return
else:
	add, 	a0, a1, zero		# if the above statements don't happen, then we need
					# to load x into a0 and return it 
	j 	return
return:
	jr	ra			# return whatever value we have in a0 to caller


# int special_sum(int bound, const int *x, int n)
#	bound  	s0
#	x 	s1
# 	n  	s2
#	result 	s3
#	i	s4
# words needed = 6 (varibles + 1 for ra), therefor shrink by 24 ( 4 x 6)
	.text
	.global special_sum

special_sum:

	# prolouge
	addi	sp, sp, -24	# shrink sp by 6 words
	sw	ra, 20(sp)	# store old ra
	sw 	s4, 16(sp)	# store old s4, used for i in function
	sw	s3, 12(sp)	# store old s3, used for result in function
	sw	s2, 8(sp)	# store olf s2, used for n in function
	sw	s1, 4(sp)	# store old s1, used for x in function
	sw	s0, 0(sp)	# store old s0, used for bound in function
	add	s0, a0, zero	# copy bound into s0 from a0
	add	s1, a1, zero	# copy address x into s1 from a1
	add	s2, a2, zero	# copy n into s2 form a2
	
	# body
	add	s3, zero, zero	# result = 0
	add	s4, zero, zero	# i = 0 for the "for" loop
f_top:	
	bge	s4, s2, f_bot	# if( i >= n) goto f_bot
	add	a0, s0, zero	# copy bound into a0
	slli	t0, s4, 2	# i*4
	add	t1, s1, t0	# puts address of x[i] in t1
	lw	a1, (t1)	# puts the values of x[i] in a1
	jal 	clamp		# calls clamp(bound, x[i]
	add	s3, s3, a0	# result += clamp(bound, x[i]
	addi	s4, s4, 1	# i++
	j	f_top		# loop back to the top of the "for" loop
	
f_bot:
	add	a0, s3, zero	# load result into a0 to be returned
	
	# epilouge
	lw	ra, 20(sp)	# restore old values of ra, and registers 
	lw 	s4, 16(sp)	# s0-s4 for safe return
	lw	s3, 12(sp)	
	lw	s2, 8(sp)	
	lw	s1, 4(sp)	
	lw	s0, 0(sp)
	addi	sp, sp, 24	# grow sp by 6 words
	jr	ra		# return value of a0 to caller	
	
	

	.data
	.global aaa
aaa:	.word	11, 11, 3, -11

	.data
	.global bbb
bbb:	.word	200, -300, 400, 500

	.data
	.global ccc
ccc:	.word	-2, -3, 2, 1, 2, 3


# int main(void)
#	red	s0
#	green	s1
#	blue	s2
# need to store 4 words, so shrink by 16
	.text
	.globl	main
	
main:
	
	# prolouge 
	addi	sp, sp, -16	# Shrinking sp by 16 words
	sw	ra, 12(sp)	# saving ra 
	sw	s2, 8(sp)	# saving old s2, used for blue
	sw	s1, 4(sp)	# saving old s1, used for green
	sw	s0, 0(sp)	# saving old s0, used for red
	addi	s2, zero, 1000	# blue  = 10000
	
	
	# body
	addi	a0, zero, 10	# load 10 into a0
	la	a1, aaa		# load address of aaa into a1
	addi	a2, zero, 4	# loads 4 intom a2
	jal	special_sum	# calls special_sum(10, aaa, 4)
	add	s0, a0, zero	# red = special_sum(10, aaa, 4)
	
	addi	a0, zero, 200	# load 200 into a0
	la	a1, bbb		# load address of bbb into a1
	addi	a2, zero, 4	# loads 4 intom a2
	jal	special_sum	# calls special_sum(200, bbb, 4)
	add	s1, a0, zero	# green = special_sum(200, bbb, 4)
	
	
	addi	a0, zero, 500	# loads 500 into a0
	la	a1, ccc		# loads address of ccc into a1
	addi	a2, zero, 6	# loads 6 into a2
	jal	special_sum	# calls special_sum(500, ccc, 6)
	
	add	t0, s0, s1	# t0 = red + green
	add	t0, t0, a0	# t0 = speical_sum(500, ccc, 6) + red + green
	add	s2, s2, t0	# blue += speical_sum(500, ccc, 6) + red + green
	
	# epilouge
	lw	ra, 12(sp)	# restore all old values of s-regs: s0-s2
	lw	s2, 8(sp)	
	lw	s1, 4(sp)	
	lw	s0, 0(sp)
	addi	sp, sp, 16	# grow sp by 16 words

	li      a0, 0   # return value from main = 0
	jr	ra