INCLUDE Irvine32.inc

.data
    array DWORD 7,3,9,1,8,2
    msg1 BYTE "Largest: ",0
    msg2 BYTE "Second Largest: ",0
    largest DWORD ?
    secondlargest DWORD ?
    i DWORD ? ; index of largest element

.code
main PROC
    ; Call findlargest procedure
    push LENGTHOF array
    push OFFSET array
    call findlargest
    add esp, 8

    ; Print largest
    mov edx, OFFSET msg1
    call WriteString
    mov eax, largest
    call WriteInt
    call Crlf

    ; Print second largest
    mov edx, OFFSET msg2
    call WriteString
    mov eax, secondlargest
    call WriteInt
    call Crlf

    exit
main ENDP

;-----------------------------------
; findlargest: finds largest element and its index
; Parameters:
;   [ebp+8]  = array pointer
;   [ebp+12] = size
;-----------------------------------
findlargest PROC
    push ebp
    mov ebp, esp
    push esi
    push ecx
    push ebx
    push edx

    mov esi, [ebp+8]    ; pointer to array
    mov ecx, [ebp+12]   ; size
    xor eax, eax        ; largest
    xor edx, edx        ; index counter
    xor ebx, ebx        ; index of largest

    mov i, 0

l1:
    mov edi, [esi]      ; current element
    cmp edi, eax
    jle skip
    mov eax, edi        ; new largest
    mov ebx, edx        ; save index
skip:
    add esi, 4
    inc edx
    cmp edx, [ebp+12]
    jl l1

    mov largest, eax
    mov i, ebx          ; store index of largest

    ; Call findsecondlargest
    push largest        ; largest value
    push [ebp+12]       ; size
    push [ebp+8]        ; array pointer
    push i              ; index of largest
    call findsecondlargest
    add esp, 16         ; clean stack

    pop edx
    pop ebx
    pop ecx
    pop esi
    pop ebp
    ret
findlargest ENDP

;-----------------------------------
; findsecondlargest: finds second largest element
; Parameters:
;   [ebp+8]  = index of largest
;   [ebp+12] = array pointer
;   [ebp+16] = size
;   [ebp+20] = largest value
;-----------------------------------
findsecondlargest PROC
    push ebp
    mov ebp, esp
    push esi
    push ecx
    push ebx
    push edx

    mov esi, [ebp+12]   ; array pointer
    mov ecx, [ebp+16]   ; size
    mov edi, [ebp+8]    ; index of largest
    mov ebx, [ebp+20]   ; largest value
    xor eax, eax        ; second largest
    xor edx, edx        ; index counter

l2:
    cmp edx, edi
    je skip2            ; skip largest element
    mov ecx, [esi]      ; current element
    cmp ecx, eax
    jle skip2
    mov eax, ecx
skip2:
    add esi, 4
    inc edx
    cmp edx, [ebp+16]
    jl l2

    mov secondlargest, eax

    pop edx
    pop ebx
    pop ecx
    pop esi
    pop ebp
    ret
findsecondlargest ENDP

END main
