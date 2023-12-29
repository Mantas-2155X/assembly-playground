SECTION .data
fish        db      'salmon', 0Ah

SECTION .text
global      _start

_start:
    mov     eax, fish
    call    strlen              ; return value gets placed in eax
    call    print
    mov     ebx, 0
    mov     eax, 1
    int 80h

print:
    mov     edx, eax
    mov     ecx, fish
    mov     ebx, 1
    mov     eax, 4
    int 80h
    ret

strlen:
    push    ebx                 ; push current ebx value onto the stack
    mov     ebx, eax
nextcharacter:
    cmp     byte [eax], 0
    jz      calculatedlength
    inc     eax
    jmp     nextcharacter
calculatedlength:
    sub     eax, ebx
    pop     ebx                 ; pop the value from the stack back into ebx
    ret