ORG 0000H
LJMP MAIN
ORG 100H
;=========================================================================
DELAY:
       MOV TH0,R6           ;#0FCH
       MOV TL0,R7           ;#018H 
       SETB TR0
	   
HERE:JNB TF0,HERE

     CLR TR0
     CLR TF0
RET
;===========================================================================
MAIN:
using 0
push 0
push 1
push 2
push 3
push 4
push 5
push 6
push 7
			          
	MOV R4,#0FFH           ; STORE VALUE OF COUNT IN 81/82H TH0
	MOV R5,#0FFH           ;TL0

	MOV R0,#81H
	MOV R1,#82H
	MOV @R0,4
	MOV @R1,5

;------------------------- {2'S COMP}-------------------------------------------
MOV 6,@R0      ; UPPER Byte
MOV A,R6
CPL A
MOV R6,A

MOV 7,@R1        ;Lower byte
MOV A,R7
CPL A
INC A           ; R6/R7 IS 2'S COMP. OF 81/82H
MOV R7,A

MOV A,R6
ADDC A, #0H
SJMP LED_blink

;----------------------------------------------------------------------
LED_blink:  
MOV P1,#00000000B         ; SET P1 AS OUTPUT
MOV TMOD,#00000001B       ; USE TIMER 0

	   SETB P1.7
Repeat_loop:

MOV R3,#30              ;Multiples of 10 for delay in multiples of 0.33sec  
Loop2:
ACALL DELAY
DJNZ R3,Loop2
     
	 CPL P1.7
	  
SJMP Repeat_loop
;------------------------------------------------------------------
pop 7
pop 6
pop 5
pop 4
pop 3
pop 2
pop 1
pop 0
	 
HERE3: SJMP HERE3
END
