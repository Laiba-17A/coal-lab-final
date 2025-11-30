;Q5 Write an Assembly program that sets EAX = 10 and repeatedly subtracts 3
;while the value in EAX remains greater than or equal to zero. Use CMP and JGE
;to simulate the while loop. After the loop ends, display the final value of EAX.

include irvine32.inc

.code
main proc
    mov eax, 10

LoopStart:
    cmp eax, 0
    jl LoopEnd
    sub eax, 3
    jmp LoopStart

LoopEnd:
    call CrLf
    call WriteInt
    exit
main endp
end main
