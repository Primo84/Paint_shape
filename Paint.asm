TITLE paint	(paint.asm)

.model medium

.stack 100h


.386

.data

tryb db ?

wsp2 label byte
	x db 1
	y db 5
	licz dw 123

wsp1 struct

	x dw -1
	y dw -1
	kol db 0

wsp1 ends


wsp label byte
	
	x1 dw 0
	y1 dw 0
	x2 dw 50
	y2 dw 0
	wx dw 0
	wy dw 0
	kolor db 1



pxls wsp1 6000 dup(<-1,-1,0>)

li dw 255
.code

main proc

mov ax,@data
mov ds,ax


mov ah,0fh
int 10h
mov tryb,al

mov ah,00h
mov al,13h
int 10h




mov di,offset wsp
mov word ptr[di],10
mov word ptr[di+2],10
mov word ptr[di+4],100
mov word ptr[di+6],10
mov word ptr[di+12],14
call line
mov word ptr[di+4],10
mov word ptr[di+6],150
call line
mov word ptr[di],50
mov word ptr[di+2],150
call line
mov word ptr[di+4],50
mov word ptr[di+6],50
call line

mov word ptr[di],75
mov word ptr[di+2],50
call line

mov word ptr[di+4],75
mov word ptr[di+6],150
call line

mov word ptr[di],250
mov word ptr[di+2],150
call line

mov word ptr[di+4],250
mov word ptr[di+6],50
call line


mov word ptr[di],100
mov word ptr[di+2],50
call line


mov word ptr[di+4],100
mov word ptr[di+6],10
call line

mov word ptr[di],10
mov word ptr[di+2],10
call line

PT:
			
	mov ah,06h
	mov dl,255
	int 21h
	jz PT
	cmp al,'f'
	jne K
	mov di,offset pxls
	mov word ptr(wsp1 ptr[di]).x,125
	mov word ptr(wsp1 ptr[di]).y,51
	mov al,(wsp1 ptr[di]).kol
	inc al
	mov byte ptr(wsp1 ptr[di]).kol,al
	call Flood
		
K:
	cmp al,'k'
	jne PT




mov ah,00h
mov al,tryb
int 10h

mov ax,4c00h
int 21h

main endp





line proc

PUSHAD

push di

mov ah,0ch
mov al,byte ptr[di+12]
mov cx,word ptr[di]
mov dx,word ptr[di+2]
mov bh,0
int 10h

pop di
mov si,di
mov ax,word ptr[di]
add di,4
mov dx,word ptr[di]
add di,4
cmp ax,dx
ja A

sub dx,ax
jmp A1

A:
 sub ax,dx
 mov dx,ax
A1:
 mov [di],dx
 sub di,6

mov ax,word ptr[di]
add di,4
mov dx,word ptr[di]
add di,4
cmp ax,dx
ja B

sub dx,ax
jmp B1

B:
 sub ax,dx
 mov dx,ax
B1:
 mov [di],dx
 mov di,si
 push di
 add di,10
 add si,8 
mov ax,word ptr[si]
mov bx,word ptr[di]
cmp ax,bx
jb YX

