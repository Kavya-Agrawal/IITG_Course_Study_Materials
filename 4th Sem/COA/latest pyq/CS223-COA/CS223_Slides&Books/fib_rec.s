#int fib(int n)
#{
#    if (n == 0) return 0;
#    else if (n == 1) return 1;
#    else return fib(n-1) + fib (n-2);
#}

#int main()
#{
#    int i, j;

#    i = 2;
#    j = 1;
#    fib(i+j);
#    return 1;
#}




.text
.globl main

main:
        addiu   $sp,$sp,-40
        sw      $31,36($sp)
        sw      $fp,32($sp)
        move    $fp,$sp
        li      $2,2                        # 0x2
        sw      $2,24($fp)
        li      $2,3                        # 0x1
        sw      $2,28($fp)
        lw      $3,24($fp)
        lw      $2,28($fp)
        nop
        addu    $2,$3,$2
        move    $4,$2
        jal     fib
        nop

	  move    $3, $2				# For viewing the result in simulator

        li      $2,1                        # 0x1
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
        # jr      $31
        nop
end:
	  li $v0, 10
	  syscall



fib:
        addiu   $sp,$sp,-40
        sw      $31,36($sp)
        sw      $fp,32($sp)
        sw      $16,28($sp)
        move    $fp,$sp
        sw      $4,40($fp)
        lw      $2,40($fp)
        nop
        bne     $2,$0,$L2
        nop

        move    $2,$0
        b       $L3
        nop

$L2:
        lw      $3,40($fp)
        li      $2,1                        # 0x1
        bne     $3,$2,$L4
        nop

        li      $2,1                        # 0x1
        b       $L3
        nop

$L4:
        lw      $2,40($fp)
        nop
        addiu   $2,$2,-1
        move    $4,$2
        jal     fib
        nop

        move    $16,$2
        lw      $2,40($fp)
        nop
        addiu   $2,$2,-2
        move    $4,$2
        jal     fib
        nop

        addu    $2,$16,$2
$L3:
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        lw      $16,28($sp)
        addiu   $sp,$sp,40
        jr      $31
        nop










