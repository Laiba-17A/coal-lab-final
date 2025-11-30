INCLUDE Irvine32.inc

.data
    prompt BYTE "Enter a string of length 10: ", 0
    resultMsg BYTE "Encrypted string: ", 0
    inputStr BYTE 11 DUP(0)          ; Buffer for input string (10 chars + null)
    outputStr BYTE 11 DUP(0)         ; Buffer for encrypted string
    vowels BYTE "AEIOUaeiou", 0      ; Vowel characters

.code
main PROC
    ; Display prompt
    mov edx, OFFSET prompt
    call WriteString
    
    ; Read string input
    mov edx, OFFSET inputStr
    mov ecx, 11                       ; Max chars to read (including null)
    call ReadString
    
    ; Initialize for encryption
    mov esi, OFFSET inputStr          ; Source string
    mov edi, OFFSET outputStr         ; Destination string
    mov ecx, 0                        ; Index counter (0-based)
    
    ; Call recursive encryption
    call EncryptRecursive
    
    ; Display result
    mov edx, OFFSET resultMsg
    call WriteString
    mov edx, OFFSET outputStr
    call WriteString
    call Crlf
    
    exit
main ENDP

;------------------------------------------------------------
; EncryptRecursive - Recursively encrypts each character
; Receives: ESI = pointer to current input character
;           EDI = pointer to current output position
;           ECX = current index (0-based)
; Returns: Nothing
;------------------------------------------------------------
EncryptRecursive PROC
    push eax
    push ebx
    push edx
    push esi
    push edi
    push ecx
    
    ; Check if we've reached end of string
    mov al, BYTE PTR [esi]
    cmp al, 0
    je EndRecursion
    
    ; Encrypt current character
    ; AL already contains current character
    mov ebx, ecx                      ; EBX = rotation count (index)
    
    ; Check if character is a vowel
    call IsVowel                      ; Returns 1 in EAX if vowel, 0 otherwise
    cmp eax, 1
    je RotateVowel
    
RotateConsonant:
    ; Rotate left for consonants
    mov al, BYTE PTR [esi]
    call RotateLeft                   ; Rotate AL left by EBX times
    jmp StoreChar
    
RotateVowel:
    ; Rotate right for vowels
    mov al, BYTE PTR [esi]
    call RotateRight                  ; Rotate AL right by EBX times
    
StoreChar:
    ; Store encrypted character
    mov BYTE PTR [edi], al
    
    ; Recursive call for next character
    inc esi                           ; Move to next input char
    inc edi                           ; Move to next output position
    inc ecx                           ; Increment index
    call EncryptRecursive
    
EndRecursion:
    pop ecx
    pop edi
    pop esi
    pop edx
    pop ebx
    pop eax
    ret
EncryptRecursive ENDP

;------------------------------------------------------------
; IsVowel - Checks if character is a vowel
; Receives: AL = character to check
; Returns: EAX = 1 if vowel, 0 if not
;------------------------------------------------------------
IsVowel PROC
    push ebx
    push ecx
    push edx
    
    mov ebx, OFFSET vowels
    mov ecx, 10                       ; Number of vowels
    
CheckLoop:
    mov dl, BYTE PTR [ebx]
    cmp al, dl
    je FoundVowel
    inc ebx
    loop CheckLoop
    
    ; Not a vowel
    mov eax, 0
    jmp IsVowelEnd
    
FoundVowel:
    mov eax, 1
    
IsVowelEnd:
    pop edx
    pop ecx
    pop ebx
    ret
IsVowel ENDP

;------------------------------------------------------------
; RotateLeft - Rotates character left in alphabet
; Receives: AL = character, EBX = rotation count
; Returns: AL = rotated character
;------------------------------------------------------------
RotateLeft PROC
    push ecx
    push edx
    
    cmp ebx, 0
    je RotateLeftEnd
    
    mov ecx, ebx                      ; ECX = rotation counter
    
    ; Check if uppercase or lowercase
    cmp al, 'A'
    jl RotateLeftEnd                  ; Not a letter
    cmp al, 'Z'
    jle RotateLeftUpper
    cmp al, 'a'
    jl RotateLeftEnd                  ; Not a letter
    cmp al, 'z'
    jle RotateLeftLower
    jmp RotateLeftEnd                 ; Not a letter
    
RotateLeftUpper:
    ; Uppercase letter rotation
RotateLeftUpperLoop:
    dec al
    cmp al, 'A'
    jge RotateLeftUpperContinue
    mov al, 'Z'                       ; Wrap around
RotateLeftUpperContinue:
    loop RotateLeftUpperLoop
    jmp RotateLeftEnd
    
RotateLeftLower:
    ; Lowercase letter rotation
RotateLeftLowerLoop:
    dec al
    cmp al, 'a'
    jge RotateLeftLowerContinue
    mov al, 'z'                       ; Wrap around
RotateLeftLowerContinue:
    loop RotateLeftLowerLoop
    
RotateLeftEnd:
    pop edx
    pop ecx
    ret
RotateLeft ENDP

;------------------------------------------------------------
; RotateRight - Rotates character right in alphabet
; Receives: AL = character, EBX = rotation count
; Returns: AL = rotated character
;------------------------------------------------------------
RotateRight PROC
    push ecx
    push edx
    
    cmp ebx, 0
    je RotateRightEnd
    
    mov ecx, ebx                      ; ECX = rotation counter
    
    ; Check if uppercase or lowercase
    cmp al, 'A'
    jl RotateRightEnd                 ; Not a letter
    cmp al, 'Z'
    jle RotateRightUpper
    cmp al, 'a'
    jl RotateRightEnd                 ; Not a letter
    cmp al, 'z'
    jle RotateRightLower
    jmp RotateRightEnd                ; Not a letter
    
RotateRightUpper:
    ; Uppercase letter rotation
RotateRightUpperLoop:
    inc al
    cmp al, 'Z'
    jle RotateRightUpperContinue
    mov al, 'A'                       ; Wrap around
RotateRightUpperContinue:
    loop RotateRightUpperLoop
    jmp RotateRightEnd
    
RotateRightLower:
    ; Lowercase letter rotation
RotateRightLowerLoop:
    inc al
    cmp al, 'z'
    jle RotateRightLowerContinue
    mov al, 'a'                       ; Wrap around
RotateRightLowerContinue:
    loop RotateRightLowerLoop
    
RotateRightEnd:
    pop edx
    pop ecx
    ret
RotateRight ENDP

END main
