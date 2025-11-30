INCLUDE Irvine32.inc

.data
    arr DWORD 34, 12, 56, 7, 89, 21, 45, 9, 72, 5
    arrSize DWORD 10

    msgArray BYTE "Array: ",0
    msgEnterKey BYTE "Enter value to search: ",0
    msgFound BYTE "Value found at index: ",0
    msgNotFound BYTE "Value not found.",0

    searchKey DWORD ?

.code

LinearSearch PROTO arrPtr:PTR DWORD, count:DWORD, key:DWORD

main PROC
    mov edx, OFFSET msgArray
    call WriteString

    mov ecx, arrSize
    mov esi, OFFSET arr
printArray:
        mov eax, [esi]
        call WriteDec
        mov al, ' '
        call WriteChar
        add esi, 4
        loop printArray
    call Crlf

    mov edx, OFFSET msgEnterKey
    call WriteString
    call ReadInt
    mov searchKey, eax

    INVOKE LinearSearch, ADDR arr, DWORD PTR arrSize, DWORD PTR searchKey

    cmp eax, -1
    je NotFound

    mov edx, OFFSET msgFound
    call WriteString
    call WriteDec
    call Crlf
    jmp EndProg

NotFound:
    mov edx, OFFSET msgNotFound
    call WriteString
    call Crlf

EndProg:
    exit
main ENDP

; -------------------------
; Linear Search Procedure
; -------------------------
LinearSearch PROC arrPtr:PTR DWORD, count:DWORD, key:DWORD
    mov esi, arrPtr
    mov ecx, count
    mov ebx, key
    xor eax, eax

searchLoop:
        cmp [esi], ebx
        je found
        add esi, 4
        inc eax
        loop searchLoop
    mov eax, -1
    ret

found:
    ret
LinearSearch ENDP

END main
