%include    'extras.asm'

SECTION .data
filename    db          'fish.txt', 0h
fish1       db          'salmon', 0h
fish2       db          "Humuhumunukunukuapua’a", 0h

SECTION .bss
content     resb        255

SECTION .text
global      _start

_start:
    ; create file
    mov     ecx, 0777o                  ; file permissions
    mov     ebx, filename
    mov     eax, 8                      ; call creat
    int 80h

    ; write file
    mov     edx, 6
    mov     ecx, fish1
    mov     ebx, eax                    ; put file descriptor to ebx
    mov     eax, 4                      ; call write
    int 80h

    ; open file (r)
    mov     ecx, 0                      ; open type (0 - r, 1 - w, 2 - rw)
    mov     ebx, filename
    mov     eax, 5                      ; call open
    int 80h

    ; read file
    mov     edx, 6
    mov     ecx, content
    mov     ebx, eax                    ; put file descriptor to ebx
    mov     eax, 3                      ; call read
    int 80h
    mov     eax, content                ; contents to eax for print
    call    printLF

    ; close file
    mov     ebx, ebx                    ; put file descriptor to ebx
    mov     eax, 6                      ; call close
    int 80h

    ; open file (w)
    mov     ecx, 1
    mov     ebx, filename
    mov     eax, 5
    int 80h

    ; seek file
    mov     edx, 2                      ; seek location
    mov     ecx, 0                      ; seek bytes offset
    mov     ebx, eax                    ; put file descriptor to ebx
    mov     eax, 19                     ; call seek
    int 80h

    ; write file
    mov     edx, 22
    mov     ecx, fish2
    mov     ebx, ebx                    ; put file descriptor to ebx
    mov     eax, 4                      ; call write
    int 80h

    ; remove file
    mov     ebx, filename               ; put file descriptor to ebx
    mov     eax, 10                     ; call unlink
    int 80h

    call    exit