TITLE   Assignment 5
;------------------------------
; date: 05/24/2018
;------------------------------
Comment !
Write a program that:
1. Clears the screen, locates the cursor near the middle of the screen.
2. Prompts the user for two signed integers.
3. Displays their sum and difference.
4. Repeats the same steps three times. Clears the screen after each loop iteration.
5. You need to call the following procedures from irvine32 library:
   - ClrScr
   - WriteString
   - WriteInt
   - ReadInt
   - Crlf
   - ReadChar
   - Gotoxy
The Gotoxy procedure locates the cursor at a given row and column in the console window. 
By default, the console window’s X-coordinate range is 0 to 79 and the Y-coordinate range is 0 to 24. 
When you call Gotoxy, pass the Y-coordinate (row) in DH and the X-coordinate (column) in DL. 
6. You need to create the following procedures:
   - Locate. It needs to be called before anything displays on the screen. Where it sets the cursor position.
   - Input: this procedure prompts the user and saves the input.
   - DisplaySum: displays the sum.
   - DisplayDiff: displays the difference.
   - WaitForKey; It needs to be called at the end of each iteration. 
     It displays "Press any key..." and waits for an input
!

include irvine32.inc

.data
total byte 10
int1 sdword ?
int2 sdword ?
sumInt byte "The sum is: ",0
diffInt byte "The difference is: ",0
endMsg byte "Press any key...", 0
userInput1 byte "Please enter sign number1: ",0
userInput2 byte "Please enter sign number2: ",0



.code
main proc

	mov ecx, 3				  ; to repeat loop L1 three times
L1:
	call ClrScr				  ; to clear the screen
	call locate				
	call Input				  ; ask user for signed number
	call DisplaySum			  ; display the sum of the integer
	call DisplayDiff          ; display the difference of the number
	call WaitForKey			  ; display the "Print any key... " and wait for user's response
	mov total,10            
loop L1
	
	exit

main ENDP

;----------------------------------------------------------------
; The locate Procedure
; Set the cursor position on the screen
; The first procedure we need to call before anything displayed
;
; Receives: None
; Returns: None
;----------------------------------------------------------------


locate PROC
	sub edx, edx		       ; initialized the edx register
	mov dh,total			 
    mov dl,20			    
	inc dh                     ; increment the register dh
	mov total, dh			
	call Gotoxy				   ; locate the cursor on the screen
	ret
locate ENDP

;----------------------------------------------------------------
; The Input Procedure
; Ask the user to enter the numbers and saves the input
;
; Receives: None
; Returns: None
;----------------------------------------------------------------

Input PROC
	mov edx, offset userInput1	; ask for the first user input
	call writeString		
	call readInt			    ; read the first user input 
	mov int1, eax
	call crlf
	
	call locate				    ; locate the cursor on the screen
	mov edx, offset userInput2  ; ask for the second user input
	call writeString		
	call readInt			    ; read the second user input 
	mov int2, eax
	ret
Input ENDP

;----------------------------------------------------------------
; The DisplaySum Procedure
; display the sum of the numbers on the screen
; 
; Receives: None
; Returns: None
;----------------------------------------------------------------


DisplaySum PROC
	call locate				     ; locate cursor on the screen
	mov eax, int1
	mov ebx, int2
	add eax, ebx
	mov edx, offset sumInt      
	call writeString		
	call writeInt			     ; print out the sum of the integer
	call crlf
	ret

DisplaySum ENDP

;----------------------------------------------------------------
; The DisplayDiff Procedure
; display the difference of the numbers on the screen
;
; Receives: None
; Returns: None
;----------------------------------------------------------------

DisplayDiff PROC
	call locate				      ; locate cursor on the screen
	mov edx, offset diffInt 
	call writeString		
	mov eax, int1
	sub eax,int2
	call writeint                 ; print out the difference of the integer
	call crlf				
	ret
DisplayDiff ENDP

;----------------------------------------------------------------
; The WaitForKey Procedure
; Display "Press any key..." on the sce=reen and wait for the input
; The procedure that should be called at the end of each runs
;
; Receives: None
; Returns: None
;----------------------------------------------------------------

WaitForKey PROC
	call locate				       ; locate cursor on the screen
	mov al, total			       ; move the value of total to al
	mov total, 29			       ; initialize the value of total with 29
	mov edx, offset endMsg	       ; display "Press any key..." to the screen
	call writeString		
	call readChar			       ; read any input to proceed
	ret
WaitForKey ENDP

END main

