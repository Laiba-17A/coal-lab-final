INCLUDE Irvine32.inc

.data
originalStr BYTE "The cat sat on the mat",0
searchStr   BYTE "cat",0
replaceStr  BYTE "dog",0      
msgBefore   BYTE "Original string: ",0
msgAfter    BYTE "Modified string: ",0

.code
main PROC
    ; Show original string
    mov edx, OFFSET msgBefore
    call WriteString
    mov edx, OFFSET originalStr
    call WriteString
    call Crlf

    ; Replace substring
    ; Parameters pushed right-to-left: originalStr, searchStr, replaceStr
    push OFFSET replaceStr
    push OFFSET searchStr
    push OFFSET originalStr
    call ReplaceSubstring
    add esp, 12             ; Clean up 3 parameters (3 * 4 = 12 bytes)

    ; Show modified string
    mov edx, OFFSET msgAfter
    call WriteString
    mov edx, OFFSET originalStr
    call WriteString
    call Crlf

    exit
main ENDP

;---------------------------------------
; ReplaceSubstring: replaces first occurrence
; Parameters (via EBP):
;   [EBP+8]  = pointer to originalStr
;   [EBP+12] = pointer to searchStr
;   [EBP+16] = pointer to replaceStr
;---------------------------------------
ReplaceSubstring PROC
    push ebp
    mov ebp, esp
    push esi        ; Save non-volatile registers
    push edi
    push ebx
    push edx        ; EDX will be used temporarily

    mov esi, [ebp+8]    ; ESI = originalStr base pointer
    mov edi, [ebp+12]   ; EDI = searchStr pointer
    mov ebx, [ebp+16]   ; EBX = replaceStr pointer

    xor ecx, ecx        ; ECX = current index in originalStr (0-based)

find_loop:
    mov al, [esi+ecx]   ; Check current character in originalStr
    cmp al, 0
    je done_replace     ; End of originalStr, nothing found

    ; --- Prepare for IsSubstring call ---
    ; IsSubstring expects: ESI = start of search window in originalStr
    ;                      EDI = searchStr pointer
    
    ; Save loop state: ESI (base), EDI (search ptr), ECX (index)
    push esi
    push edi
    push ecx

    ; Set up registers for IsSubstring
    add esi, ecx            ; ESI = originalStr + current index (start of search window)
    ; EDI already holds searchStr pointer (saved on stack)
    
    call IsSubstring        ; Returns EAX = 1 if match, 0 if no match
    
    ; Restore original state after call
    pop ecx                 ; Restore ECX (index)
    pop edi                 ; Restore EDI (searchStr ptr)
    pop esi                 ; Restore ESI (originalStr base ptr)
    
    cmp eax, 1
    je do_replace           ; Found a match, replace it!
    
    inc ecx                 ; No match, move to next character in original
    jmp find_loop

do_replace:
    ; ECX holds the 0-based index where the match started
    
    mov esi, [ebp+8]        ; ESI = originalStr base
    add esi, ecx            ; ESI now points to the start of "cat" in originalStr
    mov edi, [ebp+16]       ; EDI points to "dog" (replaceStr)

replace_loop:
    mov al, [edi]           ; Read char from replaceStr
    cmp al, 0
    je done_replace         ; End of replaceStr
    mov [esi], al           ; Write char to originalStr
    inc esi
    inc edi
    jmp replace_loop

done_replace:
    pop edx
    pop ebx
    pop edi
    pop esi
    pop ebp
    ret
ReplaceSubstring ENDP

;---------------------------------------
; IsSubstring: checks if string at ESI starts with substring at EDI
; Expects: ESI = pointer to current spot in originalStr
;          EDI = pointer to searchStr
; Returns: EAX = 1 if matches, 0 otherwise
; Note: This procedure is simplified to use the registers passed by the caller.
;---------------------------------------
IsSubstring PROC
    ; Save registers used internally (optional, but good practice)
    push ebx
    push ecx

check_loop:
    mov al, [esi]       ; Character from originalStr
    mov bl, [edi]       ; Character from searchStr

    cmp bl, 0           ; Check if end of searchStr
    je matched          ; If so, the whole searchStr matched!
    
    cmp al, bl          ; Compare characters
    jne not_matched     ; If different, no match

    inc esi             ; Move to next char in originalStr
    inc edi             ; Move to next char in searchStr
    jmp check_loop

matched:
    mov eax, 1          ; EAX = 1 (match found)
    jmp done_is

not_matched:
    mov eax, 0          ; EAX = 0 (no match)

done_is:
    pop ecx
    pop ebx
    ret                 ; Return value in EAX
IsSubstring ENDP

END main
