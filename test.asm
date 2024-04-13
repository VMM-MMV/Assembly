section .data
    input_buffer times 100 db 0
    
    arr dq 10 dup(0)
    arr_len dq 0
    arr_counter dq 0
    str_arr dq 10 dup(0)
    counter dq 0
    reversed_counter dq 9
    strr dd 0

section .text
    global _start

end:
    mov rax, 60
    mov rdi, 0
    syscall

_start:
    mov rax, 100
    call int_to_string

int_to_string:
    mov rdx, 0
    mov rbx, 10

    div rbx                     ; divides rax by dbx

    mov r9, [counter]
    mov [str_arr+r9*8], rdx
    inc qword [counter]
    cmp rax, 0
    jne int_to_string
    
    mov qword [counter], 0
    call reversed_array_to_str
    ret

reversed_array_to_str:
    mov r9, [reversed_counter]
    mov r9, [str_arr+r9*8]
    
    cmp r8, -100
    je is_zero

    cmp r9, 0
    jne number_other_than_zero

    call continue
    ret

continue:
    dec qword [reversed_counter]
    inc qword [counter]
    cmp qword [reversed_counter], -1
    jne reversed_array_to_str
    ret

number_other_than_zero:
    mov r8, -100
    jmp reversed_array_to_str

is_zero:
    cmp r9, 0
    je add_zero

    jmp add_number
    is_zero_bod:
        call continue
        ret


add_zero:
    mov r10, [counter]
    dec r10
    mov byte [strr+r10], 48

    jmp is_zero_bod

add_number:
    add r9, 48
    mov r10, [counter]
    mov [strr+r10], r9
    
    jmp is_zero_bod
