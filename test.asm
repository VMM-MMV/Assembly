; Global entry point for linking purposes
global main

; External function declarations 
extern printf
extern puts
extern atoi

; Data section
section .text

main:
    ; Save callee-saved registers (convention for preserving values)
    push    r12
    push    r13
    push    r14

    ; Argument validation
    cmp     rdi, 3              ; Verify three arguments (argc)
    jne     error1

    ; Store arguments
    mov     r12, rsi            ; Load argv into r12

    ; Calculate x^y 
    mov     rdi, [r12+16]       ; Load argv[2] (exponent) into rdi
    call    atoi                ; Convert exponent to integer (result in eax)
    cmp     eax, 0              ; Check for negative exponents
    jl      error2
    mov     r13d, eax           ; Store exponent in r13d

    mov     rdi, [r12+8]        ; Load argv[1] (base) into rdi
    call    atoi                ; Convert base to integer (result in eax) 
    mov     r14d, eax           ; Store base in r14d  

    mov     eax, 1              ; Initialize result to 1

check:
    test    r13d, r13d          ; Check if exponent is zero
    jz      gotit               ; Jump if done

    imul    eax, r14d           ; Multiply current result by base
    dec     r13d                ; Decrement exponent
    jmp     check               ; Continue loop

gotit: 
    ; Print final result
    mov     rdi, answer         ; Format string for output
    movsxd  rsi, eax            ; Sign-extend result into rsi (for 64-bit)
    xor     rax, rax            ; Zero out rax (required for call)
    call    printf              

jmp done  

error1:
    ; Error handling - Incorrect argument count
    mov     rdi, badArgumentCount 
    call    puts

jmp done  

error2:
    ; Error handling - Negative exponent
    mov     rdi, negativeExponent 
    call    puts

done:
    ; Restore registers and exit
    pop     r14
    pop     r13
    pop     r12
    ret 

; Data section (messages and format strings)
answer:
    db      "%d", 10, 0         ; Format string for the result
badArgumentCount:
    db      "Requires exactly two arguments", 10, 0 
negativeExponent:
    db      "The exponent may not be negative", 10, 0 
