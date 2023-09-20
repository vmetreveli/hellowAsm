section .data
    hello db  'Hello, World!',  0xA ; Null-terminated string with a newline character
    .len: equ $ - hello

section .text
    global _main ; Entry point for the program

_main:
   xor r9, r9 ; Initialize rax to 0 (count)
    
again:
    ; Write "Hello, World!" to stdout (file descriptor 1)
    
    mov rax, 0x2000004 ; syscall number for sys_write
    mov rdi, 0x1       ; file descriptor (stdout)
    mov rsi, hello     ; pointer to the message
    mov rdx, hello.len ; message length
    syscall
    
    
    inc r9
    ; Check if we've printed "Hello, World!" five times
    cmp r9, 0x5
    jl  short again
  

    ; Exit the program
    mov rax, 0x2000001 ; syscall number for sys_exit
    xor rdi, rdi       ; exit status (0)
    syscall


    section .bss

        string resb     20
        count  resw     256
        x      resd     1
    ;nasm -f macho64 h.asm    
    ;ld -arch x86_64 -o hi h.o -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -macosx_version_min 10.13 -no_pie