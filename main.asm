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
    extern concat

end:
    mov rax, 60
    mov rdi, 0
    syscall
    
start_msg:
    db "Choose Your Poison!", 10, 10
    db "1. Concatenating two strings", 10
    db "2. Calculating the length of a string", 10
    db "3. Removing spaces from a string", 10
    db "4. Generating a random string", 10
    db "5. Replacing all occurrences of a character with another character in a string", 10
    db "6. Removing spaces from a string", 10
    db "7. Determining the arithmetic mean of a list of numbers", 10
    db "8. Sorting a list of numbers in descending order", 10
    db "9. Reversing a list of numbers backwards", 10
    db "10. Calculating the sum of the elements in a list of numbers", 10

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, start_msg
    mov rdx, 470
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall
    
    cmp byte [input_buffer], "1"
    je concat

    call end