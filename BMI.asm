; Jonathan Rodriguez
; FPU Project Lab
; Goal is to calculate BMI
; 5/12/23

INCLUDE Irvine32.inc

.data
first REAL8 ?
second REAL8 ?
Obese REAL8 39.9
Over REAL8 24.9
Normal REAL8 18.4
Under REAL8 18.3
Height BYTE "Please enter Height (in meters): ", 0
Weight BYTE "Please enter Weight (in kilograms): ", 0
output BYTE "Your BMI is: ", 0
ObesePrompt BYTE "You are Obese", 0
OverweightPrompt BYTE "You are Overweight", 0
NormalPrompt BYTE "Your BMI is Normal", 0
UnderweightPrompt BYTE "You are Underweight", 0

.code
main PROC
    finit ; initialize FPU
    
    ; Push two floats.
    fld first
    fld second
    
    ; Input two floats
    mov edx, OFFSET Height
    call WriteString
    call ReadFloat
    fld ST(0)
    
    fmul ST(0), ST(0) ; Multiply height by itself
    
    mov edx, OFFSET Weight
    call WriteString
    call ReadFloat
    
    ; Divide the two floats and display their product.
    fdiv ST(0), ST(1) ; divide
    
    mov edx, OFFSET output
    call WriteString
    call WriteFloat
    call Crlf
    
    ; Check BMI status
    
    ; Check if Obese
    fld Obese
    fcomi ST(0), ST(1)
    jb Obese1
    
    ; Check if Over
    fld Over
    fcomi ST(0), ST(2)
    jb Over1
    
    ; Check if Normal
    fld Normal
    fcomi ST(0), ST(3)
    jb Normal1
    
    ; Check if Under
    fld Under
    fcomi ST(0), ST(4)
    jb Under1
    
    jmp done
    
    ; Labels that output your BMI status
Obese1:
    mov edx, OFFSET ObesePrompt
    call WriteString
    call Crlf
    jmp done
    
Over1:
    mov edx, OFFSET OverweightPrompt
    call WriteString
    call Crlf
    jmp done
    
Normal1:
    mov edx, OFFSET NormalPrompt
    call WriteString
    call Crlf
    jmp done
    
Under1:
    mov edx, OFFSET UnderweightPrompt
    call WriteString
    call Crlf
    jmp done
    
done:
    invoke ExitProcess, 0
    
main ENDP
END main
