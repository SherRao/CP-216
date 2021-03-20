/*
-------------------------------------------------------
l02_t02.s
Assign to and add contents of registers.
-------------------------------------------------------
Author:  Nausher Rao
ID:      190906250
Email:   raxo6250@mylaurier.ca
Date:    2021-01-28
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

LDR	R3, =First
LDR	R0, [R3]
LDR	R3, =Second
LDR	R1, [R3]
ADD	R2, R0, R1
LDR	R3, =Total
STR	R2, [R3]
SUB	R2, R0, R1
LDR	R3, =Diff  // Changed from =difff to =diff
STR	R2, [R3]   // Changed from #3 to [R3]

// End program
_stop:
B _stop

.data	
First:
.word	4
Second:
.word	8
.bss	
Total:
.space 4	
Diff:
.space 4 //Changed .space from 2 to 4
.end


