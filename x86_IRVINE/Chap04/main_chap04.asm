.386
.model flat, stdcall
.stack 4096



ExitProcess PROTO, dwExitCode:DWORD

PI                  EQU     <3.14>                 ; text 3.14 => number 3.14
pressKey            EQU     <"Press any key to continue...",0>	; text
matrix1             EQU     10 * 10                ; number 100
matrix2             EQU     <10 * 10>              ; text 10*10
 
.data
    var01           DWORD    5, 6

    varWORD         WORD     7, 8

    byteVal         BYTE     10001111b

    saveflags       BYTE    ?



    val1            WORD    1000h
    val2            WORD    2000h
    arrayB          BYTE    10h,20h,30h,40h,50h
    arrayW          WORD    100h,200h,300h
    arrayD          DWORD   10000h,20000h

    bVal            BYTE    ?
    myArray         WORD    1,2,3,4,5
    bigArray        DWORD   520 DUP(3)
    pArray          DWORD   bigArray

    bVal2           BYTE    ?   ; 00404004h
    ALIGN           4
    dVal            DWORD   ?   ; 00404008h (instead of 00404005h)

    myDouble        DWORD   12345678h

    arrayDD         DWORD 10000h,20000h,30000h
    sum             DWORD   0
    sum2            DWORD   0
    sum3            DWORD   0
 
.code
main PROC  

        ; test flags
        ; PL (sign) up when result is negative (1 in the highest bit)
        mov     al, 8
        add     al, -9

        ; Zero(ZR): Set when result is equa 0
        ; Carry (CY): set to 1, if carry is generated after a operation.
        ; not overflow but result is too big for AL to hold
        mov     al, 00001000b
        add     al, 11111000b

        ; OV: Overflow
        mov     al, 120
        add     al, 120




        ; The instruction pointer register (IP, EIP, or RIP) cannot be a destination operand in MOV instruction

        ; Immediate�uses a numeric literal expression
        mov     eax, 6  
        ; Register�uses a named register in the CPU
        mov     eax, ebx
        ; Memory�references a memory location
        mov     eax, var01                      ; Direct Memory Operands
        mov     ebx, [var01]                    ; dereference operation
        mov     ebx, [var01 + 4]                ; direct-offset operand (dereference operation)
   

        mov     ax, varWORD

        ; sign extension
        ; source operand cannot be a constant
        ; byteVal BYTE 10001111b
        ; MOVZX (move with zero-extend => only use with unsigned int)
        movzx   ax, byteVal                     ; AX = 0000000010001111b

        ; MOVSX instruction (move with sign-extend)
        ; byteVal BYTE 10001111b
        movsx   ax,byteVal                      ; AX = 1111111110001111b

        ; another example
        mov     bx,0A69Bh                       ; The leading zero appearing before A69B is just a 
                                                ; notational convenience so the assembler does not 
                                                ; mistake the constant for the name of an identifier
        movsx   eax,bx                          ; EAX = FFFFA69Bh
        movsx   edx,bl                          ; EDX = FFFFFF9Bh
        movsx   cx,bl                           ; CX = FF9Bh

        
        ; flags
        ; EFLAGS register into AH: Sign, Zero, Auxiliary Carry, Parity, and Carry
        lahf                                    ; load flags into AH
        mov     saveflags, ah                   ; save them in a variable

        mov     ah, saveflags                   ; load saved flags into AH
        sahf                                    ; copy into Flags register

        add     varWORD, 1


        ; Demonstrating MOVZX instruction:
        mov     bx,0A69Bh
        movzx   eax,bx                          ; EAX = 0000A69Bh
        movzx   edx,bl                          ; EDX = 0000009Bh
        movzx   cx,bl                           ; CX = 009Bh

        ; Demonstrating MOVSX instruction:
        mov     bx,0A69Bh
        movsx   eax,bx                          ; EAX = FFFFA69Bh
        movsx   edx,bl                          ; EDX = FFFFFF9Bh
        mov     bl,7Bh
        movsx   cx,bl                           ; CX = 007Bh

        ; Memory-to-memory exchange:
        mov     ax,val1                         ; AX = 1000h
        xchg    ax,val2                         ; AX=2000h, val2=1000h
        mov     val1,ax                         ; val1 = 2000h
 

        ; Direct-Offset Addressing (byte array):
        mov     al,arrayB                       ; AL = 10h
        mov     al,[arrayB+1]                   ; AL = 20h
        mov     al,[arrayB+2]                   ; AL = 30h
        ; Direct-Offset Addressing (word array):
        mov     ax,arrayW                       ; AX = 100h
        mov     ax,[arrayW+2]                   ; AX = 200h
        ; Direct-Offset Addressing (doubleword array):
        mov     eax,arrayD                      ; EAX = 10000h
        mov     eax,[arrayD+4]                  ; EAX = 20000h
        mov     eax,[arrayD+4]                  ; EAX = 20000h
         


        mov     esi,OFFSET bVal                 ; ESI = 00404000h (location of bVal)

        ; myArray WORD 1,2,3,4,5
        ; move third element location myArray to esi
        mov     esi,OFFSET myArray + 4          ; esi POINT to third element


        ; bigArray DWORD 500 DUP(?)
        ; pArray DWORD bigArray
        ; pArray (32 bit) a pointer to bigArray (location of the first element)
        mov esi,pArray                          ; esi now a pointer to bigArray
        mov esi,OFFSET bigArray                 ; the same as above
        mov esi,[bigArray]                      ; this will bring value in location [bigArray]

        mov esi, 8

        ; myDouble DWORD 12345678h
        mov ax,WORD PTR myDouble                ; move 16 lower bit to ax; (5678h because of little endian order)
        mov ax,WORD PTR [myDouble+2]            ; 1234h

        ; indirect operand, indirect addressing
        mov esi,OFFSET byteVal
        mov al,[esi] ; AL = 10h
        mov [esi],bl

        ;inc [esi] ; error: operand must have size
        inc BYTE PTR [esi]


        ; arrayD          DWORD 10000h,20000h,30000h
        ; sum             DWORD   0
        mov esi,OFFSET arrayDD
        mov eax,[esi]
        add esi, 4
        add eax, [esi]
        add esi, 4
        add eax, [esi]
        mov sum, eax

        mov esi,OFFSET arrayDD
        mov eax,[esi]
        add eax,[esi + 4]
        add eax,[esi + 8]
        mov sum2,eax

        mov esi,0
        mov eax,arrayDD[esi]
        add eax,arrayDD[esi + 4]
        add eax,arrayDD[esi + 8]
        mov sum3,eax



        mov esi,3 ; subscript
        mov eax,arrayDD[esi*TYPE arrayDD] ; EAX = 4




     INVOKE ExitProcess, eax
main ENDP

END main



.data?
bigArray            DWORD     5000 DUP(?)                 ; 20,000 bytes, not initialized; 