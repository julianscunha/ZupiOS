.code16
.global _start
_start:
    xor %ax, %ax
    mov %ax, %ds
    mov $msg, %si
1:
    lodsb
    test %al, %al
    jz 2f
    outb %al, $0xe9
    jmp 1b
2:
    cli
3:
    hlt
    jmp 3b
msg:
    .asciz "ZupiOS QEMU boot OK\r\n"
.org 510
.word 0xaa55
