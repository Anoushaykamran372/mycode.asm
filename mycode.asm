.model small
.stack 100h
.data

.code
main:
    mov ax, @data
    mov ds, ax

    ; Read first digit
    mov ah, 1
    int 21h
    sub al, 30h
    mov bl, al

    ; Read operator
    mov ah, 1
    int 21h
    mov cl, al

    ; Read second digit
    mov ah, 1
    int 21h
    sub al, 30h
    mov bh, al

    ; Perform operation
    cmp cl, '+'
    je add_op
    cmp cl, '-'
    je sub_op
    cmp cl, '*'
    je mul_op
    cmp cl, '/'
    je div_op
    jmp exit

add_op:
    mov al, bl
    add al, bh
    daa
    jmp print_result

sub_op:
    mov al, bl
    sub al, bh
    das
    jmp print_result

mul_op:
    mov al, bl
    mul bh
    ; BCD conversion
    mov ah, 0
    aam
    add ax, 3030h
    mov dl, ah
    mov ah, 2
    int 21h
    mov dl, al
    int 21h
    jmp exit

div_op:
    mov al, bl
    mov ah, 0
    div bh
    ; BCD conversion
    aam
    add ax, 3030h
    mov dl, ah
    mov ah, 2
    int 21h
    mov dl, al
    int 21h
    jmp exit

print_result:
    add al, 30h
    cmp al, 3Ah
    jl show
    add al, 7

show:
    mov dl, al
    mov ah, 2
    int 21h

exit:
    mov ah, 4Ch
    int 21h
end main





