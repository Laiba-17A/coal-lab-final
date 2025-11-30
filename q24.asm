INCLUDE Irvine32.inc

.data
    sourceString    BYTE "ABCDEFGHIJKLMNOP", 0   ; 16 characters + Null-terminator
    sliceBuffer     BYTE 17 DUP(0)              ; Buffer for the sliced string (Max 16 chars + Null)
    
    startIndex      DWORD 3                     ; Start slicing at index 3 ('D')
    endIndex        DWORD 8                     ; Stop before index 8 ('I'). Slice is 8 - 3 = 5 chars long.
    
    msgOriginal     BYTE "Original: ", 0
    msgSliced       BYTE "Sliced: ", 0

.code
main PROC
    
    ; Display the original string
    mov edx, OFFSET msgOriginal
    call WriteString
    mov edx, OFFSET sourceString
    call WriteString
    call Crlf
    
    ; --- 2. Calculate Pointers and Loop Counter ---
    
    ; ESI = Source Pointer
    mov esi, OFFSET sourceString
    
    ; Add the startIndex to ESI to get the starting address of the slice
    mov ebx, startIndex                 ; EBX = 3
    add esi, ebx                        ; ESI now points to 'D' (sourceString + 3)
    
    ; EDI = Destination Pointer
    mov edi, OFFSET sliceBuffer         ; EDI points to the start of the empty buffer
    
    ; ECX = Loop Counter (Number of characters to copy)
    mov eax, endIndex                   ; EAX = 8 (End Index)
    sub eax, startIndex                 ; EAX = 8 - 3 = 5 (Slice Length)
    mov ecx, eax                        ; ECX = 5
    
    ; --- 3. Copy Loop (The Slicing) ---

L1:
    ; Move the byte from the source address (ESI) to the destination address (EDI)
    mov al, [esi]                       ; AL = character at ESI ('D', then 'E', etc.)
    mov [edi], al                       ; Store AL into buffer at EDI
    
    inc esi                             ; Move source pointer to the next character
    inc edi                             ; Move destination pointer to the next byte
    
    loop L1                             ; Decrement ECX, repeat 5 times

    ; --- 4. Null-Terminate the Sliced String ---
    
    ; The loop finished after placing the last character. EDI is now pointing 
    ; one byte *past* the end of the last copied character.
    mov BYTE PTR [edi], 0               ; Place the null terminator (0) at the end of the sliceBuffer
    
    ; --- 5. Display the Sliced String ---
    
    mov edx, OFFSET msgSliced
    call WriteString
    mov edx, OFFSET sliceBuffer         ; EDX = address of the new, sliced string
    call WriteString
    call Crlf
    
    ; --- Program Exit ---
    INVOKE ExitProcess, 0
main ENDP
END main
