# Einführung in GitHub

## Was ist GitHub?

GitHub ist eine webbasierte Plattform für Versionskontrolle und kollaborative Softwareentwicklung. Es verwendet Git, ein verteiltes Versionskontrollsystem, um Entwicklern zu helfen, Änderungen an ihrem Code zu verwalten und nachzuverfolgen. GitHub bietet eine benutzerfreundliche Oberfläche zur Verwaltung von Repositories, zur Zusammenarbeit mit anderen und zum Teilen von Code mit der Welt.

### Wichtige Funktionen von GitHub:
- **Repositories**: Speicherplätze für Ihre Projekte, in denen Sie alle Ihre Dateien und deren Verlauf verfolgen können.
- **Branches**: Separate Entwicklungslinien innerhalb eines Repositories, die es Ihnen ermöglichen, gleichzeitig an verschiedenen Funktionen oder Fehlerbehebungen zu arbeiten.
- **Pull Requests**: Vorschläge für Änderungen, die in den Hauptzweig integriert werden sollen, und die Code-Überprüfung und Zusammenarbeit erleichtern.
- **Issues**: Werkzeuge zur Verfolgung von Fehlern, Verbesserungen und anderen Aufgaben im Zusammenhang mit Ihrem Projekt.

## Ein Repository klonen

Ein Repository zu klonen bedeutet, eine lokale Kopie eines Projekts von GitHub auf Ihrem Computer zu erstellen. Dies ermöglicht es Ihnen, lokal an dem Projekt zu arbeiten und Änderungen mit dem Remote-Repository zu synchronisieren.

### Ein Repository ohne GitHub-Konto klonen

Sie benötigen kein GitHub-Konto, um ein öffentliches Repository zu klonen. Folgen Sie diesen Schritten:

1. **Git installieren**: Wenn Sie Git noch nicht installiert haben, laden Sie es von [git-scm.com](https://git-scm.com/) herunter und installieren Sie es.

2. **Ein Terminal öffnen**: Öffnen Sie Ihr Terminal (Eingabeaufforderung, PowerShell oder einen beliebigen Terminal-Emulator).

3. **Das Repository klonen**: Verwenden Sie den Befehl `git clone` gefolgt von der Repository-URL.

    ```sh
    git clone https://github.com/GeoSense-Freiburg/bsc_2024_25_teaching_inventur_und_geomatik.git
    ```

4. **Zum Repository wechseln**: Wechseln Sie in das Repository-Verzeichnis.

    ```sh
    cd bsc_2024_25_teaching_inventur_und_geomatik
    ```

### Ein Repository mit einem GitHub-Konto klonen

Mit einem GitHub-Konto können Sie zu Repositories beitragen, Ihre eigenen Repositories erstellen und auf private Repositories zugreifen. Folgen Sie diesen Schritten, um ein Repository mit Ihrem Konto zu klonen:

1. **Git installieren**: Wenn Sie Git noch nicht installiert haben, laden Sie es von [git-scm.com](https://git-scm.com/) herunter und installieren Sie es.

2. **Ein Terminal öffnen**: Öffnen Sie Ihr Terminal (Eingabeaufforderung, PowerShell oder einen beliebigen Terminal-Emulator).

3. **Mit GitHub authentifizieren**: Konfigurieren Sie Git mit Ihrem GitHub-Benutzernamen und Ihrer E-Mail-Adresse.

    ```sh
    git config --global user.name "Ihr-Benutzername"
    git config --global user.email "Ihre-E-Mail@example.com"
    ```

4. **Das Repository klonen**: Verwenden Sie den Befehl `git clone` gefolgt von der Repository-URL.

    ```sh
    git clone https://github.com/GeoSense-Freiburg/bsc_2024_25_teaching_inventur_und_geomatik.git
    ```

5. **Zum Repository wechseln**: Wechseln Sie in das Repository-Verzeichnis.

    ```sh
    cd bsc_2024_25_teaching_inventur_und_geomatik
    ```

6. **SSH einrichten (optional)**: Für eine einfachere Authentifizierung können Sie SSH-Schlüssel einrichten. Folgen Sie den Anweisungen in [GitHubs SSH-Dokumentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

## Die neuesten Daten aus dem Repository abrufen

Um sicherzustellen, dass Sie die neuesten Änderungen und Aktualisierungen aus dem Remote-Repository haben, müssen Sie die neuesten Daten abrufen. Dies wird als "Pull" bezeichnet. Folgen Sie diesen Schritten:

1. **Ein Terminal öffnen**: Öffnen Sie Ihr Terminal (Eingabeaufforderung, PowerShell oder einen beliebigen Terminal-Emulator).

2. **Zum Repository wechseln**: Wechseln Sie in das Repository-Verzeichnis, falls Sie sich nicht bereits dort befinden.

    ```sh
    cd bsc_2024_25_teaching_inventur_und_geomatik
    ```

3. **Die neuesten Daten abrufen**: Verwenden Sie den Befehl `git pull`, um die neuesten Änderungen aus dem Remote-Repository zu holen und in Ihr lokales Repository zu integrieren.

    ```sh
    git pull
    ```

Dieser Befehl aktualisiert Ihr lokales Repository mit allen neuen Commits, die im Remote-Repository hinzugefügt wurden, seit Sie das letzte Mal synchronisiert haben.

## Zusammenfassung

GitHub ist eine leistungsstarke Plattform für Versionskontrolle und Zusammenarbeit. Das Klonen eines Repositories ermöglicht es Ihnen, eine lokale Kopie eines Projekts zu erstellen, sodass Sie lokal daran arbeiten und Änderungen mit dem Remote-Repository synchronisieren können. Ob Sie ein GitHub-Konto haben oder nicht, das Klonen eines Repositories ist einfach und kann mit dem Befehl `git clone` durchgeführt werden.