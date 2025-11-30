INCLUDE Irvine32.inc
.data
num1 DWORD ?
num2 DWORD ?
result DWORD ?
prompt1 BYTE "Enter first number: ",0
prompt2 BYTE "Enter second number: ",0
resultMsg BYTE "GCD = ",0
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
    
    mov edx, OFFSET prompt1
    call WriteString
    call ReadInt
    mov num1, eax
    
    mov edx, OFFSET prompt2
    call WriteString
    call ReadInt
    mov num2, eax
    
    push num2
    push num1
    call GCD
    mov result, eax
    ret
TakeInput ENDP

GCD PROC
    mov edx, OFFSET espMsg
    call WriteString
    mov eax, esp
    call WriteHex
    call Crlf
    
    push ebp
    mov ebp, esp
    mov eax, [ebp+12]
    mov ebx, [ebp+8]
    
L1: cmp ebx, 0
    je done
    mov edx, 0
    div ebx
    mov eax, ebx
    mov ebx, edx
    jmp L1
    
done:
    pop ebp
    ret 8
GCD ENDP

Display PROC
    mov edx, OFFSET espMsg
    call WriteString
    mov eax, esp
    call WriteHex
    call Crlf
    
    mov edx, OFFSET resultMsg
    call WriteString
    mov eax, result
    call WriteInt
    call Crlf
    ret
Display ENDP

END main
