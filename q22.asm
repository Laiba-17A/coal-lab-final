INCLUDE Irvine32.inc

.data
    arr DWORD 1,2,3,4,5,6,7,8,9,10
    arrSize DWORD 10

    msgOriginal BYTE "Original Array: ",0
    msgRotated BYTE "Array after 1-step left rotation: ",0

.code

main PROC
    ; Print original array
    mov edx, OFFSET msgOriginal
    call WriteString

    mov esi, OFFSET arr
    mov eax, arrSize
    mov ecx, eax         ; ECX = loop counter
printOrig:
        mov eax, [esi]
        call WriteDec
        mov al, ' '
        call WriteChar
        add esi, 4
        loop printOrig
    call Crlf

    ; Perform single left rotation
    call RotateOnce

    ; Print rotated array
    mov edx, OFFSET msgRotated
    call WriteString

    mov esi, OFFSET arr
    mov eax, arrSize
    mov ecx, eax         ; ECX = loop counter
printRot:
        mov eax, [esi]
        call WriteDec
        mov al, ' '
        call WriteChar
        add esi, 4
        loop printRot
    call Crlf

    exit
main ENDP

; ---------------------------------
; RotateOnce Procedure (left by 1)
; ---------------------------------
RotateOnce PROC
    mov esi, OFFSET arr       ; base of array
    mov eax, arrSize
    mov ecx, eax

    mov eax, [esi]            ; save first element

    mov edi, 0
shiftLoop:
    cmp edi, ecx
    jge shiftDone

    ; Compute source = array[edi + 1]
    mov edx, edi
    inc edx
    shl edx, 2
    mov ebx, [esi + edx]

    ; Compute destination = array[edi]
    mov edx, edi
    shl edx, 2
    mov [esi + edx], ebx

    inc edi
    jmp shiftLoop
shiftDone:

    ; Place saved first element at the end
    mov edx, ecx
    dec edx
    shl edx, 2
    mov [esi + edx], eax

    ret
RotateOnce ENDP

END main
