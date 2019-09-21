org 0x7c00
jmp main

intro: db "Type a number discover if its a fibonacci number", 0xd, 0xa, 0x0
it_is: db "It is", 0xd, 0xa, 0x0
it_is_not: db "It is not", 0xd, 0xa, 0x0
new_line: db 0xd, 0xa, 0x0

is_from_fibonacci:
    push ax
    push bx
    push cx

    cmp bx, 0x0         ; Checks for the first fibonacci number (0)
    je result_true

    mov cx, 0x0         ; First 2 fibonacci numbers
    mov dx, 0x1

fibonacci_loop:
    add dx, cx          ; Adds both numbers to get next fibonacci number. Stores it in cx
    cmp bx, cx          ; Compares input with the new fibonacci number.
    je result_true      ; If equal, it is a fibonacci number
    jl result_false     ; If less, it isn't. If greater, continue loop

    add cx, dx          ; Adds both numbers to get next fibonacci number. This time stores it in dx
    cmp bx, dx          ; Compares input with the new fibonacci number.
    je result_true      ; If equal, it is a fibonacci number
    jl result_false     ; If less, it isn't. If greater, continue loop
    jmp fibonacci_loop  

result_true:
    mov bx, it_is
    jmp fibonacci_end

result_false:
    mov bx, it_is_not

fibonacci_end:
    call print_string

    pop cx
    pop bx
    pop ax
    ret
-----------------------------------------------------------------------------------------------------------------------------------------
; Pushs all important registers and puts zero on base register
read_integer:
    push ax
    push cx
    mov bx, 0

; Only reads the integers and ignores other ascii characters
while_read_integer:
    
    ;Prepare to read the number
    mov ah, 0x00 ; Chooses the function that reads keyboard
    int 0x16     ; Interupt on keyboard services

    ;Checks if the value that was read is '\n'
    cmp al, 13   ; If the number is equal to 13 then it is a '\n'
    je stop_read_integer

    ;Reads the number
    mov ah, 0xe  ; Chooses the function thet prints a character 
    int 0x10     ; Interrupt on video services

    ;This section makes so ignoring not number ascii characters is possible
   ; cmp al, '0'  ; Checks if the read number is less than '0' character
    ;jl while_read_integer

    ;cmp al, '9'  ; Checks if the read number is greater than '9' character
    ;jg while_read_integer
    
    ;Finaly armazenate the read number
    movzx dx, al ; Stores the read number on dx
   
    sub dx, '0'  ; Translates from ascii to integer the numbers

    imul bx, 0xa  ; Multiplies by 10 the real number that is being read

    add bx, dx   ; Adds the new character to the real number

    jmp while_read_integer

; Pops back all the values stored and returns where it stoped
stop_read_integer: 
    pop cx
    pop ax
    ret



times 510-($-$$) db 0
dw 0xaa55
