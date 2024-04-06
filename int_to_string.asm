section .data
    arr dq 10 dup(0)
    counter dq 0
    reversed_counter dq 9
    strr dd 0

section .text
    global int_to_string

int_to_string:
    mov rdx, 0
    mov rbx, 10

    div rbx                     ; divides rax by dbx

    mov r9, [counter]
    mov [arr+r9*8], rdx
    inc qword [counter]
    cmp rax, 0
    jne int_to_string
    
    mov qword [counter], 0
    jmp reversed_array_to_str
    ret

reversed_array_to_str:
    mov r9, [reversed_counter]
    mov r9, [arr+r9*8]
    add r9, 48
    mov r10, [counter]
    mov [strr+r10], r9
    dec qword [reversed_counter]
    inc qword [counter]
    cmp qword [reversed_counter], -1
    jne reversed_array_to_str
    mov rax, strr
    ret