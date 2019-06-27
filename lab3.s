//Chelsea Fernandes
//lab3.s

 //src = source ptr = R1, dst = destination ptr = R0

.extern main3.c
.syntax unified
.cpu cortex-m4
.text

//copies 1 byte at a time using LDRB and STRB
	.global	UseLDRB
	.thumb_func
	.align
UseLDRB:
	PUSH {LR}//in order to preserve the addresses of src	
	.rept 512
	LDRB R2, [R1], 1
	STRB R2, [R0], 1
 	.endr
        POP {LR}
        BX LR

//copies 2 bytes at a time using LDRH and STRH
	.global UseLDRH
	.thumb_func
        .align
UseLDRH:
	PUSH {LR}
        .rept 256 // 256 times 2 bytes = 512 bytes
	LDRH R2, [R1], 2
        STRH R2, [R0], 2
	.endr
	POP {LR}
	BX LR

//copies 4 bytes at a time using LDR and STR
	.global UseLDR
	.thumb_func
        .align
UseLDR:
	PUSH {LR}
	.rept 128	
	LDR R2, [R1], 4        
	STR R2, [R0], 4
	.endr
	POP {LR}
	BX LR

//copies 8 bytes at a time using LDRD and STRD
	.global UseLDRD
	.thumb_func
        .align
UseLDRD:	
	PUSH {LR}
	.rept 64
	LDRD R2, R3, [R1], 8
	STRD R2,R3, [R0], 8
	.endr
	POP {LR}
	BX LR

//copies 32 bytes at a time using LDMIA and STMIA
	.global UseLDMIA
	.thumb_func
        .align
UseLDMIA:
	PUSH {R4-R11}
	.rept 16
	LDMIA R1!, {R4-R11}
	STMIA R0!, {R4-R11}
	.endr

	POP {R4-R11}
	BX LR

.end
