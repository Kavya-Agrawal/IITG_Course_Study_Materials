	.text
	.globl main
main: la $t0, value
	  li $t2, 0		#store the sum
	  li $t3, 0		#Use for counter
	  
loop: lw  $t1, 0($t0)
	  add $t2, $t2, $t1
	  addi $t3, $t3, 1
	  addi $t0, $t0, 4
	  bne $t3, 10, loop
	  
	  li $v0, 1		#Exit
	  move $a0, $t2
	  syscall
	  
	  li $v0, 10	#Exit
	  syscall
	.data
value: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10