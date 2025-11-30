INCLUDE Irvine32.inc

.data
A DWORD 12, 15, 7, 9
B DWORD 8, 10, 3, 5
Result DWORD 4 DUP(?)
SumResult DWORD ?
msgAdd BYTE "MATRIX ADDITION",0
msgSub BYTE "MATRIX SUBTRACTION",0
msgResult BYTE "Result: ",0
msgSum BYTE "Total Sum: ",0
temp BYTE " ",0

.code
main PROC
    call MatrixAdd
    mov edx, OFFSET msgAdd
    call WriteString
    call Crlf

    mov esi, OFFSET Result
    mov ecx, 4
    print_loop1:
        mov eax, [esi]
        call WriteInt
        mov al, ' '
        call WriteChar
        add esi, 4
        loop print_loop1

    call Crlf
    call MatrixSum
    mov edx, OFFSET msgSum
    call WriteString
    mov eax, SumResult
    call WriteInt
    call Crlf
    mov edx, OFFSET temp
    call WriteString
    call Crlf

    call MatrixSub
    mov edx, OFFSET msgSub
    call WriteString
    call Crlf

    mov esi, OFFSET Result
    mov ecx, 4
    print_loop2:
        mov eax, [esi]
        call WriteInt
        mov al, ' '
        call WriteChar
        add esi, 4
        loop print_loop2

    call Crlf
    call MatrixSum
    mov edx, OFFSET msgSum
    call WriteString
    mov eax, SumResult
    call WriteInt
    call Crlf
    exit
main ENDP

MatrixAdd PROC
    mov esi, OFFSET A
    mov edi, OFFSET B
    mov ebx, OFFSET Result
    mov ecx, 4
add_loop:
    mov eax, [esi]
    add eax, [edi]
    mov [ebx], eax
    add esi, 4
    add edi, 4
    add ebx, 4
    loop add_loop
    ret
MatrixAdd ENDP

MatrixSub PROC
    mov esi, OFFSET A
    mov edi, OFFSET B
    mov ebx, OFFSET Result
    mov ecx, 4
sub_loop:
    mov eax, [esi]
    sub eax, [edi]
    mov [ebx], eax
    add esi, 4
    add edi, 4
    add ebx, 4
    loop sub_loop
    ret
MatrixSub ENDP

MatrixSum PROC
    mov esi, OFFSET Result
    mov ecx, 4
    xor eax, eax
sum_loop:
    add eax, [esi]
    add esi, 4
    loop sum_loop
    mov SumResult, eax
    ret
MatrixSum ENDP

END main
