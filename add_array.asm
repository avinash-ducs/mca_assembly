DATA SEGMENT
                 
    SIZE DW 10
    SUM DD 0
    ARRAY DD 122345H, 200251H, 300300H, 421H, 59H, 22878H, 90000H, 78H, 100H, 6789H  
              
DATA ENDS
    
    
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    START: 
        MOV AX, DATA       
        MOV DS, AX                  ;LOAD DS WITH "DATA"
        MOV SI, 0
        LEA BX, ARRAY               ;LOAD BX WITH THE STARTING ADDRESS OF "ARRAY"
        MOV CX, SIZE                ;INITIALIZE CX WITH SIZE OF ARRAY
        MOV AX, 0
        MOV DX, 0                   ;CLEAR AX,DX
        
    LAB:
        ADD AX, BX[SI]              ;ADD LOWER WORD OF ALL ELEMENTS OF ARRAY IN AX
        ADD SI, 2                   ;INC SI BY 2
        ADC DX, BX[SI]              ;ADD HIGHER WORD OF ALL ELEMENTS OF ARRAY IN DX
        ADD SI, 2                   ;INC SI BY 2
        LOOP LAB
        MOV WORD PTR SUM, AX        ;STORE SUM OF LOWER WORDS AT "SUM"
        MOV WORD PTR SUM + 2, DX    ;STORE SUM OF HIGHER WORDS AT "SUM+2"
    
CODE ENDS
    END START
      