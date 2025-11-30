INCLUDE Irvine32.inc

.data
    target BYTE "AAEBDCFBBC",0
    freqTable DWORD 256 DUP(0)
    
    msg1 BYTE "Target String: ",0
    msg2 BYTE "Character Frequencies:",0
    charMsg BYTE "  '",0
    freqMsg BYTE "': ",0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET target
    call WriteString
    call Crlf
    call Crlf
    
    mov esi, OFFSET target
    mov edi, OFFSET freqTable
    call Get_Frequencies
    
    mov edx, OFFSET msg2
    call WriteString
    call Crlf
    call Display_Frequencies
    
    exit
main ENDP

Get_Frequencies PROC
    push eax
    push ebx
    push ecx
    push esi
    push edi
    
    mov ecx, 256
    mov eax, 0
ClearLoop:
    mov [edi], eax
    add edi, 4
    loop ClearLoop
    
    sub edi, 256 * 4
    
CountLoop:
    movzx eax, BYTE PTR [esi]
    cmp al, 0
    je FreqEnd
    
    mov ebx, eax
    shl ebx, 2
    inc DWORD PTR [edi + ebx]
    
    inc esi
    jmp CountLoop
    
FreqEnd:
    pop edi
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
Get_Frequencies ENDP

Display_Frequencies PROC
    push eax
    push ebx
    push ecx
    push edx
    
    mov ebx, 0
    
DisplayFreqLoop:
    cmp ebx, 256
    jge DisplayFreqEnd
    
    mov ecx, ebx
    shl ecx, 2
    mov eax, DWORD PTR [freqTable + ecx]
    cmp eax, 0
    je SkipChar
    
    cmp ebx, 32
    jl SkipChar
    cmp ebx, 126
    jg SkipChar
    
    mov edx, OFFSET charMsg
    call WriteString
    mov al, bl
    call WriteChar
    mov edx, OFFSET freqMsg
    call WriteString
    
    mov ecx, ebx
    shl ecx, 2
    mov eax, DWORD PTR [freqTable + ecx]
    call WriteDec
    call Crlf
    
SkipChar:
    inc ebx
    jmp DisplayFreqLoop
    
DisplayFreqEnd:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
Display_Frequencies ENDP

END main
