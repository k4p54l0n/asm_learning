.intel_syntax noprefix
.global itoa 

itoa:
xor rdx, rdx
mov rcx, 10
mov rax, rdi
div rcx
mov r8, rax
mov r9, rdx
add r8, 0x30
add r9, 0x30
mov [rsi], r8b
mov [rsi+1], r9b
mov rdi, 1
mov rax, 1
mov rdx, 2
syscall
ret
