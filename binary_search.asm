DATA SEGMENT  
    
    ARRINP DB "Enter elements of array (in ascending order): $"
    INPUT_ELE DB "Enter number to search: $" 
    NOTFOUND_MSG DB "Element not found! $"
    FOUND_MSG DB "Element found! $"
    INPSIZE DB "Enter size of array: $"
    EMPTY DB "Empty array!$"
    ELE DB ?
    ARRAY DB 10 DUP(?)
    SIZE DB ?          
    TWO DB 2  
    TEN DB 10                 
    BEG DB ?
    LAST DB ?
    
DATA ENDS

CODE SEGMENT
    START:    
        ASSUME DS:DATA, CS:CODE      
        ;LOADING DS AND ES
        MOV AX, DATA
        MOV DS, AX           
        MOV ES, AX
             
        ;USER INPUT SIZE                
        MOV AX,0
        LEA DX, INPSIZE
        MOV AH,9
        INT 21H
        
        CALL NEWLINE       
                        
        CALL READ 
        CMP BX,0
        JE EMP
        MOV SIZE, BL                
                        
        ;INPUT ELEMENTS OF ARRAY
               
        CALL NEWLINE       
               
        MOV AX,0
        LEA DX, ARRINP
        MOV AH,9
        INT 21H
                
        CALL NEWLINE            
                             
        MOV CX, 0
        MOV CL, SIZE         
        MOV DI,0
            
        ARRAYINPUT:
                MOV BX,0
                CALL READ        
                MOV DX, BX
                MOV BX, OFFSET ARRAY
                MOV BX[DI], DX
                INC DI 
                
                CALL NEWLINE
                
                LOOP ARRAYINPUT
    
        ;INPUT ELEMENT TO SEARCH
        
        MOV AX,0
        LEA DX, INPUT_ELE
        MOV AH,9
        INT 21H
                
        CALL NEWLINE
        MOV BX,0
        CALL READ
        MOV ELE,BL         
                                                                 
        ;BINARY SEARCH LOGIC
        
        MOV BEG, 0      
        MOV AL, SIZE
        AND AX, 0FFH
        MOV LAST, AL
        DEC LAST
    
        SEARCH: 
            MOV AL, BEG
            CMP AL, LAST
            JG NOT_FOUND
            ADD AL, LAST
            DIV TWO
            AND AX,0FFH
            MOV SI,AX
            MOV DL,ELE
            CMP DL,BYTE PTR ARRAY[SI]
            JL SMALLER
            JG GREATER
            JE FOUND
        
        ;ELEMENT TO SEARCH IS SMALLER THAN MIDDLE ELEMENT, UPDATE LAST
        SMALLER: 
            MOV LAST,AL
            DEC LAST
            JMP SEARCH   
            
        ;ELEMENT TO SEARCH IS GREATER THAN MIDDLE ELEMENT, UPDATE BEG     
        GREATER: 
            MOV BEG,AL
            INC BEG
            JMP SEARCH 
                                 
        ;PRINT ELEMENT FOUND AND DISPLAY ITS INDEX      
        FOUND:  
            LEA DX,FOUND_MSG     
            MOV AH,9H
            INT 21H   
            MOV DX,SI
            ADD DL,30H
            MOV AH,2H
            INT 21H  
            JMP EXIT
       
        ;PRINT ELEMENT NOT FOUND    
        NOT_FOUND:
            LEA DX,NOTFOUND_MSG
            MOV AH,9H
            INT 21H
            JMP EXIT 
          
        ;PRINT ARRAY EMPTY     
        EMP:
            LEA DX,EMPTY                                 
            MOV AH,09H
            INT 21H

     EXIT: HLT           
     
     ;--------------------------------- 
       
     NEWLINE PROC NEAR                  ;PROCEDURE WHICH PRINTS A NEWLINE AND CARRIAGE RETURN ON THE CONSOLE
        
        MOV AH, 2      
        MOV DL, 0DH
        INT 21H              
        MOV DL, 0AH
        INT 21H        
        RET
        
     NEWLINE ENDP                      
     
     ;---------------------------------
     
     READ PROC NEAR                     ;PROCEDURE WHICH READS INPUT FROM USER ONTO THE CONSOLE
        
        MOV BX,0
        MOV DX,0
        
        LOOP1:  
                MOV AX, 0100H
                INT 21H
                CMP AL,0DH
                
                JE ENDLOOP
                AND AX,0FH
                XCHG AX,BX
                MUL TEN
                ADD BX,AX
                JMP LOOP1
        ENDLOOP:
                RET
                
      READ ENDP
     
     ;--------------------------------
        
       
CODE ENDS
    END START
        