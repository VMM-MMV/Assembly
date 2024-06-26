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
    global list_sum

start_msg:
    db "Add your list!", 10

reset:
    mov qword [counter], 0
    mov qword [arr_counter], 0
    mov qword [reversed_counter], 9

    xor r8, r8
    input_reset:
        mov qword [input_buffer+r8], 0
        inc r8

        cmp qword r8, 100
        jne input_reset
        
    xor r8, r8
    arr_reset:
        cmp qword r8, [arr_len]
        jne arr_reset_bod
    ret

    arr_reset_bod:
        mov qword [arr+r8*8], 0
        inc r8
        jmp arr_reset

list_sum:
    call reset
    mov rax, 1
    mov rdi, 1
    mov rsi, start_msg
    mov rdx, 15
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall

    dec rax
    mov r11, rax
    mov r12, rax
    call string_to_array

    dec qword [arr_len]
    mov r14, 0
    mov r15, 0
    call get_arr_sum

    ret

get_arr_sum:
    add r14, [arr+r15*8]
    inc r15
    cmp r15, [arr_len]
    jle get_arr_sum

    xor rdx, rdx
    mov rax, r14

    call clean_int_to_string
    call int_to_string

    mov qword [strr+10], 10

    mov rax, 1
    mov rdi, 1
    mov rsi, strr
    mov rdx, 11
    syscall
    ret

string_to_array:
    string_to_array_loop:
        dec r12
        cmp r12, -1
        je rett 

        cmp r12, 0
        je add_to_array

        cmp byte [input_buffer+r12-1], 32
        je add_to_array

        cmp r12, 0
        jne string_to_array_loop
    ret

    rett:
        ret

    add_to_array:
        call convert_string
        dec r11

        mov r14, [arr_counter]
        mov [arr+r14*8], r8
        inc qword [arr_counter]
        mov r14, [arr_counter]
        mov [arr_len], r14
        jmp string_to_array

    convert_string:   
        ; r11 is end of string  
        ; r12 start of the string     
        mov r9, 1           ; multiplier
        mov r8, 0           ; this would be the result int
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
