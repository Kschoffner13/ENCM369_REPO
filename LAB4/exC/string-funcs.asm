# string-funcs.asm
# ENCM 369 Winter 2023 Lab 4 Exercise C

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
	

#	void copycat(char *dest, const char *src1, const char *src2)
#
	.text
	.globl	copycat
copycat:

L1:	
	lbu	t0, (a1)		# t0 = *src1
	beq	t0, zero, L2		# if (t0 == '\0') goto L2
	sb	t0, (a0)		# *dest = bits 7-0 of t0
	addi	a0, a0, 1		# dest++
	addi	a1, a1, 1		# src1++
	j	L1

L2:
	lbu	t1, (a2)		# t1 = *src2
	beq	t1, zero, L3		# if (t1 == '\0') goto L3
	sb	t1, (a0)		# *dest = bits 7-0 of t1
	addi	a0, a0, 1		# dest++
	addi	a2, a2, 1		# src2++
	j	L2
L3:	
	sb	zero, (a0)		# *dest = '\0'
	jr	ra

	

#	void lab4reverse(const char *str)
#	
	.text
	.globl	lab4reverse
lab4reverse:

	add	t0, a0, zero	# t0 = &str
	li	t1, 0		# t1 = back = 0
	
LA:
	add	t2, t0, t1	# t2 = &str[back]
	lbu	t3, (t2)
	beq	t3, zero, LB
	addi	t1, t1, 1
	j	LA

LB:
	addi	t1, t1, -1
	li	t4, 0		# t4 = front = 0

LC: 
	ble	t1, t4, LD
	add	t2, t0, t1	# t2 = &str[back]
	add	t3, t0, t4	# t3 = &str[front]
	lbu	t5, (t2)	# c = str[back]
	lbu	t6, (t3)
	
	sb	t6,(t2)
	sb	t5, (t3)
	
	addi	t1, t1, -1
	addi	t4, t4, 1
	j	LC
LD:
	jr	ra

	
#	void print_in_quotes(const char *str)
#
	.text
	.globl	print_in_quotes
print_in_quotes:
	add	t0, a0, zero		# copy str to t0	
	
	addi	a0, zero, '"'
	li	a7, 11
	ecall
	mv	a0, t0
	li	a7, 4
	ecall
	li	a0, '"'
	li	a7, 11	     
	ecall
	li	a0, '\n'
	li	a7, 11
	ecall
	jr	ra		
		
#	Global arrays of char for use in testing copycat and lab4reverse.
	.data
	
	.align	5
	# char array1[32] = { '\0', '*', ..., '*' };
array1:	.byte	0, '*', '*', '*', '*', '*', '*', '*'	
	.byte	'*', '*', '*', '*', '*', '*', '*', '*'	
	.byte	'*', '*', '*', '*', '*', '*', '*', '*'	
	.byte	'*', '*', '*', '*', '*', '*', '*', '*'
	
	# char array2[] = "X";	
array2:	.asciz "X"
		
	# char array3[] = "YZ";	
array3:	.asciz "YZ"
		
	# char array4[] = "123456";	
array4:	.asciz "123456"
		
	# char array5[] = "789abcdef";	
array5:	.asciz "789abcdef"
		
#	int main(void)
#
#	string constants used by main
	.data
sc0:	.asciz ""
sc1:	.asciz	"good"
sc2:	.asciz "bye"
sc3:	.asciz "After 1st call to copycat, array1 has "
sc4:	.asciz "After 2nd call to copycat, array1 has "
sc5:	.asciz "After 3rd call to copycat, array1 has "
sc6:	.asciz "After 4th call to copycat, array1 has "
sc7:	.asciz "After use of lab4reverse, array2 has "
sc8:	.asciz "After use of lab4reverse, array3 has "
sc9:	.asciz "After use of lab4reverse, array4 has "
sc10:	.asciz "After use of lab4reverse, array5 has "

	.text
	.globl	main
main:
	# Prologue only needs to save ra
	addi	sp, sp, -32
	sw	ra, 0(sp)
	
	# Body
	# Start tests of copycat.
	la	a0, array1	# a0 = array1
	la	a1, sc0		# a1 = sc0
	la	a2, sc0		# a2 = sc0
	jal	copycat
	la	a0, sc3
	li	a7, 4
	ecall	
	la	a0, array1	# a0 = array1
	jal	print_in_quotes
	
	la	a0, array1	# a0 = array1
	la	a1, sc1		# a1 = sc1
	la	a2, sc0		# a2 = sc0
	jal	copycat
	la	a0, sc4
	li	a7, 4
	ecall	
	la	a0, array1	# a0 = array1
	jal	print_in_quotes
	
	la	a0, array1	# a0 = array1
	la	a1, sc0		# a1 = sc0
	la	a2, sc2		# a2 = sc2
	jal	copycat
	la	a0, sc5
	li	a7, 4
	ecall	
	la	a0, array1	# a0 = array1
	jal	print_in_quotes
	
	la	a0, array1	# a0 = array1
	la	a1, sc1		# a1 = sc1
	la	a2, sc2		# a2 = sc2
	jal	copycat
	la	a0, sc6
	li	a7, 4
	ecall	
	la	a0, array1	# a0 = array1
	jal	print_in_quotes
	
	# End tests of lab4cat; start tests of lab4reverse.
	la	a0, array2	# a0 = array2
	jal	lab4reverse
	la	a0, sc7
	li	a7, 4
	ecall
	la	a0, array2	# a0 = array2
	jal	print_in_quotes
	
	la	a0, array3	# a0 = array3
	jal	lab4reverse
	la	a0, sc8
	li	a7, 4
	ecall
	la	a0, array3	# a0 = array3
	jal	print_in_quotes
	
	la	a0, array4	# a0 = array4
	jal	lab4reverse
	la	a0, sc9
	li	a7, 4
	ecall
	la	a0, array4	# a0 = array4
	jal	print_in_quotes
	
	la	a0, array5	# a0 = array5
	jal	lab4reverse
	la	a0, sc10
	li	a7, 4
	ecall
	la	a0, array5	# a0 = array5
	jal	print_in_quotes
		
	# End tests of lab4reverse.
	
	mv	a0, zero	# r.v. from main = 0
	
	# Epilogue
	lw	ra, 0(sp)
	addi	sp, sp, 32
	jr	ra
