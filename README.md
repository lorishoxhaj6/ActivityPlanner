#  Laboratorio di Architettura degli Elaboratori
![Logo Università di Verona](https://www.univr.it/documents/20142/0/A-Logo_Univr_Rettore_2016-02.png/c6839c11-83c2-cec9-308e-828dc4b43620?t=1552921491487) 

**Progetto Universitario - Università degli Studi di Verona**  
_Corso di Architettura degli Elaboratori_  
_Autori: [Loris Hoxhaj, Mattia Nicolis]_  
## Elaborato Assembly - A.A. 2023/2024

Benvenuti nel progetto per la pianificazione delle attività di un sistema produttivo! Questo README ti guiderà attraverso i dettagli del progetto, l'uso del software e la struttura dei file.

---

##  Descrizione del Progetto

Il progetto consiste nello sviluppo di un programma in Assembly per gestire la pianificazione delle attività di un sistema produttivo.

### Obiettivo
Schedulare la produzione di 10 prodotti nei successivi 100 slot temporali, minimizzando eventuali penalità dovute a ritardi.

### Specifiche dei Prodotti
Ogni prodotto è descritto da:
- **Identificativo**: un numero compreso tra 1 e 127
- **Durata**: da 1 a 10 slot temporali
- **Scadenza**: compresa tra 1 e 100
- **Priorità**: da 1 a 5

### Penalità
Per ogni unità di tempo di ritardo, la penalità è calcolata come:
**Priorità × Ritardo**

---

##  Come Utilizzare il Programma

### Esecuzione
Per eseguire il programma, specifica il file degli ordini utilizzando il seguente comando:

```bash
pianificatore <percorso del file degli ordini>
```

#### Esempio:
```bash
pianificatore Ordini.txt
```

Puoi anche specificare un file di output per salvare i risultati:

```bash
pianificatore Ordini.txt Pianificazione.txt
```

### Menu Principale
Dopo aver caricato gli ordini, il programma ti chiederà di scegliere un algoritmo di pianificazione:
1. **Earliest Deadline First (EDF)**
2. **Highest Priority First (HPF)**

Inserisci il numero corrispondente all'algoritmo desiderato.

---

##  Struttura del Progetto

Ecco come è organizzata la cartella del progetto:

```
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
```

---

##  Output Atteso

Dopo aver scelto un algoritmo, il programma stamperà:
- **Ordine di pianificazione**: formato `ID:Inizio`
- **Conclusione**: l'unità di tempo in cui termina la produzione
- **Penalty**: la somma delle penalità totali

#### Esempio con EDF:
```
Pianificazione EDF:  
4:0  
12:10  
Conclusione: 17  
Penalty: 0
```

#### Esempio con HPF:
```
Pianificazione HPF:  
12:0  
4:17  
Conclusione: 17  
Penalty: 20
```

---

## 🛠️ Compilazione

Per compilare il progetto, utilizza il comando:

```bash
make
```

Il file eseguibile verrà salvato nella cartella `bin/`.

---

