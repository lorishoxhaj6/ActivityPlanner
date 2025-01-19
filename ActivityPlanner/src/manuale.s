.section .data

testo:
	.ascii "\n\t\tSOTWARE PER LA PRODUZIONE DI 10 PRODOTTI\n\n"

testo_len:
	.long . - testo

spiegazione:
	.ascii "Benvenuto/a...questa breve introduzione ha il solo scopo di dare una piccola spiegazione sulle scelte che ti verranno proposte.\nSe verrà digitato il numero 1, verrà selezionato l'algoritmo EDF ovvero Earliest Deadline First --> si ordina la produzione in base alla scadenza più vicina.\nSe verrà selezionato il numero 2, verrà selezionato l'algoritmo HPF ovvero Highest Priority First --> si ordina la produzione in base alla priorità più alta.\nse verrà digitato 3 il programma terminerà.\n\n"

spiegazione_len:
	.long . - spiegazione

titolo:
	.ascii "Digitare la tua scelta:\n"

titolo_len:
	.long . - titolo

menu1:
	.ascii "\n 1-Algoritmo EDF\n"

menu1_len:
	.long . - menu1

menu2:
	.ascii " 2-Algoritmo HPF\n"

menu2_len:
	.long . - menu2

menu3:
	.ascii " 3-Termina\n\n"

menu3_len:
	.long . -menu3

scelta:
	.ascii "Scelta --> "

scelta_len:
	.long . - scelta

scelta_num:
	.ascii "0\n\n"

scelta_num_len:
	.long . - scelta_num

.section .text
	.global manuale

.type manuale @function

manuale:
	movl $4, %eax
	movl $1, %ebx
	leal testo, %ecx
	movl testo_len, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	leal spiegazione, %ecx
	movl spiegazione_len, %edx
	int $0x80
	
	movl $4, %eax
	movl $1, %ebx
	leal titolo, %ecx
	movl titolo_len, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	leal menu1, %ecx
	movl menu1_len, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	leal menu2, %ecx
	movl menu2_len, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	leal menu3, %ecx
	movl menu3_len, %edx
	int $0x80

	movl $4, %eax
	movl $1, %ebx
	leal scelta, %ecx
	movl scelta_len, %edx
	int $0x80

	movl $3, %eax
	movl $1, %ebx
	leal scelta_num, %ecx
	movl scelta_num_len, %edx
	int $0x80

ret
