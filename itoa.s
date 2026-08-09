.intel_syntax noprefix
.global itoa 

itoa:
xor rdx, rdx
mov rcx, 10
mov rax, rdi
div rcx
mov r8, rax
mov r9, rdx
cmp r8, 0
je drop_zero
add r8, 0x30
add r9, 0x30
mov [rsi], r8b
mov [rsi+1], r9b
mov rax, 2
ret

drop_zero:
add r9, 0x30
mov [rsi], r9b
mov rax, 1
ret
