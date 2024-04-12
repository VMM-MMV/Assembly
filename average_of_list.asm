section .data
    input_buffer times 100 db 0
    
    arr dq 10 dup(0)
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
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall

    dec rax
    mov r11, rax
    mov r12, rax
    call string_to_array

    call print_arr

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

print_arr:
    mov r15, [arr_counter]
    dec r15
    mov rax, [arr+r15*8]

    mov qword [counter], 0
    mov qword [reversed_counter], 9
    call clean_arrs
    call int_to_string

    mov rax, 1
    mov rdi, 1
    mov rsi, strr
    mov rdx, 10
    syscall

    ; mov r15, 32
    mov rax, 1
    mov rdi, 1
    mov rsi, space
    mov rdx, 2
    syscall

    dec qword [arr_counter]
    cmp qword [arr_counter], 0
    jne print_arr
    ret

space:
    db " ", 0

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
    jmp reversed_array_to_str
    ret

reversed_array_to_str:
    mov r9, [reversed_counter]
    mov r9, [str_arr+r9*8]
    cmp r9, 0
    je continue


    add r9, 48
    mov r10, [counter]
    mov [strr+r10], r9
    dec qword [reversed_counter]
    inc qword [counter]
    cmp qword [reversed_counter], -1
    jne reversed_array_to_str
    mov rax, strr
    ret

continue:
    dec qword [reversed_counter]
    inc qword [counter]
    jmp reversed_array_to_str

clean_arrs:
    mov qword [strr+r15], 0
    mov qword [str_arr+r15*8], 0
    inc r15
    cmp r15, 9
    jne clean_arrs
    ret
