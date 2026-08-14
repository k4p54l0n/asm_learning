.intel_syntax noprefix
.global _start
_start:

xor r13, r13
xor r8, r8
mov r12, [rsp]
cmp r12, 1
je no_arguments
dec r12
lea r14, [rsp+24]
mov rdi, [r14]
mov r11, rdi
xor rdi, rdi
lea r14, [rsp+16]
jmp atoi

not_supported:
mov rdi, -1
mov rax, 60
syscall

no_arguments:
mov r13, 0
jmp finish

operators:
cmp byte ptr [r11], '+'
je addition
cmp byte ptr [r11], '-'
je substraction 
cmp byte ptr [r11], '*'
je multiplication
cmp byte ptr [r11], '^'
je xor_bitwise
cmp byte ptr [r11], '|'
je or_bitwise
cmp byte ptr [r11], '&'
je and_bitwise 
jmp not_supported

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
jmp operators 

negative_done:
xor r8, r8
neg rax
jmp operators 

addition:
add r14, 16
dec r12
add r13, rax
xor rax, rax
cmp r12, 1
je finish
jmp atoi

substraction:
add r14, 16
dec r12
sub r13, rax
neg r13
xor rax, rax
cmp r12, 1
je sub_finish
jmp atoi

xor_bitwise:
dec r12
cmp r12, 1
je xor_finish 
add r14, 16
mov rbx, rax
xor rax, rax
jmp atoi

or_bitwise:
dec r12
cmp r12, 1
je or_finish 
add r14, 16
mov rbx, rax
xor rax, rax
jmp atoi

and_bitwise:
dec r12
cmp r12, 1
je and_finish 
add r14, 16
mov rbx, rax
xor rax, rax
jmp atoi

xor_finish:
xor rax, rbx 
mov rdi, rax
jmp itoa
or_finish:
or rax, rbx 
mov rdi, rax
jmp itoa
and_finish:
and rax, rbx 
mov rdi, rax
jmp itoa

multiplication:
dec r12
cmp r12, 1
je mul_finish
add r14, 16
mov rbx, rax
xor rax, rax
jmp atoi

mul_finish:
imul rax, rbx 
mov rdi, rax
jmp itoa

sub_finish:
mov rdi, r13
neg rdi
jmp itoa

finish:
mov rdi, r13
jmp itoa

itoa:
sub rsp, 50 
mov rsi, rsp
xor r12, r12
xor r10, r10
xor r11, r11
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
