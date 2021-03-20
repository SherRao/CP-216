/*
-------------------------------------------------------
l08_t03.s
Working with stack frames.
-------------------------------------------------------
Author: Nausher Rao
ID: 190906250
Email: raox6250@mylaurier.ca
Date: 2021-03-14
-------------------------------------------------------
*/

.equ SIZE, 80     // Constant
.org       0x1000 // Start at memory location 1000
.text             // Code section
.global _start
_start:

// push parameters onto the stack
MOV    R3, #SIZE   		 // Set the maximum comparison length
STMFD  SP!, {R3}         // Push the maximum length
LDR    R3, =common
STMFD  SP!, {R3}         // Push the common space
LDR    R3, =second
STMFD  SP!, {R3}         // Push the second string address
LDR    R3, =first
STMFD  SP!, {R3}         // Push the first string address

BL     FindCommon
ADD    SP, SP, #16 // clean up the stack

_stop:
B      _stop

//-------------------------------------------------------
FindCommon:
/*
-------------------------------------------------------
Equivalent of: FindCommon(*first, *second, *common, size)
Finds the common parts of two null-terminated strings from the beginning of the
strings. Example:
first: "pandemic"
second: "pandemonium"
common: "pandem", length 6
-------------------------------------------------------
Parameters:
  first - pointer to start of first string
  second - pointer to start of second string
  common - pointer to storage of common string
  size - maximum size of common
Uses:
  R0 - address of first
  R1 - address of second
  R2 - address of common
  R3 - value of max length of common
  R4 - character in first
  R5 - character in second
-------------------------------------------------------
*/

// set up stack
STMFD SP!, {FP, LR} 
MOV FP, SP	
STMFD SP!, {R1-R5}

// extract parameters
LDR R0, [FP, #8]
LDR R1, [FP, #12]
LDR R2, [FP, #16]

FCLoop:
CMP    R3, #1          // is there room left in common?
BEQ    _FindCommon     // no, leave subroutine
LDRB   R4, [R0], #1    // get next character in first
LDRB   R5, [R1], #1    // get next character in second
CMP    R4, R5
BNE    _FindCommon     // if characters don't match, leave subroutine
CMP    R5, #0          // reached end of first/second?
BEQ    _FindCommon
STRB   R4, [R2], #1    // copy character to common
SUB    R3, R3, #1      // decrement space left in common
B      FCLoop

_FindCommon:
MOV    R4, #0
STRB   R4, [R2]        // terminate common with null character

// clean up stack
LDMFD SP!, {R1-R5}
LDMFD SP!, {FP, PC}

/** Data Section */
.data
first:
.asciz "pandemic"
second:
.asciz "pandemonium"
common:
.space SIZE

.end
