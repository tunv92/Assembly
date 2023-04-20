.386
.model flat, stdcall
.stack 4096



ExitProcess PROTO, dwExitCode:DWORD

PI                  EQU     <3.14>                 ; text 3.14 => number 3.14
pressKey            EQU     <"Press any key to continue...",0>	; text
matrix1             EQU     10 * 10                ; number 100
matrix2             EQU     <10 * 10>              ; text 10*10




.data

num1                DWORD   matrix1                ; 100
num2                DWORD   matrix2                ; 10*10 (still 100)

prompt              BYTE    pressKey

meo                 BYTE    2
meo2                BYTE    2 

selfPtr             DWORD   $
ListSize            =       (selfPtr - meo)
selfPtr2            DWORD   $

myString            BYTE    "This is a long string, containing"
                    BYTE    "any number of characters", 0
myString_len        =       ($ - myString)


list                WORD    1000h,2000h,3000h,4000h
ListSize            =       ($ - list) / 2
  
abcd                BYTE    "ABCD"
; number data type
myList              DWORD   2, 3, 5, 8
myarr               BYTE    1, 2
                    BYTE    3, 4

; declaring string
mystr001            BYTE    "chao the gioi", 0
mystr002            BYTE    'chao the gioi', 0


myint32             DD       5, 6, 7                 ; DD = DWORD
intdefault          DD       ?
sum                 DD       ?

value1              BYTE     'A' 
value2              BYTE     0
value3              BYTE     255
value4              SBYTE    -128
value5              SBYTE    +127

greeting0	          \
                    BYTE \
			            "Welcome to the Encryption Demo program "

; 0Dh and 0Ah are alternately called CR/LF 
greeting1           BYTE     "Welcome to the Encryption Demo program "
                    BYTE     "created by Kip Irvine.",0dh,0ah
                    BYTE     "If you wish to modify this program, please "
                    BYTE     "send me a copy.",0dh,0ah,0

; DUP
arr1                BYTE     20 DUP(0)                  ; 20 bytes, all equal to zero
arr2                BYTE     20 DUP(?)                  ; 20 bytes, uninitialized
arr3                BYTE     4 DUP("STACK")             ; 20 bytes: "STACKSTACKSTACKSTACK"

; POINTER?
; pVal contains the offset of arr2
pVal                DWORD    arr2

; REAL number
rVal1               REAL4    -1.2
rVal2               REAL8    3.2E-260
rVal3               REAL10   4.6E+4096
ShortArray          REAL4    20 DUP(0.0)

; Symbolic Constants
COUNT               =        500
array               dword    COUNT DUP(0)

; TEXTEQU Directive
rowSize             =        5
count2              TEXTEQU  %(rowSize * 2)
move                TEXTEQU  <mov>
setupAL             TEXTEQU  <move al,count2>

SecondsInDay        =        24*60*60

myArray             WORD     20 DUP(?)
ArrayStorageSize    =        ($ - myArray)
ArraySize           =        ($ - myArray)/4

procedure           TEXTEQU     <proc>
Sample              TEXTEQU     <"Sample string">
MyString2           BYTE        Sample
SetupESI            TEXTEQU     <mov esi,OFFSET myArray>

int001              =           25
int002              =           11001b
int003              =           31o
int004              =           19h
choa                BYTE        4,126,7,8

choachoa            label BYTE 
numnbersmall        DWORD       01020304h
bigend              label DWORD  
meomeo              BYTE        04h,03h,02h,01h

; DWORD with negative value
nevDWORD            DWORD       -3
posDWORD            DWORD       3

declare01           BYTE        "a", "b", "c", "d", "e"
declare02           SDWORD      -2147483648
myString3           BYTE        500 DUP("TEST")



th2                 =         2
th3                 =         3
th4                 =         4
th5                 =         5
th6                 =         6
th7                 =         7
cnh                 =         8

week                BYTE        th2, th3, th4, th5, th6, th7, cnh

declare04           TEXTEQU     <"chao">
hellow              BYTE        declare04
 
.code
main PROC

        mov         edx, nevDWORD
        add         edx, posDWORD

        add         eax, 5
        add         edx, 5


        mov         ebx, num1
        mov         ecx, num2
        ; redefine  
        COUNT = 100
        mov         eax, COUNT              ; mov eax, 500
        setupAL
        mov         eax, 7
        add         eax, 8
        mov         sum, eax

        mov         ecx, 5                  ; move mem to reg
   
     INVOKE ExitProcess, eax
main ENDP

END main        ;specify the program's entry point



.data?
bigArray            DWORD     5000 DUP(?)                 ; 20,000 bytes, not initialized; 