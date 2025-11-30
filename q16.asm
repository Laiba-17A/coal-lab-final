INCLUDE Irvine32.inc
.data
num DWORD ?
result DWORD ?
prompt BYTE "Enter a number: ",0
yesMsg BYTE "Armstrong number",0
noMsg BYTE "Not Armstrong",0
espMsg BYTE "ESP = ",0

.code
main PROC
    call TakeInput
    call Display
    exit
main ENDP

TakeInput PROC
    mov edx, OFFSET espMsg
    call WriteString
    mov eax, esp
    call WriteHex
    call Crlf
    
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt
    mov num, eax
    
    push eax
    call Armstrong
    mov result, eax
    ret
TakeInput ENDP

Armstrong PROC
    mov edx, OFFSET espMsg
    call WriteString
    mov eax, esp
    call WriteHex
    call Crlf
    
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    mov ebx, eax
    mov esi, 0
    
L1: mov edx, 0
    mov ecx, 10
    div ecx
    mov edi, edx
    imul edi, edi
    imul edi, edx
    add esi, edi
    cmp eax, 0
    jne L1
    
    cmp esi, ebx
    je isArm
    mov eax, 0
    jmp done
    
isArm:
    mov eax, 1
    
done:
    pop ebp
    ret 4
Armstrong ENDP

Display PROC
    mov edx, OFFSET espMsg
    call WriteString
    mov eax, esp
    call WriteHex
    call Crlf
    
    cmp result, 1
    je printYes
    mov edx, OFFSET noMsg
    jmp print
    
printYes:
    mov edx, OFFSET yesMsg
    
print:
    call WriteString
    call Crlf
    ret
Display ENDP

END main
