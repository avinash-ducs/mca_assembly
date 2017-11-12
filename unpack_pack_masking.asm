DATA SEGMENT
    
    UNPACKED DB 01H, 02H, 03H, 04H, 05H, 06H, 07H, 08H, 09H, 03H, 08H, 07H, 05H, 02H, 01H, 04H
    PACKED DB 8 DUP(?)
    
DATA ENDS

CODE SEGMENT 
    START:
    MOV AX, DATA
    MOV DS, AX                ;LOAD DS WITH DATA
    MOV DI, 0H
    MOV CX, 8                 ;LOAD CX WITH SIZE OF "PACKED" 
    MOV SI, 0H                ;CLEAR SI AND DI
NEXT: 
    MOV AL, UNPACKED[SI+1]    ;LOAD BYTES OF "UNPACKED" INTO AL
    SHL AL, 4                 ;SHIFT LEFT AL BY 4
    OR AL, UNPACKED[SI]       ;MASKING FOR CONVERSION TO PACKED 
    MOV PACKED[DI], AL        ;STORE AL IN ONE BYTE OF "PACKED"
    INC SI
    INC SI                    ;SI = SI + 2
    INC DI                    ;DI++
    LOOP NEXT
    
CODE ENDS
    END START