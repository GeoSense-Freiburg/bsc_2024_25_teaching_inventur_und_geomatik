# Anleitung: Nutzung von Avenza Maps für Pfadtracking und Punktmessung und Verarbeitung in QGIS

## 1. Installation und Einrichtung von Avenza Maps

- App herunterladen: Laden Sie die App Avenza Maps aus dem App Store (iOS) oder Google Play Store (Android) herunter und installieren Sie sie.
- Registrierung: Optional können Sie ein Konto bei Avenza erstellen, um Ihre Daten synchronisieren zu können. Dies ist für unsere Zwecke **nicht** erforderlich.

## 2. Import einer Ebene in Avenza Maps

- Öffnen Sie Avenza Maps und navigieren sie unten auf "Ebenen".
- Tippen Sie oben rechts auf das ‘+’-Symbol und wählen "Ebenen importieren".
- Wählen Sie die Datei aus (in unserem Fall "03.kmz"), und sie wird in Avenza Maps importiert (oder eben per QR Code).
- Die Ebene sollte nun in Ihrer Basiskarte angezeigt werden.

Nun sollten Sie die einzelnen Stationen sehen und können dort hinnavigieren. **Jetzt müssen sie darauf achten, dass sie für ihre Messungen eine neue Ebene erstellen und diese als "aktive ebene" deklarieren**:

- als aktive Ebene festlegen
    - gehen sie nun auf "Basiskarte öffnen"
    - gehen sie unten rechts auf das layer-symbol
    - dann wählen sie mit den 3 Punkten bei der Ebene "name-der-eigenen-ebene" "als aktive Ebene festlegen" aus

Nun sollten sie, wenn sie Punkte hinzufügen, diese auf ihrer eigenen Ebene hinzufügen können. Am Ende der Übung können Sie dann nämlich ganz einfach ihre Punkte exportieren.

## 3. Pfadtracking mit Avenza Maps

**Tracking starten:**

- Stellen Sie sicher, dass Ihr GPS aktiviert ist.
- **Stellen Sie sicher, dass ihre eigens erstellte, neue Ebene die aktive Ebene ist!!**
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

- **Stellen Sie sicher, dass ihre eigens erstellte, neue Ebene die aktive Ebene ist!!**
- Tippen Sie während des Rundlaufs auf die Pin-Nadel-Schaltfläche unten rechts, um einen neuen Punkt auf der Karte zu speichern. **Achten Sie darauf, dass ihre Position auf ihrem aktuellen Standort ist!!!**
- Ihre Position wird automatisch als Punkt markiert.
- Punkte benennen:
    - Nach dem Einfügen des Punktes können Sie ihn benennen, z.B. A, B usw.
    - Beschreibung hinzufügen (Bedeckungsgrad): Dort schreiben sie eine Zahl zw. 1 und 10 hinein (nichts anderes!), das ungefähr den Bedeckungsgrad über ihnen widerspiegelt. Also wenn sie z.b. im Wald stehen unter vielen Bäumen, wäre 8 oder 9 ein realistischer Wert. Unter freiem Himmel wohl eher eine 1 oder 2
    - speichern sie den Punkt und gehen anschließend zum nächsten!

## 5. Export der Daten

**Export des Pfads:**

- Öffnen Sie die Liste der gespeicherten Tracks (unter ‘Meine Karten’ > Track-Symbol).
- Wählen Sie den getrackten Pfad aus und tippen Sie auf die drei Punkte (⋮) neben dem Track-Namen.
- Wählen Sie ‘Exportieren’ und exportieren Sie den Pfad als GPX (GPX ist für den Import in QGIS ausreichend).

**Export der Punkte:**

- Öffnen Sie die Liste der gespeicherten Punkte (unter ‘Meine Karten’ > Punkt-Symbol).
- Wählen Sie alle Punkte aus, die Sie während der Übung gespeichert haben (NICHT die, die wir ihnen gegeben haben!).
- Exportieren Sie die Punkte als CSV so, dass Sie sie wieder finden!

## Nun folgen Sie weiter der Anleitung in ex03.pdf