; ; Global entry point for linking purposes
; global main

; ; External function declarations 
; extern printf
; extern puts
; extern atoi

; section .data
;     msg db "Add Input!", 0xA  ; Message to print (0xA is a newline)
;     len equ $-msg                ; Length of the message
;     first_word_buffer times 100 db 0

; ; Data section
; section .text

; main:
;     mov rax, 1                              
;     mov rdi, 1
;     mov rsi, msg
;     mov rdx, len
;     syscall

;     mov rax, 0
;     mov rdi, 0
;     mov rsi, first_word_buffer
;     mov rdx, 100
;     syscall
    
;     ; mov eax, rax

; gotit: 
;     ; Print final result
;     mov     rdi, answer         ; Format string for output
;     movsxd  rsi, eax            ; Sign-extend result into rsi (for 64-bit)
;     xor     rax, rax            ; Zero out rax (required for call)
;     call    printf              

; ; Data section (messages and format strings)
; answer:
;     db      "%d", 10, 0         ; Format string for the result
; badArgumentCount:
;     db      "Requires exactly two arguments", 10, 0 
; negativeExponent:
;     db      "The exponent may not be negative", 10, 0 



section .data
    my_integer dd 12345       ; The integer you want to convert

section .text
    global _start

INCLUDE 'int_to_string.asm' 
_start:
    mov rax, my_integer       ; Load the integer into rax 
    call int_to_string        ; Call the conversion function
    
    mov rax, 1
    mov rdi, 1
    mov rsi, rax
    mov rdx, 10
