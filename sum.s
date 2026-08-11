.intel_syntax noprefix
.global _start
_start:

mov r12, [rsp]
lea r14, [rsp+16]
jmp atoi

atoi:
mov rdi, [r14]
cmp byte ptr [rdi], 0x2d
je negative_handling
movzx rax, byte ptr [rdi]
sub rax, 0x30
mov rdx, rax
inc rdi
cmp byte ptr [rdi], '9'
ja done
cmp byte ptr [rdi], '0'
jb done
jmp loop

loop:
cmp byte ptr [rdi], '9'
ja done
cmp byte ptr [rdi], '0'
jb done
imul rdx, 10
movzx rax, byte ptr [rdi]
sub rax, 0x30
add rdx, rax
mov rax, rdx
inc rdi
jmp loop

negative_handling:
mov r8, 1
inc rdi
movzx rax, byte ptr [rdi]
sub rax, 0x30
mov rdx, rax
inc rdi
jmp loop

done:
cmp r8, 1
je negative_done
jmp addition 

negative_done:
xor r8, r8
neg rax
jmp addition 

addition:
add r14, 8
dec r12
add r13, rax
xor rax, rax
cmp r12, 1
je finish
jmp atoi

finish:
mov rdi, r13
mov rax, 60
syscall
