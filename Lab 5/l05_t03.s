/*
-------------------------------------------------------
l05_t03.s
Traverses, sums, counts, and finds the minimum and maximum elements of all elements of an integer list.

R0: Temp storage of value in list
R1: Sum of the values
R2: Address of start of list
R3: Address of end of list
R4: Count of the values
R5: Count of the bytes of the values
R6: Minimum value of the list
R7: Maximum value of the list

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

LDR    R1, =0        // Load register 1 with 0. ***
LDR    R2, =Data     // Store address of start of list.
LDR    R3, =_Data    // Store address of end of list.
LDR    R4, =0        // Load register 4 with 0. ***
LDR    R5, =0        // Load register 5 with 0. ***
LDR    R6, [R2]      // Load register 6 with the first value of the list. ***
LDR    R7, [R2]      // Load register 7 with the first value of the list. ***

Loop:
LDR    R0, [R2], #4	 // Read address with post-increment (R0 = *R2, R2 += 4)

CMP    R6, R0        // Compares the current min value in R6 to the temp value in R0. ***
MOVGT  R6, R0        // Move the temporary register 0 value to the minimum register R6. ***
CMP    R7, R0        // Compares the current max value in R7 to the temp value in R0. ***
MOVLT  R7, R0        // Move the temporary register 0 value to the maximum register R7. ***

ADD    R1, R1, R0    // Add the value in the temp register to the sum register. ***
ADD    R4, R4, #1    // Increments the count by 1 in the count register. ***
ADD    R5, R5, #4    // Increments the count by 4 in the byte count register. (Could also just multiply the count register by 4 at the end) ***

CMP    R3, R2        // Compare current address with end of list.
BNE    Loop          // If not at end, continue.

_stop:
B	_stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:	                        // End of list address
.end
