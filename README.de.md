# Nachhilfe App

## Über

[[english]](https://github.com/FineFindus/NachHilfeApp#readme)

Eine App mit dessen Hilfe Schüler Nachhilfe suchen können. 
Die App soll mit Flutter programmiert werden, als Backend wird Firebase verwendet. Bei Problemen / Skalierungsproblemen wird auf einen eigenen Linux Server mit docker gewechselt.
Der Benutzer kann nach Nachhilfe suchen, andere sollen sich anschließen können, oder Nachhilfe geben können. Hierbei soll der Ersteller einen Benachrichtigung mit Firebase Push Services erhalten. Danach soll die Möglichkeit zu externen Kontakt bestehen (z.B. per Email).

## Zeitplanung

| Zeit (Woche) | Ziel                                                      |
|--------------|-----------------------------------------------------------|
| 4            | Einfache UI, Daten von Server empfangen                   |
| 10           | Funktionaler Backend-Server                               |
| 20           | Vollständige UI                                           |
| 25             | andere Funktionalitäten (Performance, Push-Services, etc) |
| ?           | Backend Server vervollständigen                                         |

## Aussehen
Eine Suche sollte folgende Informationen enthalten:
* Fach
* Thema (Auswahl von Liste, sontiges)
* Klassenstufe
* Ablaufdatum (automatisch löschen)
* Kontakt Möglichkeit (erst freigegeben bei Annahme)
* Name
* Ort?
