%include    'extras.asm'

SECTION .data

SECTION .bss

SECTION .text
global          _start

_start:
    ;call print10
    call print10Fixed
    call exit

print10:
    mov         ecx, 0              ; set counter to 0
next10:
    inc         ecx
    mov         eax, ecx            ; put counter digit into eax
    add         eax, 48             ; add 48 to convert it to ASCII number
    push        eax
    mov         eax, esp            ; put stack pointer address to eax
    call        printLF
    pop         eax
    cmp         ecx, 10             ; check if counter digit is 10
    jne         next10              ; if its not, repeat
    ret

print10Fixed:
    mov         ecx, 0
next10Fixed:
    inc         ecx
    mov         eax, ecx
    call        printIntLF
    cmp         ecx, 10
    jne         next10Fixed
    ret