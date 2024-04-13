section .data    
    arr dq 1, 4, 3, 2
    ; arr dq 10 dup(0)
    str_arr dq 10 dup(0)
    arr_len dq 4
    arr_counter dq 0
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
    mov r10, 4
    call bubble_sort
    mov r8, 4
    call print_arr
    call end

bubble_sort:
    ; r8 is i
    ; r9 is j
    ; r10 is size of array
    ; r11, r12 temp
    mov r9, -1
    xor r8, r8
    xor r11, r11
    xor r12, r12
    inner_loop:
        inc r9

        mov r11, r10
        dec r11
        sub r11, r8
        cmp r9, r11
        jge outer_loop

        mov r11, [arr+((r9+1)*8)]
        mov r12, [arr+(r9*8)]

        cmp r12, r11
        jg swap

        jmp inner_loop

    outer_loop:
        mov r9, -1
        inc r8
        cmp r8, r10
        jne inner_loop

    ret

swap:
    mov r12, [arr+r9*8]
    mov r11, [arr+((r9+1)*8)]

    mov [arr+((r9+1)*8)], r12
    mov [arr+r9*8], r11
    jmp inner_loop

print_arr:
    ; r8 len
    ; r9 counter
    mov qword [arr_counter], 0
    print_loop:
        
        mov r9, [arr_counter]
        mov rax, [arr+r9*8]
        call int_to_string

        mov rax, 1
        mov rdi, 1
        mov rsi, strr
        mov rdx, 10
        syscall

        mov rax, 1
        mov rdi, 1
        mov rsi, space
        mov rdx, 1
        syscall

        inc qword [arr_counter]
        mov r9, [arr_counter]
        cmp qword r9, [arr_len]
        jne print_loop
    ret

space:
    db " "

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