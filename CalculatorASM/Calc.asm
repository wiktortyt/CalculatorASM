.386
.model flat,c
.code
CalculateByVar proc
	push ebp
	mov ebp,esp
	push ebx

	xor ecx,ecx ;ecx = result

	mov eax,[ebp+8] ;eax = n1
	mov ebx,[ebp+12] ;ebx = n2
	mov edx,[ebp+16] ;edx = op ,1=add,3=sub,0=mul
	
	cmp edx,1
	je addition
	cmp edx,3
	je subtraction
	cmp edx,0
	je multiplication
	jmp ending

addition:
	add ecx,eax
	add ecx,ebx
	jmp ending
subtraction:
	sub eax,ebx
	mov ecx,eax
	jmp ending
multiplication:
	imul eax,ebx
	mov ecx,eax
	jmp ending

ending:
	mov eax,ecx
	pop ebx
	pop ebp
	ret
CalculateByVar endp

.data
op1 dd 0
operation dd ?
op2 dd 0
.code

CalculateByString proc
	push ebp
	mov ebp,esp
	; format: operand(32 bit) operation operand(32 bit)
	xor eax,eax
	sub esp,4
	mov dword ptr[esp-4],1
	mov esi,[ebp+8] ;esi=source of string

@@:    ;loads first operand
	movzx eax,byte ptr [esi]
	sub eax,48 ; ascii code

	push eax
	push esi
	call CountPowerFactor
	pop esi
	mov ecx,eax ;ecx=result count power factor
	pop eax

	imul ecx ;multiply to shift left(1,10,100)
	add [op1],eax ;op1 contains operand1
	inc esi
	movzx ebx,byte ptr[esi]
	cmp ebx,32 ;check if next byte is space

	jne @B
	inc esi
	xor eax,eax
	lodsb
	sub eax,42 ;subtract ascii code, 0=multiply,1=addition,3=subtraction
	mov [operation],eax

	inc esi ;omits space
	xor eax,eax
	
	xor edx,edx
	mov dword ptr[esp-4],1

@@:    ;loads second operand
	movzx eax,byte ptr [esi]
	sub eax,48 ; ascii code

	push eax
	push esi
	call CountPowerFactor
	pop esi
	mov ecx,eax ;ecx=result count power factor
	pop eax

	imul ecx ;multiply to shift left(1,10,100)
	add [op2],eax ;op1 contains operand1
	inc esi
	movzx ebx,byte ptr[esi]
	cmp ebx,0 ;check if next byte is space

	jne @B

	add esp,4
	push operation
	push op2
	push op1

	call CalculateByVar
	add esp,12
	pop ebp
	ret
CalculateByString endp

CountPowerFactor proc ;function counts power factor (1,10,100,1000) from number literal
	push ebp
	mov ebp,esp
	push esi
	xor edx,edx
	mov ecx,1 ;powerFactor
	
	mov esi,[ebp+8] ;esi=pointer to string with number
start:
	
	mov dl,byte ptr[esi+1] ;next char
	cmp edx,32 ;in string ends go to end(space is 32 and string ends with 0)
	ja @F
	jmp ending
@@:
	inc esi
	imul ecx,10 ;incerase power factor
	jmp start

ending:
	mov eax,ecx
	pop esi
	pop ebp
	ret
CountPowerFactor endp
end
