🛠️ Laboratorio di Architettura degli Elaboratori
Elaborato Assembly - A.A. 2023/2024
Benvenuti nel progetto per la pianificazione delle attività di un sistema produttivo! Questo README ti guiderà attraverso i dettagli del progetto, l'uso del software e la struttura dei file.

📝 Descrizione del Progetto
Il progetto consiste nello sviluppo di un programma in Assembly per gestire la pianificazione delle attività di un sistema produttivo.
L'obiettivo è schedulare la produzione di 10 prodotti nei successivi 100 slot temporali, minimizzando eventuali penalità dovute a ritardi.

Ogni prodotto è descritto da:

Identificativo (1-127)
Durata (1-10 slot temporali)
Scadenza (1-100)
Priorità (1-5)
💡 Penalità: Per ogni unità di tempo di ritardo, la penalità è calcolata come priorità × ritardo.

🚀 Come Utilizzare il Programma
Esecuzione
Esegui il programma specificando il file degli ordini:

bash
Copia
Modifica
pianificatore <percorso del file degli ordini>
Esempio:

bash
Copia
Modifica
pianificatore Ordini.txt
Puoi anche specificare un file di output per salvare i risultati:

bash
Copia
Modifica
pianificatore Ordini.txt Pianificazione.txt
Menu Principale
Dopo aver caricato gli ordini, il programma ti chiederà di scegliere un algoritmo di pianificazione:
1️⃣ Earliest Deadline First (EDF)
2️⃣ Highest Priority First (HPF)

Inserisci il numero corrispondente all'algoritmo desiderato.

📂 Struttura del Progetto
Ecco come è organizzata la cartella del progetto:

python
Copia
Modifica
VRXXXXXX_VRXXXXXX/
├── src/          # Codice sorgente
├── obj/          # File oggetto (vuoto inizialmente)
├── bin/          # File eseguibili (vuoto inizialmente)
├── Makefile      # Script di compilazione
├── Ordini/       # File di input per i test
│   ├── EDF.txt   # Penalità 0 con EDF
│   ├── HPF.txt   # Penalità 0 con HPF
│   ├── Both.txt  # Penalità 0 con entrambi gli algoritmi
│   ├── None.txt  # Penalità >0 con entrambi gli algoritmi
├── Relazione.pdf # Documentazione del progetto
📊 Output Atteso
Dopo aver scelto un algoritmo, il programma stamperà:

Ordine di pianificazione (formato: ID:Inizio)
Conclusione: l'unità di tempo in cui termina la produzione.
Penalty: la somma delle penalità totali.
Esempio con EDF:

makefile
Copia
Modifica
Pianificazione EDF:  
4:0  
12:10  
Conclusione: 17  
Penalty: 0  
Esempio con HPF:

makefile
Copia
Modifica
Pianificazione HPF:  
12:0  
4:17  
Conclusione: 17  
Penalty: 20  
🛠️ Compilazione
Per compilare il progetto, usa il comando:

bash
Copia
Modifica
make
Il file eseguibile sarà salvato nella cartella bin/.
