# 📘 Wiki – Tag 1: Setup & Grundlagen

## WSL2 (Windows Subsystem for Linux)

WSL2 ist eine Linux-Umgebung die direkt auf Windows läuft – ohne extra Hardware oder VM-Fenster.

**Was es abbildet:** Später in der Cloud verbindest du dich per SSH auf Linux-Server. WSL ist genau das – ein echter Linux-Server auf deinem Laptop. Alles was du in WSL lernst, funktioniert 1:1 auf einem AWS EC2-Server.

**Installation:**
```powershell
wsl --install
```
Danach neu starten. Ubuntu öffnet sich automatisch → Benutzername & Passwort festlegen.

**Status prüfen:**
```powershell
wsl --status          # Zeigt Standardversion
wsl --list --verbose  # Zeigt alle installierten Distros + Status
```

---

## VS Code mit WSL verbinden

1. VS Code installieren: code.visualstudio.com
2. Extension "WSL" von Microsoft installieren (`Strg+Shift+X`)
3. Unten links auf grünes `><` Symbol → "Connect to WSL"
4. Oben links erscheint "WSL: Ubuntu" in blau

**Ordner öffnen:** In VS Code → File → Open Folder → `/home/leif/projektname`

---

## Terminal Shortcuts (Ubuntu)

| Aktion | Shortcut |
|---|---|
| Einfügen | `Strg + Shift + V` |
| Kopieren | `Strg + Shift + C` |
| Zeile abbrechen | `Strg + C` |

---

## Git Grundlagen

Git ist ein Versionskontrollsystem – es speichert Snapshots (Commits) deines Codes.

**Einmalige Konfiguration:**
```bash
git config --global user.name "Dein Name"
git config --global user.email "deine@email.de"
git config --list   # Prüfen ob es geklappt hat
```

**Repo klonen:**
```bash
git clone https://github.com/USERNAME/repo-name.git
cd repo-name
```

**Workflow (täglich):**
```bash
git add .                        # Alle Änderungen vormerken
git commit -m "Beschreibung"     # Snapshot speichern
git push                         # Auf GitHub hochladen
```

**Commits anzeigen:**
```bash
git log           # Alle Commits mit Details
git log --oneline # Kompakte Ansicht
git status        # Aktueller Stand
```

### Was ist ein Commit?
Ein Commit ist wie ein Speicherpunkt in einem Spiel. Du kannst jederzeit zu einem alten Stand zurückspringen. Auf GitHub siehst du alle Commits chronologisch.

---

## GitHub

- **Public Repository** = öffentlich sichtbar → wird später dein Portfolio
- **README.md** = Visitenkarte des Repos – Arbeitgeber schauen da zuerst drauf
- **Personal Access Token** = statt Passwort beim git push (unter Settings → Developer settings → Tokens)

---

## Vergleich: WSL vs. Cloud-Server

| Dein WSL | Später in der Cloud |
|---|---|
| `leif@DESKTOP:~$` | `ubuntu@ec2-server:~$` |
| Dateien in `/home/leif` | Dateien auf dem Server |
| Bash-Scripts schreiben | Automatisierung auf Servern |
| Docker lokal starten | Container in AWS deployen |
