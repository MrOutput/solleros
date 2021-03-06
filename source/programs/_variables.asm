db 255,44,"%",0
	ans:
		mov esi, buf2
		call chkadd
		ret
		
db 255,44,"$",0
var: mov esi, [currentcommandloc]
	mov ebx, variables
lkeq:	mov al, [esi]
	cmp al, '='
	je eqfnd	;is there an '=' sign?
	cmp al, 0
	je echovars
	inc esi
	jmp lkeq
echovars: mov esi, variables
	mov ebx, varend
	mov cl, 5
	mov ch, 4
	call array
	ret
eqfnd:	inc esi
	mov al, [esi]
	cmp al, 0
	je readvar
	mov esi, [currentcommandloc]
	mov ebx, variables
	jmp seek
readvar:
	mov al, 10
	mov bx, 7
	mov byte [commandedit], 0
	mov edi, buftxtend
	call rdprint
	jmp var
seek:	mov ax, [ebx]
	mov cl, 5
	mov ch, 4
	cmp ax, 0
	je near save
	cmp ax, cx
	je skfnd
	inc ebx
	jmp seek
skfnd:	mov esi, [currentcommandloc]
	inc esi
	add ebx, 2
	mov edi, ebx
	mov cl, '='
	call cndtest
	cmp al, 1	
	je varfnd
	mov ebx, edi
	mov esi, [currentcommandloc]
	mov ax, [ebx]
	cmp ax, 0
	je near save
	inc ebx
	jmp seek
varfnd:	mov al, [ebx]
	cmp al, 4
	je save2
	dec ebx
	dec esi
	jmp varfnd
save2:	dec ebx
	dec esi
	mov al, [ebx]
	cmp al, 5
	je remove
	jmp varfnd
remove: mov al, [ebx]
	cmp al, 0
	je seek
	xor al, al
	mov [ebx], al
	inc ebx
	jmp remove	;do not need for now-need defragmentation
save:	mov esi, [currentcommandloc]
	inc ebx
	mov al, 5
	mov ah, 4
	mov [ebx], ax
	inc ebx
svhere:	inc ebx
	inc esi
	mov al, [esi]
	cmp al, 0
	je near svdone
	cmp al, '%'
	je ans2
	mov [ebx], al	
	jmp svhere
ans2:	push esi
	mov esi, buf2
	call ansfnd
	call anscp
	pop esi
	jmp svhere
anscp:	mov al, [esi]
	mov [ebx], al
	cmp esi, numbuf
	je svhere
	cmp al, 0
	je svhere
	inc ebx
	inc esi
	jmp anscp
ansnf:	pop esi
	mov al, [esi]
	mov [ebx], al
	jmp svhere
ansfnd:	inc esi
	cmp esi, numbuf - 1
	je fndans
	mov al, [esi]
	cmp al, 0
	je ansnf
	cmp al, '0'
	je ansfnd
fndans:
	ret
svdone:	xor al, al
	mov [ebx], al
	ret
