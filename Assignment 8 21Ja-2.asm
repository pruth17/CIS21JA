COMMENT!
;;;;;;;;;;;;;;;;;;;;;;;;;;
date: 6/21/2018
;;;;;;;;;;;;;;;;;;;;;;;;;;
Prompt the user for number of elements the array want.
Prompt the user for number of elements in each row in the array.
Prompt the user on the type of array.
Prompt the user for number of the elements of the array.
Prompt the user for number row target.
Display the sum of the selected row.
!

INCLUDE Irvine32.inc

.data
tableB BYTE 40 dup(?)
tableW word 40 dup(0)
tableD dword 40 dup(0)
target dword ?

prompt1 BYTE 'Enter how many elements in your array: ', 0
prompt2 BYTE 'Enter the row size: ', 0
prompt3 BYTE 'Enter the type of your array.',0
prompt4 BYTE 'Enter an element in your array, ',0
prompt5 BYTE 'Enter row number that you want me to sum: ',0
choices1 BYTE ' 1 for byte.',0
choices2 BYTE ' 2 for word.',0
choices3 BYTE ' 4 for doubleword.',0
result1 BYTE 'The sum is: ',0


.code
main PROC

mov edx, OFFSET prompt1    ; "Enter how many elements in your array: "
call writeString
call readInt
mov ecx, eax               ; move the number of array elements to ecx

mov edx, OFFSET prompt2    ; "Enter the row size:"
call writeString
call readInt
mov ebx, eax               ; move size of row to ebx

mov edx, OFFSET prompt3    ; "Enter the type of your array."
call writeString
call crlf
mov edx, OFFSET choices1   ; "1 for byte."
call writeString
call crlf
mov edx, OFFSET choices2   ; "2 for word."
call writeString
call crlf
mov edx, OFFSET choices3   ; "4 for doubleword."
call writeString
call crlf
call readInt
mov edi, eax               ; move the type of array to edi
     
   

mov edx, OFFSET prompt5    ;"Enter row number that you want me to sum: "
call crlf
call writeString
call readInt
mov target, eax


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [Code Equivalent in C++] :
;
; if (edi==1)
; {
;  jump to ArrB   
; }
; else if (edi==2)
;{
;  jump to ArrW
;}
; else if (edi==4)
; {
;   jump to ArrD
;}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


cmp edi,1
JE ArrB
cmp edi, 2
JE ArrW
cmp edi, 4
JE ArrD

ArrB:  
	mov esi, OFFSET tableB  ; get address of tableB

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [Code Equivalent in C++] :
;
; for(edx =5; edx > 0; edx --)
; {
;     //ask user for the element number
; }
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

L1 :   
	mov edx, OFFSET prompt4
	call writeString
	call readInt
	mov [esi], al
	add esi, 1           
loop L1
              
sub esp,4                     ; prepare for the return value
push OFFSET tableB            ; push the address of the array
push ebx                      ; push the size of the row
push TYPE BYTE                ; push the type of array
push target                   ; push the target of the row
call calcRowSum               ; call the procedure

mov edx,OFFSET result1
call crlf
call WriteString
pop eax
call WriteHex                 ; the sum is saved in Hex    
call Crlf          
jmp out01          

ArrW:    
	mov esi, OFFSET tableW   ; get address of tableW

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [Code Equivalent in C++] :
;
; for(edx =5; edx > 0; edx --)
; {
;     //ask user for the element number
; }
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

L2 :   
	mov edx, OFFSET prompt4
	call writeString
	call readInt      
	mov [esi], ax      
	add esi, 2                
loop L2      
   
sub esp,4                    ; prepare for the return value
push OFFSET tableW           ; push the address of the array
push ebx                     ; push the size of the row
push TYPE WORD               ; push the type of array
push target                  ; push the target of the row
call calcRowSum              ; call the procedure

mov edx,OFFSET result1
call crlf
call WriteString
pop eax
call Writeint 
call Crlf
jmp out01

ArrD:     
    mov esi, OFFSET tableD    ; get address of tableD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [Code Equivalent in C++] :
;
; for(edx =5; edx > 0; edx --)
; {
;     //ask user for the element number
; }
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

L3 :   
	mov edx, OFFSET prompt4
	call writeString
	call readInt
	mov [esi], eax
	add esi, 4          
loop L3
  
sub esp,4                      ; prepare for the return value
push OFFSET tableD             ; push the address of the array
push ebx                       ; push the size of the row
push TYPE DWORD                ; push the type of arra
push target                    ; push the target of the row
call calcRowSum                ; call the procedure
mov edx,OFFSET result1 
call crlf
call WriteString      
			   
pop eax
call Writeint 
call Crlf

   out01:
  
    exit
main ENDP


; =========================================================================
; int calRowSum(int rowTarget, type arr[], int userRowSize, int typeSize)
;
; Input: 
; Row Target, array address, rowSize, typeSize(of array)
;   
; Output:
;   The sum of row target
;
; Operation:
;   This procedure will calculate the sum of row that user wish to calculate
;   
;===========================================================================

calcRowSum PROC

push ebp
mov ebp,esp
push eax
push ebx
push ecx
push esi
push edx
push edi

mov eax, [ebp+8]            ; rowTarget
mov ebx, [ebp+20]           ; address of the array
mov ecx, [ebp+16]           ; rowSize
mov edi, [ebp+12]           ; typeSize

mul ecx
mul edi
add ebx, eax
xor eax, eax
xor esi, esi

cmp edi,4
je if01
cmp edi, 2
je L2

; Loop through the columns.

L1:
  movzx edx,BYTE ptr[ebx + esi] ; move the double word to edx
  add eax,edx                   ; add to the eax
  inc esi                       ; increment to the next value in the row
loop L1
  jmp out1


L2:
  movzx edx,WORD PTR[ebx + esi] ; move the double word to edx
  add eax,edx                   ; add to the eax
  add esi,2                     ; increment to the next value in the row
loop L2
  jmp out1

if01:


L3:
  mov edx,DWORD PTR[ebx + esi]  ; move the double word to edx
  add eax,edx                   ; add to the eax
  add esi,4                     ; increment to the next value in the row
loop L3

out1:

  mov [ebp+24],eax
  pop edi
  pop edx
  pop esi
  pop ecx
  pop ebx
  pop eax
  pop ebp
  
  ret 16

calcRowSum ENDP
end main


COMMENT $

SAMPLE RUN

Enter how many elements in your array: 6
Enter the row size: 2
Enter the type of your array.
 1 for byte.
 2 for word.
 4 for doubleword.
1

Enter row number that you want me to sum: 0
Enter an element in your array, 1
Enter an element in your array, 2
Enter an element in your array, 3
Enter an element in your array, 4
Enter an element in your array, 5
Enter an element in your array, 6

The sum is: 00000003
Press any key to continue . . .

$