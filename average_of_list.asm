section .data
    input_buffer times 100 db 0
    arr dq 10 dup(0)
    arr_counter dq 0
    ; int_word dq dup(0)

section .text
    global _start

end:
    mov rax, 60
    mov rdi, 0
    syscall

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall

    dec rax
    mov r11, rax
    mov r12, rax
    call string_to_array

    call end

string_to_array:
    dec r12
    cmp r12, -1
    je rett 

    cmp r12, 0
    je add_to_array

    cmp byte [input_buffer+r12-1], 32
    je add_to_array

    cmp r12, 0
    jne string_to_array
    ret

rett:
    ret

add_to_array:
    call convert_string
    dec r11

    mov r14, [arr_counter]
    mov [arr+r14*8], r8
    inc qword [arr_counter]
    jmp string_to_array

convert_string:   
    ; r11 is end of string  
    ; r12 start of the string     
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

    cmp r11, r12
    jne convert_loop
    ret
    