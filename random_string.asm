section .data
    string times 100 dq 0  ; Holds the current LCG state
    len dq 30
    counter dq 0
    my_input db 0

section .text
    global _start

_start:
    call get_random_string
    mov r8, [len]
    inc r8
    mov byte [string+r8], 10
    inc r8

    mov rax, 1     ; Syscall for write
    mov rdi, 1     ; Standard output
    mov rsi, string   ; Value to print
    mov rdx, r8    ; Length (adjust for more digits)
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

get_random_string:
    call get_random_character

    mov r8, [counter]
    mov [string+r8], rdx
    inc qword [counter]

    mov r8, [len]
    cmp qword [counter], r8
    jne get_random_string

    mov qword [counter], 0d
    ret

get_random_character:
    rdtsc
    xor rdx, rdx
    mov r8, 26d
    div r8
    add rdx, 97
    xor rax, rax
    ret

rett:
    ret