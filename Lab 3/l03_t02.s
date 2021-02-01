/*
-------------------------------------------------------
l03_t02.s
A simple count down program (BGE)
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

// Store data in registers
LDR	R3, =Counter

TOP:
SUB	R3, R3, #1 // Decrement the countdown value
CMP	R3, #0 // Compare the countdown value to 0
BGE	TOP // Branch to top under certain conditions
	
// End program
_stop: 
B	_stop

.data
Counter:
.word 5
.end