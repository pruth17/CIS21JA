; Program template
TITLE   Assignment 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; date: 5/17/2018
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Comment !
Write a complete program that:
    1. Prompts the user to enter 5 numbers then 5 letters.
    2. Saves the numbers to a 32-bit integer array, numArr.
    3. Saves the letters to charArr where each element reserves one byte.
    4. Prints the numbers and letters. 
    5. prints the mean of the number array,numArr
    6. copy all the elements from the numArr and the charArr
        to a quadword array, newArr in a reverse order.
        where each qword in newArr contains a letter that occupies
        4 bytes and a number that occupies 4 bytes, 
    7. Prints out the newArr.
    8. dumps out the memory for each array. This is done for you.  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      You MUST use loop and indirect addressing. 
      You MUST use the SIZEOF, type, and LENGTHOF operators to make the program
      as flexible as possible if the arrays' size and type should be 
      changed in the future. NO IMMesiATATE NUMBERS AT ALL IN THE CODE SEGMENT.
      Add comments to make your program easy to read. Your lines must not 
	  exceed 80 columns.
	  Look at the sample run for clarification.
	  Don't delete anything already written for you.		
	  Copy paste 2 of your runs and paste them at the end of your code
	
	!
    

include irvine32.inc

.data
string1 byte 0Ah,0Dh,"Dumping out charArr",0
string2 byte 0Ah,0Dh,"Dumping out numArr", 0
string3 byte 0Ah,0Dh,"Dumping out newArr", 0

charArr byte   5 dup  (?)
numArr  dword  5 dup  (?)
newArr  qword  5 dup  (?)

; add your data here
slash byte "/",0
space byte " ",0
divRemainder dword ?
numInput byte "Please enter a number: ", 0
charInput byte "Please enter five characters:", 0
numResult byte "The integer array you entered is: ", 0
charResult byte "The characters you entered are: ", 0
meanResult byte "The mean of the integer array is: ", 0
reversedChar byte "The elements in the new array are: ", 0

