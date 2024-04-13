section .data
    input_buffer times 100 db 0
    counter dq 0
    start_msg db "Remove your spaces brother!", 10
    start_msg_len equ $-start_msg

section .text
    global remove_space

remove_space:
    mov rax, 1
    mov rdi, 1
    mov rsi, start_msg
    mov rdx, start_msg_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall

    mov r10, rax

    call find_occurance

    mov rax, 1
    mov rdi, 1
    mov rsi, input_buffer
    mov rdx, r10
    syscall

    ret

find_occurance:
    mov qword [counter], 0
    occurrence_loop:
        mov r8, [counter]
        mov r9, 32
        cmp [input_buffer+r8], r9b
        je replace_str

        inc qword [counter]
        cmp [counter], r10
        jl occurrence_loop
        ret

    replace_str:
        mov r11, 0
        mov [input_buffer+r8], r11b
        inc qword [counter] 
        jmp occurrence_loop