/*
-------------------------------------------------------
l04_t01.s 
reads a string from the UART and writes that string back 
to the UART until the enter key is pressed.
-------------------------------------------------------
Author:  Nausher Rao
ID:      190906250
Email:   raox6250@mylaurier.ca
Date:    2020-11-03
-------------------------------------------------------
*/
// Constants            
.equ UART_BASE, 0xff201000 // UART base address
.equ SIZE, 80 // Size of string buffer storage (bytes)
.equ VALID, 0x8000 // Valid data in UART mask
.equ ENTER, 0x0a
.org 0x1000 // Start at memory location 1000
.text // Code section
.global _start
_start:

// read a string from the UART
LDR  R1, =UART_BASE
        
LOOP:
LDRB R0, [R1]  // read the UART data register
TST R0, #VALID //check if there is new data

CMP R0, #ENTER //comparing current byte with the enter key value
BEQ _stop

STR R0, [R1] //copy the character to the UART DATA field

B    LOOP

_stop:
B    _stop

.end

// What happens if you type in data without pressing the enter key and run the program?
// the program will take the last character in the read fifo and print it until overflow if no enter key is pressed
	