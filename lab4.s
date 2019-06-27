//Chelsea Fernandes
//lab4.s

.extern main4.c
.syntax unified
.cpu cortex-m4
.text

//calculates the discriminant of a quadratic
	.global Discriminant	
	.thumb_func
	.align
Discriminant:
	//assumed R0=a, R1=b, R2=c
	MUL	R1,R1,R1 //b^2
	LSL	R0, R0, 2 //4a
	//following is same as above ^MUL R0, R0, 4 
	MLS 	R0, R0, R2, R1
	BX 	LR

//calculates one of the roots of a quadratic
	.global Root1
    .thumb_func
    .align
Root1:
	//assumed R0=a, R1=b, R2=c
	PUSH	{R4, R5, LR}
	LSL     R5, R0, 1 //2a
	NEG     R4, R1
	BL	Discriminant 
	BL 	SquareRoot //takes in Discriminant(a,b,c) as parameter and stores value in R0
	ADD 	R0, R0, R4 //-b+SquareRoot(Discrim(a,b,c))
	SDIV 	R0, R0, R5 //divide top by bottom
	POP 	{R4, R5, PC}
	//no need for BX LR because of POP

//calculates the other root of a quadratic
	.global Root2
    .thumb_func
    .align
Root2:
	//assumed R0=a, R1=b, R2=c
	PUSH    {R4, R5, LR}
        LSL     R5, R0, 1 //2a
        NEG     R4, R1 //negate b => -b
        BL      Discriminant
        BL      SquareRoot //takes in Discriminant(a,b,c) as parameter and stores value in R0
        SUB     R0, R4, R0 //-b-SquareRoot(Discrim(a,b,c))
        SDIV    R0, R0, R5 //divide top by bottom
        POP     {R4, R5, PC}


//finds the f(x)=ax^2+bx+c with given x, a, b, and c
	.global Quadratic
    .thumb_func
    .align
Quadratic:
	//assumed R0=x, R1=a, R2=b, R3=c
	MUL	R2, R0, R2 //bx
	MUL	R0, R0, R0 //x^2
	MUL 	R0, R0, R1 //ax^2
	ADD 	R0, R0, R2 //ax^2 +bx
	ADD 	R0, R0, R3 //(ax^2 + bx) + c
	BX 	LR

//calculates the square root that is used
//assumed R0 = n = value inside square root
	.global SquareRoot
    .thumb_func
    .align
SquareRoot:
	CMP 	R0, 2
	IT 	    LT
	BXLT 	LR  
	
	PUSH    {R4, LR}
	MOV 	R4, R0 //preserve n in R4
	MOV 	R1, 4 //put 4 in R1 so i can use SDIV
	
	SDIV 	R0, R4, R1 //store n/4 to prepare for SquareRoot(n/4)

	BL 	    SquareRoot //stores square root in R0
	LSL 	R0, R0, 1 // 2*SquareRoot(n/4), my small candidate	
	ADD 	R1, R0, 1 //largeCandidate = smallCandidate + 1
	MUL 	R2, R1, R1 //largeCandidate * largeCandidate	
	
	CMP 	R2, R4 //compare if (large x large)> n
	ITT 	GT
	POPGT 	{R4, LR}
	BXGT 	LR 

	MOV 	R0, R1 //put largeCandidate into R0 to return it 	
	POP	    {R4, PC}

.end
