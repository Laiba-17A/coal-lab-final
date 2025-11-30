;Q1 Write an Assembly program that stores three 8-bit values in registers. Use
;AND, OR, and XOR instructions to clear all odd bits, set all even bits, and then
;toggle all bits. Finally, use the TEST instruction to check whether bit 0 is set in
;the final result and display "Bit 0 is ON" or "Bit 0 is OFF" using conditional
;jumps.

include irvine32.inc

findfive proto :dword
.data
    
    msg1 byte "bit 0 is on",0
    msg2 byte "bit 0 is off",0
.code
main proc
    mov al,15
    and al,10101010b
    xor al,11111111b
    test al,1
    jz off
    jmp on

    on:
        mov edx,offset msg1
        call writestring
        call crlf
        jmp done

    off:
        mov edx,offset msg2
        call writestring
        call crlf

    ;mov bl,60

    ;mov cl,82
    done:
    exit
main endp

end main