XY:
  pop si
  mov bp,word ptr[si+2] 
  mov di,si
  mov bp,word ptr[di+2]
  add di,4
  push si	 
  mov ax,word ptr[si]
  mov bx,word ptr[di]
  cmp ax,bx
  ja X2_X1
  pop si
  mov di,si
  push si
  add si,2
  add di,6
  mov ax,word ptr[si]
  mov bx,word ptr[di]
  cmp ax,bx
  jb FUN2

  Fun1:
	pop si
	mov di,si
	mov cx,word ptr[si+8]
	
	
	PETLA1:
		
		mov edx,0
		mov eax,0
		mov ax,word ptr[si+2]
		mov ebx,0
		mov bx,word ptr[si+8]
		mul ebx	
		mov edi,eax
		mov eax,0
		mov ax,word ptr[si]
		mov ebx,0
		mov bx,word ptr[si+10]
		mov edx,0
		mul ebx
		add eax,edi
		mov edi,eax
		mov eax,0
		mov edx,0
		mov ebx,0
		
		mov ax,word ptr[si]
		mov bx,word ptr[si+8]
		cmp ax,[si+4]
		ja X2toX1
		add ax,bx
		inc ax
		sub ax,cx
		jmp X1toX2
		
		X2toX1:
			sub ax,bx
			dec ax
			add ax,cx
		
		X1toX2:
		
		mov bx,word ptr[si+10]
		mul ebx
		sub edi,eax
		mov ebx,0
		mov bx,word ptr[si+8]
		mov edx,0
		mov eax,edi
		div bx
		mov di,ax
		mov ax,bx
		mov bl,2
		push dx
		mov dx,0
		div bx	
		pop dx
		cmp dx,ax
		jb DAL1
		inc di
		DAL1:
		push cx
		
		mov ax,word ptr[si]
		mov bx,word ptr[si+8]
		cmp ax,[si+4]
		ja X2tX1
		add ax,bx
		inc ax
		sub ax,cx
		jmp X1tX2
		
		X2tX1:
			sub ax,bx
			dec ax
			add ax,cx
		
		X1tX2:
		
		mov cx,ax
		mov ah,0ch
		mov al,byte ptr[si+12]
		mov dx,di
		mov bh,0
		int 10h		
		cmp dx,bp
		je DALEJ1
			
			cmp dx,word ptr [si+6]
			jbe DALEJ1
				inc dx
				int 10h
				mov bp,dx
				dec bp
				jmp DALEJ1
							
		

		DALEJ1:
		
		pop cx	
		dec cx
		cmp cx,0
	
	jne  PETLA1
	jmp KONIEC

  FUN2:  
	pop si
	mov di,si
	mov cx,word ptr[si+8]
	
	
	PETLA2:
		
		mov edx,0
		mov eax,0
		mov ax,word ptr[si+2]
		mov ebx,0
		mov bx,word ptr[si+8]
		mul ebx	
		mov edi,eax
		mov eax,0
		mov ax,word ptr[si]
		mov ebx,0
		mov bx,word ptr[si+10]
		mov edx,0
		mul ebx
		sub edi,eax
		mov eax,0
		mov edx,0
		mov ebx,0
		
		mov ax,word ptr[si]
		mov bx,word ptr[si+8]
		cmp ax,[si+4]
		ja X2ttoX1
		add ax,bx
		inc ax
		sub ax,cx
		jmp X1ttoX2
		
		X2ttoX1:
			sub ax,bx
			dec ax
			add ax,cx
		
		X1ttoX2:
		
		mov bx,word ptr[si+10]
		mul ebx
		add edi,eax
		mov ebx,0
		mov bx,word ptr[si+8]
		mov edx,0
		mov eax,edi
		div bx
		mov di,ax
		mov ax,bx
		mov bl,2
		push dx
		mov dx,0
		div bx	
		pop dx
		cmp dx,ax
		jb DAL2
		inc di
		DAL2:

		push cx
		
		mov ax,word ptr[si]
		mov bx,word ptr[si+8]
		cmp ax,[si+4]
		ja X2ttX1
		add ax,bx
		inc ax
		sub ax,cx
		jmp X1ttX2
		
		X2ttX1:
			sub ax,bx
			dec ax
			add ax,cx
		
		X1ttX2:
		
		mov cx,ax
		mov ah,0ch
		mov al,byte ptr[si+12]
		mov dx,di
		mov bh,0
		int 10h
		
		cmp dx,bp
		je DALEJ2
			
			cmp dx,word ptr [si+6]
			jbe DALEJ2
				inc dx
				int 10h
				mov bp,dx
				dec bp
				jmp DALEJ2
							

		

		DALEJ2:
		
		pop cx
		dec cx
		cmp cx,0
	
	jne  PETLA2
	jmp KONIEC

	
  X2_X1:
	pop si
	mov di,si
	add di,6
	push si
	add si,2
	mov ax,word ptr[si]
  	mov bx,word ptr[di]
  	cmp ax,bx
	jb FUN1
	jmp FUN2   
  
