//Chelsea Fernandes
//Reversing Bits and Bytes n 

.extern main6a.c
.syntax unified
.cpu cortex-m4
.text

/***
given function just to return the data
 ***/
	.global CallReturnOverhead
	.thumb_func
	.align
CallReturnOverhead: 
	BX	LR

/***
 given 32 bits, reverse them
 ex: 11001010 -> 01010011
 note: the word is in R0, 32 bits
 ***/
	.global ReverseBits
    .thumb_func
    .align
ReverseBits:
	.rept 32
		CMP	R1, 32          //stop looping after going through all 32 bits
		LSRS	R0, R0, 1   //shift right by 1, remember the carry
		ADC	R2, R2, R2      //put the carry in a new register
	.endr
	MOV 	R0, R2          //R2 has the reversed bits, put it into R0
	BX	LR

/***
given 4 bytes: #1 #2 #3 #4
reverse the bytes so that the new order is 4 3 2 1
***/
	.global ReverseBytes
    .thumb_func
    .align
ReverseBytes:
	MOV	R1, R0          //preserve word in R1
	LSL	R1, R1, 24      //R1<- shift first 8 bits (0-7 = #1) into last 8 bits (24-31)
	
	LSR	R0, R0, 8       //shift R0 so that the next 8 bits (8-15 = #2) we will move is now in bits (0-7)
	BFI	R1, R0, 16, 8   //put those bits into bits (19-23)
	
	LSR     R0, R0, 8   //shift R0 so that the next 8 bits (16-23 = #3) we will move is now in bits (0-7)
	BFI	R1, R0, 8, 8    //put those bits into bits (8-15)
	
	LSR 	R0, R0, 8   //shift R0 so that the next 8 bits (originally bits 24-31 = #4) we will move is now in bits (0-7)
	BFI	R1, R0, 0, 8    //put those bits into bits (0-7)
	
	MOV	R0, R1          //the reversed bytes are in R1, put them in R0
	BX	LR

.end
