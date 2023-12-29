%include    'extras.asm'

SECTION .data
dot         db      '.'

SECTION .bss

SECTION .text
global      _start

_start:
    mov     eax, 10
    mov     ebx, 11
    add     eax, ebx
    call    printIntLF

    mov     eax, 23
    mov     ebx, 2
    sub     eax, ebx
    call    printIntLF

    mov     eax, 7
    mov     ebx, 3
    mul     ebx
    call    printIntLF

    mov     eax, 210
    mov     ebx, 10
    div     ebx
    call    printInt
    mov     eax, dot
    call    print
    mov     eax, edx        ; put remainder into edx
    call    printIntLF

    call    exit