YX:
  pop si
  mov bp,word ptr[si]
  mov di,si
  add di,6
  push si
  add si,2	 
  mov ax,word ptr[si]
  mov bx,word ptr[di]
  cmp ax,bx
  ja Y2_Y1
  pop si
  mov di,si
  push si
  add di,4
  mov ax,word ptr[si]
  mov bx,word ptr[di]
  cmp ax,bx
  jb FUN4

  Fun3:
	pop si
	mov di,si
	mov cx,word ptr[si+10]
	
	
	PETLA3:
		
		mov edx,0
		mov eax,0
		mov ax,word ptr[si+2]
		mov ebx,0
		mov bx,word ptr[si+8]
		mul ebx	
		mov edi,eax
		mov eax,0
		mov ax,word ptr[si]
		mov ebx,0
		mov bx,word ptr[si+10]
		mov edx,0
		mul ebx
		add eax,edi
		mov edi,eax
		mov eax,0
		mov edx,0
		mov ebx,0
		
		mov ax,word ptr[si+2]
		mov bx,word ptr[si+10]
		cmp ax,[si+6]
		ja Y2toY1
		add ax,bx
		inc ax
		sub ax,cx
		jmp Y1toY2
		
		Y2toY1:
			sub ax,bx
			dec ax
			add ax,cx
		
		Y1toY2:
		
		mov bx,word ptr[si+8]
		mul ebx
		sub edi,eax
		mov ebx,0
		mov bx,word ptr[si+10]
		mov edx,0
		mov eax,edi
		div bx
		mov di,ax
		mov ax,bx
		mov bl,2
		push dx
		mov dx,0
		div bx	
		pop dx
		cmp dx,ax
		jb DAL3
		inc di
		DAL3:

		push cx
		
		mov ax,word ptr[si+2]
		mov bx,word ptr[si+10]
		cmp ax,[si+6]
		ja Y2tY1
		add ax,bx
		inc ax
		sub ax,cx
		jmp Y1tY2
		
		Y2tY1:
			sub ax,bx
			dec ax
			add ax,cx
		
		Y1tY2:
		
		mov dx,ax
		mov ah,0ch
		mov al,byte ptr[si+12]
		mov cx,di
		mov bh,0
		int 10h
		
		cmp bp,cx
		je DALEJ3
			
			inc dx
			int 10h
			mov bp,cx	
		

		DALEJ3:
		
		pop cx
		dec cx
		cmp cx,0
	
	jne  PETLA3
	jmp KONIEC

  FUN4:  
	pop si
	mov di,si
	mov cx,word ptr[si+10]
	
	
	PETLA4:
		
		mov edx,0
		mov eax,0
		mov ax,word ptr[si]
		mov ebx,0
		mov bx,word ptr[si+10]
		mul ebx	
		mov edi,eax
		mov eax,0
		mov ax,word ptr[si+2]
		mov ebx,0
		mov bx,word ptr[si+8]
		mov edx,0
		mul ebx
		sub edi,eax
		mov eax,0
		mov edx,0
		mov ebx,0
		
		mov ax,word ptr[si+2]
		mov bx,word ptr[si+10]
		cmp ax,[si+6]
		ja Y2ttoY1
		add ax,bx
		inc ax
		sub ax,cx
		jmp Y1ttoY2
		
		Y2ttoY1:
			sub ax,bx
			dec ax
			add ax,cx
		
		Y1ttoY2:
		
		mov bx,word ptr[si+8]
		mul ebx
		add edi,eax
		mov ebx,0
		mov bx,word ptr[si+10]
		mov edx,0
		mov eax,edi
		div bx
		mov di,ax
		mov ax,bx
		mov bl,2
		push dx
		mov dx,0
		div bx	
		pop dx
		cmp dx,ax
		jb DAL4
		inc di
		DAL4:

		push cx
		
		mov ax,word ptr[si+2]
		mov bx,word ptr[si+10]
		cmp ax,[si+6]
		ja Y2ttY1
		add ax,bx
		inc ax
		sub ax,cx
		jmp Y1ttY2
		
		Y2ttY1:
			sub ax,bx
			dec ax
			add ax,cx
		
		Y1ttY2:
		
		mov cx,di
		mov dx,ax
		mov ah,0ch
		mov al,byte ptr[si+12]
		mov bh,0
		int 10h
		
		cmp bp,cx
		je DALEJJ3
			
			dec dx
			int 10h
				
		

		DALEJJ3:
		
		pop cx
		dec cx
		cmp cx,0
	
	jne  PETLA4
	jmp KONIEC

	
  Y2_Y1:
	pop si
	mov di,si
	add di,4
	push si
	mov ax,word ptr[si]
  	mov bx,word ptr[di]
  	cmp ax,bx
	jb FUN3
	jmp FUN4   









