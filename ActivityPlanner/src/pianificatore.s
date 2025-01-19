.section .data
    stampa_error_open_file:.ascii "E' stato riscontrato un errore durante l'apertura del file"
    stampa_error_open_file_length: .long .-stampa_error_open_file
    stampa_errori_input: .ascii "Sono stati riscontrati alcuni errori negli input immessi dall'utente"
    stampa_errori_input_length: .long .-stampa_errori_input
    stampa_errore1: .ascii "Sono stati inseriti piu' di 10 prodotti"
    stampa_errore1_length: .long .-stampa_errore1
    error: .byte 127
    lines: .int 0
    cont: .int 0
    buffer: .string "" 
    newline: .byte 10
    fd: .int 0
    virgola: .byte 44
    stringa: .ascii "0000"
    parametro: .ascii ""

.section .bss
    .lcomm array, 40 # inizializzo array di 40 byte 4 byte --> per riga ---> max 10 prodotti = max 10 righe
    
.section .text

.global _start

_start:

             
    popl %ebx
    popl %ebx  
    popl %ebx                          # apertura del file con passaggio da parametro

   # movl %ebx, parametro
apertura_file: 

    mov $5, %eax  
   # mov parametro, %ebx     
    mov $0, %ecx
    int $0x80

    cmp $0, %eax
    jl error_open  # raggiunto EOF

    mov %eax, fd            # ottengo da eax fd
        
    leal stringa, %esi      #                                  input:                       output:
read_loop:                  # loop per la lettura del file     buffer: 4,4,3,5\n           string:"4\n4\n3\n5\n"
                                                        
    mov $3, %eax                
    mov fd, %ebx
    mov $buffer, %ecx           # dove vengono scritti i valori letti
    mov $1, %edx
    int $0x80


    cmp $0, %eax                # se 0 raggiunto EOF         
    jle lettura_corretta                 # ho finito lettura del file -> vado a chiuderlo
    

    # controllo se ho una nuova linea
    movb buffer, %al
    cmpb newline, %al
    jne compila
    incw lines              # se ho una nuova linea incremento il contatore di righe
    
    
    cmpl $11, lines
    jge errore1

compila:
    cmpb virgola, %al       
    jne controlla_a_capo    # se non è una virgola controllo se è un \n
    movb $10, (%esi)        # se invece è una virgola metto un \n al suo posto
    jmp fine_compila        

controlla_a_capo:
    cmpb newline, %al       
    jne metto_numero        # se non è un \n e neanche una virgola --> è un numero, perciò andiamo ad inserirlo nella stringa
    movb $10, (%esi)        # se invece è \n vado a sostituire \n -> \n
    jmp fine_str       # ho visto che è \n -> sono a fine riga lo mando alla memorizzazione del primo struct

metto_numero:
    movb %al, (%esi)        # superata la fase di check metto il numero in .string "" e incremento il suo indirizzo così da puntare
    incl %esi               # al carattere dopo
    jmp read_loop     

fine_compila:

leal stringa, %esi
pushl %esi
call stoi
popl %esi
pushl %eax
jmp read_loop

fine_str:
leal stringa, %esi
pushl %esi
call stoi
popl %esi
pushl %eax
call struct
cmp $1, %ecx
je fclose
popl %edx
popl %edx
popl %edx           # svuoto gli elementi che sono andati a finire nello struct
popl %edx
# pushl %eax          inserisco lo struct nella pila
incw cont

movl cont, %ebx
dec %ebx
movl $array, %edx
movl %eax, (%edx, %ebx, 4)

jmp read_loop

    error_open:

    mov $4, %eax
    mov $2, %ebx
    mov $stampa_error_open_file, %ecx
    mov stampa_error_open_file_length, %edx
    int $0x80

    jmp fclose
    
    errore1:

    mov $4, %eax
    mov $2, %ebx
    mov $stampa_errore1, %ecx
    mov stampa_errore1_length, %edx
    int $0x80

    jmp fclose

lettura_corretta:


    menu:
                            # dopo che è stato stampato una volta l'array è corretto e ordinato corettamente
        call manuale


        pushl %ecx
        call stoi
        popl %ecx

        mov %eax, %ecx
        cmp $1, %ecx
        je algoritmo1
        cmp $2, %ecx
        je algoritmo2
        cmp $3, %ecx
        je fclose

        jmp fclose

    algoritmo1:

        
        mov cont, %ecx
        pushl $array
        call EDF
        popl %ecx
        jmp stampa

    algoritmo2:
        
        mov cont, %ecx
        pushl $array
        call HPF
        popl %ecx
        jmp stampa

    stampa:

        mov cont, %ecx
        pushl $array
        call stampante
        popl %ecx

        jmp menu

    fclose:
        mov $6, %eax
        mov fd, %ecx
        int $0x80

    exit:
    mov $1, %eax
    xorl %ebx, %ebx
    int $0x80
