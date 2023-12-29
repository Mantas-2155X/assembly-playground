%include    'extras.asm'

SECTION .data
fish            db      'Enter fish: ', 0h
purchased       db      'You have purchased ', 0h

SECTION .bss
input           resb    255                 ; reserve 255 bytes of memory

SECTION .text
global          _start

_start:
    mov         eax, fish
    call        print

    mov         edx, 255
    mov         ecx, input
    mov         ebx, 0
    mov         eax, 3
    int 80h

    mov         eax, purchased
    call        print

    mov         eax, input
    call        print

    call        exit