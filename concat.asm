section .data
    hello db "Hello", 0
    hello_len equ $-hello 
    
    world db "World", 0  
    world_len equ $-world 

    result db 12  ; Allocate enough space (hello_len + world_len + null terminator) 

section .text
    global _start

_start:
    mov rsi, hello       ; Source index
    mov rdi, result      ; Destination index
    mov rcx, hello_len   ; Copy hello_len bytes
    rep movsb            

    mov rsi, world    
    mov rcx, world_len
    rep movsb

    mov r8, hello_len
    add r8, world_len
    mov byte [result+r8], 10
    inc r8
    mov byte [result+r8], 0
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
