section .data
    input_buffer times 100 db 0

section .text
    global _start
    extern concat
    extern len_of_input
    extern remove_space
    extern random_string
    extern replace_str
    extern compare_numbers
    extern average_of_list
    extern sort_list_desc
    extern reverse_arr
    extern list_sum

end:
    mov rax, 60
    mov rdi, 0
    syscall
    
start_msg:
    db "Choose Your Poison!", 10, 10
    db "0. Concatenating two strings", 10
    db "1. Calculating the length of a string", 10
    db "2. Removing spaces from a string", 10
    db "3. Generating a random string", 10
    db "4. Replacing all occurrences of a character with another character in a string", 10
    db "5. Determining the larger of two numbers", 10
    db "6. Determining the arithmetic mean of a list of numbers", 10
    db "7. Sorting a list of numbers in descending order", 10
    db "8. Reversing a list of numbers backwards", 10
    db "9. Calculating the sum of the elements in a list of numbers", 10

retry_msg:
    db 10, "Again? Press ENTER!", 10

retry:
    mov rax, 1
    mov rdi, 1
    mov rsi, retry_msg
    mov rdx, 21
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall

    jmp _start

screen_clear_buffer:
    db 10, 10, 10, 10, 10, 10, 10, 10, 10
    db 10, 10, 10, 10, 10, 10, 10, 10, 10
    db 10, 10, 10, 10, 10, 10, 10, 10, 10
    db 10, 10, 10, 10, 10, 10, 10, 10, 10
    
clear_screen:
    mov rax, 1
    mov rdi, 1
    mov rsi, screen_clear_buffer
    mov rdx, 35
    syscall
    ret

_start:
    call clear_screen
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
    
    cmp byte [input_buffer], "0"
    je concat_jmp

    cmp byte [input_buffer], "1"
    je len_of_input_jmp

    cmp byte [input_buffer], "2"
    je remove_space_jmp

    cmp byte [input_buffer], "3"
    je random_string_jmp

    cmp byte [input_buffer], "4"
    je replace_str_jmp

    cmp byte [input_buffer], "5"
    je compare_numbers_jmp

    cmp byte [input_buffer], "6"
    je average_of_list_jmp

    cmp byte [input_buffer], "7"
    je sort_list_desc_jmp

    cmp byte [input_buffer], "8"
    je reverse_arr_jmp

    cmp byte [input_buffer], "9"
    je list_sum_jmp

    jmp end

concat_jmp:
    call clear_screen
    call concat
    jmp retry

len_of_input_jmp:
    call clear_screen
    call len_of_input
    jmp retry

remove_space_jmp:
    call clear_screen
    call remove_space
    jmp retry

random_string_jmp:
    call clear_screen
    call random_string
    jmp retry

replace_str_jmp:
    call clear_screen
    call replace_str
    jmp retry

compare_numbers_jmp:
    call clear_screen
    call compare_numbers
    jmp retry

average_of_list_jmp:
    call clear_screen
    call average_of_list
    jmp retry

sort_list_desc_jmp:
    call clear_screen
    call sort_list_desc
    jmp retry

reverse_arr_jmp:
    call clear_screen
    call reverse_arr
    jmp retry

list_sum_jmp:
    call clear_screen
    call list_sum
    jmp retry