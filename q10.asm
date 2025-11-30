INCLUDE Irvine32.inc
.data
array DWORD 45,23,67,89,12,34,56,78,90,11,33,55,77,99,21,43,65,87,10,50
minMsg BYTE "Minimum = ",0
maxMsg BYTE "Maximum = ",0

.code
main PROC
    push OFFSET array
    call MinMaxArray
    exit
main ENDP

MinMaxArray PROC
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]
    
    mov eax, [esi]
    mov ebx, 99999999
    mov edi,-9999999
    mov ecx, 20
    
L1: mov eax, [esi]
    cmp eax, ebx
    jl newMin
    cmp eax, edi
    jg newMax
    jmp next
    
newMin:
    mov ebx, eax
    jmp next
    
newMax:
    mov edi, eax
    
next:
    add esi, 4
    loop L1
    
    mov edx, OFFSET minMsg
    call WriteString
    mov eax, ebx
    call WriteInt
    call Crlf
    
    mov edx, OFFSET maxMsg
    call WriteString
    mov eax, edi
    call WriteInt
    call Crlf
    
    pop ebp
    ret 4
MinMaxArray ENDP

END main
