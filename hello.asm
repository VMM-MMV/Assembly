section .data
    msg db "Add Input!", 0xA  ; Message to print (0xA is a newline)
    len equ $-msg                ; Length of the message
    input_buffer times 100 db 0

section .bss
    number_of_bytes resd 1   

section .text
    global _start

end:
    mov rax, 60
    mov rdi, 420
    syscall
  
_start:
    mov rax, 1                                ; Prepare syscall number for write
    mov rdi, 1                            ; Prepare file descriptor for stdout
    mov rsi, msg                         ; Load the address of text1 into rsi (inner loop output)
    mov rdx, len                            ; Load the length of text1 into rdx
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100
    syscall
    
    mov [number_of_bytes], rax

    mov rax, 1
    mov rdi, 1
    mov rsi, input_buffer
    mov rdx, [number_of_bytes]
    syscall

    call end