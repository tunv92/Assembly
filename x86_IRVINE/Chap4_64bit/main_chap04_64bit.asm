; Summing an Array (SumArray_64.asm)
ExitProcess PROTO
.data
intarray    QWORD 1000000000000h,2000000000000h
            QWORD 3000000000000h,4000000000000h

str1    BYTE    "Khong bao gio bo tay", 0
intNum  DWORD   88
str2    BYTE    "Khong bao gio bo tay 2", 0
str123  BYTE    (SIZEOF str1 + SIZEOF str2) DUP(0)
total   DWORD   0

three   DWORD   12345678h

.code
main PROC 

    ; Summing intarray
    mov rcx, LENGTHOF intarray
    mov rdi, OFFSET intarray
    mov rax, 0
L1:
    add rax, [rdi]
    add rdi, TYPE intarray
    loop  L1

    mov ecx, 0
    ; End Summing intarray

    ; Concat string (64 bit, visual studio 2019: Project Properties) -> Confuguration properties -> Linker -> System -> Enable Large Addresses = No
    ; 
    mov total,SIZEOF str123
    mov ecx, SIZEOF str1
    mov rsi, 0

L2: 
    mov al, str1[rsi]
    mov str123[rsi], al
    inc rsi
    loop L2

    mov ecx, SIZEOF str2
    mov rdi, 0

L3:
    mov al, str2[rdi]
    mov str123[rsi], al
    inc rsi
    inc rdi
    loop L3
    ; End concat string

    ; 4.9.2 -> 1
    ; three   DWORD   12345678h
    mov ax, WORD PTR three
    mov bx, WORD PTR three + 2
    mov WORD PTR three, bx
    mov WORD PTR three + 2, ax




call ExitProcess
main ENDP
END