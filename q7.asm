INCLUDE Irvine32.inc

.data
n DWORD ?
msg BYTE "Enter odd number n: ",0
newline BYTE 13,10,0
star BYTE "*",0

.code
main PROC
    mov edx, OFFSET msg
    call WriteString
    call ReadInt
    mov n, eax

    ; -------------------------
    ; UPPER HALF including middle
    ; -------------------------
    mov eax, 1         ; stars = 1

upperLoop:
    cmp eax, n
    jg lowerHalf

    ; print stars
    mov ecx, eax
printStars:
    cmp ecx, 0
    je printNewline
    mov edx, OFFSET star
    call WriteString
    dec ecx
    jmp printStars

printNewline:
    mov edx, OFFSET newline
    call WriteString
    add eax, 2
    jmp upperLoop

; -------------------------
; LOWER HALF
; -------------------------
lowerHalf:
    sub eax, 4         ; start from n-2 stars
lowerLoop:
    cmp eax, 0
    jle endPattern

    mov ecx, eax
printStars2:
    cmp ecx, 0
    je printNewline2
    mov edx, OFFSET star
    call WriteString
    dec ecx
    jmp printStars2

printNewline2:
    mov edx, OFFSET newline
    call WriteString
    sub eax, 2
    jmp lowerLoop

endPattern:
    exit
main ENDP
END main
