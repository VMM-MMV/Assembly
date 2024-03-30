section .data
    arr dq 10 dup(0)
    counter dq 0
    reversed_counter dq 9
    ; strr dd 10 dup(0)
    strr dd 0

section .text
    global _start
     
print1:
    push qword 49
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    add rsp, 8

    push qword 10
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall
    add rsp, 8
    ret

end:
    mov rax, 1
    mov rdi, 1
    mov rsi, strr
    mov rdx, 10
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

_start:
    mov rax, 1234
    call int_to_string
    call end

int_to_string:
    ; mov rax, 1234 rax is quotient  
    mov rdx, 0  ; rdx is reminder
    mov rbx, 10

    div rbx

    mov r9, [counter]
    mov [arr+r9*8], rdx
    inc qword [counter]
    cmp rax, 0
    jne int_to_string
    
    mov qword [counter], 0
    jmp reversed_array_to_str

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
    jmp end

; reversed_array_to_str:
;     mov r9, [counter]
;     mov r9, [arr+r9*8]
;     add r9, 48
;     mov r10, [reversed_counter]
;     mov [strr+r10], r9
;     dec qword [reversed_counter]
;     inc qword [counter]
;     cmp qword [reversed_counter], -1
;     jne reversed_array_to_str
;     jmp end
