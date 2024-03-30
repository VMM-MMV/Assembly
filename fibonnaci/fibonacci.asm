section .data
    amount dq 2  ; Number of Fibonacci numbers to calculate
    counter dq 0
    n dq 0
    nx dq 1

section .text
    ; global _start
    global fibonacci

; _start:
;     call fibonacci

fibonacci:
    cmp qword [amount], 0
    je end

    mov r9, [nx]    ; Load temp value
    mov r10, [n]
    add r10, [nx]
    mov [nx], r10
    mov [n], r9    
    dec qword [amount]
    cmp qword [amount], 0
    jne fibonacci
    call end

end:
    mov rax, 60   ; System call for exit
    xor rdi, rdi  ; Exit code 0
    syscall
