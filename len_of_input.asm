section .data
    input_buffer times 100 db 0
    str_arr dq 10 dup(0)
    counter dq 0
    reversed_counter dq 9
    strr dd 0

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall

    dec rax

    call int_to_string

    mov r9, strr
    
    mov rax, 1
    mov rdi, 1
    mov rsi, r9
    mov rdx, 10
    syscall

end:
    mov rax, 60
    xor rdi, rdi
    syscall

int_to_string:
    int_to_str_array:
        call clean_int_to_string
        to_arr_convert_loop:
            xor rdx, rdx
            mov rbx, 10

            div rbx                     ; divides rax by dbx

            mov r9, [counter]
            mov [str_arr+r9*8], rdx
            inc qword [counter]
            cmp rax, 0
            jne to_arr_convert_loop
        
        mov qword [counter], 0
        call str_array_to_str
        ret

    str_array_to_str:
        mov r9, [reversed_counter]
        mov r9, [str_arr+r9*8]
        
        cmp r8, -42069
        je switch

        cmp r9, 0
        jne flip_switch

        call continue
        mov r8, -42068
        ret

    switch:
        cmp r9, 0
        je add_zero

        jmp add_number
        is_zero_bod:
            call continue
            ret

    flip_switch:
        mov r8, -42069
        jmp str_array_to_str

    continue:
        dec qword [reversed_counter]
        cmp qword [reversed_counter], -1
        jne str_array_to_str
        ret

    add_zero:
        mov r10, [counter]
        mov byte [strr+r10], 48

        inc qword [counter]
        jmp is_zero_bod

    add_number:
        add r9, 48
        mov r10, [counter]
        mov [strr+r10], r9

        inc qword [counter]
        jmp is_zero_bod

    clean_int_to_string:
        mov r15, 0
        mov qword [counter], 0
        mov qword [reversed_counter], 9
        clean_loop:
            mov qword [strr+r15], 0
            mov qword [str_arr+r15*8], 0
            inc r15
            cmp r15, 9
            jne clean_loop

        ret
    