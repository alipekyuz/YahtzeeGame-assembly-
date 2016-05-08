INCLUDE Irvine32.inc

.data
menu BYTE "Welcome the yahtzee game",0dh,0ah,0
menu0 BYTE "Order   Combination     Score",0dh,0ah,0
menu1 BYTE "1.      Ones              ",0dh,0ah,0
menu2 BYTE "2.      Twos              ",0dh,0ah,0
menu3 BYTE "3.      Threes            ",0dh,0ah,0
menu4 BYTE "4.      Fours             ",0dh,0ah,0
menu5 BYTE "5.      Fives             ",0dh,0ah,0
menu6 BYTE "6.      Sixes             ",0dh,0ah,0
menu7 BYTE "7.      3 of a kind       ",0dh,0ah,0
menu8 BYTE "8.      4 of a kind       ",0dh,0ah,0
menu9 BYTE "9.      Yahtzee           ",0dh,0ah,0
menu10 BYTE "10.     4 in row         ",0dh,0ah,0
menu11 BYTE "11.     5 in row         ",0dh,0ah,0
menu12 BYTE "12.     Anything         ",0dh,0ah,0
menu13 BYTE "Press enter to roll the dice",0dh,0ah,0
menu14 BYTE "Choose the place that you want to fill?",0
d BYTE "Dice",0
d2 BYTE " : ",0
d3 BYTE "Choose the dice that you want to reroll:(Select 1,2,3,4,5 OR N or Y) ",0dh,0ah

count DWORD 0
score DWORD 12 DUP (0),0
zar1 BYTE 0
zar2 BYTE 0
zar3 BYTE 0
zar4 BYTE 0
zar5 BYTE 0
zar6 BYTE 0

dice DWORD 5 DUP(0)
countControl DWORD 5 DUP (0),0
countArray DWORD 5 DUP (0),0
zarYuvarlamaSayisi BYTE 1 DUP(0),0
.code
main PROC

call oyun
call oyun
call oyun
call oyun
call oyun
call oyun
call oyun
call oyun
call oyun
call oyun
call oyun
call oyun
 
;exit
;main ENDP


oyun PROC

call ekran
 call scoreEkran
 call crlf
 mov  edx,OFFSET menu13
 call WriteString
 call readInt
 mov ecx,13  ;enter nin kodu
 cmp edx,ecx
 je L1
 
 
