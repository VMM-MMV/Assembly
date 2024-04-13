section .data
    msg db "Concat Your Words!", 0xA  ; Message to print (0xA is a newline)
    len equ $-msg                ; Length of the message
    first_word_buffer times 100 db 0
    second_word_buffer times 100 db 0

section .bss
    result resb 200

section .text
    global concat

concat:
    mov rax, 1                              
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, first_word_buffer
    mov rdx, 100
    syscall
    
    mov r8, rax

    mov rax, 0
    mov rdi, 0
    mov rsi, second_word_buffer
    mov rdx, 100
    syscall
    
    mov r9, rax
    
    mov rsi, first_word_buffer       ; Source index
    mov rdi, result                  ; Destination index
    mov rcx, r8                      ; Copy n bytes/times
    rep movsb
    
    mov rsi, second_word_buffer    
    dec rdi
    mov rcx, r9
    rep movsb

    add r8, r9
    inc r8
    
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, r8
    syscall
    ret

