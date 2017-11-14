DATA SEGMENT 
    
    ARRINP DB "Enter elements of array: $"
    INPUT_ELE DB "Enter number to search: $" 
    NOTFOUND_MSG DB "Element not found! $"
    FOUND_MSG DB "Element found! $"
    INPUT_SIZE DB "Enter size of array: $"
    EMPTY DB "Empty array!$"
    ELE DW ?
    ARRAY DW 10 DUP(?)
    SIZE DW ?  
    TEN DW 10 
    TABLE_OF_PARAMS DW 3 DUP(?)
    
DATA ENDS
       
CODE SEGMENT
    START:         
        ASSUME DS:DATA, CS:CODE  
        ;LOAD ES AND DS WITH DATA      
        MOV AX, DATA
        MOV DS, AX           
        ;MOV ES, AX
        
        ;TAKE SIZE OF ARRAY AS INPUT                
        MOV AX,0
        LEA DX, INPUT_SIZE
        MOV AH,9
        INT 21H
        
        CALL NEWLINE
                              
        CALL READ
        MOV SIZE, BX                
        CMP BX,0
        JE EMP
                        
        ;INPUT ELEMENTS OF ARRAY
               
        CALL NEWLINE
           
        MOV AX,0
        LEA DX, ARRINP
        MOV AH,9
        INT 21H
                
        CALL NEWLINE
        
        MOV CX, SIZE         
        MOV DI,0
            
        ARRAYINPUT:
                CALL READ   
                MOV DX, BX
                MOV BX, OFFSET ARRAY
                MOV BX[DI], DX
                INC DI 
                INC DI  
                
                CALL NEWLINE
                LOOP ARRAYINPUT
        
        ;INPUT ELEMENT TO BE SEARCHED
        
        MOV AX,0
        LEA DX, INPUT_ELE
        MOV AH,9
        INT 21H
                
        CALL NEWLINE
        
        MOV BX,0
        
        CALL READ
        MOV ELE,BX 
        
        ;LINEAR SEARCH
        MOV TABLE_OF_PARAMS, OFFSET ARRAY
        MOV TABLE_OF_PARAMS+2, OFFSET SIZE  
        MOV TABLE_OF_PARAMS+4, OFFSET ELE
        MOV BX, OFFSET TABLE_OF_PARAMS
        
        CALL L_SEARCH
                          
        
     EXIT:
         HLT       
     
     ;------------------------------- 
        
     NEWLINE PROC NEAR                  ;PROCEDURE WHICH PRINTS A NEWLINE AND CARRIAGE RETURN ON THE CONSOLE
        
        MOV AH,2
        MOV DL, 0DH
        INT 21H   
        MOV DL, 0AH
        INT 21H       
        RET           
        
     NEWLINE ENDP          
     
     ;--------------------------------
     
     READ PROC NEAR                     ;PROCEDURE WHICH READS INPUT FROM USER ONTO THE CONSOLE
        
                MOV BX,0
        LOOP1:        
                MOV AX,0100H
                INT 21H
                CMP AL,0DH
                JE ENDLOOP
                AND AX, 0FH
                XCHG AX,BX
                MUL TEN
                ADD BX,AX
                JMP LOOP1
        ENDLOOP: 
                RET       
                
      READ ENDP
     
     ;--------------------------------           
     
     L_SEARCH PROC NEAR 
        
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        PUSH DI
      
        
        MOV DI,[BX+2]
        MOV CX,[DI]
        MOV DI,[BX+4]
        MOV SI,[BX] 
        
        SEARCH:   
        MOV AX,[DI]
        CMP AX, [SI]
        JE FOUND
        INC SI 
        INC SI
        LOOP SEARCH         
        
        CALL NEWLINE
         
        ;PRINT MSG "ELEMENT NOT FOUND"  
          
        MOV AX,0
        MOV DX, OFFSET NOTFOUND_MSG
        MOV AH, 9
        INT 21H
        JMP EXITL   
          
     ;PRINT MSG "ELEMENT FOUND"     
        
     FOUND:      
        CALL NEWLINE
        
        MOV AX,0
        MOV DX, OFFSET FOUND_MSG
        MOV AH, 9
        INT 21H            
        JMP EXITL
      
     ;PRINT MSG "ARRAY EMPTY"    
         
     EMP:   
        CALL NEWLINE
        
        MOV AX,0
        MOV DX, OFFSET EMPTY
        MOV AH,9
        INT 21H  
        
        EXITL: 
        
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
        POP AX
        
        RET
        
     L_SEARCH ENDP
     
     ;---------------------------------
     
CODE ENDS
    END START