KONIEC:

POPAD
RET

line endp




Flood proc

pushad
mov si,di
mov ah,0dh
mov bh,0
mov cx,(wsp1 ptr[di]).x
mov dx,(wsp1 ptr[di]).y
int 10h
mov ah,0h				
mov bp,ax
mov bx,0	
inc cx
push bx
push cx
push dx

LW1:
	pop dx
	pop cx
	mov ah,0dh
	mov bh,0
	dec cx
	int 10h
	mov ah,0h
	cmp ax,bp
	jne PR
	push cx
	push dx

	dec cx
	mov ah,0dh
	mov bh,0h
	int 10h
	inc cx
	mov ah,0h
	cmp ax,bp
	je SGR2
	pop dx
	pop cx
	pop bx
	mov bx,1
	push bx
	push cx
	push dx
	jmp SGR1
	
	PR:
		mov cx,(wsp1 ptr[di]).x
		mov dx,(wsp1 ptr[di]).y
		pop bx
		mov bx,0
		push bx
		push cx
		push dx
		jmp PR1
			
	
	GR1:

		mov ah,0dh
		mov bh,0
		int 10h
		mov ah,0h
		cmp ax,bp	
		jne DL1
	SGR1:
		mov ax,dx
		pop dx
		pop cx
		pop bx
		push bx
		push cx
		push dx
		mov dx,ax
		cmp bx,0
		je SGR2
		add si,5
		mov word ptr(wsp1 ptr[si]).x,cx
		mov word ptr(wsp1 ptr[si]).y,dx
		
		
		

		
	SGR2:
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		mov bh,0h
		int 10h
		dec dx
		jmp GR1
	DL1:
		add si,5
		inc dx
		mov word ptr(wsp1 ptr[si]).x,cx
		mov word ptr(wsp1 ptr[si]).y,dx
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		mov bh,0h
		int 10h
		pop dx
		push dx
	
	PTL1:
		
		mov ah,0dh
		mov bh,0
		inc dx
		int 10h
		mov ah,0h
		cmp ax,bp	
		jne Zap1

		mov ax,dx
		pop dx
		pop cx
		pop bx
		push bx
		push cx
		push dx
		mov dx,ax
		cmp bx,0
		je SDL1
		add si,5
		mov word ptr(wsp1 ptr[si]).x,cx
		mov word ptr(wsp1 ptr[si]).y,dx
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		mov bh,0h
		int 10h
		jmp PTL1	

	SDL1:
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		int 10h
		jmp PTL1
	Zap1:
		add si,5
		dec dx
		mov word ptr(wsp1 ptr[si]).x,cx
		mov word ptr(wsp1 ptr[si]).y,dx
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		mov bh,0h
		int 10h
		jmp LW1
	
PR1:

	pop dx
	pop cx
	mov ah,0dh
	mov bh,0
	inc cx
	int 10h
	mov ah,0h
	cmp ax,bp
	jne SPr8
	push cx
	push dx
	inc cx
	mov ah,0dh
	mov bh,0h
	int 10h
	dec cx
	mov ah,0h
	cmp ax,bp
	je SGR4
	pop dx
	pop cx
	pop bx
	mov bx,1
	push bx
	push cx
	push dx
	jmp SGR3


	GR2:
	
		mov ah,0dh
		mov bh,0
		int 10h
		mov ah,0h
		cmp ax,bp	
		jne DL2
	SGR3:	
	
		mov ax,dx
		pop dx
		pop cx
		pop bx
		push bx
		push cx
		push dx
		mov dx,ax
		cmp bx,0
		je SGR4
		add si,5
		mov word ptr(wsp1 ptr[si]).x,cx
		mov word ptr(wsp1 ptr[si]).y,dx
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		mov bh,0h
		int 10h
		dec dx
		jmp GR2
		
		
	SGR4:
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		int 10h
		dec dx
		jmp GR2


	DL2:	
		add si,5
		inc dx
		mov word ptr(wsp1 ptr[si]).x,cx
		mov word ptr(wsp1 ptr[si]).y,dx
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		mov bh,0h
		int 10h
		pop dx
		push dx
	PTL2:

		mov ah,0dh
		mov bh,0
		inc dx
		int 10h
		mov ah,0h
		cmp ax,bp
		jne Zap2


		mov ax,dx
		pop dx
		pop cx
		pop bx
		push bx
		push cx
		push dx
		mov dx,ax
		cmp bx,0
		je SDL2
		add si,5
		mov word ptr(wsp1 ptr[si]).x,cx
		mov word ptr(wsp1 ptr[si]).y,dx
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		mov bh,0h
		int 10h	
		jmp PTL2

	SDL2:
		
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		int 10h
		jmp PTL2

	Zap2:
		add si,5
		dec dx
		mov word ptr(wsp1 ptr[si]).x,cx
		mov word ptr(wsp1 ptr[si]).y,dx
		mov ah,0ch
		push di
		mov di,offset pxls
		mov al,(wsp1 ptr[di]).kol
		pop di
		mov bh,0h
		int 10h	
		pop dx
		push dx
		jmp PR1



