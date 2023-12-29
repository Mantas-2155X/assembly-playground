exit:
    mov     ebx, 0
    mov     eax, 1
    int 80h
    ret

print:
    push    edx
    push    ecx
    push    ebx
    push    eax
    mov     ebx, eax            ; put str into ebx
    call    strlen
    mov     edx, eax            ; put strlen result to edx
    mov     ecx, ebx
    mov     ebx, 1
    mov     eax, 4
    int 80h
    pop     eax
    pop     ebx
    pop     ecx
    pop     edx
    ret

printLF:
    call    print
    push    eax
    mov     eax, 0Ah            ; put line feed into eax
    push    eax
    mov     eax, esp            ; put current stack pointer into eax
    call    print
    pop     eax
    pop     eax
    ret

strlen:
    push    ebx
    mov     ebx, eax
nextcharacter:
    cmp     byte [eax], 0
    jz      calculatedlength
    inc     eax
    jmp     nextcharacter
calculatedlength:
    sub     eax, ebx
    pop     ebx
    ret