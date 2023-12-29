%include    'extras.asm'

SECTION .data
command     db      '/bin/echo', 0h
arg1        db      'Fish', 0h
arguments   dd      command
            dd      arg1
            dd      0h
environment dd      0h
unix        db      'Unix seconds: ', 0h

SECTION .bss

SECTION .text
global      _start

_start:
    mov     eax, unix
    call    print
    mov     eax, 13                 ; call time
    int 80h

    call    printIntLF
    mov     edx, environment
    mov     ecx, arguments
    mov     ebx, command
    mov     eax, 11                 ; call execve
    int 80h

    call    exit