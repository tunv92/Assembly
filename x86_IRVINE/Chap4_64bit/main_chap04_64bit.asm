; Summing an Array (SumArray_64.asm)
ExitProcess PROTO
.data
intarray    QWORD 1000000000000h,2000000000000h
            QWORD 3000000000000h,4000000000000h
.code
main PROC 

    mov rcx, LENGTHOF intarray
    mov rdi, OFFSET intarray
    mov rax, 0
L1:
    add rax, [rdi]
    add rdi, TYPE intarray
    loop  L1

    mov ecx, 0
call ExitProcess
main ENDP
END