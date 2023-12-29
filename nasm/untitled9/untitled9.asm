%include    'extras.asm'

SECTION .data
response db 'HTTP/1.1 200 OK', 0Dh, 0Ah, 'Content-Type: text/html', 0Dh, 0Ah, 'Content-Length: 14', 0Dh, 0Ah, 0Dh, 0Ah, 'salmonfishes', 0Dh, 0Ah, 0h

SECTION .bss
buffer      resb    255

SECTION .text
global      _start

_start:
    xor     eax, eax            ; xor by self is a good way to make sure it is zero
    xor     ebx, ebx
    xor     edi, edi
    xor     esi, esi
createSocket:
    push    byte 6              ; 6 IPPROTO_TCP
    push    byte 1              ; 1 SOCK_STREAM
    push    byte 2              ; 2 PP_INET
    mov     ecx, esp            ; move args address (stack pointer location) to ecx

    mov     ebx, 1              ; subroutine socket
    mov     eax, 102            ; call socketcall
    int 80h

    call    printIntLF
bindSocket:
    mov     edi, eax            ; put socket file descriptor to edi
    push    dword 0x00000000    ; put 0 decimal onto the stack (0.0.0.0)
    push    word 0x2923         ; put 9001 decimal onto the stack with reverse byte order (port)
    push    word 2              ; put 2 decimal AF_INET
    mov     ecx, esp            ; move stack pointer location to ecx
    push    byte 16             ; push 16 decimal for arguments length
    push    ecx                 ; push args address (stack pointer location)
    push    edi                 ; push file descriptor
    mov     ecx, esp            ; move args address (stack pointer location) to ecx

    mov     ebx, 2              ; invoke BIND
    mov     eax, 102            ; call socketcall
    int 80h
listenSocket:
    push    byte 1              ; push max queue length arg
    push    edi                 ; push file descriptor
    mov     ecx, esp            ; move args address (stack pointer location) to ecx

    mov     ebx, 4              ; invoke LISTEN
    mov     eax, 102            ; call socketcall
    int 80h
acceptSocket:
    push    byte 0              ; push address length arg
    push    byte 0              ; push address arg
    push    edi                 ; push file descriptor
    mov     ecx, esp            ; move args address (stack pointer location) to ecx

    mov     ebx, 5              ; invoke ACCEPT
    mov     eax, 102            ; call socketcall
    int 80h
forkSocket:
    mov     esi, eax            ; put file descriptor for accepted socket to esi
    mov     eax, 2              ; call fork
    int 80h

    cmp     eax, 0              ; if 0 then in child process
    jz      readSocket

    jmp     acceptSocket
readSocket:
    mov     edx, 255            ; read 255 bytes
    mov     ecx, buffer         ; move memory address into ecx
    mov     ebx, esi            ; put file descriptor for accepted socket to ebx
    mov     eax, 3              ; call read
    int 80h

    mov     eax, buffer         ; put memory address into eax for print
    call    printLF
writeSocket:
    mov     edx, 78             ; byte length to write
    mov     ecx, response       ; memory to write
    mov     ebx, esi            ; put file descriptor for accepted socket to ebx
    mov     eax, 4              ; call write
    int 80h
closeSocket:
    mov     ebx, esi            ; put file descriptor for accepted socket to ebx
    mov     eax, 6              ; call close
    int 80h

    call    exit