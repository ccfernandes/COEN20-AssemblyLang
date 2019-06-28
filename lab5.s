//Chelsea Fernandes 
//shifting cells in an array to insert and delete an item

.extern main5.c
.syntax unified
.cpu cortex-m4
.text
/****
 given function: void DeleteItem(int32_t data[], int32_t items, int32_t index) ;
 delete an item in array and shift everything over so there is no space
 ***/
    .global DeleteItem
	.thumb_func
	.align
DeleteItem: 
	//assumed R0=data[] R1=items R2=index

	SUB 	R3, R1, R2  //R3<-items+index
	SUB 	R3, R3, 1   //R3<-num of iterations
		
	ADD	R0, R0, R2, LSL 2 //R0<-data[items]
	loop:
		CMP	R3, 0   //have we reached the end of the array?
		BEQ	done
			
		LDR	R1, [R0, 4] //put stuff from R0 into R1
		STR	R1, [R0]    //put it into R0
		ADD	R1, R1, 4   //shift to new R1 address
		ADD	R0, R0, 4   //new R0 address

		SUB	R3, R3, 1   //decrement counter
		B 	loop
	done: 
		BX 	LR

/***
given function: void InsertItem(int32_t data[], int32_t items, int32_t index, int32_t value) ;
shift elements over in array and insert new element at new slot
***/
	.global InsertItem
        .thumb_func
        .align
InsertItem:
	//assumed R0=data[] R1=items R2=index R3=value
	
	SUB     R2, R1, R2      //R2<-items- index
        SUB     R2, R2, 1   //R2<-num of iterations

	ADD	R0, R0, R1, LSL 2   //R0<-data[items]
	SUB	R0, R0, 4
	loop2:
		CMP	R2, 0 
		BEQ	done2

		LDR	R1 ,[R0, -4]    //R1<-data[current index-1]
		STR	R1, [R0]        //*R0<-data[current index-1]
	
		SUB	R0, R0, 4       //R0<-&data[current index-1]
		
		SUB     R2, R2, 1   //decrement counter
		B 	loop2
	done2:
		
		STR	R3, [R0]    //*R0<-R3
		BX 	LR

.end
