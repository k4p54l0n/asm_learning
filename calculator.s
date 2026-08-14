.intel_syntax noprefix
.global _start
_start:

xor r13, r13
xor r8, r8
mov r12, [rsp]
cmp r12, 1
je no_arguments
dec r12
lea r14, [rsp+16]
jmp atoi

no_arguments:
mov r13, 0
jmp finish

atoi:
mov rdi, [r14]
add rdi, r8
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
jmp atoi

done:
cmp r8, 1
je negative_done
jmp addition 

negative_done:
xor r8, r8
neg rax
jmp addition 

addition:
add r14, 16
dec r12
add r13, rax
xor rax, rax
cmp r12, 1
je finish
jmp atoi

finish:
mov rdi, r13
jmp itoa

itoa:
sub rsp, 50 
mov rsi, rsp
xor r12, r12
xor r10, r10
mov r11, 0
xor rdx, rdx
mov rcx, 10
mov rax, rdi
cmp rdi, 0
jl is_negative
jmp itoa_loop

is_negative:
mov byte ptr [rsi], 0x2d
neg rax
inc r10
inc r11
jmp itoa_loop

itoa_loop:
xor rdx, rdx
div rcx
mov r8, rax
mov r9, rdx
add r9, 0x30
push r9
inc r10
cmp r8, 0
je drop_zero
jmp itoa_loop

drop_zero:
cmp r10, r11
je write 
pop r9
mov [rsi+r11], r9b
inc r11
jmp drop_zero

write:
mov rdi, 1
mov rdx, r11
mov rax, 1
syscall

itoa_done:
add rsp, 50
mov rax, 60
mov rdi, 0
syscall
