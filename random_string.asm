section .data
    string times 100 dq 0
    len dq 30
    counter dq 0
    my_input db 0

section .text
    global random_string

reset:
    mov qword [counter], 0
    xor r8, r8
    string_reset:
        mov qword [string+r8], 0
        inc r8

        cmp qword r8, 100
        jne string_reset
    ret

random_string:
    call reset

    call get_random_string
    mov r8, [len]
    inc r8
    mov byte [string+r8], 10
    inc r8

    mov rax, 1
    mov rdi, 1
    mov rsi, string
    mov rdx, r8
    syscall

    ret

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