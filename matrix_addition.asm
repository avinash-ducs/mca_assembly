data segment
    
    matrix1 dw 01h, 02h, 03h
            dw 04h, 05h, 06h
            dw 07h, 08h, 09h           
    matrix2 dw 01h, 02h, 03h
            dw 04h, 05h, 06h
            dw 07h, 08h, 09h            
    result dw 9 dup(?)
    three dw 3     
    six dw 6
    
data ends

code segment                

    start:    
    mov ax, data
    mov ds, ax                   ;load ds with "data"
    
    mov si,0
    mov di,0
    mov ax,0
    mov bx,0                     ;clear registers
    mov cx,three                 ;load cx with number of rows
    loop1: 
    mov si,0
    push cx                      ;push outer loop's cx onto stack
    mov cx,three                 ;load cx with number of columns
        loop2:     
         mov ax,matrix1[bx][si]
         add ax,matrix2[bx][si]  ;add each element of both matrices
         mov result[bx][si], ax  ;store sum in "result" matrix
         inc si           
         inc si                  ;increment si
         loop loop2
    add bx,six                   ;increment bx for next row
    pop cx                       ;load cx with outer loop's value
    loop loop1
    
code ends 
    end start
