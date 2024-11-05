# B.Sc. Inventuren und angewandte Geomatik
## Allgemeine Infos zum Kurs
https://campus.uni-freiburg.de:443/qisserver/pages/startFlow.xhtml?_flowId=detailView-flow&unitId=103312&periodId=2483&navigationPosition=examEventOverviewOwn

Start 16.10.24

**Mi: 10-12 Uhr (HS 3118 KGIII) + 14:00-16:00 (HS HH5 → Kristallographie - nur bei Bedarf und Ankündigung)**

- Laptop mitbringen. Falls nicht vorhanden im Team
- Qgis (3.34 LTR version!) und Rstudio installieren

Hier im Github finden sie alle unterlagen zum Kurs. Die Themen sind durchnummeriert und bekommen wöchentlich einen neuen Ordner + Nummer.
Generell wird es immer eine README.md Datei in jedem dieser Ordner geben,
worin sie auf github dann direkt sehen, worum es geht. Im Ordner "lecture" gibt es Folien und Vorlesungsmaterial, im Ordner "exercises"
gibt es dann die Übungen dazu zum herunterladen.

Also getreu dem Schema:
```
01_intro
-- lecture
-- -- beispielfolie.pdf
-- -- ...
-- exercise
-- -- übung_1
-- -- ...
-- README.md
```
--------------------

# News

## 06.11.2024 (Feldtag)

folder: 04_accuracy_inventory

### Feldtag (Max, Teja, Jon): 10:00-14:00 +-

- Nachbesprechung Feldübung Positionsbestimmung
- Besprechung Ungenauigkeit GPS (ca. 15 Minuten)
- Sammeln / Erfahrungen / Besprechung
- Vorbesprechung Inventur Mooswald am Nachmittag (1 Stunde)
- Jon Sheppard übernimmt (manche kennen ihn evtl. aus früheren Semestern)
- Briefing zum Vorgehen und Aufgaben
- Feldübung Inventur in Mooswald (Art, DBH, Position, …)
- Essen mitbringen
- Pro Plot 2-3 mal gemessen
- Festes Schuhwerk etc.
- Bildung mehrerer Studentengruppen
- Gruppen wechseln nach Inventur des Plots zum nächsten Plot, so dass mehrere Inventuren pro Plot zum Vergleich in der Nachbesprechung zur Verfügung sind (z.B. n=3 bei 3 Durchläufen). z.B. bei 8 Gruppen gibt es 8 Plots. Gruppe 1 startet bei 1, 2 bei 2, etc… danach geht Gruppe 1 zu 2, 2 zu 3, etc…

### Hausaufgabe

- Inventur-Metriken (z.B. Stammdichte, BHD, Grundfläche) berechnen und einsenden (z.B. Google-Sheet)

-----------------------

## 30.10.2024

folder: 03_gnss

## Block Vormittags (Thomas P.):

- Positionsbestimmung
- Einführung Satellitebasierte Positionsbetimmung
- Warum Positionsbestimmung für Inventuren wichtig?
- GPS, GLONASS, BEIDOU, GALILEO +
- GNSS Unsicherheiten und Einflussfaktoren
- Hemispähre, Nord, Süd, An welcher Himmelsseite Bäume messen?
- Abstand/Abschattung von Bäumen
- GNSS Unsicherheiten minimieren
- RTK, SAPOS, Rover, Base station, Postprocessing

## Block Nachmittags (Max): Feldübung!

- **Feldübung** zu GNSS
- Gruppen zu 2 Personen
    - Eine Person trackt, eine misst punkte ein (Rundlauf um schloßberg)
- Einführung in EmlidReach, Base, Rover (vor der Übung)

Was ihr braucht:

- **Wetterfeste Kleidung**
- Smartphone
- Avenza Maps App (bitte downloaden!)
- Unterlagen im Ordner 03_gnss/exercises

**Treffpunkt hinter dem Kanonenplatz (https://maps.app.goo.gl/1t6J6wnk2cSg4bkt7) pünktlich um 14:15 Uhr (bitte seid vorher da, damit wir direkt starten können).**

Grober Ablauf:

- Start 14:15
- ca. 15-20 Minuten Einführung in Emlid Reach Base und Rover
- Eigenständig den Rundlauf (ca. 1,5h) absolvieren und mittels Avenza Maps die Punkte und den Pfad tracken.
- Nach der Übung direkt die CSV und GPX online hochladen und Ergebnisse anschauen
- CSV und GPX an Max per Mail senden (als Backup falls die online App nicht funktionieren sollte)

--------------------------

folder (02_essentials)

## 23.10.2024: Block Vormittag (Thomas P.):

### Theorie bzw. Einführung Forstliche Inventuren

- Einführung Theorie Inventuren
- Warum Inventuren
- Terrestrische Inventuren
- Inventurdesign
- Inventurverfahren

## Block Nachmittag - Themen je nach Fortschritt (Thomas P., Max F.):

- Anwendung Inventurplanung
- Planung einer Inventur im GIS
- Ausgangslage Inventur für Forstbetrieb bzw. Privatwald mit vorgegebener Fläche
- Welches Inventurverfahren (Winkelzählprobe, etc…)?
- Bestimmung des Inventurumfangs (Anzahl der Stichproben/Plots)
- Positionierung der Inventurpunkte
- Regular grid
- Random samples
- Stratifizierung? (z.B. Nach Beständen/Waldtypen/Topographie)
