section .data    
    arr dq 10, 3, 8, 3, 5

section .text
    global _start

end:
    mov rax, 60
    mov rdi, 0
    syscall

_start:
    mov r10, 5
    mov r9, -1
    call bubble_sort
    call end

bubble_sort:
    ; r8 is i
    ; r9 is j
    ; r10 is size of array
    inner_loop:
        inc r9
        mov r11, r10-1
        sub r11, r8
        cmp r9, r11
        jne inner_loop

    mov r9, -1
    inc r8
    cmp r8, r10-1
    jne bubble_sort

    ret

swap:
