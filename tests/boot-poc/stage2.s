.code16
.global _start
_start:
    xor %ax, %ax
    mov %ax, %ds
    mov %ax, %es
    mov %dl, boot_drive

    # Contract: one 512-byte payload sector at LBA 2, loaded at 0000:9000.
    # This fixed-sector proof caps payload size at 512 bytes.
    mov $0x9000, %bx
    mov $0x02, %ah
    mov $0x01, %al
    mov $0x0003, %cx
    mov $0x00, %dh
    mov boot_drive, %dl
    int $0x13
    jc disk_error

    mov boot_drive, %dl
    ljmp $0x0000, $0x9000

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
    .asciz "ZupiOS: falha ao carregar payload\r\n"
.org 510
