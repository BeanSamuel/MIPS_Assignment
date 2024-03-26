.data 
    inputStr: .asciiz "Give a number: "
    outputStr: .asciiz "The ternary form of the number: "
    endline: .asciiz "\n"
.text
main:
    # Give Input message and store input numbers to $a0 and $a1
    li $v0, 4
    la $a0, inputStr
    syscall
    li $v0, 5
    syscall
    # save first input number
    add $a0, $v0, $zero
    
    # TODO: terminate condition
	# hint: terminate when input number is less or equal than 0
	sgt $t0, $a0, $zero

	beqz $t0, exit
    
    # call Ternary function recursively
    jal Ternary
    add $t0, $v0, $zero
    
    # print '\n'
    li $v0, 4
    la $a0, endline
    syscall
    # return to main
    j main
# END Main

Ternary:
    # save in the stack
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
	
	# assign input number to $s0
    add $s0, $a0, $zero
    
    # TODO: Do the algorithm
    # recursive end condition
    addi $t1, $zero, 3 
    div $s0, $t1
    mflo $a0  # quotient
    mfhi $s1  
    
    slti $t0, $s0, 3
    bnez $t0, retTernary
    # End of the algorithm

	jal Ternary

return:
	# TODO: What do you need to return?
	move $a0, $s1


    # print the digits
    add $a0, $s1, $zero
    li $v0, 1
    syscall
     
restore:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    
    jr $ra

retTernary:
	# print output string
    li $v0, 4
    la $a0, outputStr
    syscall
    
    j return
# END Ternary

exit:
    # The program is finished running
    li $v0, 10
    syscall
