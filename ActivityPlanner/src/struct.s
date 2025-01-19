.section .data
	
messaggio_errore:
	.ascii "Errore!\nNumero sbagliato!\n"
	
messaggio_errore_len:
	.long . - messaggio_errore

.section .text
  .global struct

.type struct, @function

_errore:
	movl $4, %eax
	movl $2, %ebx
	leal messaggio_errore, %ecx
	movl messaggio_errore_len, %edx
	int $0x80
	
	mov $1, %ecx	# flag=1 --> c'è un numero sbagliato
	jmp fine

struct:
  # in eax c'è il numero --> decodificato da codifica ASCII
 xorl %ebx, %ebx
 xorl %eax, %eax 
 
 mov $0, %ecx	# pongo la variabile flag=0 (no errori) 
 
 
 mov 4(%esp), %al	# priorità
 cmpb $0, %al
 jle _errore
 cmpb $5, %al
 jg _errore
 
 mov 8(%esp), %ah	# scadenza
 cmpb $0, %ah
 jle _errore
 cmpb $100, %ah
 jg _errore
 
 
 mov 12(%esp), %bl	# durata
 cmpb $0, %bl
 jle _errore
 cmpb $10, %bl
 jg _errore
 
 shl $16, %ebx
 or %ebx, %eax
 xorl %ebx, %ebx
 mov 16(%esp), %bl
 cmpb $0, %bl
 jle _errore
 cmpb $127, %bl
 jg _errore
 
 shl $24, %ebx
 or %ebx, %eax

fine:
  # il risultato si trova in EAX
    
    ret
