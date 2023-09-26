bits 64

section .data
    message db "Enter filename: ", 0
    message_len equ $-message

section .bss
	buffer resb 1024
	string resb 1024
	filename_len equ 256
	filename resb 256
	len equ $-buffer

section .text
    global _start

_start:

	mov rsi, message 
	mov rdx, message_len
    mov eax, 1              
    mov edi, 1            
    syscall 

	xor eax, eax
	xor edi, edi
	mov rsi, filename
	mov edx, filename_len
	syscall

	xor bl,bl
	mov [filename + eax - 1], bl

    mov eax, 2              
    mov rsi, 0              
    mov rdi, filename       
    syscall   

    cmp eax, 0
    jl exit       

    mov edi, eax
    mov rax, 0              
    mov rsi, buffer       
    mov rdx, len     
	syscall

	cmp eax, 0
	jl exit

	xor r9, r9               
	xor r10d, r10d            
	xor r11, r11            
	mov edi, buffer

	
process:
	mov bl, [buffer + r11]
	
	cmp bl, "a"
	je skip_letter
	cmp bl, "A"
	je skip_letter
	cmp bl, "e"
	je skip_letter
	cmp bl, "E"
	je skip_letter
	cmp bl, "y"
	je skip_letter
	cmp bl, "Y"
	je skip_letter
	cmp bl, "u"
	je skip_letter
	cmp bl, "U"
	je skip_letter
	cmp bl, "i"
	je skip_letter
	cmp bl, "I"
	je skip_letter
	cmp bl, "o"
	je skip_letter
	cmp bl, "O"
	je skip_letter
	
	mov al, [buffer + r11]
	mov [string + r9], al
	inc r9	
	inc r10
	

skip_letter:
	inc r11
	cmp byte [rdi + r11], 0
	jne process


close_file:
	mov eax, 3
	mov esi, edi
	syscall
		

print:
	mov rsi, string    
	mov edx, r10d
    mov eax, 1              
    mov edi, 1            
    syscall     


exit:
    xor rdi,rdi            
    mov rax, 60        
    syscall  
