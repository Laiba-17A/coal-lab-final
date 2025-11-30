INCLUDE Irvine32.inc

.data
A DWORD 5
B DWORD 3
X DWORD 4
D DWORD 2

msgVars   BYTE "A=5, B=3, X=4, D=2",0
msg1      BYTE "Step1 (A+B): ",0
msg2      BYTE "Step2 ((A+B)*X): ",0
msgFinal  BYTE "Final ((A+B)*X)-D: ",0

result1 DWORD ?
result2 DWORD ?
result3 DWORD ?

.code

main PROC

    mov edx, OFFSET msgVars
    call WriteString
    call Crlf

    ; Step 1: A+B
    call AddAB
    mov result1, eax
    mov edx, OFFSET msg1
    call WriteString
    mov eax, result1
    call WriteInt
    call Crlf

    ; Step 2: (A+B)*X
    call MulC
    mov result2, eax
    mov edx, OFFSET msg2
    call WriteString
    mov eax, result2
    call WriteInt
    call Crlf

    ; Step 3: ((A+B)*X)-D
    call SubD
    mov result3, eax
    mov edx, OFFSET msgFinal
    call WriteString
    mov eax, result3
    call WriteInt
    call Crlf

    exit
main ENDP


AddAB PROC
    mov eax, A
    add eax, B
    ret
AddAB ENDP

MulC PROC
    mov eax, result1
    imul eax, X
    ret
MulC ENDP

SubD PROC
    mov eax, result2
    sub eax, D
    ret
SubD ENDP

END main
