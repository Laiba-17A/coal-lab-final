INCLUDE Irvine32.inc
.data
nums DWORD 4 DUP(?)
prompt BYTE "Enter number: ",0
notPrimeMsg BYTE "Not all prime",0
largestMsg BYTE "Largest prime = ",0

.code
main PROC
    mov ecx, 4
    mov esi, OFFSET nums
inputLoop:
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt
    mov [esi], eax        ; store number
    push eax              ; pass number to CheckPrime
    call CheckPrime
    add esp, 4            ; clean up stack
    cmp eax, 0
    je notAllPrime
    add esi, 4
    loop inputLoop

    call LargestPrime
    jmp done

notAllPrime:
    mov edx, OFFSET notPrimeMsg
    call WriteString
    call Crlf

done:
    exit
main ENDP

;-----------------------------------------
CheckPrime PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]       ; get number
    cmp eax, 2
    jl notPrime
    cmp eax, 2
    je prime
    mov ebx, 2
checkLoop:
    mov edx, 0
    div ebx
    cmp edx, 0
    je notPrime
    inc ebx
    cmp ebx, eax
    jl checkLoop
prime:
    mov eax, 1
    jmp done
notPrime:
    mov eax, 0
done:
    pop ebp
    ret 4
CheckPrime ENDP

;-----------------------------------------
LargestPrime PROC
    mov esi, OFFSET nums
    mov eax, [esi]       ; first number
    mov ecx, 3           ; remaining numbers
largestLoop:
    add esi, 4
    cmp eax, [esi]
    jge skip
    mov eax, [esi]
skip:
    loop largestLoop
    mov edx, OFFSET largestMsg
    call WriteString
    call WriteInt
    call Crlf
    ret
LargestPrime ENDP

END main
