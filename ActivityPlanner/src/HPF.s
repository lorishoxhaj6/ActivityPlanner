# HPF (Highest Priority First). 
# Si pianificano i prodotti con la priorità più alta. 
# In caso di parità: si pianifica il prodotto con la scadenza più vicina.

.section .data

	cont: .int 0

.section .text
	.global HPF
	
.type HPF, @function

HPF:
	mov %ecx, cont
	movl $1, %ecx	# flag=1
	movl $1, %edi 	# j=1
	
	movl 4(%esp), %esi
	
ciclo_esterno:
	cmp $1, %ecx
	jne fine_cicli
	
	mov cont, %ecx
	cmp %ecx, %edi
	jge fine_cicli
	
	movl $0, %ecx	# prima di entrare nel ciclo interno abbasso il flag = 0 --> no spostamenti
	
	movl $0, %edx	# k=0, per scorrere l'array
	
	jmp ciclo_interno
	
ciclo_interno:
	movl cont, %eax	# pongo temporaneamente in EAX il numero totale di prodotto (numero di righe)
	
	subl %edi, %eax
	
	cmp %edx, %eax
	
	jle incremento_j
	
	xorl %eax, %eax
	
	movl (%esi, %edx, 4), %eax	# prendo il k valore dell'array e lo metto in EAX
	
	incl %edx
	
	movl (%esi, %edx, 4), %ebx	# prendo il k+1 valore dell'array e lo metto in EBX
	
	cmpb %al, %bl			# confronto le priorità memorizzate in ah e bh
	
	je priorita_uguale			# se le scadenze sono uguali passo al confronto delle priorità
	
	jg scambio_valori		# se l'elemento (k+1)esimo è maggiore del k-esimo, scambio i valori
	
	jmp ciclo_interno		# continuo il ciclo fino a quando k < N-j
	
incremento_j:
	incl %edi			# quando ho passato tutto l'array incremnto j ad ogni cilo
	
	jmp ciclo_esterno		# ritorno al ciclo esterno (while)
	
priorita_uguale:
	cmpb %ah, %bh			# se anche le scadenze (oltre alle priorità) sono =, allora non faccio niente
	
	jl scambio_valori		# se invece la scadenze di EBX < EAX, allora scambio i valori
	
	jmp ciclo_interno
	
scambio_valori:
	decl %edx
	
	movl %ebx, (%esi, %edx, 4)
	
	incl %edx
	
	movl %eax, (%esi, %edx, 4)
	
	movl $1, %ecx		# rimetto il flag=1 perchè ci sono stati spostamenti --> perciò bisogna ricontrollare tutto l'array - j posizioni perchè il massimo ad ogni ciclo lo abbiamo messo già in fondo all'array
	
	jmp ciclo_interno	# ritorno al ciclo interno

fine_cicli:
	ret
