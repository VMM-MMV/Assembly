section .data
    input_buffer times 100 db 0
    replace_buffer times 10 db 0
    replace_with_buffer times 10 db 0
    counter dq 0
    

section .text
    global replace_str

start_msg:
    db "Replace Your Strings Brother!", 10

reset:
    xor r8, r8
    input_reset:
        mov qword [input_buffer+r8], 0
        inc r8

        cmp qword r8, 100
        jne input_reset

    xor r8, r8
    replace_buffer_reset:
        mov qword [replace_buffer+r8], 0
        inc r8

        cmp qword r8, 10
        jne replace_buffer_reset
        xor r8, r8
    
    xor r8, r8
    replace_with_buffer_reset:
        mov qword [replace_with_buffer+r8], 0
        inc r8

        cmp qword r8, 10
        jne replace_with_buffer_reset
    ret

replace_str:
    call reset
    mov rax, 1
    mov rdi, 1
    mov rsi, start_msg
    mov rdx, 30
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall

    mov r10, rax

    mov rax, 0
    mov rdi, 0
    mov rsi, replace_buffer
    mov rdx, 10
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, replace_with_buffer
    mov rdx, 10
    syscall

    call find_occurance

    mov rax, 1
    mov rdi, 1
    mov rsi, input_buffer
    mov rdx, r10
    syscall

    ret

find_occurance:
    mov r8, [counter]
    mov r9, [replace_buffer]
    cmp [input_buffer+r8], r9b
    je replace

    inc qword [counter]
    cmp [counter], r10
    jl find_occurance
    ret

replace:
    mov r11, [replace_with_buffer]
    mov [input_buffer+r8], r11b
    inc qword [counter] 
    jmp find_occurance