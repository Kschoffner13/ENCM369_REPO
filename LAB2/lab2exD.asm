 # lab2exD.asm
# ENCM 369 Winter 2023 Lab 2


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
	
# local variable	register
#   int *p		s0
#   int *guard		s1
#   int min		s2
#   ifloop place holder	s3
#   int j		s4
#   int k		s5
#   int 8		s6
# pointer for alpha	s7
# pointer for beta	s8

		

	.data
	.globl	alpha
alpha: 	.word  	0xb1, 0xe1, 0x91, 0xc1, 0x81, 0xa1, 0xf1, 0xd1		
	.global beta
beta:	.word 0x0, 0x10, 0x20, 0x30, 0x40, 0x50, 0x60, 0x70
	
	.text
	.global main

main:
	la 	s0, alpha 		# p = alpha
	addi	s1, s0, 32		# guard = p + 8
	lw	s2, (s0)		# min = *p
	addi	s0, s0, 4		# p++
	
f_top:
	beq	s0, s1, f_bot	# if (p == guard) goto f_bot

if_top:
	lw	s3, (s0)		# setting s3 = *p for this itteration of p
	bge	s3, s2, if_bot		# if(*p >= min) goto if_bot
	add	s2, s3, zero		# min = *p

if_bot:
	addi	s0, s0, 4		# p++
	j	f_top			# goto f_top (looping)

f_bot:
	add	s4, zero, zero		# j = 0
	addi	s5, zero, 7		# k = 7(
	addi	s6, zero, 8		# creating a regtister for the bqe instruction below
	la	s7, alpha		# address of alpha loaded into s7
	la	s8, beta		# address of beta loaded into s8

	
w_top:
	bge 	s4, s6, w_bot		# if(j >=8) goto w_bot
	slli	t0, s4, 2		# putting j*4 into t0
	slli	t1, s5, 2		# putting k*4 into t1
	
	add	t0, s7, t0		# gets the address of alpha[j] 
	add	t1, s8, t1		# gets the address of beta[k] 
	
	lw	t1, (t1)		# retives the value of beta[k] 
	sw	t1, (t0)		# stores the value of beta[k] into alpha[j]
	
	addi	s4, s4, 1		#j++
	addi	s5, s5, -1		#k--
	
	j	w_top			# goto w_top
	

w_bot:	
	add	a0, zero, zero	        # return 0 at end if main 
	jr	ra	
