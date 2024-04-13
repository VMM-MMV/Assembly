section .text
    global _start

_start:
    mov r8, 49
    mov rax, 1                                ; Prepare syscall number for write
    mov rdi, 1                            ; Prepare file descriptor for stdout
    mov rsi, 49                         ; Load the address of text1 into rsi (inner loop output)
    mov rdx, 100                           ; Load the length of text1 into rdx
    syscall
    ; Clear screen instruction
    mov ah, 0x06        ; AH = 06h (scroll up window)
    mov al, 0x00        ; AL = 00h (number of lines to scroll)
    mov bh, 0xCE        ; BH = 0CEh (display attribute - colors)
    mov cx, 0x0501      ; CX = 0105h (start row and column)
    mov dx, 0x793d      ; DX = 3D79h (end row and column)
    syscall          ; BIOS interrupt

    ; Move cursor to middle
    mov ah, 0x02        ; AH = 02h (move cursor)
    mov bh, 0x00        ; BH = 00h (page number)
    mov dh, 0x12        ; DH = 12d (row)
    mov dl, 0x39        ; DL = 39d (column)
    syscall          ; BIOS interrupt

    ; Read a character
    mov ah, 0x01        ; AH = 01h (read character with echo)
    syscall           ; DOS interrupt (stdin)

    mov r8, 49
    mov rax, 1                                ; Prepare syscall number for write
    mov rdi, 1                            ; Prepare file descriptor for stdout
    mov rsi, 49                         ; Load the address of text1 into rsi (inner loop output)
    mov rdx, 2                            ; Load the length of text1 into rdx
    syscall
    ; Exit program
    mov eax, 60         ; EAX = 60 (exit syscall number)
    xor edi, edi        ; EDI = 0 (exit status)
    syscall             ; Perform syscall to exit
