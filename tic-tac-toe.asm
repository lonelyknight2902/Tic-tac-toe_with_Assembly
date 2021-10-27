	.data
title: .asciiz "\n\n\tTic Tac Toe\n"
player: .asciiz "\nPlayer 1 (X)  -  Player 2 (O)\n"
grid: .byte '1','2','3','4','5','6','7','8','9'
vertical: .asciiz "     |     |     \n"
horizontal: .asciiz "_____|_____|_____\n"
space: .asciiz "  "
seperator: .asciiz "|"
newline: .asciiz "\n"
enter: .asciiz ", enter your move: "
play: .asciiz "Player "
invalid: .asciiz "Invalid move\n"
win: .asciiz " wins\n"
tie: .asciiz "It's a draw\n"
	.text
main:
	la $a0, title
	addi $v0, $0, 4
	addi $t0, $0, 1	#variable for player turn
	addi $t1, $0, 1
	addi $s4, $0, 0 #variable for checking draw
	addi $s5, $0, 9
	syscall	#print title
Redraw:
	jal draw
	bne $t0, $t1, p2 #if $t0 == 1, player 1, $s1 register stores 'X', else stores 'O'
	addi $s1, $0, 'X'
	j Play
p2:	addi $s1, $0, 'O'
Play:	
	la $a0, play
	addi $v0, $0, 4
	syscall
	addi $a0, $t0, 0
	addi $v0, $0, 1
	syscall
	la $a0, enter
	addi $v0, $0, 4
	syscall
	addi $v0, $0, 5
	syscall
	slti $t5, $v0, 1
	bne $t5, $t1, Valid1
	la $a0, invalid
	addi $v0, $0, 4
	syscall
	j Play
Valid1:
	slt $t5, $s5, $v0
	bne $t5, $t1, Valid2
	la $a0, invalid
	addi $v0, $0, 4
	syscall
	j Play
Valid2:
	la $s2, grid
Loop:
	beq $v0, $t1, Found #finding the position chosen by the player
	addi $s2, $s2, 1
	addi $v0, $v0, -1
	j Loop
Found:
	addi $t2, $0, 'X'
	addi $t3, $0, 'O'
	lb $t4, 0($s2)
	bne $t4, $t2, ValidO #check if it's occupied or not
	la $a0, invalid
	addi $v0, $0, 4
	syscall
	j Play
ValidO:
	bne $t4,$t3, ValidX
	la $a0, invalid
	addi $v0, $0, 4
	syscall
	j Play
ValidX:
	sb $s1, 0($s2) #store the player move into that position of the array
	jal checkWin
	beq $v0, $0, Continue #if checkWin return 1, the player who play the latest move win.
	j Win
Continue:
	addi $s4, $s4, 1
	beq $s4, $s5, Tie #if the number of moves reach 9 and no one wins, it's a draw
	bne $t0, $t1, decrement #else we will toggle the player turn.
	addi $t0, $t0, 1
	j Redraw
decrement:	
	addi $t0, $t0, -1
	j Redraw
draw: 
	la $s0, grid
	la $a0, player
	addi $v0, $0, 4
	syscall
	la $a0, vertical
	syscall
	la $a0, space
	syscall
	lb $a0, 0($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, seperator
	syscall
	la $a0, space
	syscall
	lb $a0, 1($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, seperator
	syscall
	la $a0, space
	syscall
	lb $a0, 2($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, newline
	syscall
	la $a0, horizontal
	syscall
	la $a0, vertical
	syscall
	la $a0, space
	syscall
	lb $a0, 3($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, seperator
	syscall
	la $a0, space
	syscall
	lb $a0, 4($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, seperator
	syscall
	la $a0, space
	syscall
	lb $a0, 5($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, newline
	syscall
	la $a0, horizontal
	syscall
	la $a0, vertical
	syscall
	la $a0, space
	syscall
	lb $a0, 6($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, seperator
	syscall
	la $a0, space
	syscall
	lb $a0, 7($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, seperator
	syscall
	la $a0, space
	syscall
	lb $a0, 8($s0)
	addi $v0, $0, 11
	syscall
	addi $v0, $0, 4
	la $a0, space
	syscall
	la $a0, newline
	syscall
	la $a0, vertical
	syscall
	jr $ra
checkWin:
	la $s3, grid
	addi $v0, $0, 0
Case1:
	lb $t2, 0($s3)
	lb $t3, 1($s3)
	lb $t4, 2($s3)
	bne $t2, $t3, Case2
	bne $t2, $t4, Case2
	addi $v0, $0, 1
	jr $ra
Case2:
	lb $t2, 3($s3)
	lb $t3, 4($s3)
	lb $t4, 5($s3)
	bne $t2, $t3, Case3
	bne $t2, $t4, Case3
	addi $v0, $0, 1
	jr $ra
Case3:
	lb $t2, 6($s3)
	lb $t3, 7($s3)
	lb $t4, 8($s3)
	bne $t2, $t3, Case4
	bne $t2, $t4, Case4
	addi $v0, $0, 1
	jr $ra
Case4:
	lb $t2, 0($s3)
	lb $t3, 3($s3)
	lb $t4, 6($s3)
	bne $t2, $t3, Case5
	bne $t2, $t4, Case5
	addi $v0, $0, 1
	jr $ra
Case5:
	lb $t2, 1($s3)
	lb $t3, 4($s3)
	lb $t4, 7($s3)
	bne $t2, $t3, Case6
	bne $t2, $t4, Case6
	addi $v0, $0, 1
	jr $ra
Case6:
	lb $t2, 2($s3)
	lb $t3, 5($s3)
	lb $t4, 8($s3)
	bne $t2, $t3, Case7
	bne $t2, $t4, Case7
	addi $v0, $0, 1
	jr $ra
Case7:
	lb $t2, 0($s3)
	lb $t3, 4($s3)
	lb $t4, 8($s3)
	bne $t2, $t3, Case8
	bne $t2, $t4, Case8
	addi $v0, $0, 1
	jr $ra
Case8:
	lb $t2, 2($s3)
	lb $t3, 4($s3)
	lb $t4, 6($s3)
	bne $t2, $t3, Else
	bne $t2, $t4, Else
	addi $v0, $0, 1
	jr $ra
Else:
	jr $ra
Win:
	jal draw
	bne $t0, $t1, player2
	addi $s1, $0, '1'
	j winner
player2:	
	addi $s1, $0, '2'
winner:
	la $a0, play
	addi $v0, $0, 4
	syscall
	addi $a0, $s1, 0
	addi $v0, $0, 11
	syscall
	la $a0, win
	addi $v0, $0, 4
	syscall
	j Exit
Tie:
	jal draw
	la $a0, tie
	addi $v0, $0, 4
	syscall
Exit:
