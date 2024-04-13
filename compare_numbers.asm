section .data
    first_word_buffer times 100 db 0

section .text
    global _start

start_msg:
    db "Compare 2 numbers!", 10

reset:
    xor r8, r8
    first_word_buffer_reset:
        mov qword [first_word_buffer+r8], 0
        inc r8
        
        cmp qword r8, 100
        jne first_word_buffer_reset

    ret

_start:
    call compare_numbers
    mov rax, 60
    mov rdi, 0
    syscall

compare_numbers:
    ; call reset
    mov rax, 1                              
    mov rdi, 1
    mov rsi, start_msg
    mov rdx, 19
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, first_word_buffer
    mov rdx, 100
    syscall

    dec rax
    mov r11, rax
    mov r12, 0
    call string_to_int

    mov r13, r8


    ; call reset

    mov rax, 0
    mov rdi, 0
    mov rsi, first_word_buffer
    mov rdx, 100
    syscall

    dec rax
    mov r11, rax
    mov r12, 0
    call string_to_int

    cmp r13, r8
    jne smaller_or_bigger
    
    mov rax, 1
    mov rdi, 1
    mov rsi, same_number
    mov rdx, 26
    syscall
    ret

same_number:
    db "The Numbers Are The Same!", 10

smaller_or_bigger:
    cmp r13, r8
    jg first_number_bigger

    jmp second_number_bigger

first_number_bigger:
    mov rax, 1
    mov rdi, 1
    mov rsi, first_number_bigger_msg
    mov rdx, 24
    syscall
    ret

first_number_bigger_msg:
    db "First Number Is Bigger!", 10

second_number_bigger:
    mov rax, 1
    mov rdi, 1
    mov rsi, second_number_bigger_msg
    mov rdx, 25
    syscall
    ret
    
second_number_bigger_msg:
    db "Second Number Is Bigger!", 10

string_to_int:   
    ; r11 is end of string  
    ; r12 start of the string     
    mov r9, 1           ; multiplier
    mov r8, 0           ; this would be the result int
    convert_loop:
        mov r10b, [first_word_buffer+r11-1]
        
        sub r10, 48
        imul r10, r9
        add r8, r10
    
        imul r9, 10
        dec r11
    
        cmp r11, r12
        jne convert_loop
    ret

