INCLUDE Irvine32.inc

.data
    sourceString  BYTE "the end of", 0 ; The string to reverse
    space         BYTE " ", 0         ; A space character for separation
    
    ; Addresses of the spaces that separate the words.
    ; "the(space)end(space)of"
    space1        DWORD OFFSET sourceString + 3 ; Address of the first space
    space2        DWORD OFFSET sourceString + 7 ; Address of the second space
    
    msgPrompt     BYTE "Original: the end of", 0dh, 0ah, 0
    msgResult     BYTE "Reversed: ", 0

.code
main PROC
    ; Display original string for comparison
    mov edx, OFFSET msgPrompt
    call WriteString
    
    ; Display result prompt
    mov edx, OFFSET msgResult
    call WriteString

    ; --- 1. Temporarily Null-Terminate Words ---
    ; We replace the spaces with null (0) so WriteString treats each word
    ; as a separate string.
    
    mov al, 0                   ; AL = null terminator (0)
    
    ; Null-terminate the first word "the"
    mov ebx, [space1]           ; EBX = address of the first space
    mov [ebx], al               ; Replace space with 0: "the[0]end of"
    
    ; Null-terminate the second word "end"
    mov ebx, [space2]           ; EBX = address of the second space
    mov [ebx], al               ; Replace space with 0: "the[0]end[0]of"
    
    ; --- 2. Push Word Addresses onto the Stack (LIFO) ---
    
    ; Push addresses (offsets) of the start of each word
    push OFFSET sourceString + 0  ; Pushes address of "the"
    push OFFSET sourceString + 4  ; Pushes address of "end"
    push OFFSET sourceString + 8  ; Pushes address of "of"
    
    ; Stack now holds (top to bottom): [Addr of 'of'], [Addr of 'end'], [Addr of 'the']
    
    ; --- 3. Pop and Display Addresses in Reverse Order ---
    
    ; Pop 3rd word: "of"
    pop edx                     
    call WriteString           
    
    mov edx, OFFSET space       ; Print a space
    call WriteString           
    
    ; Pop 2nd word: "end"
    pop edx                    
    call WriteString           
    
    mov edx, OFFSET space       ; Print a space
    call WriteString           
    
    ; Pop 1st word: "the"
    pop edx                     
    call WriteString           
    
    call Crlf                   ; Newline
    
    ; --- Exit Program ---
    INVOKE ExitProcess, 0
main ENDP

END main
