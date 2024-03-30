section .data
    amount dq 20  ; Number of Fibonacci numbers to calculate
    n dq 0
    nx dq 1
    arr dq 8 dup(0)
    counter dq 0
    reversed_counter dq 7
    strr dd 0

section .text
    global _start

_start:
    call fibonacci

fibonacci:
    cmp qword [amount], 0
    je exit_fibonacci

    mov r9, [nx]     ; Load temp value
    mov r10, [n]
    add r10, [nx]
    mov [nx], r10
    mov [n], r9 

    dec qword [amount]  ; Decrement the loop counter
    cmp qword [amount], 0
    jne fibonacci
    call exit_fibonacci
    ret

exit_fibonacci:
    mov rax, [n]
    call int_to_string

;rax is quotient and value that you want to divide
;rdx is reminder
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

end:
    mov rax, 1
    mov rdi, 1
    mov rsi, strr
    mov rdx, 10
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
    