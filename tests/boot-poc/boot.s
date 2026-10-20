.code16
.global _start
_start:
    xor %ax, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %dl, boot_drive
    mov $0x8000, %bx
    mov $0x02, %ah
    mov $0x01, %al
    mov $0x0002, %cx
    mov $0x00, %dh
    mov boot_drive, %dl
    int $0x13
    jc disk_error
    ljmp $0x0000, $0x8000

disk_error:
    mov $disk_error_msg, %si
    call print_message
1:
    cli
    hlt
    jmp 1b

print_message:
    lodsb
    test %al, %al
    jz 2f
    outb %al, $0xe9
    jmp print_message
2:
    ret

boot_drive:
    .byte 0
disk_error_msg:
    .asciz "ZupiOS: falha ao carregar segundo estagio\r\n"
.org 510
.word 0xaa55
