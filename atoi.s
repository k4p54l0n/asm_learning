.intel_syntax noprefix
.global atoi

atoi:

movzx rax, byte ptr [rdi]
sub rax, 0x30
mov rdx, rax
inc rdi
cmp byte ptr [rdi], 0
je done
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

done:
ret
