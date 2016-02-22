# FP program
		.data
matrix_a:
		.word   1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12
		.word  13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24
		.word  25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36
		.word  37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48
		.word  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60
		.word  61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72
		.word  73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84
		.word  85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96
		.word  97, 98, 99,100,101,102,103,104,105,106,107,108
		.word 109,110,111,112,113,114,115,116,117,118,119,120
		.word 121,122,123,124,125,126,127,128,129,130,131,132
		.word 133,134,135,136,137,138,139,140,141,142,143,144

matrix_b:
		.word 133,134,135,136,137,138,139,140,141,142,143,144
		.word 121,122,123,124,125,126,127,128,129,130,131,132
		.word 109,110,111,112,113,114,115,116,117,118,119,120
		.word  97, 98, 99,100,101,102,103,104,105,106,107,108
		.word  85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96
		.word  73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84
		.word  61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72
		.word  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60
		.word  37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48
		.word  25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36
		.word  13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24
		.word   1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12

matrix_c:
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		.word   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0

bs:		.word 4
n:		.word 12

nline:  .asciiz "\n"				#Define new line string
sp:	.asciiz " "
msga: .asciiz "Matrix A is: \n"
msgb: .asciiz "Matrix B is: \n"
msgc: .asciiz "Matrix C=A*B is: \n"

		.text
		.globl main
main:

		la	$s0, bs	
		lw	$s0, 0($s0)
		la	$s1, n
		lw	$s1, 0($s1)
		la	$s2, matrix_a
		la	$s3, matrix_b
		la	$s4, matrix_c

		la	$a0, msga
		la 	$a1, matrix_a
		jal	PRINT_MAT 
		la	$a0, msgb
		la 	$a1, matrix_b
		jal	PRINT_MAT 

# Your CODE HERE
		# Name: Amit Pachore - 010317047
		# Date: Nov 19, 2015
		#Instruction Count: 26688
		
		#load addresses of all 3 matrices
		la	$t0, matrix_a
		la	$t1, matrix_b
		la	$t2, matrix_c
		
		#Calculate Memory block sizes to to adjust memory locations
		mul 	$t7,$s1,4    #12*4=48       -- 0x30 - one row memory size # here 12 memory locations (e.g from (1,1) to (1,12))
		mul	$s5,$s0,4    #bs(4)*4 = 16  -- 0x10 - one row of block memory size # 4 memory location (e.g from (1,1) to (1,4))
		mul	$s6,$t7,$s0  #48*bs(4)= 192 -- 0xC0 - 4 rows block memory size(e.g from (1,1) to (4,1)) 
		mul	$s7,$t7,$s1  #12 rows block memory size-(e.g from (1,1) to (12,1))
		
		addi	$t9,$0,0	# Loop 6 Counter
loop6:		addi	$t8,$0,0	# Loop 5 Counter
loop5:		addi	$a3,$0,0	# Loop 4 Counter
loop4:		addi	$a2,$0,0	# Loop 3 Counter
loop3:		addi	$a0,$0,0	# Loop 2 Counter
loop2: 		addi	$a1,$0,0	# Loop 1 Counter
		lw	$t6,0($t2)	# loads previous stored value of Matrix C element (e.g. C 1x1)
loop1:		lw	$t3,0($t0)	# Value of matrix A element
		lw	$t4,0($t1)	# Value of matrix B element
		mul	$t5,$t3,$t4	
		add	$t6,$t6,$t5
		addi	$t0,$t0,4	# Memory location adjustment to access next element of A
		add	$t1,$t1,$t7	# Memory location adjustment to access next element of B
		addi	$a1,$a1,1	
		blt	$a1,$s0,loop1
		
		# Adjsuts memory pointer to next column of block in consideration of matrix B
		#and 1st element of matrix A block
		sw	$t6,0($t2)
		sub	$t0,$t0,$s5	
		sub	$t1,$t1,$s6	
		addi	$t1,$t1,4
		addi	$t2,$t2,4
		addi	$a0,$a0,1
		blt	$a0,$s0,loop2
		
		# Adjsuts memory pointer to next row of block in consideration of matrix A 
		#and 1st element of matrix B block
		add	$t0,$t0,$t7
		sub	$t1,$t1,$s5
		sub	$t2,$t2,$s5
		add	$t2,$t2,$t7
		addi	$a2,$a2,1
		blt	$a2,$s0,loop3
		
		# Adjsuts memory pointer to move on next block of matrix A in row
		#and next block of martrix B in column
		sub	$t0,$t0,$s6
		add 	$t0,$t0,$s5
		add	$t1,$t1,$s6
		sub	$t2,$t2,$s6
		add	$a3,$a3,$s0
		blt	$a3,$s1,loop4
		
		# Adjsuts memory pointer to access same set of Matrix A block
		# but different blocks of matrix B ... in next set of columns
		sub	$t0,$t0,$t7
		sub	$t1,$t1,$s7
		add	$t1,$t1,$s5
		add 	$t2,$t2,$s5
		add 	$t8,$t8,$s0
		blt	$t8,$s1,loop5
		
		# In next set of rows of martix A with all blocks of matrix B
		add	$t0,$t0,$s6
		sub	$t1,$t1,$t7
		sub	$t2,$t2,$t7
		add	$t2,$t2,$s6
		add	$t9,$t9,$s0
		blt	$t9,$s1,loop6
		
# End CODE

		la	$a0, msgc
		la 	$a1, matrix_c
		jal	PRINT_MAT 

#   Exit
		li	 $v0,10
    	syscall


PRINT_MAT:	li	$v0,4
		syscall
		addi $a2,$0,0	
PL4:	bge	$a2,$s1,PL1
		addi $a3,$0,0
PL3:	bge	$a3,$s1,PL2

		lw	$a0,0($a1)
		li	$v0,1
		syscall
		la	$a0,sp
		li	$v0,4
		syscall
		addi $a1,$a1,4
		addi $a3,$a3,1
		b 	PL3

PL2:	addi	$a2,$a2,1
		la	$a0,nline
		li	$v0,4
		syscall
		b	PL4
PL1:	jr	$ra
