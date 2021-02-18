# xSpim Memory Demo Program

#  Data Area
.data

space:
    .asciiz " "

newline:
    .asciiz "\n"

dispArray:
    .asciiz "\nCurrent Array:\n"

convention:
    .asciiz "\nConvention Check\n"

myArray:
	.word 0 33 123 -66 332 -1 -223 453 9 45 -78 -14  

#Text Area (i.e. instructions)
.text

main:
    ori     $v0, $0, 4          
    la      $a0, dispArray 
    syscall

    ori     $s1, $0, 12
    la      $s0, myArray

    add     $a1, $0, $s1
    add     $a0, $0, $s0
 
    jal     DispArray

    ori     $s2, $0, 0
    ori     $s3, $0, 0
    ori     $s4, $0, 0
    ori     $s5, $0, 0
    ori     $s6, $0, 0
    ori     $s7, $0, 0
    
    add     $a1, $0, $s1
    add     $a0, $0, $s0

    jal     IterativeMax

    add     $s1, $s1, $s2
    add     $s1, $s1, $s3
    add     $s1, $s1, $s4
    add     $s1, $s1, $s5
    add     $s1, $s1, $s6
    add     $s1, $s1, $s7

    add     $a1, $0, $s1
    add     $a0, $0, $s0
    jal     DispArray

    j       Exit

DispArray:
    addi    $t0, $0, 0 
    add     $t1, $0, $a0

dispLoop:
    beq     $t0, $a1, dispend
    sll     $t2, $t0, 2
    add     $t3, $t1, $t2
    lw      $t4, 0($t3)

    ori     $v0, $0, 1
    add     $a0, $0, $t4
    syscall

    ori     $v0, $0, 4
    la      $a0, space
    syscall

    addi    $t0, $t0, 1
    j       dispLoop    

dispend:
    ori     $v0, $0, 4
    la      $a0, newline
    syscall
    jr      $ra 

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi $v0, $zero, -1
    addi $v1, $zero, -1
    addi $a0, $zero, -1
    addi $a1, $zero, -1
    addi $a2, $zero, -1
    addi $a3, $zero, -1
    addi $k0, $zero, -1
    addi $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

IterativeMax:

    addiu $sp, $sp, -28
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    sw $ra, 24($sp)

    move $s0, $a0
    move $s1, $a1
    lw $s2, 0($a0)

    move $t0, $s0
    li $t1, 1

    j loop

loop:

    lw $t2, 0($t0)

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    move $a0, $t2
    move $a1, $s2

    jal checkmax

    li $v0, 1
    move $a0, $v1
    syscall

    move $s2, $v1
    move $s3, $t0
    move $s4, $t2
    move $s5, $t1

    jal ConventionCheck

    move $t0, $s3
    move $t2, $s4
    move $t1, $s5
    move $v1, $s2

    addiu $t0, $t0, 4
    addi $t1, $t1, 1

    bge $s1, $t1, loop

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $s5, 20($sp)
    lw $ra, 24($sp)

    addiu $sp, $sp, 28

    # Do not remove this line
    jr      $ra

checkmax:
    bgt $a0, $a1, swap
    move $v1, $a1
    jr $ra

swap:
    move $v1, $a0
    jr $ra
    