mov edx,0
mov esi,0
mov ebx,1
call Randomize
ZarYuvarla:
mov ecx,5
L1:	
	mov edx,OFFSET d
	call WriteString
	mov eax,ebx
	call WriteDec
	mov eax,6
	call RandomRange
	add eax,1
    mov dice[esi],eax
	call zar
	add esi,4
	inc ebx
	mov edx,OFFSET d2
	call WriteString
	call WriteDec
	call crlf
	loop L1


	askRerol:
	mov edx,OFFSET d3
	call WriteString
    call readChar
	;call writeInt   ; girilen sayiyi bastir
	;mov bl,121  ;y nin kodu
	mov bl,49  ;1 nin kodu
	cmp al,bl
	jz chose1
	
	mov bl,50  ;2 nin kodu
	cmp al,bl
	jz chose2
	
	mov bl,51  ;3 nin kodu
	cmp al,bl
	jz chose3
	
	mov bl,52  ;4 nin kodu
	cmp al,bl
	jz chose4
	
	mov bl,53  ;5 nin kodu
	cmp al,bl
	jz chose5
	
	mov bl,110
	cmp al,bl
	jz choseN
	
	mov bl,121
	cmp al,bl
	jz choseY
	
	jmp noChose
	
	chose1:
		mov esi,0
		mov eax,6
		call RandomRange
		add eax,1
		mov dice[esi],eax
		jmp noChose
	chose2:
		mov esi,4
		mov eax,6
		call RandomRange
		add eax,1
		mov dice[esi],eax
		jmp noChose
	chose3:
		mov esi,8
		mov eax,6
		call RandomRange
		add eax,1
		mov dice[esi],eax
		jmp noChose
	chose4:
		mov esi,12
		mov eax,6
		call RandomRange
		add eax,1
		mov dice[esi],eax
		jmp noChose
	chose5:
		mov esi,16
		mov eax,6
		call RandomRange
		add eax,1
		mov dice[esi],eax
		jmp noChose
	
	choseN:
		mov al, 2
		mov zarYuvarlamaSayisi, al
		jmp yesChose
	
	choseY: 
		call diceEkran
		mov al,[zarYuvarlamaSayisi]
		inc al
		mov zarYuvarlamaSayisi, al
		jmp noChose
		
	noChose:
		; dice ekranını burda yazdırabilirsiniz
		call zar
		mov al,[zarYuvarlamaSayisi]
		mov bl,2
		cmp al,bl
		jz yesChose
		jmp askRerol;
		
		
	yesChose:
			;-------menu bastırılacak burda
			call ekran
			call scoreEkran
		; dice bastirma ================
			call diceEkran

						
		
	reRolOk: ; düzgün degerler girilmiş

	sayilariTabloyaYaz: ; no
		mov  edx,OFFSET menu14
		call WriteString
		call readInt
		mov ecx,1  ;1 nin kodu
		cmp eax,ecx
		;call dumpregs
		jne test1
		call ones
		jmp selectionFinal
		test1:
		;;;;;;;;;;;;;;;;;;
		mov ecx,2  ;2 nin kodu
		cmp eax,ecx
		jne test2
		call twos
		jmp selectionFinal
		test2:
		;;;;;;;;;;;;;;;;
		mov ecx,3  ;3 nin kodu
		cmp eax,ecx
		;call dumpregs (debug yapmak için kullan)
		jne test3
		call threes
		jmp selectionFinal
		test3:
		;;;;;;;;;;;;;;;
		mov ecx,4  ;4 nin kodu
		cmp eax,ecx
		;call dumpregs (debug yapmak için kullan)
		jne test4
		call fours
		jmp selectionFinal
		test4:
		;;;;;;;;;;;;;;;
		mov ecx,5  ;5 nin kodu
		cmp eax,ecx
		jne test5
		call fives
		jmp selectionFinal
		test5:
		;;;;;;;;;;;;;
		mov ecx,6  ;6 nin kodu
		cmp eax,ecx
		jne test6
		call sixes
		jmp selectionFinal
		test6:
		;;;;;;;;;;;;;
		mov ecx,7  ;7 nin kodu
		cmp eax,ecx
		jne test7
		call threeOfKind
		jmp selectionFinal
		test7:
		;;;;;;;;;;;;;
		mov ecx,8  ;8 nin kodu
		cmp eax,ecx
		jne test8
		call fourOfKind
		jmp selectionFinal
		test8:
		;;;;;;;;;;;;;
		mov ecx,9  ;9 nin kodu
		cmp eax,ecx
		jne test9
		call yahtzee
		jmp selectionFinal
		test9:
		;;;;;;;;;;;;;
		mov ecx,10  ;10 nin kodu
		cmp eax,ecx
		jne test10
		call fourInRow
		jmp selectionFinal
		test10:
		;;;;;;;;;;;;;
		mov ecx,11  ;11 nin kodu
		cmp eax,ecx
		jne test11
		call fiveInRow
		jmp selectionFinal
		test11:
		;;;;;;;;;;;;;;
		mov ecx,12  ;12 nin kodu
		cmp eax,ecx
		jne test12
		call anything
		jmp selectionFinal
		test12:
	selectionFinal:	
	jmp SecimBitis
	SecimBitis:
ret
oyun ENDP

;--------------menu ekranı-----------------
ekran PROC
			call Clrscr 
			mov  edx,OFFSET menu
			call WriteString			
			mov  edx,OFFSET menu0
			call WriteString
			mov  edx,OFFSET menu1
			call WriteString
			mov  edx,OFFSET menu2
			call WriteString
			mov  edx,OFFSET menu3
			call WriteString
			mov  edx,OFFSET menu4
			call WriteString
			mov  edx,OFFSET menu5
			call WriteString
			mov  edx,OFFSET menu6
			call WriteString
			mov  edx,OFFSET menu7
			call WriteString
			mov  edx,OFFSET menu8
			call WriteString
			mov  edx,OFFSET menu9
			call WriteString
			mov  edx,OFFSET menu10
			call WriteString
			mov  edx,OFFSET menu11
			call WriteString
			mov  edx,OFFSET menu12
			call WriteString
			call crlf 
			
