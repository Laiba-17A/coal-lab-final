INCLUDE Irvine32.inc

.data
msgX BYTE "Enter x: ",0
msgPoly BYTE "Polynomial: 3x3 + 2x2 - 5x + 7",0
msgRes BYTE "Result: ",0

x DWORD ?
x2 DWORD ?
x3 DWORD ?
result DWORD ?

.code
main PROC

    mov edx, OFFSET msgX
    call WriteString
    call ReadInt
    mov x, eax

    ; x2 = x * x     (stack only)
    push x
    push x
    pop ebx
    pop eax
    imul eax, ebx
    mov x2, eax
    imul eax,ebx ; x3 = x2 * x
    mov x3,eax

    ; push coefficients
    push 7
    push -5
    push 2
    push 3

    ; 3*x3
    push x3
    pop eax        ; x3
    pop ebx        ; 3
    imul eax, ebx
    mov x3,eax

    ; 2*x2
    push x2
    pop eax
    pop ebx
    imul eax, ebx
    mov x2,eax

    ; -5*x
    push x
    pop eax
    pop ebx
    imul eax, ebx
    mov x,eax

    ; sum all terms (stack only)
    push x3
    push x2
    push x
    pop eax
    pop ebx
    add eax, ebx
    pop ebx
    add eax, ebx
    pop ebx
    add eax,ebx
 
    mov result, eax

    ; output
    call Crlf
    mov edx, OFFSET msgPoly
    call WriteString
    call Crlf

    mov edx, OFFSET msgRes
    call WriteString
    mov eax, result
    call WriteInt
    call Crlf

    exit
main ENDP
END main
