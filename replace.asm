section .data
    input_buffer times 100 db 0
    replace_buffer times 10 db 0
    replace_with_buffer times 10 db 0
    counter dq 0

section .text
    global _start

_start:
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

    mov rax, 60
    mov rdi, 0
    syscall

find_occurance:
    mov r8, [counter]
    mov r9, [replace_buffer]
    cmp [input_buffer+r8], r9b
    je replace_str

    inc qword [counter]
    cmp [counter], r10
    jl find_occurance
    ret

replace_str:
    mov r11, [replace_with_buffer]
    mov [input_buffer+r8], r11b  ; Replace the character
    inc qword [counter] 
    jmp find_occurance