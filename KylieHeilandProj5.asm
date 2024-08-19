; This program is used as a calculator for hexadecimal numbers. It uses the boolean AND, OR, XOR, and NOT operations to determine a hexadecimal number using 1-2 hexadecimal numbers.
; Kylie Heiland
; 10 / 31 / 22


INCLUDE Irvine32.inc

.386
.stack 4096
ExitProcess proto, dwExitCode:dword

.data
carriageReturn BYTE ' ', 13, 10, 0                ; Used as a new line to separate the random strings from one another.
hexNum1 DWORD ?                                   ; The first hexadecimal number.
hexNum2 DWORD ?                                   ; Holds the second hexadecimal number.
array1 BYTE 32('!'), 0                            ; Holds the binary version of the hexadecimal number.
array2 BYTE 32('1'), 0                            ; Holds the binary version of the hexadecimal number.

temp DWORD ?                                      ; Holds the eax value.

; Displays a menu asking the user to make a selection.
menu BYTE "---- Bitwise Multiplication ----", 0
firstMenuOption BYTE "1. X AND Y", 0
secondMenuOption BYTE "2. X OR Y", 0
thirdMenuOption BYTE "3. NOT X", 0
fourthMenuOption BYTE "4. X XOR Y", 0
fifthMenuOption BYTE "5. Exit Program", 0 
enterInteger BYTE "Enter integer: ", 0


firstHexadecimal BYTE "Input the first 32-bit hexadecimal apparand: ", 0
secondHexadecimal BYTE "Input the second 32-bit hexadecimal apparand: ", 0
result BYTE "The 32-bit hexadecimal result is: ", 0

;EXITPROGRAM
exitProgramMessage BYTE "Thank you for using this program. Goodbye!", 0

;WRONGANSWER
wrongAnswerMessage BYTE "Please choose an answer between 1 and 5.", 0

.code
    main proc
.REPEAT
    mov eax, 0              ; Makes the eax register 0.
    

    mov edx, OFFSET menu             ; Prints "---- Boolean Calculator ----" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET firstMenuOption               ; Prints "1. X AND Y" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET secondMenuOption              ; Prints "2. X OR Y" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET thirdMenuOption               ; Prints "3. NOT X" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET fourthMenuOption              ; Prints "4. X XOR Y" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET fifthMenuOption               ; Prints "5. Exit Program" to the console.
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString
    mov edx, OFFSET enterInteger                  ; Asks user to enter an integer.
    call WriteString
    call ReadInt
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString

    mov temp, eax                                 ; temp is set to whatever int the user chose.

    .IF (eax == 1)                                ; If eax equals 1. 
        call AND_op
    .ELSEIF (eax == 2)                            ; If eax equals 2.
        call OR_op
    .ELSEIF (eax == 3)                            ; If eax equals 3.
        call NOT_op
    .ELSEIF (eax == 4)                            ; If eax equals 4.
        call XOR_op
    .ELSEIF (eax == 5)                            ; If eax equals 5.
        call EXITPROGRAM
    .ELSEIF (eax < 1 || eax > 5)                  ; If the user inputted an invalid integer.
        call WRONGANSWER
    .ENDIF
    
    mov edx, OFFSET carriageReturn                ; New line is made
    call WriteString

    call WaitMsg
    call Clrscr
.UNTIL (eax == 5)
invoke ExitProcess, 0
main endp

AND_op PROC
    mov edx, OFFSET firstHexadecimal       ; Prompts user to enter a 32-bit hexadecimal apparand.
    call WriteString
    call ReadHex                           ; User inputs hexadecimal number.
    mov ebx, eax                           ; Moves hexadecimal number to ebx. 
    
    mov edx, OFFSET carriageReturn         ; New line is made
    call WriteString

    mov edx, OFFSET secondHexadecimal      ; Prompts user to enter a 32-bit hexadecimal apparand.
    call WriteString
    call ReadHex

    and eax, ebx                           ; ANDs the two hexadecimal numbers together.

    mov edx, OFFSET result                 ; Prints the result of the AND.
    call WriteString
    call WriteHex
    ret
AND_op ENDP

OR_op PROC
    mov edx, OFFSET firstHexadecimal       ; Prompts user to enter a 32-bit hexadecimal apparand.
    call WriteString
    call ReadHex                           ; User inputs hexadecimal number.
    mov ebx, eax                           ; Moves hexadecimal number to ebx. 
    
    mov edx, OFFSET carriageReturn         ; New line is made
    call WriteString

    mov edx, OFFSET secondHexadecimal      ; Prompts user to enter a 32-bit hexadecimal apparand.
    call WriteString
    call ReadHex

    or eax, ebx                            ; ORs the two hexadecimal numbers together.

    mov edx, OFFSET result                 ; Prints the result of the OR.
    call WriteString
    call WriteHex
    ret
OR_op ENDP

NOT_op PROC
    mov edx, OFFSET firstHexadecimal       ; Prompts user to enter a 32-bit hexadecimal apparand.
    call WriteString
    call ReadHex                           ; User inputs hexadecimal number.

    not eax                                ; NOTs the hexadecimal number.

    mov edx, OFFSET result                 ; Prints the result.
    call WriteString
    call WriteHex
    ret
NOT_op ENDP

XOR_op PROC
    mov edx, OFFSET firstHexadecimal       ; Prompts user to enter a 32-bit hexadecimal apparand.
    call WriteString
    call ReadHex                           ; User inputs hexadecimal number.
    mov ebx, eax                           ; Moves hexadecimal number to ebx. 
    
    mov edx, OFFSET carriageReturn         ; New line is made
    call WriteString

    mov edx, OFFSET secondHexadecimal      ; Prompts user to enter a 32-bit hexadecimal apparand.
    call WriteString
    call ReadHex                           ; User inputs hexadecimal number.

    xor eax, ebx                           ; XORs the hexadecimal numbers together.

    mov edx, OFFSET result                 ; Prints the result.
    call WriteString
    call WriteHex
    ret
XOR_op ENDP

EXITPROGRAM PROC
    mov edx, OFFSET exitProgramMessage     ; Tells the user goodbye.
    call WriteString
    ret
EXITPROGRAM ENDP

WRONGANSWER PROC
    mov edx, OFFSET wrongAnswerMessage     ; Tells the user they entered the wrong message.
    call WriteString
    ret
WRONGANSWER ENDP
end main