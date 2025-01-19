# README: Laboratorio di Architettura degli Elaboratori

## Descrizione del Progetto
Questo progetto consiste nello sviluppo di un software per la pianificazione delle attività di un sistema produttivo. L'obiettivo è schedulare la produzione di un massimo di 10 prodotti nelle successive 100 unità di tempo ("slot temporali"), considerando parametri come identificativo, durata, scadenza e priorità di ciascun prodotto.

Il software è realizzato in Assembly e prevede l'implementazione di due algoritmi di pianificazione:
1. **Earliest Deadline First (EDF):** prioritizza i prodotti con la scadenza più vicina.
2. **Highest Priority First (HPF):** prioritizza i prodotti con la priorità più alta.

Il programma calcola inoltre eventuali penalità per ritardi nella produzione e consente di salvare i risultati della pianificazione su file.

## Requisiti di Esecuzione
- **Input:** File degli ordini con massimo 10 righe, ciascuna contenente 4 valori separati da virgole:
  - Identificativo (1-127)
  - Durata (1-10)
  - Scadenza (1-100)
  - Priorità (1-5)

- **Output:**
  - Pianificazione dei prodotti (ID e slot di inizio produzione)
  - Tempo di completamento della produzione
  - Penalità totale (se applicabile)

- **Comando di Esecuzione:**
  ```bash
  pianificatore <percorso del file degli ordini> [<percorso del file di output>]
  ```
  Esempio:
  ```bash
  pianificatore Ordini.txt Pianificazione.txt
  ```

## Struttura della Cartella
La struttura della cartella è organizzata come segue:

```
VRXXXXXX_VRXXXXXX/
├── src/                  # Contiene il codice sorgente
├── obj/                  # Vuota; conterrà i file oggetto
├── bin/                  # Vuota; conterrà il file binario eseguibile
├── Makefile             # Per compilare il progetto
├── Ordini/               # Contiene file di test per gli algoritmi
│   ├── EDF.txt        # Penalità zero con EDF
│   ├── HPF.txt        # Penalità zero con HPF
│   ├── Both.txt       # Penalità zero con entrambi gli algoritmi
│   └── None.txt       # Penalità maggiore di zero con entrambi gli algoritmi
└── Relazione.pdf         # Descrizione dettagliata del progetto
```

## Procedura di Compilazione
1. Posizionarsi nella directory principale del progetto.
2. Eseguire il comando:
   ```bash
   make
   ```
   Questo comando compila il progetto e genera il file binario nella cartella `bin/`.

## Utilizzo del Software
1. Creare un file di ordini nella directory `Ordini/` seguendo la sintassi:
   ```
   ID,Durata,Scadenza,Priorità
   ```
   Esempio:
   ```
   4,10,12,4
   12,7,32,1
   ```
2. Eseguire il programma specificando il file di input:
   ```bash
   ./bin/pianificatore Ordini/EDF.txt
   ```
3. Per salvare i risultati su file, specificare un secondo parametro:
   ```bash
   ./bin/pianificatore Ordini/EDF.txt Pianificazione_EDF.txt
   ```

## Output
Il programma genera l'output nel seguente formato:
```
Pianificazione [Algoritmo]:
ID:Inizio
...
Conclusione: [Tempo]
Penalty: [Valore]
```
Esempio di output per EDF:
```
Pianificazione EDF:
4:0
12:10
Conclusione: 17
Penalty: 0
```

## Test e Validazione
La cartella `Ordini/` contiene file di test che verificano i seguenti scenari:
- **EDF.txt:** Penalità zero con EDF, maggiore di zero con HPF.
- **HPF.txt:** Penalità zero con HPF, maggiore di zero con EDF.
- **Both.txt:** Penalità zero con entrambi gli algoritmi.
- **None.txt:** Penalità maggiore di zero con entrambi gli algoritmi.

## Relazione
La relazione tecnica è fornita nel file `Relazione.pdf`. Essa descrive:
- La struttura del codice e delle funzioni.
- La logica degli algoritmi di pianificazione implementati.
- I test effettuati e i risultati ottenuti.
