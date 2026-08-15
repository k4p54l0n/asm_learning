.intel_syntax noprefix
.global _start
_start:

mov rsi, [rsp+16]
cmp byte ptr [rsp], 1
je done
mov rdx, 1 # writesize = 1 byte
mov rax, 1 # write syscall
mov rdi, 1 # output to stdout
jmp read 

read:
cmp byte ptr [rsi], 0
je done
syscall
inc rsi
jmp read

done:
add rsp, 128
mov rdi, 0
mov rax, 60
syscall
