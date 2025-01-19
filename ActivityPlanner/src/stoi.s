
.section .data

.section .text
  .global stoi

.type stoi, @function

stoi:

  movl 4(%esp), %esi       # popl %esi -- popl %esi
  movl $0, %eax
  movl $0, %ecx            # azzero il contatore
  movl $0, %ebx            # azzero il registro EBX


ripeti:

  # movb (%esi), %al
  movb (%ecx,%esi,1), %bl  # "43\n4\n3\n5\n"  inizio: %esi -> 4      %bl=52

  cmp $13, %bl             # vedo se è stato letto il carridge return '\r\n'
  je substitution

back:
  cmp $10, %bl             # vedo se e' stato letto il carattere '\n' 
  je fine

  subb $48, %bl            # converte il codice ASCII della cifra nel numero corrisp. %bl=52-48=4
  movl $10, %edx
  mulb %dl                # EBX = EBX * 10    EBX=4*10=40
  addl %ebx, %eax         

  inc %ecx
  jmp ripeti

substitution:

  movb $10, (%ebx)
  jmp back

fine:
  # il risultato si trova in EAX
    
    ret
