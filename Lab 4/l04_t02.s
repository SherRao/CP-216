/*
-------------------------------------------------------
l04_t02.s
Reads a string from the UART and writes that string to memory until either the enter
key is pressed or the memory buffer is full.
-------------------------------------------------------
Author:  Nausher Rao
ID:      190906250
Email:   raox6250@mylaurier.ca
Date:    2020-11-03
-------------------------------------------------------
*/
// Constants            
.equ UART_BASE, 0xff201000     // UART base address
.equ SIZE, 80        // Size of string buffer storage (bytes)
.equ VALID, 0x8000   // Valid data in UART mask
.equ ENTER, 0x0a	 // enter stop key
.org    0x1000       // Start at memory location 1000
.text  // Code section
.global _start
_start:

// read a string from the UART
LDR  R1, =UART_BASE
LDR  R4, =READ_STRING
ADD  R5, R4, #SIZE // store address of end of buffer
        
LOOP:
LDRB R0, [R1]  // read the UART data register
TST R0, #VALID    // check if there is new data

CMP R0, #ENTER //check to see if the entered char is enter (0x0a)
BEQ  _stop

STRB R0, [R4]      // store the character in memory
ADD R4, R4, #1    // move to next byte in storage buffer

CMP R4, R5 //check to see if memory buffer is full
BEQ _stop

B    LOOP

_stop:
B    _stop

.data   // Data section
		// Set aside storage for a string
READ_STRING:
.space    SIZE

.end

//reads a string from the UART and writes that string to memory until either the enter
//key is pressed or the memory buffer is full. Do not store the value of the enter key in memory

//What happens to the Read FIFO: if all of its data is not read? Can you run the program again?