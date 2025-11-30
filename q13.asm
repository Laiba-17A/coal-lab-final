INCLUDE Irvine32.inc
.data
prompt BYTE "Enter n: ",0
recMsg BYTE "Recursive time: ",0
iterMsg BYTE "Iterative time: ",0
msMsg BYTE " ms",0

.code
main PROC
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt
    mov ebx, eax
    
    call GetMseconds
    push eax
    push ebx
    call FactRecursive
    call GetMseconds
    pop ebx
    sub eax, ebx
    
    mov edx, OFFSET recMsg
    call WriteString
    call WriteInt
    mov edx, OFFSET msMsg
    call WriteString
    call Crlf
    
    mov eax, ebx
    call GetMseconds
    push eax
    push ebx
    call FactIterative
    call GetMseconds
    pop ebx
    sub eax, ebx
    
    mov edx, OFFSET iterMsg
    call WriteString
    call WriteInt
    mov edx, OFFSET msMsg
    call WriteString
    call Crlf
    exit
main ENDP

FactRecursive PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    cmp eax, 1
    jle base
    dec eax
    push eax
    call FactRecursive
    mov ebx, [ebp+8]
    imul eax, ebx
    jmp done
base:
    mov eax, 1
done:
    pop ebp
    ret 4
FactRecursive ENDP

FactIterative PROC
    push ebp
    mov ebp, esp
    mov ecx, [ebp+8]
    mov eax, 1
L1: imul eax, ecx
    loop L1
    pop ebp
    ret 4
FactIterative ENDP

END main