.code
main proc
	 
      ;----------------------------Your Code starts Here-----------------------
	  mov ecx, lengthof numArr								
	  mov esi, offset numArr	

  ; ask for user to enter integers
  L1:
	  mov edx, offset numInput
	  call writeString					                 ; print the prompt for user to enter 5 integer 
	  call crlf
	  call readDec						                 ; read the input of integers from user
	  mov [esi], eax				                     ; store the input to numArr
	  add esi, type dword                                ; increment esi by the size of dword
  loop L1                                                ; loop L1
	 
	  mov edx, offset numResult                                  
	  mov esi, offset numArr                             ; move the adress of numArr to esi
	  mov ecx, lengthof numArr			     
      call writeString                                   ; printing the numResult 

  ; print out the value that stored in numArr   
  L2:
	  mov eax, [esi]                                     ; move the value that stored in esi to eax
	  call writeDec                                      ; print the value out 
	  mov al, space                                      ; print the space for the output 
	  call writeChar                          
	  add esi, type dword                                ; increment esi by the size of dword
  loop L2                                                ; loop L2
	 
	  mov edx, offset space		              
	  call crlf
	  mov edx, offset charInput			      
	  call writeString					                 ; print the prompt for use to enter 5 character
	  mov ecx, lengthof charArr			
	  mov esi, offset charArr			                 ; move the adress from charArr to esi
	  
 ; ask for user to input characters
  L3:
	  call readChar						                 ; read the input of characters from user
	  mov [esi], al				                         ; move the value from al to esi
	  add esi, type byte                                 ; increment esi by the size of byte
  loop L3                                                ; loop L3

	  mov edx, offset charResult		                 ; move the adress of charResult to edx
	  call crlf
	  call writeString					                 ; print the charResult
	  call crlf   
	  mov ecx, lengthof charArr			                 ; move the element of charArr to ecx
	  mov esi, offset charArr

  ; print out the value that stored in charArr
  L4:
	  mov al, [esi]				                         ; moves the value of array from each index to al
	  call writeChar					
	  mov al,space                                       ; move the space to al for the output
	  call writeChar                                     ; print out the index that stored in charArr
	  add esi, type byte                                ; increment esi by the size of byte
  loop L4                                                ; loop L4

	  mov edx, offset meanResult                         ; move the adress of meanResult to edx
	  call crlf
	  call writeString                        
	  mov ecx, lengthof numArr  

	  mov esi, offset numArr
	  sub eax, eax							              ; initializing eax
	  sub edx, edx                                        ; initializing edx 
 
 ; add value from esi to eax
  L5:										
	  add eax, [esi]			              	
	  add esi, type dword					              ; increment esi by the size of dword
 loop L5

	 
	  call crlf
	  mov ecx, lengthof numArr			   
	  mov esi, offset numArr			       
	  sub edx, edx						                   ; initializing edx
	  mov ebx,lengthof numArr
	  div ebx							                   ; (sum of the array) / (size of the array)	
	  call writeDec						                   ; print the meanResult after the calculation above
	  mov divRemainder, edx                                        ; moving the remainder to the divRemainder

	  mov edx, offset space		                           ; dereference the space for the output
	  call writeString					  
	  mov eax,divRemainder                                         ; moving the remainder after the calculation to eax 
	  call writeDec						                   ; print the mean value 
	  mov edx, offset slash				    
	  call writeString					                   ; print out  slash for the output 
	  mov eax, lengthof numArr               
	  call writeDec						                   ; print out the size of array for the output 
	  call crlf

	  mov edx, offset reversedChar
	  call writeString					                   ; print out the reversedChar 
	  call crlf
	  mov esi, offset newarr			
	
	  mov ecx, lengthof newArr			   
	  
	; reversed the character that stored in the index
  L6:
	  movzx ebx, charArr[ecx - type byte]               ; move the value after the calculation in the array to ebx
      mov[esi], ebx                                        
      add esi, type dword                                  ; increment esi by the size of dword

      mov eax, numArr [(ecx * type dword) - type dword]  ; move the value after the calculation in the array to eax
      mov [esi], eax                                       
      add esi, type dword                                 ; increment esi by the size of dword
  loop L6

	  mov ecx, LENGTHOF newArr
      mov esi, OFFSET newArr

    ; print out those characters that stored in the array
   L7:									
      mov eax, [esi]
      call writeChar							
      add esi, type dword                                ; increment esi by the size of dword
      mov eax, [esi]
      call writeDec						
      add esi, type dword                                 ; increment esi by the size of dword

      mov al, space
      call writeChar
   loop L7

    ; ---------------------------Your Code Ends Here-------------------------

	  mov edx, offset string1
	  call writeString
      mov  esi,OFFSET charArr
      mov  ecx,LENGTHOF charArr
      mov  ebx,type charArr
      call DumpMem
	   
	  mov edx, offset string2
	  call writeString
      mov  esi,OFFSET numArr
      mov  ecx,LENGTHOF numArr 
      mov  ebx,type numArr    
      call DumpMem
	   
	  mov edx, offset string3
	  call writeString
      mov  esi,OFFSET newArr
      mov  ecx,LENGTHOF newArr 
      mov  ebx,type numArr     
      call DumpMem
	  mov  esi,OFFSET newArr + Type numArr * LENGTHOF newArr
      mov  ecx,LENGTHOF newArr 
      mov  ebx,type numArr     
      call DumpMem
exit
main endp
end main

COMMENT *
RUN #1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Please enter a number:
1
Please enter a number:
2
Please enter a number:
3
Please enter a number:
4
Please enter a number:
5
The integer array you entered is: 1 2 3 4 5
Please enter five characters:
The characters you entered are:
a b c d e
The mean of the integer array is:
3 0/5
The elements in the new array are:
e5 d4 c3 b2 a1
Dumping out charArr
Dump of offset 00406040
-------------------------------
61 62 63 64 65

Dumping out numArr
Dump of offset 00406045
-------------------------------
00000001  00000002  00000003  00000004  00000005

Dumping out newArr
Dump of offset 00406059
-------------------------------
00000065  00000005  00000064  00000004  00000063

Dump of offset 0040606D
-------------------------------
00000003  00000062  00000002  00000061  00000001
Press any key to continue . . .

RUN #2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Please enter a number:
3
Please enter a number:
55
Please enter a number:
6
Please enter a number:
7
Please enter a number:
3
The integer array you entered is: 3 55 6 7 3
Please enter five characters:
The characters you entered are:
a l a m e
The mean of the integer array is:
14 4/5
The elements in the new array are:
e3 m7 a6 l55 a3
Dumping out charArr
Dump of offset 00406040
-------------------------------
61 6C 61 6D 65

Dumping out numArr
Dump of offset 00406045
-------------------------------
00000003  00000037  00000006  00000007  00000003

Dumping out newArr
Dump of offset 00406059
-------------------------------
00000065  00000003  0000006D  00000007  00000061

Dump of offset 0040606D
-------------------------------
00000006  0000006C  00000037  00000061  00000003
Press any key to continue . . .
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*