.section .data

    inizio_produzione: .ascii "0\n"
    norma: .ascii "000:000"
    norma_length: .long .-norma
    durata: .long 0
    durata2: .long 0
    due_punti: .ascii ":"
    contatore: .int 0
    indice: .int 0
    newline: .ascii "\n"
   # array: .long 0
    stmp_conclusion: .ascii "Conclusione: "
    concl_length: .long .-stmp_conclusion
    penalty: .ascii "Penalty: "
    penalty_length: .long .-penalty
    penalita_num: .long 0
    scadenza: .long 0
    priorita: .long 0
    tmp: .long 0
.section .bss
    .lcomm array, 40

.section .text
.global stampante

.type stampante, @function

stampante:  
    mov 4(%esp), %esi              # carica indirizzo memoria dell'array 
    mov %ecx, contatore
    movl $0, indice
    movl $0, penalita_num
    xorl %edx, %edx
    xorl %eax, %eax
    xorl %ebx, %ebx
    
    mov %esi, array

    mov (%esi), %ebx                  # copio il prodotto in ebx per fare lo shif right e recuperare
    mov %bl, priorita
    mov %bh, scadenza
    sarl $16, %ebx
    movb %bl, durata                # prendo la durata 
    sarl $8, %ebx                   # vado a prendere l'id del prodotto
    pushl %ebx                      
    call itos
    popl %ebx

    mov %edx, tmp

    mov scadenza, %eax
    mov durata, %ebx
    cmp %ebx, %eax

    jl calcolo_penalita
    
post_penalita:
    
    movl $4, %eax
    movl $1, %ebx                   # stampa stringa convertita 
    movl tmp, %edx
    int $0x80

    movl $4, %eax
    movl $1, %ebx                    # stampa i due punti
    movl $due_punti, %ecx
    movl $1, %edx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    movl $inizio_produzione, %ecx              # stampa lo 0 di inizio produzione
    movl $2, %edx
    int $0x80

    decw contatore
    incw indice

stampe_ripetute:

    movl array, %esi
    movl indice, %edx
    movl (%esi, %edx, 4), %ebx
    movb %bl, priorita
    movb %bh, scadenza
    sar $16, %ebx
    movb %bl, durata2
    sar $8, %ebx
    pushl %ebx
    call itos
    popl %ebx


    movl $4, %eax
    movl $1, %ebx
    int $0x80

    movl $4, %eax
    movl $1, %ebx                    # stampa i due punti
    movl $due_punti, %ecx
    movl $1, %edx
    int $0x80

    movl durata, %ebx                # mi stampa la durata del prodotto prima della somma
    pushl %ebx                       
    call itos
    popl %ebx

    movl $4, %eax
    movl $1, %ebx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $1, %edx
    int $0x80

    
    mov durata, %eax
    mov durata2, %ebx
    addl %eax, %ebx
    mov %ebx, durata

    mov scadenza, %eax
    mov durata, %ebx
    cmp %ebx, %eax

    jl calcolo_penalita2
    
post_penalita2:
    incw indice
    decw contatore
    mov contatore, %ecx
    cmp $0, %ecx
    jne stampe_ripetute

conclusione:
    
    movl $4, %eax
    movl $1, %ebx
    movl $stmp_conclusion, %ecx
    movl concl_length, %edx
    int $0x80

    mov durata, %ebx
    pushl %ebx
    call itos
    popl %ebx

    mov $4, %eax
    mov $1, %ebx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $1, %edx
    int $0x80

    mov $4, %eax
    mov $1, %ebx
    mov $penalty, %ecx
    mov penalty_length, %edx
    int $0x80

    mov penalita_num, %ebx
    pushl %ebx
    call itos
    popl %ebx

    mov $4, %eax
    mov $1, %ebx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $1, %edx
    int $0x80

    jmp exit

calcolo_penalita2:

        subl %eax, %ebx             # eax->scadenza ebx->durata se durata>scadenza = ritardo -> ritardo*priorità
        mov %ebx, %eax
        mov priorita, %ebx
        mul %ebx

        movl penalita_num, %ebx
        addl %ebx, %eax
        movl %eax, penalita_num

        
    jmp post_penalita2

calcolo_penalita:

        subl %eax, %ebx             # eax->scadenza ebx->durata se durata>scadenza = ritardo -> ritardo*priorità
        mov %ebx, %eax
        mov priorita, %ebx
        mul %ebx

        movl penalita_num, %ebx
        addl %ebx, %eax
        movl %eax, penalita_num

    jmp post_penalita

exit:
    ret
