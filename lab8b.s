//Chelsea Fernandes

/************************************
 similar to previous quadratic operations file
 but now implemented with floating-point instructions
 and uses VSQRT.F32 instead of an entire square root function
 ************************************/

.extern main8b.c
.syntax unified
.cpu cortex-m4
.text

/************
 calculate b^2+4ac aka the discriminant
 function: float Discriminant(float a, float b, float c) ;
 S0=a, S1=b, S2=c
 ************/
    .global Discriminant
	.thumb_func
	.align
Discriminant:
    VMOV        S3, 4.0
    VMUL.F32    S0, S0, S2  //S0<-ac
    VMUL.F32    S0, S0, S3
    VNEG.F32    S0, S0        
    VMLA.F32    S0, S1, S1  //S1<-b^2
    BX          LR

/************
 calculate root 1
 function: float Root1(float a, float b, float c) ;
 S0=a, S1=b, S2=c
 ************/
    .global Root1
	.thumb_func
	.align
Root1:
    PUSH	    {LR}
    VPUSH       {S4, S5}
    VMOV        S6, 2.0       
    VMUL.F32    S4, S0, S6      //S4 <- 2a
    VNEG.F32    S5, S1          //S5 <- -b
    BL	        Discriminant    //S0
    VSQRT.F32   S0, S0          //S0 <- sqrt(Discriminant)
    VADD.F32    S0, S0, S5      //S0 <- Discriminant+(-b)
    VDIV.F32    S0, S0, S4        
    VPOP        {S4, S5}
    POP         {PC}
    BX          LR

/************
 calculate root 2
 function: float Root2(float a, float b, float c) ;
 S0=a, S1=b, S2=c
 ************/
    .global Root2
	.thumb_func
	.align
Root2:
    PUSH	    {LR}
    VPUSH       {S4, S5}
    VMOV        S6, 2.0       
    VMUL.F32    S4, S0, S6      //S4 <- 2a
    VNEG.F32    S5, S1          //S5 <- -b
    BL	        Discriminant    //S0
    VSQRT.F32   S0, S0          //S0 <- sqrt(Discriminant)
    VSUB.F32    S0, S5, S0      //S0 <- Discriminant+(-b)
    VDIV.F32    S0, S0, S4        
    VPOP        {S4, S5}
    POP         {PC}
    BX          LR

/************
 calculate f(x), with given x
 function: float Quadratic(float x, float a, float b, float c) ;
 S0=x, S1=a, S2=b, S3=c
 ************/
    .global Quadratic
	.thumb_func
	.align
Quadratic:
    VMUL.F32    S4, S0, S0      //x^2
    VMUL.F32    S1, S1, S4      //ax^2
    VMUL.F32    S2, S2, S0
    VADD.F32    S1, S1, S2
    VADD.F32    S0, S1, S3
    BX          LR

.end
