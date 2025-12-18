global _start

section .bss
audio_buffer  resb 320
sockaddr      resb 16
sock_fd       resq 1
pcm_fd        resq 1
argc          resq 1
argv          resq 1

section .text

_start:
    mov [argc], rdi
    mov [argv], rsi

    cmp rdi, 4
    jne exit

    mov rbx, [rsi+8]
    mov al, byte [rbx]
    cmp al, 's'
    je mode_server
    cmp al, 'c'
    je mode_client
    jmp exit

mode_server:
    call parse_addr
    call socket_create
    call socket_bind
    jmp audio_start

mode_client:
    call parse_addr
    call socket_create
    call socket_connect
    jmp audio_start

parse_addr:
    mov rsi, [argv]
    mov rbx, [rsi+16]
    xor eax, eax
    xor ecx, ecx
parse_ip:
    mov dl, [rbx]
    cmp dl, 0
    je ip_done
    cmp dl, '.'
    je ip_dot
    sub dl, '0'
    imul eax, eax, 10
    add eax, edx
    inc rbx
    jmp parse_ip
ip_dot:
    shl ecx, 8
    or ecx, eax
    xor eax, eax
    inc rbx
    jmp parse_ip
ip_done:
    shl ecx, 8
    or ecx, eax
    mov dword [sockaddr+4], ecx

    mov rbx, [rsi+24]
    xor eax, eax
parse_port:
    mov dl, [rbx]
    cmp dl, 0
    je port_done
    sub dl, '0'
    imul eax, eax, 10
    add eax, edx
    inc rbx
    jmp parse_port
port_done:
    xchg al, ah
    mov word [sockaddr+2], ax
    mov word [sockaddr], 2
    ret

socket_create:
    mov eax, 41
    mov edi, 2
    mov esi, 2
    xor edx, edx
    syscall
    mov [sock_fd], rax
    ret

socket_bind:
    mov eax, 49
    mov edi, [sock_fd]
    lea rsi, [sockaddr]
    mov edx, 16
    syscall
    ret

socket_connect:
    mov eax, 42
    mov edi, [sock_fd]
    lea rsi, [sockaddr]
    mov edx, 16
    syscall
    ret

audio_start:
    mov eax, 2
    lea rdi, [pcm_dev]
    mov esi, 2
    syscall
    mov [pcm_fd], rax

audio_loop:
    mov eax, 0
    mov edi, [pcm_fd]
    lea rsi, [audio_buffer]
    mov edx, 320
    syscall

    mov eax, 44
    mov edi, [sock_fd]
    lea rsi, [audio_buffer]
    mov edx, 320
    xor r10, r10
    syscall

    mov eax, 45
    mov edi, [sock_fd]
    lea rsi, [audio_buffer]
    mov edx, 320
    xor r10, r10
    syscall

    mov eax, 1
    mov edi, [pcm_fd]
    lea rsi, [audio_buffer]
    mov edx, 320
    syscall

    jmp audio_loop

exit:
    mov eax, 60
    xor edi, edi
    syscall

section .rodata
pcm_dev db "/dev/snd/pcmC0D0c",0