ret
ekran ENDP

;-------------score ekran---------------
scoreEkran PROC
	mov ecx,12
	mov edi ,0
	mov dh,2
	mov dl,26
	L3:
		call Gotoxy
		mov eax,score[edi]
		call WriteDec
		add edi,type score
		inc dh	
		loop L3
	
ret
scoreEkran ENDP


;-------dice ekranı----------
diceEkran PROC
		; dice bastirma ================
		mov ecx,5
		mov esi,0
		mov ebx,1
		mov dh,16
		mov dl,0
		call Gotoxy
		L2:	
			mov edx,OFFSET d
			call WriteString
			mov eax,ebx
			call WriteDec
			mov eax,dice[esi]
			add esi,4
			inc ebx
			mov edx,OFFSET d2
			call WriteString
			call WriteDec
			call crlf
			loop L2
		;################################
ret
diceEkran ENDP

		;Ones hesaplama
ones PROC
	    mov ecx,5
		mov esi,0
		mov edx,0
		;mov ebx,1
		L3:
			mov eax,dice[esi]
			cmp eax,1
			jne next
			add edx,1
			next:
			add esi,4
			loop L3
			mov score[0],edx
			mov eax,score[0]
			call WriteDec
			call scoreEkran
			call diceEkran
ret
ones ENDP

		;Twos hesaplama
twos PROC
	    mov ecx,5
		mov esi,0
		mov edx,0
		mov ebx,1
		L4:
			mov eax,dice[esi]
			cmp eax,2
			jne next
			add edx,2
			next:
			add esi,4
			loop L4
			mov score[4],edx
			mov eax,score[4]
			call WriteDec
			call scoreEkran
			call diceEkran
ret
twos ENDP

		;Threes hesaplama
threes PROC
	    mov ecx,5
		mov esi,0
		mov edx,0
		mov ebx,1
		L5:
			mov eax,dice[esi]
			cmp eax,3
			jne next
			add edx,3
			next:
			add esi,4
			loop L5
			mov score[8],edx
			mov eax,score[8]
			call WriteDec
			call scoreEkran
			call diceEkran
ret
threes ENDP


		;Fours hesaplama
fours PROC
	    mov ecx,5
		mov esi,0
		mov edx,0
		mov ebx,1
		L6:
			mov eax,dice[esi]
			cmp eax,4
			jne next
			add edx,4
			next:
			add esi,4
			loop L6
			mov score[12],edx
			mov eax,score[12]
			call WriteDec
			call scoreEkran
			call diceEkran
ret
fours ENDP



		;Fives hesaplama
fives PROC
	    mov ecx,5
		mov esi,0
		mov edx,0
		mov ebx,1
		L7:
			mov eax,dice[esi]
			cmp eax,5
			jne next
			add edx,5
			next:
			add esi,4
			loop L7
			mov score[16],edx
			mov eax,score[16]
			call WriteDec
			call scoreEkran
			call diceEkran
ret
fives ENDP

		;sixes hesaplama
sixes PROC
	    mov ecx,5
		mov esi,0
		mov edx,0
		;mov ebx,1
		L8:
			mov eax,dice[esi]
			cmp eax,6
			jne next
			add edx,6
			next:
			add esi,4
			loop L8
			mov score[20],edx
			mov eax,score[20]
			call WriteDec
			call scoreEkran
			call diceEkran
ret
sixes ENDP

;--------------threeOfKind---------
threeOfKind PROC
	  cmp zar1,3
	  jge Calculate
	  cmp zar2,3
	  jge Calculate
	  cmp zar3,3
	  jge Calculate
	  cmp zar4,3
	  jge Calculate
	  cmp zar5,3
	  jge Calculate
	  cmp zar6,3
	  jge Calculate
	  jmp finish
Calculate:	  
	  mov eax,0
	  add eax,dice[0]
	  add eax,dice[4]
	  add eax,dice[8]
	  add eax,dice[12]
	  add eax,dice[16]
	  mov score[24],eax
	  finish:
