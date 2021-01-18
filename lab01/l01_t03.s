/*
-------------------------------------------------------
l01.s
Assign to and add contents of registers.
-------------------------------------------------------
Author:  Nausher Rao
ID:      190906250
Email:   raox6250@mylaurier.ca
Date:    2021-01-18
-------------------------------------------------------
*/
.org    0x1000  // Start at memory location 1000
.text  // Code section
.global _start
_start:

MOV R0, #9       // Store decimal 9 in register R0
MOV R1, #14     // Store decimal 14 in register R1
ADD R2, R1, R0  // Add the contents of R0 and R1 and put result in R2
MOV R3, #8 //Store decimal value 8 into register R3
ADD R3, R3, R3 //Add the value in R3 to itself and store it in itself too 
ADD #4, R3, R4 //Tried to add the immediate decimal value of 4 to the value in regsiter R3 and stores in R4

// End program
_stop:
B   _stop