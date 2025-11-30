INCLUDE Irvine32.inc

.data
    MIN_VALUE   DWORD 50    ; Minimum value
    MAX_VALUE   DWORD 100   ; Maximum value
    
    ARRAY_SIZE  = 5
    randArray   DWORD ARRAY_SIZE DUP(?) ; Array to hold 5 random numbers
    
    msgPrompt   BYTE "Loop Iteration ", 0
    msgRange    BYTE ": ", 0

.code
main PROC
    
    call Randomize          ; Initialize seed (even if deterministic, it's required)
    
    ; Calculate Range Size (Max - Min + 1)
    mov eax, MAX_VALUE      ; EAX = 100
    sub eax, MIN_VALUE      ; EAX = 50
    inc eax                 ; EAX = 51 (The size of the range)
    mov ebx, eax            ; EBX holds the range size (51) for the loop
    
    ; --- 2. Generate and Store 5 Unique Random Numbers ---
    
    mov ecx, ARRAY_SIZE     ; ECX = 5 (loop counter for generation)
    mov esi, OFFSET randArray ; ESI = address of the array
    
L1_Generate:
    mov eax, ebx            ; EAX = 51 (required input for RandomRange)
    call RandomRange        ; EAX now holds R in [0, 50]
    
    add eax, MIN_VALUE      ; EAX = R + 50 (Final number in [50, 100])
    
    mov [esi], eax          ; Store the generated number into the array
    add esi, TYPE DWORD     ; Move ESI to the next array element (4 bytes)
    loop L1_Generate
    
    ; --- 3. Loop 5 Times and Print Stored Value ---
    
    mov ecx, ARRAY_SIZE     ; ECX = 5 (loop counter for printing)
    mov esi, OFFSET randArray ; ESI = Reset pointer to the start of the array
    mov ebx, 1              ; EBX = Loop counter for display (1 to 5)
    
L2_Print:
    ; Display "Loop Iteration X: "
    mov edx, OFFSET msgPrompt
    call WriteString
    mov eax, ebx
    call WriteDec           ; Print the iteration number (1, 2, 3, 4, 5)
    mov edx, OFFSET msgRange
    call WriteString
    
    ; Load and Display the stored random number
    mov eax, [esi]          ; Load the number from the array into EAX
    call WriteDec           ; Print the random number
    call Crlf
    
    add esi, TYPE DWORD     ; Move ESI to the next array element
    inc ebx                 ; Increment the display counter (EBX)
    loop L2_Print           ; Decrement ECX and repeat 5 times
    
    ; --- Program Exit ---
    INVOKE ExitProcess, 0
main ENDP

END main
