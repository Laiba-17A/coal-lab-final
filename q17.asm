INCLUDE Irvine32.inc

.data
    Str1 BYTE "127&j~3#&##45^",0
    msg1 BYTE "String: ",0
    msg2 BYTE "Index of first '#': ",0
    notFound BYTE "Character not found!",0

.code
main PROC
    ; Display the string
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET Str1
    call WriteString
    call Crlf
    
    ; Find the '#' character
    mov edx, OFFSET msg2
    call WriteString
    
    mov esi, OFFSET Str1
    call Scan_String
    
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
; Scan_String Procedure
;
; Finds the index of the first occurrence of '#' in a string
;
; Receives: ESI = pointer to string
; Returns:  EAX = index of first '#', or -1 if not found
;------------------------------------------------------------
Scan_String PROC
    push ebx
    push ecx
    
    mov ebx, 0              ; Index counter
    
ScanLoop:
    mov cl, [esi + ebx]     ; Get character at current position
    cmp cl, 0               ; Check for null terminator
    je CharNotFound
    
    cmp cl, '#'             ; Check if it's '#'
    je CharFound
    
    inc ebx                 ; Move to next character
    jmp ScanLoop
    
CharFound:
    mov eax, ebx            ; Return index in EAX
    jmp ScanEnd
    
CharNotFound:
    mov eax, -1             ; Return -1 if not found
    
ScanEnd:
    pop ecx
    pop ebx
    ret
Scan_String ENDP

END main
