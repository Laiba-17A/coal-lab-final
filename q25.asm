INCLUDE Irvine32.inc

.data
    string1         BYTE "Hello", 0, 10 DUP(?) ; String 1 (A): "Hello". Space for 10 more chars.
    string2         BYTE " World!", 0          ; String 2 (B): " World!"
    msgPrompt       BYTE "Concatenated String: ", 0

.code
main PROC
    
    ; Display the prompt message
    mov edx, OFFSET msgPrompt
    call WriteString
    
    ; --- 1. Find the End of string1 (The Null Terminator) ---
    
    mov esi, OFFSET string1     ; ESI = Pointer to the start of string1
    
L1:
    cmp BYTE PTR [esi], 0       ; Compare the byte at ESI with the Null Terminator (0)
    je L2                       ; If it is 0, jump to the copy loop (L2)
    inc esi                     ; Move ESI to the next character
    loop L1                     ; This loop is conceptual; we don't know the max length, 
                                ; so a jump is better than using ECX here.
                                
    ; NOTE: ESI now points directly to the NULL terminator of string1.
                                
    ; --- 2. Set Up Pointers for Copying ---
L2:
    mov edi, OFFSET string2     ; EDI = Pointer to the start of string2 (" World!")
    
    ; We are copying bytes from [EDI] to [ESI].
    
    ; --- 3. Copy string2 to the End of string1 ---
    
L3:
    mov al, [edi]               ; AL = Get character from string2
    mov [esi], al               ; Store character into the old NULL position of string1
    
    inc esi                     ; Advance destination pointer (string1)
    inc edi                     ; Advance source pointer (string2)
    
    cmp al, 0                   ; Check if the character we just copied was the NULL terminator
    jne L3                      ; If it was not 0, continue the loop
    
    ; --- 4. Display the Result ---
    
    ; string1 now holds "Hello World!" followed by the final NULL terminator.
    mov edx, OFFSET string1
    call WriteString
    call Crlf
    
    ; --- Program Exit ---
    INVOKE ExitProcess, 0
main ENDP
END main
