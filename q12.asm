INCLUDE Irvine32.inc
.data
prompt BYTE "Enter n: ",0
resultMsg BYTE "Factorial = ",0

.code
main PROC
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt
    
    push eax
    call Fact
    
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt
    call Crlf
    exit
main ENDP

Fact PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    
    cmp eax, 1
    jle baseCase
    
    dec eax
    push eax
    call Fact
    
    mov ebx, [ebp+8]
    imul eax, ebx
    jmp done
    
baseCase:
    mov eax, 1
    
done:
    pop ebp
    ret 4
Fact ENDP

END main
