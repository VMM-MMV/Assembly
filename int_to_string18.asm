section .data
    input_buffer times 100 db 0
    arr dq 10 dup(0)
    counter dq 0
    reversed_counter dq 9
    strr dd 0

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, input_buffer
    mov rdx, 100

    mov r8, rax
    xor rax, rax

    mov rsi, input_buffer       ; Source index
    mov rdi, rax                  ; Destination index
    mov rcx, r8                    ; Copy n bytes/times
    rep movsb

    call int_to_string

    mov rax, 1
    mov rdi, 1
    mov rsi, strr
    mov rdx, 10

int_to_string:
    mov rdx, 0
    mov rbx, 10

    div rbx                     ; divides rax by dbx

    mov r9, [counter]
    mov [arr+r9*8], rdx
    inc qword [counter]
    cmp rax, 0
    jne int_to_string
    
    mov qword [counter], 0
    jmp reversed_array_to_str
    ret

reversed_array_to_str:
    mov r9, [reversed_counter]
    mov r9, [arr+r9*8]
    add r9, 48
    mov r10, [counter]
    mov [strr+r10], r9
    dec qword [reversed_counter]
    inc qword [counter]
    cmp qword [reversed_counter], -1
    jne reversed_array_to_str
    mov rax, strr
    ret