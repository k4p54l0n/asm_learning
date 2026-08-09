.intel_syntax noprefix
.global itoa 

itoa:
xor r10, r10
mov r11, 0
xor rdx, rdx
mov rcx, 10
mov rax, rdi
cmp rdi, 0
jl is_negative
jmp loop

is_negative:
mov byte ptr [rsi], 0x2d
neg rax
inc r10
inc r11
jmp loop

loop:
xor rdx, rdx
div rcx
mov r8, rax
mov r9, rdx
add r9, 0x30
push r9
inc r10
cmp r8, 0
je drop_zero
jmp loop

drop_zero:
cmp r10, r11
je done
pop r9
mov [rsi+r11], r9b
inc r11
jmp drop_zero

done:
mov rax, r10
ret
