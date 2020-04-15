TITLE  Assignment 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; name: Pruthvi Punwar
; date: 5/3/2018
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COMMENT !
a. Write a complete program that will input values for num1, num2, and num3 
b. display the value of the expression (num1 + num2 * num3)/ (11 *num2)
c. display the quotient and remainder 
d. assume that the user enters only numbers that are > 0 & < 500
!


include irvine32.inc
.data

num1 word ?
num2 word ?
num3 word ?
sum word ?
quotient word ?
remainder word ?
string1 byte "Enter the value of num1 ? ",0
string2 byte "Enter the value of num2 ? ",0
string3 byte "Enter the value of num3 ? ",0
string4 byte "The Quotient is: ",0
string5 byte "The Remainder is: ",0


.code
main proc

mov edx,offset string1            
call writeString                   ; print the first prompt to the user
call readDec                       ; read the input into ax
call crlf
mov num1, ax                       ; move the number from register eax to num1

mov edx,offset string2             
call writeString                   ; print the second prompt to the user
call readDec                       ; read the input into ax
call crlf
mov num2,ax                        ; move the number from register eax to num2

mov edx, offset string3            
call writeString                   ; print the third prompt to the user
call readDec                       ; read the input into ax
call crlf
mov num3,ax                        ; move the number from register eax to num3


mov ax,num2                        ; move num2 to ax
mul num3                           ; multiply num2 with num3

add ax,num1                       ; add num1 to ax, (num1 + num2 * num3) in ax


mov cx,ax                         
mov ax,11                          ; moving 11 to ax
mul num2                           ; multiply num2 to 11 in ax, (11 * num2)

mov bx,ax                         
mov ax,cx
div bx                             ; (num1 + num2 * num3)/ (11 *num2) , divide ax/bx, and store the divisor in ax

mov bx,dx 

call crlf
mov edx, offset string4
call writestring                   ; print "The Quotient is: "
call writeDec                      ; print the quotient of the calculation
call crlf

call crlf
mov edx,offset string5
call writestring                   ; print "The Remainder is: "
mov ax,bx                          ; move the remainder of the calculation to ax

call writedec                      ; print the remainder of the calculation
call crlf
call crlf

.code
exit 
main endp
end main 

COMMENT *
RUN #1
------------------------------------------------------
Enter the value of num1 ? 3

Enter the value of num2 ? 6

Enter the value of num3 ? 23


The Quotient is: 2

The Remainder is: 9

Press any key to continue . . .
--------------------------------------------------------


RUN #2
--------------------------------------------------------
Enter the value of num1 ? 3

Enter the value of num2 ? 7

Enter the value of num3 ? 9


The Quotient is: 0

The Remainder is: 66

Press any key to continue . . .
--------------------------------------------------------


RUN #3
--------------------------------------------------------
Enter the value of num1 ? 16

Enter the value of num2 ? 11

Enter the value of num3 ? 96


The Quotient is: 8

The Remainder is: 104

Press any key to continue . . .
----------------------------------------------------------
*
