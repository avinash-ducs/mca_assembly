DATA SEGMENT
    
    PACKED DB 12H, 34H, 56H, 78H, 22H, 28H, 79H, 60H
    UNPACKED DB 16 DUP(?)
    
DATA ENDS

CODE SEGMENT
    START:
    ASSUME DS:DATA, CS:CODE
    MOV AX, DATA
    MOV DS, AX                    ;LOAD DS WITH "DATA"
    MOV SI, 0H      
    MOV DI, 0H                    ;CLEAR SI AND DI
    MOV CX, 8                     ;LOAD CX WITH SIZE OF ARRAY
    
    NEXT:
    MOV AX,0                      ;CLEAR AX TO ZERO
    MOV AL, PACKED[SI]            ;MOVE 1ST BYTE OF "PACKED" INTO AL
    SHL AX, 4
    SHR AL, 4                     ;PERFORM SHIFTS AND CONVERT PACKED TO UNPACKED
    MOV WORD PTR UNPACKED[DI], AX ;STORE AX HAVING UNPACKED DATA IN ARRAY "UNPACKED"
    INC SI                        ;SI = SI+1
    INC DI
    INC DI                        ;DI = DI+2
    LOOP NEXT   
    
CODE ENDS
    END START
    