/*
-------------------------------------------------------
l03_t01.s
A simple count down program (BGT)
-------------------------------------------------------
Author:  Nausher Rao
ID:      190906250
Email:   raox6250@mylaurier.ca
Date:    2021-02-01
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

.text	// code section
// Store data in registers
MOV	R3, #5		// Initialize a countdown value
	
TOP:
SUB	R3, R3, #1	// Decrement the countdown value
CMP	R3, #0		// Compare the countdown value to 0
BGT	TOP	        // Branch to TOP if > 0

_stop:
B	_stop

.end

// When using BGT, the value in R3 is 0. When using BGE, the value is -1