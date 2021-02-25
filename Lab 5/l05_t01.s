/*
-------------------------------------------------------
l05_t01.s
Traverses and sums all elements of an integer list.

R0: Temp storage of value in list
R1: Sum of the values
R2: Address of start of list
R3: Address of end of list

-------------------------------------------------------
Author:  Nausher Rao
ID:      190906250
Email:   raox6250@mylaurier.ca
Date:    2020-12-14
-------------------------------------------------------
*/
.org	0x1000	     // Start at memory location 1000
.text                // Code section
.global _start
_start:

LDR    R1, =0        // Load register 1 with 0 ***
LDR    R2, =Data     // Store address of start of list 
LDR    R3, =_Data    // Store address of end of list

Loop:
LDR    R0, [R2], #4	 // Read address with post-increment (R0 = *R2, R2 += 4)
ADD    R1, R1, R0    // Add the value in the temp register to the sum register ***
CMP    R3, R2        // Compare current address with end of list
BNE    Loop          // If not at end, continue

_stop:
B	_stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:	                        // End of list address

.end
