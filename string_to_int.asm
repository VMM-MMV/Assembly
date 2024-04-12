section .data
    input_buffer times 100 db 0
    arr dq 10 dup(0)
    int_word dq 0 dup(0)
    input_buffer_len dq 0

section .text
    global _start

end:
    mov rax, 60
    mov rdi, 420
    syscall

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall

    mov r11, rax 
    dec r11
    call convert_string

    call end

convert_string:   
    ; r11 is lenght of string          
    mov r9, 1           ; multiplier
    mov r8, 0           ; this would be the result int
    call convert_loop
    ret

convert_loop:
    mov r10b, [input_buffer+r11-1]
    
    sub r10, 48
    imul r10, r9
    add r8, r10

    imul r9, 10
    dec r11

    cmp r11, 0
    jne convert_loop
    ret