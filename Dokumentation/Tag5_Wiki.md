# 📘 Wiki – Tag 5: Git Vertiefung – Branching, Merge & Rebase

## Branches – Was & Warum

Ein Branch ist eine parallele Kopie des Codes – zum Experimentieren ohne den Hauptcode zu gefährden.

```
main:      A → B → C
                    \
feature:             D → E → F
```

- `main` = stabiler, funktionierender Code
- `feature/...` = Experiment, neues Feature, Bugfix

---

## Branch Befehle

```bash
git branch                        # Alle Branches anzeigen (* = aktueller)
git checkout -b feature/name      # Neuen Branch erstellen & wechseln
git checkout main                 # Zu main wechseln
git branch -d feature/name        # Branch löschen (nach Merge)
```

**Branch Namens-Konventionen:**
| Präfix | Bedeutung |
|---|---|
| `feature/` | Neues Feature |
| `bugfix/` | Fehler beheben |
| `hotfix/` | Dringender Fix |

---

## Merge

Bringt einen Branch in den aktuellen Branch – du musst auf dem **Zielbranch** sein!

```bash
git checkout main           # Auf Zielbranch wechseln
git merge feature/name      # Feature Branch reinmergen
```

### Fast-forward Merge
Passiert automatisch wenn Änderungen nicht in derselben Zeile sind:
```
Updating abc123..def456
Fast-forward
```

### Merge Konflikt
Passiert wenn dieselbe Zeile in beiden Branches unterschiedlich bearbeitet wurde:

```
<<<<<<< HEAD
echo 'Ich bin main'          ← aktuelle Version
=======
echo 'Ich bin Feature'       ← andere Version
>>>>>>> feature/name
```

**Konflikt lösen:**
1. Datei in VS Code öffnen
2. Gewünschte Version behalten
3. `<<<<<<<`, `=======`, `>>>>>>>` Zeilen entfernen
4. Speichern
5. `git add .`
6. `git commit -m "Merge Konflikt gelöst"`

---

## Rebase

Alternative zu Merge – schreibt Commits um für eine **lineare Historie**.

```bash
git checkout main
git rebase feature/name
```

**Merge vs. Rebase:**

```
Nach Merge:
main:    A → B → C ──────────── M
                  \            /
feature:           D → E → F ──

Nach Rebase:
main:    A → B → C → D' → E' → F'
```

| | Merge | Rebase |
|---|---|---|
| Historie | Zeigt alle Pfade | Linear & sauber |
| Extra Commit | ✅ Merge Commit | ❌ Kein extra Commit |
| Teamarbeit | Sicherer | Vorsicht bei geteilten Branches |
| Typisch für | `main` Branch | Feature Branches aufräumen |

---

## Typischer Branch Workflow

```bash
# 1. Neuen Branch erstellen
git checkout -b feature/mein-feature

# 2. Änderungen machen & committen
git add .
git commit -m "feature - Beschreibung"

# 3. Zurück zu main
git checkout main

# 4. Mergen
git merge feature/mein-feature

# 5. Branch löschen
git branch -d feature/mein-feature

# 6. Pushen
git push
```

---

## Neue Befehle

| Befehl | Bedeutung |
|---|---|
| `git branch` | Branches anzeigen |
| `git checkout -b name` | Branch erstellen & wechseln |
| `git checkout name` | Branch wechseln |
| `git merge name` | Branch mergen |
| `git rebase name` | Branch rebasen |
| `git branch -d name` | Branch löschen |
| `git log --oneline` | Kompakte Commit-Historie |
