/*
-------------------------------------------------------
l06_t02.s
Uses subroutined to read from the UART and write to the UART AND memory.
-------------------------------------------------------
Author:  Nausher Rao
ID:      190906250
Email:   raox6250@mylaurier.ca
Date:    2020-12-14
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20    	// Size of string buffer storage (bytes)
.text               // Code section
.org	0x1000	    // Start at memory location 1000
.global _start
_start:

MOV R5, #SIZE
LDR R4, =First
BL	ReadString
LDR R4, =Second
BL	ReadString
LDR R4, =Third
BL  ReadString
LDR R4, =Last
BL  ReadString

LDR R4, =First
BL  PrintString
LDR R4, =Second
BL  PrintString
LDR R4, =Third
BL  PrintString
LDR R4, =Last
BL  PrintString
    
_stop:
B	_stop

// Subroutine constants
.equ UART_BASE, 0xff201000     // UART base address
.equ VALID,     0x8000	       // Valid data in UART mask
.equ DATA,      0x00FF	       // Actual data in UART mask
.equ ENTER,     0x0A	       // End of line character

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  R4 - address of string buffer
  R5 - size of string buffer
Uses:
  R0 - holds character to print
  R1 - address of UART
-------------------------------------------------------
*/
STMFD  SP!, {R0, R1, R4, R5, LR} // Temporarily push onto the stack.
LDR  R1, =UART_BASE
ADD  R5, R4, #SIZE 

LOOP:
LDRB R0, [R1]     // Read a single character from the UART data register.
TST R0, #VALID    // Check if there's new data.

CMP R0, #ENTER    // Check to see if the entered character is the enter-terminating character. (0x0a)
BEQ  _ReadString

STRB R0, [R4]     // Store the character in memory register R4.
ADD R4, R4, #1    // Increment the R4 counter register by 1 to move to the next byte.
CMP R4, R5        // Check to see if memory buffer is full
BEQ _ReadString
B LOOP
_ReadString:
LDMFD  SP!, {R0, R1, R4, R5, PC} // Pop of the stack and restore values.


PrintString:
/*
-------------------------------------------------------
Prints a null terminated string.
-------------------------------------------------------
Parameters:
  R4 - address of string
Uses:
  R0 - holds character to print
  R1 - address of UART
-------------------------------------------------------
*/
STMFD  SP!, {R0, R1, R4, R5, LR}
LDR R1, =UART_BASE

psLOOP:
LDRB R0, [R4], #1   // load a single byte from the string
CMP R0, #0
BEQ  _PrintString   // stop when the null character is found
STR  R0, [R1]       // copy the character to the UART DATA field
B    psLOOP
_PrintString:
LDR R5, =0x0a       // Store the terminating character (0x0a) into register 5
STR R5, [R1]        // Store the value from R5 into the UART.
LDMFD  SP!, {R0, R1, R4, R5, PC}


.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space	SIZE
Third:
.space	SIZE
Last:
.space	SIZE
_Last:        
// End of list address
.end
