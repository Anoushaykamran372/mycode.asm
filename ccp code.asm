org 100h

.data
recordSize db 15
maxRecords db 10
records db 150 dup(0) 
totalMembers db 0
totalWater db 0
totalFlour db 0
totalPulses db 0

menu db 0dh,0ah,"1. Add Record",0dh,0ah,"2. Display All",0dh,0ah,"3. Total Summary",0dh,0ah,"4. Exit",0dh,0ah,"Enter option: $"
newline db 0dh,0ah,"$"
msgAdd db "Enter Sr# (1 byte): $"
msgMem db "Enter Family Members: $"
msgWtr db "Enter Water (liters): $"
msgFlr db "Enter Flour (kg): $"
msgPul db "Enter Pulses (kg): $"

.code
start:
    mov ax, @data
    mov ds, ax

menu_loop:
    mov ah, 09h
    lea dx, menu
    int 21h
    mov ah, 01h
    int 21h
    sub al, '0'

    cmp al, 1
    je add_record
    cmp al, 2
    je display_records
    cmp al, 3
    je display_summary
    cmp al, 4
    je exit

    jmp menu_loop

add_record:
    mov ah, 09h
    lea dx, msgAdd
    int 21h
    mov ah, 01h
    int 21h
    mov bl, al  
    mov si, 0
check_loop:
    mov al, [records + si]
    cmp al, bl
    je dup_error
    add si, 15
    cmp si, 150
    jb check_loop

    mov si, 0
find_empty:
    mov al, [records + si]
    cmp al, 0
    je found_slot
    add si, 15
    cmp si, 150
    jb find_empty
    jmp menu_loop

found_slot:
    mov [records + si], bl ; Sr#
    mov ah, 09h
    lea dx, msgMem
    int 21h
    mov ah, 01h
    int 21h
    mov [records + si + 11], al
    mov ah, 09h
    lea dx, msgWtr
    int 21h
    mov ah, 01h
    int 21h
    mov [records + si + 12], al
    mov ah, 09h
    lea dx, msgFlr
    int 21h
    mov ah, 01h
    int 21h
    mov [records + si + 13], al
    mov ah, 09h
    lea dx, msgPul
    int 21h
    mov ah, 01h
    int 21h
    mov [records + si + 14], al

    jmp menu_loop

dup_error:
    mov ah, 09h
    lea dx, newline
    int 21h
    jmp menu_loop

display_records:
    jmp menu_loop

display_summary:
    mov si, 0
    mov cx, 0
    mov totalMembers, 0
    mov totalWater, 0
    mov totalFlour, 0
    mov totalPulses, 0

sum_loop:
    mov al, [records + si]
    cmp al, 0
    je next_record

    mov al, [records + si + 11]
    add totalMembers, al
    mov al, [records + si + 12]
    add totalWater, al
    mov al, [records + si + 13]
    add totalFlour, al
    mov al, [records + si + 14]
    add totalPulses, al

next_record:
    add si, 15
    cmp si, 150
    jb sum_loop

    jmp menu_loop

exit:
    mov ah, 4ch
    int 21h





