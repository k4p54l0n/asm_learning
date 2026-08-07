.intel_syntax noprefix
.global atoi

atoi:

cmp byte ptr [rdi], 0x2d
je negative_handling
movzx rax, byte ptr [rdi]
sub rax, 0x30
mov rdx, rax
inc rdi
jmp loop

loop:
cmp byte ptr [rdi], 0
je done
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
jmp atoi

done:
cmp r8, 1
je negative_done
ret

negative_done:
neg rax
ret
