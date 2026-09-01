# Start .text segment (program code)

  .text
  .globl main
  
main:
  li $t0, 25
  addi $t2, $t0, 1
  li $v0, 10
  syscall
  
  # How do we exit the program? Through system calls
  # Many calls are there and we can pick appropriate one.
  # 10 is the code for exit and place it in $v0 
