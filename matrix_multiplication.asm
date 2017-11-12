data segment 
    
    matrix1 dw 01h,02h,03h
            dw 04h,05h,06h
            dw 07h,08h,09h
            
    matrix2 dw 01h,02h,03h
            dw 04h,05h,06h
            dw 07h,08h,09h        
            
    product dw 9 dup(?)
    sum dw ?               
    three dw 3
    
data ends

code segment
    
    start:
        mov ax,data
        mov ds,ax
        mov es,ax
            
        mov ax,0    
        mov si,0
        mov di,0
        mov cx,3
        
    loop1:
        mov di,0
        push cx
        mov cx,3
        
        loop2:
            mov bx,0
            mov sum,0
            push cx
            mov cx,3
            
            loop3:
                mov ax,matrix1[si][bx]    
                push bx
                push ax    
                mov ax,bx
                mul three
                mov bx,ax
                pop ax
                mul matrix2[bx][di]
                pop bx
                add sum,ax
                add bx,2
                loop loop3
                
            mov bx,di
            add di,2
            mov ax,sum
            mov product[si][bx],ax
            pop cx
            loop loop2
       
        add si,6
        pop cx
        loop loop1
        
code ends
    end start