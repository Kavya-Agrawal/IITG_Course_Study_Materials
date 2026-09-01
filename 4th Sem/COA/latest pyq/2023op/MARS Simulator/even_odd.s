	.text
	.globl main
main: li  $v0, 4		#Print "Enter the number :" string
	  la  $a0, str1
	  syscall
	  
	  li $v0, 5		#Read the number
	  syscall
	  move $t0, $v0
	  
	  rem $t1, $t0, 2	#t1 = t0 % 2
	  
	  beq $t1, 1, odd
	  
	  li $v0, 4		#Print "Number is even " string
	  la $a0, str3
	  syscall
	  
	  li $v0, 10		#Exit
	  syscall
	  
odd:  li $v0, 4			#Print "Number is odd " string
	  la $a0, str2
	  syscall
	  
	  li $v0, 10		#Exit
	  syscall
	.data
str1: .asciiz "Enter the number : "
str2: .asciiz "Number is odd "
str3: .asciiz "Number is even "
