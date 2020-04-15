TITLE Assignment 6

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; date: 5/31/2018
;;;;;;;;;;;;;;;;;;;;;;;;;;;
include irvine32.inc

.data

userInput byte "Enter a number: ",0  
userInput2 byte "Please enter a positive number.", 0 
userInput3 byte "Has exact 2 different divisors: ",0

.code
main proc

	while01:
	mov edx, offset userInput		 ; prints "Enter a number: "
	call writeString
	call readdec
	
	cmp eax, 0
	jg out01					
	mov edx, offset userInput2		 ; prints "Please enter a positive number!"
	call writeString
	call crlf
	jmp while01
	
	
	out01:
	mov edx, offset userInput3      ; prints "Has exact 2 different divisors: "
	call writeString

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [Code Equivalent in C++] :
;
;  if(eax > 7)
;  {
;    ecx = eax;
;    ecx--;
;    for(int i = eax; i > 0; i--)
;    {
;      is2divisors;
;      if(esi == 1)
;       {
;         eax = ecx;
;         cout << eax;
;       }
;    }
;  }
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cmp eax,7
	JL while0
	mov ecx, eax
	dec ecx

	L1:
	call is2divisors
	cmp esi, 1
	jne endLoop01
	mov eax, ecx
	call writeInt
	mov eax, " "
	call writeChar
	endLoop01:
	LOOP L1

	while0:
	call crlf
	exit

main ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; is2divisors
;
; Check if the number has exactly 2 different integral divisors (Besides 1 and X)
; Return back (through one of the registers) to main
; return if the program has exactly 2 different integral divisors
; if the number entered doesn't have any divisors, left it blank
;
; Receives: eax
; Returns: ecx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

is2divisors PROC
	push ecx				
	mov ebx, ecx			
	mov edi, 0
	mov esi, 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;[Code Equivalent in C++] :
;
; for (int i = ecx; i > 0; i--)
;   {
;      edx=0;
;      eax = ebx;
;      edx = eax % ecx;
;      if(edx == 0)
;      {
;        edi++;
;      }
;   }
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	L2:
	mov edx, 0
	mov eax, ebx				
	div ecx
	cmp edx, 0				
	jne endLoop02
	inc edi					
	endLoop02:
	LOOP L2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;[Code Equivalent in C++] :
;
; if(edi == 4)
; {
;   esi++;
; }
; else 
; {
; return ecx;
; }
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cmp edi, 4				
	jne finish
	inc esi					
	finish:
	pop ecx
	ret

is2divisors ENDP

END main

COMMENT *

[Run Output]:

Enter a number: -1
Please enter a positive number.
Enter a number: 0
Please enter a positive number.
Enter a number: 15
Has exact 2 different divisors: +14 +10 +8 +6
Press any key to continue . . .

*
