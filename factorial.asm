DATA SEGMENT
    
    NUMBER DW 6
    RESULT DW ?   
    
DATA ENDS         

CODE SEGMENT
         
     START:
     MOV AX,DATA
     MOV DS,AX     
     
     MOV CX,NUMBER
     MOV AX,1
     NEXT:
     MUL CX  
     LOOP NEXT
     MOV RESULT,AX
                             
       
CODE ENDS
    END START