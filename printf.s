.intel_syntax noprefix
.global _start
_start:

cmp QWORD ptr[rsp], 1
je done
mov rsi, [rsp+16]
sub rsp, 1
mov byte ptr [rsp], 0x0a
mov rdx, 1 # writesize = 1 byte
mov rax, 1 # write syscall
mov rdi, 1 # output to stdout
jmp read 

read:
mov rax, 1
cmp byte ptr [rsi], 0
je done
cmp byte ptr [rsi], 0x5c
je newline
syscall
inc rsi
jmp read

newline:
cmp byte ptr[rsi+1], 'n'
je write_newline
syscall
inc rsi
jmp read

write_newline:
add rsi, 2
mov r8, rsi
lea rsi, [rsp]
mov rax, 1
mov rdi, 1
syscall
mov rsi, r8
jmp read 

done:
add rsp, 1
mov rdi, 0
mov rax, 60
syscall
