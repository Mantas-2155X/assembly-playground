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

printInt:
    push    eax
    push    ecx
    push    edx
    push    esi
    mov     ecx, 0              ; characters to print counter
    jmp     .divLoop
.divLoop:
    inc     ecx
    mov     edx, 0
    mov     esi, 10
    idiv    esi                 ; divide eax by esi
    add     edx, 48             ; convert edx to ASCII, edx holds remainder after it
    push    edx
    cmp     eax, 0              ; divide if possible
    jnz     .divLoop
    jmp     .printLoop
.printLoop:
    dec     ecx                 ; move down the stack
    mov     eax, esp            ; put current stack pointer for print
    call    print
    pop     eax                 ; remove last character
    cmp     ecx, 0              ; check if all is printed
    jnz     .printLoop
    pop     esi
    pop     edx
    pop     ecx
    pop     eax
    ret

printIntLF:
    call    printInt
    push    eax
    mov     eax, 0Ah
    push    eax
    mov     eax, esp
    call    print
    pop     eax
    pop     eax
    ret

strlen:
    push    ebx
    mov     ebx, eax
    jmp     .nextChar
.nextChar:
    cmp     byte [eax], 0
    jz      .calcLen
    inc     eax
    jmp     .nextChar
.calcLen:
    sub     eax, ebx
    pop     ebx
    ret