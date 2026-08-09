.intel_syntax noprefix
.global itoa_digit

itoa_digit:
mov rax, rdi
add rax, 0x30
ret
