;Q2 Write an Assembly program that takes three numbers from the user and
;finds the largest number two times — first using unsigned comparison (JA, JB,
;JAE) and then using signed comparison (JG, JL, JGE). Display both results with
;messages like "Largest (Unsigned) = ..." and "Largest (Signed) = ...".



include irvine32.inc

findfive proto :dword
.data
    
    msg1 byte "enter num1: ",0
    msg2 byte "enter num2: ",0
    msg3 byte "enter num3: ",0

    out1 byte "largest unsigned: ",0
    out2 byte "largest signed: ",0

.code
main proc
    
    mov edx, offset msg1
    call WriteString
    call ReadInt
    mov ebx, eax

    mov edx, offset msg2
    call WriteString
    call ReadInt
    mov ecx, eax

    mov edx, offset msg3
    call WriteString
    call ReadInt
    mov esi, eax

    mov eax, ebx
    cmp ecx, eax
    ja L2
    cmp esi, eax
    ja L3
    jmp PrintUnsigned

L2: mov eax, ecx
    cmp esi, eax
    ja L3
    jmp PrintUnsigned

L3: mov eax, esi

PrintUnsigned:
    mov edx, offset out1
    call WriteString
    call WriteInt
    call CrLf

    mov eax, ebx
    cmp ecx, eax
    jg M2
    cmp esi, eax
    jg M3
    jmp PrintSigned

M2: mov eax, ecx
    cmp esi, eax
    jg M3
    jmp PrintSigned

M3: mov eax, esi

PrintSigned:
    mov edx, offset out2
    call WriteString
    call WriteInt
    call CrLf
    exit
main endp

end main
