INCLUDE Irvine32.inc

.data
    Str1 BYTE "127&j~3#&##45^",0
    searchChar BYTE '*'
    msg1 BYTE "String: ",0
    msg2 BYTE "Searching for character: ",0
    msg3 BYTE "Index found at: ",0
    notFound BYTE "Character not found!",0

.code
main PROC
    ; Display the string
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET Str1
    call WriteString
    call Crlf
    
    ; Display search character
    mov edx, OFFSET msg2
    call WriteString
    mov al, searchChar
    call WriteChar
    call Crlf
    
    ; Search for the character
    mov edx, OFFSET msg3
    call WriteString
    
    mov esi, OFFSET Str1
    mov al, searchChar
    call Scan_String_Param
    
    cmp eax, -1
    je NotFoundMsg
    call WriteDec
    jmp Done
    
NotFoundMsg:
    mov edx, OFFSET notFound
    call WriteString
    
Done:
    call Crlf
    exit
main ENDP

;------------------------------------------------------------
; Scan_String_Param Procedure
;
; Finds the index of the first occurrence of a character
;
; Receives: ESI = pointer to string
;           AL  = character to search for
; Returns:  EAX = index of first occurrence, or -1 if not found
;------------------------------------------------------------
Scan_String_Param PROC
    push ebx
    push ecx
    push edx
    
    mov dl, al              ; Save search character in DL
    mov ebx, 0              ; Index counter
    
ScanLoop:
    mov cl, [esi + ebx]     ; Get character at current position
    cmp cl, 0               ; Check for null terminator
    je CharNotFound
    
    cmp cl, dl              ; Check if it matches search character
    je CharFound
    
    inc ebx                 ; Move to next character
    jmp ScanLoop
    
CharFound:
    mov eax, ebx            ; Return index in EAX
    jmp ScanEnd
    
CharNotFound:
    mov eax, -1             ; Return -1 if not found
    
ScanEnd:
    pop edx
    pop ecx
    pop ebx
    ret
Scan_String_Param ENDP

END main
