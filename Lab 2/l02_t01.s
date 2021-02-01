/*
-------------------------------------------------------
l02_t01.s
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

LDR	R3, =A //Changed from A: to =A
LDR	R0, [R3]
LDR	R3, =B //Changed from B: to =B
LDR	R1, [R3]
ADD	R2, R1, R0 //Removed square bracket from R0
LDR	R3, =Result	
STR	R2, [R3]	
// End program
_stop:
B _stop

.data	     
A:
.word	4
B:
.word	8
.bss	   
Result:
.space 4	
.end