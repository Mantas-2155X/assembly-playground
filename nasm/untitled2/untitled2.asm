%include    'extras.asm'                ; include the file extras.asm

SECTION .data
fish1        db      'salmon', 0h  ; add 0h (null) to indicate string ending in memory
fish2        db      'trout', 0h

SECTION .text
global      _start

_start:
    mov     eax, fish1
    call    printLF
    mov     eax, fish2
    call    printLF
    call    exit