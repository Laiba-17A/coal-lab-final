INCLUDE Irvine32.inc
.data
prompt BYTE "Enter a number: ",0
resultMsg BYTE "Square = ",0

.code
main PROC
    call LocalSquare
    exit
main ENDP

LocalSquare PROC
    enter 4, 0
    
    mov edx, OFFSET prompt
    call WriteString
    call ReadInt
    mov [ebp-4], eax
    
    mov eax, [ebp-4]
    imul eax, eax
    
    mov edx, OFFSET resultMsg
    call WriteString
    call WriteInt
    call Crlf
    
    leave
    ret
LocalSquare ENDP

END main
