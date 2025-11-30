INCLUDE Irvine32.inc
.data
array DWORD 64,34,25,12,22,11,90
count DWORD 7

.code
main PROC
    push count
    push OFFSET array
    call BubbleSort
    
    mov ecx, count
    mov esi, OFFSET array
L1: mov eax, [esi]
    call WriteInt
    call Crlf
    add esi, 4
    loop L1
    exit
main ENDP

BubbleSort PROC
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]
    mov ecx, [ebp+12]
    dec ecx
    
outer:
    push ecx
    mov edi, esi
    
inner:
    mov eax, [edi]
    mov ebx, [edi+4]
    cmp eax, ebx
    jle noSwap
    mov [edi], ebx
    mov [edi+4], eax
    
noSwap:
    add edi, 4
    loop inner
    
    pop ecx
    loop outer
    
    pop ebp
    ret 8
BubbleSort ENDP

END main
