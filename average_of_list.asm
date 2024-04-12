section .data
    input_buffer times 100 db 0
    arr dq 10 dup(0)
    int_word dq dup(0)

section .text
    global _start

_start:
    call loop_input

loop_input:
    cmp [input_buffer+r8*8], " "
    je append_to_array
    inc r8

append_to_array:
    