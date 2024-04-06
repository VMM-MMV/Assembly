section .data
    msg db "Add Input!", 0xA  ; Message to print (0xA is a newline)
    len equ $-msg                ; Length of the message
    first_word_buffer times 100 db 0
    second_word_buffer times 100 db 0

section .bss
    first_word_len resd 1
    second_word_len resd 1
    result resb 200

section .text
    global _start

_start:
    mov rax, 1                                ; Prepare syscall number for write
    mov rdi, 1                            ; Prepare file descriptor for stdout
    mov rsi, msg                         ; Load the address of text1 into rsi (inner loop output)
    mov rdx, len                            ; Load the length of text1 into rdx
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
    mov rcx, r8                      ; Copy hello_len bytes
    rep movsb
    
    dec rdi

    mov rsi, second_word_buffer    
    mov rcx, r9
    rep movsb

    add r8, r9
    inc r8
    
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, r8
    syscall

end:
    mov rax, 60  ; System call for exit
    xor rdi, rdi ; Exit code 0
    syscall
