# Anleitung: Nutzung von Avenza Maps für Pfadtracking und Punktmessung und Verarbeitung in QGIS

## 1. Installation und Einrichtung von Avenza Maps

- App herunterladen: Laden Sie die App Avenza Maps aus dem App Store (iOS) oder Google Play Store (Android) herunter und installieren Sie sie.
- Registrierung: Optional können Sie ein Konto bei Avenza erstellen, um Ihre Daten synchronisieren zu können. Dies ist für unsere Zwecke **nicht** erforderlich.

## 2. Import einer Ebene in Avenza Maps

- Öffnen Sie Avenza Maps.
- Tippen Sie oben rechts auf das ‘+’-Symbol und wählen "Ebenen importieren".
- Wählen Sie die Datei aus (in unserem Fall "03_gnss"), und sie wird in Avenza Maps importiert.
- als aktive Ebene festlegen
    - gehen sie nun auf "Basiskarte öffnen"
    - gehen sie unten rechts auf das layer-symbol
    - dann wählen sie mit den 3 Punkten bei der Ebene "03_gnss" "als aktive Ebene festlegen" aus
- Die Ebene sollte nun in Ihrer Basiskarte angezeigt werden.

## 3. Pfadtracking mit Avenza Maps

**Tracking starten:**

- Stellen Sie sicher, dass Ihr GPS aktiviert ist.
- Tippen Sie auf das Messsymbol unten links und wählen GPS tracks messen aus.
- dann können sie einen track starten. Diesen lassen Sie aktiv, bis die Übung zuende ist :)
- Die App beginnt nun, Ihren Standort zu verfolgen und den Pfad auf der Karte aufzuzeichnen.
- Achten Sie darauf, sich stets auf dem vorgegebenen Weg zu bewegen (z.B. immer auf der rechten Seite des Weges).
- Der aufgezeichnete Pfad wird als Linie auf der Karte dargestellt.

**Tracking beenden:**

Sobald Sie den Rundweg beendet haben, tippen Sie erneut auf das Track-Symbol und wählen Stop Tracking.
Der Pfad wird nun als abgeschlossenes Element gespeichert.

## 4. Einmessen von Punkten

**Punkt einfügen:**

- Tippen Sie während des Rundlaufs auf die Pin-Nadel-Schaltfläche unten rechts, um einen neuen Punkt auf der Karte zu speichern.
- Ihre aktuelle Position wird automatisch als Punkt markiert.
- Punkte benennen:
    - Nach dem Einfügen des Punktes können Sie ihn benennen, z.B. A, B usw.
    - Beschreibung hinzufügen (optional): Fügen Sie eine Beschreibung oder Notizen zum Punkt hinzu, falls nötig (z.B. "Weggabelung" oder "Aussichtspunkt").
    - Attribut bedeckungsgrad: wenn sie ganz nach unten scrollen, sollten sie dort ein attributfeld namens "bedeckungsgrad" sehen. Dort wählen sie eine Zahl zw. 1 und 10 aus, das ungefähr den Bedeckungsgrad über ihnen widerspiegelt. Also wenn sie z.b. im Wald stehen unter vielen Bäumen, wäre 8-10 ein realistischer Wert. Unter freiem Himmel wohl eher eine 1-3, z.b.
    - speichern sie den Punkt und gehen anschließend zum nächsten!

## 5. Export der Daten

**Export des Pfads:**

- Öffnen Sie die Liste der gespeicherten Tracks (unter ‘Meine Karten’ > Track-Symbol).
- Wählen Sie den getrackten Pfad aus und tippen Sie auf die drei Punkte (⋮) neben dem Track-Namen.
- Wählen Sie ‘Exportieren’ und exportieren Sie den Pfad als KML (KML ist für den Import in QGIS ausreichend).

**Export der Punkte:**

- Öffnen Sie die Liste der gespeicherten Punkte (unter ‘Meine Karten’ > Punkt-Symbol).
- Wählen Sie alle Punkte aus, die Sie während der Übung gespeichert haben (NICHT die, die wir ihnen gegeben haben!).
- Exportieren Sie die Punkte als CSV.

## 6. Import der Daten in QGIS

**Import in QGIS:**

- Öffnen Sie QGIS auf Ihrem Computer.
- Wählen Sie Layer > Layer hinzufügen > CSV oder KML hinzufügen (je nach dem, was sie exportiert haben)

**Erstellen eines Geopackage:**

- Fügen Sie sowohl den Pfad (als Linien-Layer) als auch die eingemessenen Punkte (als Punkte-Layer) in **ein** Geopackage ein (nicht zwei Geopackages).
- Speichern Sie das Geopackage für die Abgabe und senden dieses per Mail mit den Namen der Gruppenteilnehmern.