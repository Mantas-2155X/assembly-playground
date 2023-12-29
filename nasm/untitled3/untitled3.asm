%include    'extras.asm'

SECTION .text
global      _start

_start:
    pop     ecx         ; first value is argument count
nextArg:
    cmp     ecx, 0h
    jz      doneArgs
    pop     eax         ; pop next argument off the stack
    call    printLF
    dec     ecx         ; decrement argument count by 1
    jmp     nextArg
doneArgs:
    call    exit