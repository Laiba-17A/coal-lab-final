INCLUDE Irvine32.inc

.data
    testArray DWORD 1, 2, 3, 4, 5
    arraySize = ($ - testArray) / 4
    multiplier BYTE 3
    
    msg1 BYTE "Original Array: ",0
    msg2 BYTE "Multiplier: ",0
    msg3 BYTE "Array after multiplying: ",0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov esi, OFFSET testArray
    mov ecx, arraySize
    call DisplayArray
    call Crlf
    
    mov edx, OFFSET msg2
    call WriteString
    movzx eax, multiplier
    call WriteDec
    call Crlf
    
    mov esi, OFFSET testArray
    mov bl, multiplier
    mov ecx, arraySize
    call Load_Array_Multiply
    
    mov edx, OFFSET msg3
    call WriteString
    mov esi, OFFSET testArray
    mov ecx, arraySize
    call DisplayArray
    call Crlf
    
    exit
main ENDP

DisplayArray PROC
    push eax
    push ecx
    push esi
    
DisplayLoop:
    mov eax, [esi]
    call WriteDec
    mov al, ' '
    call WriteChar
    add esi, 4
    loop DisplayLoop
    
    pop esi
    pop ecx
    pop eax
    ret
DisplayArray ENDP

Load_Array_Multiply PROC
    push eax
    push ebx
    push ecx
    push esi
    
    movzx ebx, bl
    
MultiplyLoop:
    mov eax, [esi]
    imul eax, ebx
    mov [esi], eax
    add esi, 4
    loop MultiplyLoop
    
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
Load_Array_Multiply ENDP

END main
