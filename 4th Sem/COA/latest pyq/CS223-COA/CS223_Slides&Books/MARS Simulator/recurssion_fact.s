
.data

Input: .asciiz "Please Enter the number whose factorial is to be calculated: "
Output: .asciiz "The Factorial of the Number is: "

.text
.globl main

main:

# This part of main takes the input from the user by first printing the string “Input” and then reading an integer from the console which the user will enter.
# It basically implements the “cin” part of the C++ code. The input value is read into $v0. Write your code for this part here:

        li $v0, 4              # Print the String at Label “Input”
        la $a0, Input
        syscall
        li $v0, 5              # Read integer from user
        syscall
	add $a0, $v0, $zero    # Pass integer to input argument register $a0
	jal fact               # Function call to the Factorial Function. Make sure that the input argument is passed in the register $a0. Also make sure that fact returns the result in $v0.
        
        add $t0, $v0, $zero    # Move factorial result into temp $t0

 
# This part of the main prints the result of the factorial onto the console. It first prints the string “Output” and then prints the result of the factorial which is an integer. 
# It basically implements the “cout” part of the C++ Code. Write the code for this part here:

	li $v0, 4               # Print the String at the Label “Output”
        la $a0, Output
        syscall
	add $a0, $t0, $zero     # Move Result to $a0 to Print it
	li $v0, 1
	syscall             
	  
 # This part of main uses syscall to End the program and exit.
End_Prog:
	li $v0, 10             
	syscall

 

 # The procedure fact is implemented here.
fact:                                                       
	subi $sp, $sp, 4          # Decrement the stack pointer by 4
	sw $ra, 0($sp)            # Push the value of $ra on to the stack
	subi $sp, $sp, 4          # Decrement the stack pointer by 4
	sw $a0, 0($sp)            # Push the value of $a0 on to the stack
	slti $t0, $a0, 1          # Check the base condition
	beq $t0, $zero, L1        # Branch to Label L1 if base condition not met
	addi $v0, $zero, 1        # Put 1 in $v0 as the base condition requires
	lw $a0, 0($sp)            # Pop the value of $a0 from the stack
	addi $sp, $sp, 4          # Increment the stack pointer by 4
	lw $ra, 0($sp)            # Pop the value of $ra from the stack
	addi $sp, $sp, 4          # Decrement the stack pointer by 4
	jr $ra                    # Jump to the address contained in $ra
	
# Label L1
L1:                                                     

	subi $a0, $a0, 1         # Base condition not met, perform (n-1)
	jal fact                 # Call function fact again with (n-1)
	lw $a0, 0($sp)           # Pop the value of $a0 from the stack
	addi $sp, $sp, 4         # Increment the stack pointer by 4
	lw $ra, 0($sp)           # Pop the value of $ra from the stack
	addi $sp, $sp, 4         # Increment the stack pointer by 4
	mult $a0, $v0            # Perform multiplication n*fact(n-1)
	mflo $v0                 # Read LO into $v0, assume result fits in 32 bits
	jr $ra                   # Jump to the address contained in $ra

 