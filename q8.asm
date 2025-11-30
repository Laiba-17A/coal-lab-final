INCLUDE Irvine32.inc

.data
timestamp WORD  1010110010110101b   ; example timestamp
bMinutes BYTE ?
msg BYTE "Minutes: ",0

.code
main PROC

    ; Extract minutes
    mov ax, timestamp       ; load timestamp into AX
    shr ax, 5               ; shift bits 5–10 down
    and al, 111111b             ; mask lower 6 bits
    mov bMinutes, al        ; store in byte variable

    ; Display result
    mov edx, OFFSET msg
    call WriteString
    movzx eax, bMinutes     ; zero-extend byte to EAX
    call WriteInt
    call Crlf

    exit
main ENDP
END main