call WriteDec
call scoreEkran
call diceEkran

ret
threeOfKind ENDP



;--------------fourOfKind---------
fourOfKind PROC
	  cmp zar1,4
	  jge Calculate
	  cmp zar2,4
	  jge Calculate
	  cmp zar3,4
	  jge Calculate
	  cmp zar4,4
	  jge Calculate
	  cmp zar5,4
	  jge Calculate
	  cmp zar6,4
	  jge Calculate
	  jmp finish
Calculate:	  
	  mov eax,0
	  add eax,dice[0]
	  add eax,dice[4]
	  add eax,dice[8]
	  add eax,dice[12]
	  add eax,dice[16]
	  mov score[28],eax
	  finish:
call WriteDec
call scoreEkran
call diceEkran

ret
fourOfKind ENDP



;--------------yahtzee---------
yahtzee PROC
	  cmp zar1,5
	  jge Calculate
	  cmp zar2,5
	  jge Calculate
	  cmp zar3,5
	  jge Calculate
	  cmp zar4,5
	  jge Calculate
	  cmp zar5,5
	  jge Calculate
	  cmp zar6,3
	  jge Calculate
	  jmp finish
Calculate:	  
	  mov eax,50
	  mov score[32],eax
	  finish:
call WriteDec
call scoreEkran
call diceEkran

ret
yahtzee ENDP



;--------------fourInRow---------
fourInRow PROC
	  cmp zar1,1
	  jl Calculate
	  cmp zar2,1
	  jl Calculate
	  cmp zar3,1
	  jl Calculate
	  cmp zar4,1
	  jl Calculate
	  jmp finish
Calculate:
	  cmp zar2,1
	  jl Calculate2
	  cmp zar3,1
	  jl Calculate2
	  cmp zar4,1
	  jl Calculate2
	  cmp zar5,1
	  jl Calculate2
	  jmp finish
Calculate2:
      cmp zar3,1
	  jl Calculate3
	  cmp zar4,1
	  jl Calculate3
	  cmp zar5,1
	  jl Calculate3
	  cmp zar6,1
	  jl Calculate3
	  jmp finish
	  Calculate3:
	  jmp bitirekran
	  finish:
	  mov eax,30
	  mov score[36],eax
	  bitirekran:
call WriteDec
call scoreEkran
call diceEkran

ret
fourInRow ENDP


;--------------fiveInRow---------
fiveInRow PROC
	  cmp zar1,1
	  jl Calculate
	  cmp zar2,1
	  jl Calculate
	  cmp zar3,1
	  jl Calculate
	  cmp zar4,1
	  jl Calculate
	  cmp zar5,1
	  jl Calculate
	  jmp bitir
Calculate:
      cmp zar2,1
	  jl Calculate2
	  cmp zar3,1
	  jl Calculate2
	  cmp zar4,1
	  jl Calculate2
	  cmp zar5,1
	  jl Calculate2
	  cmp zar6,1
	  jl Calculate2
	  jmp bitir
Calculate2:
		jmp bitirekran
		bitir:
		mov eax,40
		mov score[40],eax
		bitirekran:
		call WriteDec
		call scoreEkran
		call diceEkran
		;call dumpregs
		

ret
fiveInRow ENDP


;------------anything----------
anything PROC
	    mov ecx,5
		mov esi,0
		mov edx,0
		mov ebx,1
		L8:
			mov eax,dice[esi]
			add edx,eax
			add esi,4
			loop L8
			mov score[44],edx
			mov eax,score[44]
			call WriteDec
			call scoreEkran
			call diceEkran
ret
anything ENDP

zar PROC
	cmp dice[esi],1
	jne test1
	add zar1 ,1
	test1:
	cmp dice[esi],2
	jne test2
	add zar2 ,1
	test2:
	cmp dice[esi],3
	jne test3
	add zar3,1
	test3:
	cmp dice[esi],4
	jne test4
	add zar4 ,1
	test4:
	cmp dice[esi],5
	jne test5
	add zar5,1
	test5:
	cmp dice[esi],6
	jne test6
	add zar6,1
	test6:
ret
zar ENDP

END main








