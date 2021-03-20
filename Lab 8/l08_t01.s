/*
-------------------------------------------------------
l08_t01.s
Working with stack frames.
-------------------------------------------------------
Author: Nausher Rao
ID: 190906250
Email: raox6250@mylaurier.ca
Date:    2020-03-14
-------------------------------------------------------
*/
.equ SIZE, 80            // Constants
.org    0x1000           // Start at memory location 1000
.text                    // Code section
.global _start
_start:

MOV    R3, #SIZE         // Set the maximum comparison length
STMFD  SP!, {R3}         // Push the maximum length
LDR    R3, =second
STMFD  SP!, {R3}         // Push the second string address
LDR    R3, =first
STMFD  SP!, {R3}         // Push the first string address
BL     strncmp
ADD    SP, SP, #12       // Release the parameter memory from stack

_stop:
B    _stop


strncmp:
/*
-------------------------------------------------------
Determines if two strings are equal up to a max length (iterative)
Equivalent of: strncmp(*str1, *str2, max_buffer_size)
-------------------------------------------------------
Parameters:
  str1 - address of first string
  str2 - address of second buffer
  max_buffer_size - maximum size of str1 and str2
Returns:
  R0 - less than 0 if first string comes first,
       greater than 0 if first string comes second,
       0 if two strings are equal up to maximum length
Uses:
  R1 - address of first string
  R2 - address of second string
  R3 - current maximum length
  R4 - character from first string
  R5 - character from second string
-------------------------------------------------------
*/

STMFD  SP!, {FP, LR}    // Push FP and LR onto the stack
MOV    FP, SP           // Save current stack top to FP
STMFD  SP!, {R1-R5}     // preserve registers

LDR    R1, [FP, #8]    
LDR    R2, [FP, #12]   
LDR    R3, [FP, #16]    
LDR    R4, [FP, #20]   
LDR    R5, [FP, #24]    
MOV    R0, #0           // Initialize result to strings equal

strncmpLoop:
CMP     R3, #0
BEQ     _strncmp        // Max length met - finish comparison
LDRB    R4, [R1], #1    // Get character from first string
LDRB    R5, [R2], #1    // Get character from second string
CMP     R4, R5
SUBNE   R0, R4, R5      // Calculate difference between two characters if not the same
BNE     _strncmp        // Return difference if not the same
CMP     R4, #0          // look for end of first string
BEQ     _strncmp        // return if at end of string
CMP     R5, #0          // look for end of second string
BEQ     _strncmp        // return if at end of string
SUB     R3, R3, #1      // decrement max length count
B       strncmpLoop

_strncmp:
LDMFD  SP!, {R1-R5}
LDMFD  SP!, {FP, PC}

.data
first:
.asciz "aaab"
second:
.asciz "aaaa"
.end