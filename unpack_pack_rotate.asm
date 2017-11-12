DATA SEGMENT
    
    UNPACKED DB 01H, 02H, 03H, 04H, 05H, 06H, 07H, 08H, 09H, 03H, 08H, 07H, 05H, 02H, 01H, 04H
    PACKED DB 8 DUP(?)
    
DATA ENDS

CODE SEGMENT 
    START:
    ASSUME DS:DATA, CS:CODE
    MOV AX, DATA
    MOV DS, AX                       ;LOAD DS WITH DATA
    MOV DI, 0H
    MOV CX, 8                        ;LOAD CX WITH SIZE OF PACKED
    MOV SI, 0H                       ;CLEAR SI AND DI
NEXT: 
    MOV AX, WORD PTR UNPACKED[SI]    ;LOAD FIRST TWO BYTES OF "UNPACKED" INTO AX
    ROL AL,4                         ;ROTATE LEFT AL BY 4
    ROR AX,4                         ;ROTATE RIGHT AX BY 4
    MOV PACKED[DI], AL               ;STORE AL IN ONE BYTE OF PACKED
    INC SI
    INC SI                           ;SI = SI + 2
    INC DI                           ;DI++
    LOOP NEXT
    
CODE ENDS
    END START