
COMMENT $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; date: 06/14/2018
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Asks the user to enter 2 numbers
Assume that the user enters unsigned 32-bit integers only.
Displays the product of the two numbers.
Assume that the result will never be larger than 32 bits.
This process will continue till the user enters 0 for both inputs.
$

INCLUDE Irvine32.inc


.data
UserInput dword ?
UserInput1 dword ?
title1 BYTE "Bitwise Multiplication of Unsigned Integers",0
str1 BYTE "Enter the  multiplicand: ",0
str2 BYTE "Enter the multiplier: ", 0
str3 BYTE "The Product is:   ",0


.code
main PROC
call Clrscr


L1:
    mov edx, OFFSET title1         
	call writestring                ;print out the title for the output
	call crlf

	mov edx, OFFSET str1            
	call writestring                ;ask user for the multiplicand
	call ReadDec
	mov  UserInput,eax

	mov edx, OFFSET str2	
	call writeString                ;ask user for the multiplier
	call readDec

	
L2:
	mov UserInput1,eax
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; [Code Equivalent in C++] :
	;
	;while(userInput != 0 && userInput1 != 0)
	; {
	;   // ask user for 2 numbers 
	;   // 1 multiplicand and multiplier
	;   // then display the output 
	; }
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	cmp UserInput1,0
	jne nested01
	cmp UserInput,0
	JE out01
	
	nested01:
	  call crlf
	  sub esp,4                       ; prepare for the return value
	  push UserInput1                 ; push userInput1 to the stack
	  push UserInput                  ; push userInput to the stack
	  call Multiply                   ; call the multiply PROC
	  mov edx, OFFSET str3
	  call writestring
	  pop eax
	  call WriteDec	                  ; print out the result of the calculation
	  call Crlf
	  call Crlf
	  jmp  L1                         ; jump back to L1 if that 2 parameters is 0

out01:
    call crlf
	exit

main ENDP

COMMENT $
MULTIPLY PROC

Receives userInput & userInput1 from the registers 
then returns the product from the main proc
$

Multiply PROC

    push ebp                           ; push ebp
	mov ebp,esp                        ; mov ebp to pointing where esp are
	push eax 
	push ebx
	push ecx
	push edx

	xor edx,edx	                       ; initialize edx
	mov  ecx,32                          

	mov ebx,[ebp+8]                    ; userInput = ebx
	mov eax,[ebp+12]                   ; userInput1 = eax

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [Code Equivalent in C++] :
;
;if (ZF=1) //after test ebx,1 performed
; {
;   userInput1+0  //bcs edx is initialized
; }
; else
;{  
;  if
;   {
;    //shift ebx to the right by 1
;    //shift eax to the left by 1
;    //display error if CF=1
;   }
;   else
;    {
;      return [ebp+16]
;    }
;}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


test01:	
    test ebx,1	
	jz   shift01                       ; no: skip to L2
	add  edx,eax	                   ; yes: add multiplicand to product
	jc  retValue	                   ; error if CF=1

shift01:
	shr  ebx,1	                       ; shift the multiplier to the right
	shl  eax,1	                       ; shift the multiplicand to the left
	jc  retValue	                   ; error if the CF=1
	loop test01	                       ; repeat the counter

retValue:	
    mov [ebp+16],edx	               ; return the product

    pop edx
    pop ecx
    pop ebx
    pop eax
    pop ebp

	ret 8

Multiply ENDP
END main

COMMENT *

SAMPLE RUN 

Bitwise Multiplication of Unsigned Integers
Enter the  multiplicand: 16
Enter the multiplier: 1

The Product is:   16

Bitwise Multiplication of Unsigned Integers
Enter the  multiplicand: 0
Enter the multiplier: 5

The Product is:   0

Bitwise Multiplication of Unsigned Integers
Enter the  multiplicand: 0
Enter the multiplier: 0

Press any key to continue . . .

*