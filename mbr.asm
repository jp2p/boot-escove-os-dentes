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

times 510-($-$$) db 0
dw 0xaa55
