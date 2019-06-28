//Chelsea Fernandes

/************************
 task: divide by 13 signed and unsigned
 note: using SDIV and UDIV costs more, so performing shifts is better
************************/

.extern main7-1.c
.syntax unified
.cpu cortex-m4
.text


    .global CallReturnOverhead
	.thumb_func
	.align
CallReturnOverhead:
    BX  LR

/************
 written for runtime comparisons, uses SDIV
 ************/
    .global SDIVby13
	.thumb_func
	.align
SDIVby13:
    MOVS.N  R1,13 
    SDIV    R0,R0,R1
    BX      LR

/************
 written for runtime comparisons, uses UDIV
 ************/
    .global UDIVby13
	.thumb_func
	.align
UDIVby13:
    MOVS.N  R1,13 
    UDIV    R0,R0,R1 
    BX      LR

/************
 division not using SDIV
 ************/
    .global MySDIVby13
	.thumb_func
	.align 
MySDIVby13:
	LDR     R1,=1321528399     
	
	SMMUL   R1,R1,R0            
	ASRS.N  R1,R1,2             
	ADD     R0,R1,R0,LSR 31     
    BX      LR

/************
 division not using UDIV
 ************/
    .global MyUDIVby13
	.thumb_func
	.align
MyUDIVby13:
    LDR     R1,=1321528399      
	UMULL   R1,R0,R0,R1         
	LSR     R0, R0, 2
    BX      LR

.end
