/*
-------------------------------------------------------
l01_t01.s
Prints a bunch of strings using an enter-terminating character 
to seperate the strings into the UART using a subroutine.
-------------------------------------------------------
Author:  Nausher Rao
ID:      190906250
Email:   raox6250@mylaurier.ca
Date:    2020-12-14
-------------------------------------------------------
*/
.org    0x1000    // Start at memory location 1000
.text             // Code section
.global _start
_start:

LDR R4, =First
BL  PrintString
LDR R4, =Second
BL  PrintString
LDR R4, =Third
BL  PrintString
LDR R4, =Last
BL  PrintString

_stop:
B    _stop

// Subroutine constants
.equ UART_BASE, 0xff201000     // UART base address

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
.asciz  "First string"
Second:
.asciz  "Second string"
Third:
.asciz  "Third string"
Last:
.asciz  "Last string"
_Last:    // End of list address

.end
