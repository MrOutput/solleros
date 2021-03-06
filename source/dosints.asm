int20h:
mov ax, 0x4C00
int21h:
dostosolleros:
	push ax
	mov ax, NEW_DATA_SEL
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov ax, SYS_DATA_SEL
	mov gs, ax
	pop ax
	pushf
	pusha
	cmp ah, 1
	je near dosgchar
	cmp ah, 2
	je near doswchar
	cmp ah, 9
	je near dosprintstr
	cmp ah, 0xA
	je near dosgetstr
	cmp ah, 0x2B
	je near dosgetdate
	cmp ah, 0x2C
	je near dosgettime
	cmp ah, 0x4C
	je near dosexit
backtodos:
	popa
	popf
	push ax
	mov ax, DOS_DATA_SEL
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	pop ax
	iret

dosgchar:
	call getchar
	jmp backtodos
	
doswchar:
	mov al, dl
	xor ah, ah
	mov bl, 7
	call prcharint
	jmp backtodos
	
dosprintstr:
	xor esi, esi
	mov si, dx
	add esi, dosprogloc
	mov ax, "$"
	mov bl, 7
	call printint
	jmp backtodos
	
dosgetstr:
	xor esi, esi
	mov si, dx
	add esi, dosprogloc
	mov ecx, 0
	mov cl, [esi]
	add esi, 2
	mov edi, esi
	mov [stringstart], esi
	add edi, ecx
	mov al, 10
	mov bl, 7
	call rdprintdos
	mov ecx, esi
	sub ecx, [stringstart]
	mov esi, [stringstart]
	mov [esi - 1], cl
	mov [esi - 2], cl
	jmp backtodos
stringstart dd 0

dosgetdate:
	call time
	mov cl, [RTCtimeYear]
	mov ch, 0
	add cx, 2000
	mov dh, [RTCtimeMonth]
	mov dl, [RTCtimeDay]
	jmp backtodos

dosgettime:
	call time
	mov ch, [RTCtimeHour]
	mov cl, [RTCtimeMinute]
	mov dh, [RTCtimeSecond]
	mov dl, 0
	jmp backtodos
	
dosexit:
	mov esi, line
	call print
	popa
	popf
	mov esp, [previousstack]
	xor ebx, ebx
	mov bl, al
	cmp bl, 0
	jne near exitprog.error
	ret
