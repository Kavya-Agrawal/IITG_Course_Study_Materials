#int my_sum(int a, int b, int c, int d, int e)
#{
#    int sum = 0;
#    sum = a+b+c+d+e;
#
#   return sum;
#}
#
#int main()
#{
#    int a, b, c, d, e, sum;
#    a = 1;
#    b = 2;
#    c = 3;
#    d = 4;
#    e = 5;
#
#    sum = my_sum(a,b,c,d,e);
#
#    return 1;
#}      



.text
.globl main


main: 
	addi	$sp, $sp, -36 	# Create space for local variables and saved registes
	sw 	$31, 32($sp)	# Save the return address ($ra)
	sw	$fp, 28($sp)	# Save the current frame pointer
	move 	$fp, $sp		# 

	li	$8, 1			# $t0 = 1
	sw 	$8, 24($fp)		# Local variable a = 1
	li	$8, 2
	sw	$8, 20($fp)		# local variable b = 2
	li	$8, 3
	sw	$8, 16($fp)		# local variable c = 3
	li	$8, 4
	sw	$8, 12($fp)		# local variable d = 4
	li	$8, 10
	sw	$8, 8($fp)		# local variable e = 5
					# local variable sum is created on 4($fp)

	# Using 4 register to pass 4 parameters
	lw 	$4, 24($fp)		# ($a0) $4 = a
	lw	$5, 20($fp)		# $a1 = b
	lw	$6, 16($fp)		# $a2 = c
	lw	$7, 12($fp)		# $a3 = d

	# Parameter e is passed using stack
	lw	$8, 8($fp)		# $t0 = e
	sw	$8, 0($fp)		# parameter is copied)

	jal 	my_sum		# returns the result in $v0 ($2)
	move 	$3, $2		# For checking the output from simulator -- extra code
	sw	$2, 4($fp)		# result is copied to the variable sum
	
	move  $sp,$fp
      lw    $31,32($sp)
      lw    $fp,28($sp)
	addi	$sp, $sp, 36

	li $2, 10
	syscall


my_sum:
	addi $sp, $sp, -12
	sw 	$31, 8($sp)		# Save the return address ($ra)
	sw	$fp, 4($sp)		# Save the current frame pointer
	move 	$fp, $sp		# 

	li 	$8, 0
	sw	$8, 0($fp)		# sum = 0
	add	$2, $4, $5		# $2 = a + b
	add	$2, $2, $6		# $2 = a + b + c
	add	$2, $2, $7		# $2 = a + b + c + d
	lw	$8, 12($fp)		# ($t0) $8 = e
	add	$2, $2, $8		# $2 = a + b + c + d + e
	
	sw 	$2, 0($fp)		# sum = a + b + c + d + e

	move 	$sp, $fp
	lw	$31, 8($sp)
	lw	$fp, 4($sp)
	addi	$sp, $sp, 12
	jr	$31			# Return to main

 

