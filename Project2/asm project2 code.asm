

STACKSG SEGMENT PARA STACK 'STACK'
DW 32 DUP(?)
STACKSG ENDS


DATASG SEGMENT PARA 'DATA'
dizi1 DB 0Dh,18h,1Fh,0FBh,28h,0Bh,01h,34h,14h,0FFh
dizi2 DB 01h,02h,03h,1Bh,0Ah,0Ah,0FFh,19h,42h,0FFh
carpim DW 10 DUP(0)
eleman DB 000Ah
DATASG ENDS
	
CODESG SEGMENT PARA 'CODE'
       ASSUME CS:CODESG, DS:DATASG, SS:STACKSG
   
   ANA      PROC FAR
                     
			PUSH DS
			XOR AX,AX
			PUSH AX
			
			MOV AX,DATASG
			MOV DS,AX
			
			XOR BX,BX
			MOV CX,eleman
	loopp:	XOR AX,AX
			MOV AL,[BX]
			PUSH AX
			MOV AL,[BX] + 0Ah
			PUSH AX
			CALL func
			SHL BX,1
	
			POP [BX]+ 14h
			SHR BX,1
			ADD BX,1
			LOOP loopp
			RETF
			ENDP
			
			func PROC NEAR
			
			PUSH BP
			PUSH BX
			PUSH DX
			MOV BP,SP
			MOV BX,[BP]+08h
			MOV DX,[BP]+0Ah
			CMP BX,1
			JNZ git
			MOV [BP]+0Ah,DX

			JMP son
			NOP
	git:	TEST BX,0001h
			JZ git2
			SHR BX,1
			PUSH BX
			MOV BX,DX
			SHL DX,1
			PUSH DX
			CALL func
			POP [BP]+0Ah
			ADD [BP]+0Ah,BX
			JMP son
			NOP
	git2:	SHR BX,1
			SHL DX,1
			PUSH DX
			PUSH BX
			CALL func
			POP [BP]+0Ah
	son:	POP DX
			POP BX
			POP BP
			RET 0002
			
			func ENDP
			
CODESG ENDS
       END ANA