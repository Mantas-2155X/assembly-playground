%include    'extras.asm'

SECTION .data
request db 'GET / HTTP/1.1', 0Dh, 0Ah, 'Host: 139.162.39.66:80', 0Dh, 0Ah, 0Dh, 0Ah, 0h

SECTION .bss
buffer      resb    1

SECTION .text
global      _start

_start:
    xor     eax, eax            ; xor by self is a good way to make sure it is zero
    xor     ebx, ebx
    xor     edi, edi
createSocket:
    push    byte 6              ; 6 IPPROTO_TCP
    push    byte 1              ; 1 SOCK_STREAM
    push    byte 2              ; 2 PP_INET
    mov     ecx, esp            ; move args address (stack pointer location) to ecx

    mov     ebx, 1              ; subroutine socket
    mov     eax, 102            ; call socketcall
    int 80h

    call    printIntLF
connectSocket:
    mov     edi, eax            ; put socket file descriptor to edi
    push    dword 0x4227a28b    ; put 139.162.39.66 onto the stack with reverse byte order
    push    word 0x5000         ; push 80 port onto stack in reverse byte order
    push    word 2              ; push 2 decimal on stack AF_INET
    mov     ecx, esp            ; put stack pointer address into ecx
    push    byte 16             ; push arguments length 16 decimal
    push    ecx                 ; push arguments address
    push    edi                 ; push file descriptor
    mov     ecx, esp            ; put address of arguments

    mov     ebx, 3              ; invoke CONNECT
    mov     eax, 102            ; call socketcall
    int 80h
writeSocket:
    mov     edx, 43             ; byte length to write
    mov     ecx, request        ; memory to write
    mov     ebx, edi            ; put file descriptor for accepted socket to ebx
    mov     eax, 4              ; call write
    int 80h
readSocket:
    mov     edx, 1              ; read 1 byte at a time
    mov     ecx, buffer         ; move memory address into ecx
    mov     ebx, edi            ; put file descriptor for connected socket to ebx
    mov     eax, 3              ; call read
    int 80h

    cmp     eax, 0              ; if zero then end of file is reached
    jz      closeSocket

    mov     eax, buffer         ; put memory address into eax for print
    call    print
    jmp     readSocket
closeSocket:
    mov     ebx, edi            ; put file descriptor for connected socket to ebx
    mov     eax, 6              ; call close
    int 80h

    call    exit