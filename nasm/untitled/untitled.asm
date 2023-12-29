SECTION .data
text        db      'test', 0Ah         ; create string variable with 0Ah line feed
fish        db      'salmon', 0Ah

SECTION .text
global      _start                      ; specify entry point for the program

_start:
    call    fixedlength                 ; call specified function
    call    variablelength
    mov     ebx, 0                      ; specify error code
    mov     eax, 1                      ; specify the syscall index for exit
    int     80h

fixedlength:
    mov     edx, 5                      ; specify length of string + 1 (line feed) to write
    mov     ecx, text                   ; specify the string address to write
    mov     ebx, 1                      ; specify write location (0 - stdin, 1 - stdout, 2 - stderr)
    mov     eax, 4                      ; specify the syscall index for write
    int     80h                         ; call an interrupt to trigger syscall
    ret                                 ; return from function

variablelength:
    mov     ebx, fish
    mov     eax, ebx                    ; point ebx address to eax
nextcharacter:
    cmp     byte [eax], 0               ; compare eax byte to zero
    jz      calculatedlength            ; if above compared byte is zero, jump to label
    inc     eax                         ; increment eax address by 1 byte
    jmp     nextcharacter
calculatedlength:
    sub     eax, ebx                    ; subtract ebx - eax addresses to get their difference
    mov     edx, eax                    ; use calculated result as string length to write
    mov     ecx, fish
    mov     ebx, 1
    mov     eax, 4
    int     80h
    ret