Spr8:
	pop bx
	mov bx,0
	push bx
	add di,5
	mov word ptr cx,(wsp1 ptr[di]).x
	mov word ptr dx,(wsp1 ptr[di]).y
	cmp cx,-1
	je Kon8
	
sprg:
	dec dx
	mov ah,0dh
	mov bh,0h
	int 10h
	mov ah,0h
	mov (wsp1 ptr[di]).x,cx
	mov (wsp1 ptr[di]).y,dx
	inc cx
	push cx
	push dx
	cmp ax,bp
	je LW1
sprp:	
	pop dx
	pop cx
	dec cx
	inc dx
	inc cx
	mov ah,0dh
	mov bh,0h
	int 10h
	mov ah,0h
	mov (wsp1 ptr[di]).x,cx
	mov (wsp1 ptr[di]).y,dx
	inc cx
	push cx
	push dx
	cmp ax,bp
	je LW1
	
sprd:
	pop dx
	pop cx
	dec cx
	dec cx
	inc dx
	mov ah,0dh
	mov bh,0h
	int 10h
	mov ah,0h
	mov (wsp1 ptr[di]).x,cx
	mov (wsp1 ptr[di]).y,dx
	inc cx
	push cx
	push dx
	cmp ax,bp
	je LW1
	
sprl:
	pop dx
	pop cx
	dec cx
	dec dx
	dec cx
	mov ah,0dh
	mov bh,0h
	int 10h
	mov ah,0h
	mov (wsp1 ptr[di]).x,cx
	mov (wsp1 ptr[di]).y,dx
	inc cx
	push cx
	push dx
	cmp ax,bp
	je LW1

pop dx
pop cx
jmp Spr8	

Kon8:
	pop bx
	mov di,offset wsp2
	mov [di+2],bx
	call licz16_out 	
	popad

	RET
Flood endp



licz16_out proc
PUSHA
mov ax,word ptr[di+2]
cmp ax,0 
jne Wykonaj

mov ah,02h
mov dl,byte ptr[di]
mov dh,byte ptr[di+1]
mov bh,0
int 10h

mov ah,09h
mov al,'0'
mov cx,1
mov bh,0
mov bl,13
int 10h

jmp Koniec

Wykonaj:
	mov bp,0
	mov cx,5
	mov bx,10000
	mov dx,0

	Dziel:	
		div bx
		PUSH dx
		cmp ax,0 
		je Dalej
		or ax,3030h
		
		push cx
		push bx
		push ax
		mov ah,02h
		mov dx,0
		mov dl,byte ptr[di+1]
		add dx,bp
		mov dh,byte ptr[di]
		mov bh,0
		int 10h
		pop ax
		mov ah,09h
		mov cx,1
		mov bh,0
		mov bl,13
		int 10h
		pop bx
		pop cx	
		inc bp
		
		Dalej:
	
			mov ax,bx
			mov bx,10
			mov dx,0	
			div bx
			mov bx,ax
			POP dx
			mov ax,dx
			mov dx,0
	

	
	LOOP Dziel
		
Koniec:

POPA
RET
licz16_out endp





end