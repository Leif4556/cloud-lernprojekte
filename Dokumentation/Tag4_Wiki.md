# 📘 Wiki – Tag 4: Netzwerk-Basics

## DNS (Domain Name System)

DNS = Telefonbuch des Internets – übersetzt Namen in IP-Adressen.

```
google.com  →  DNS  →  142.250.185.46
```

Menschen merken sich Namen – Computer arbeiten mit IP-Adressen.

**Was passiert beim Seitenaufruf:**
1. Browser fragt DNS: "Was ist die IP von google.com?"
2. DNS antwortet mit der IP
3. Browser schickt Anfrage an diese IP
4. Server schickt die Seite zurück

**DNS abfragen:**
```bash
nslookup google.com              # Standard DNS
nslookup google.com 8.8.8.8     # Bestimmten DNS-Server fragen (Google DNS)
```

**Was passiert bei DNS-Ausfall?**
- Redundanz: Es gibt immer mehrere DNS-Server als Fallback
- Notfallplan: Direkt die IP-Adresse eingeben

---

## IPv4 Adressen

Eine IPv4 Adresse besteht aus 4 Blöcken:
```
192.168.1.100
```

Jeder Block = 8 Bit = 1 Byte = 0–255

**Warum maximal 255?**
```
11111111 = 2^8 - 1 = 255
```

**Gesamte IPv4 Adressen:** 2^32 = ~4,3 Milliarden

---

## NAT & Private IP-Adressen

IPv4 Adressen sind knapp (4 Mrd. < 8 Mrd. Menschen + Geräte).

**Lösung 1: NAT (Network Address Translation)**
Private IP-Adressen dürfen mehrfach vergeben werden:

```
Zuhause:
192.168.1.100 (Laptop)  ─┐
192.168.1.101 (Handy)   ─┤── Router ── 85.214.x.x (eine öffentliche IP)
192.168.1.102 (TV)      ─┘
```

**Reservierte private Bereiche:**
| Bereich | Typisch für |
|---|---|
| `192.168.x.x` | Heimnetzwerk |
| `10.x.x.x` | Firmennetzwerk |
| `172.16.x.x` | AWS & Cloud (auch WSL!) |
| `127.0.0.1` | Loopback (eigener Rechner) |

**Lösung 2: IPv6**
128 Bit statt 32 Bit → 2^128 Adressen – praktisch unendlich
```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

---

## Subnetting & CIDR Notation

Die Zahl nach dem `/` = wie viele Bits für das Netzwerk reserviert sind.

```
172.21.121.221/20
│              └── 20 Bits Netzwerk, 12 Bits für Hosts
└── IP-Adresse
```

**Beispiele:**
| CIDR | Subnetzmaske | Hosts |
|---|---|---|
| `/24` | 255.255.255.0 | 2^8 - 2 = **254** |
| `/20` | 255.255.240.0 | 2^12 - 2 = **4094** |
| `/16` | 255.255.0.0 | 2^16 - 2 = **65534** |

**Warum -2?**
- Erste Adresse = Netzadresse (z.B. `192.168.1.0`)
- Letzte Adresse = Broadcast (z.B. `192.168.1.255`)

**Binär verstehen:**
```
/24 = 11111111.11111111.11111111.00000000 = 255.255.255.0
/20 = 11111111.11111111.11110000.00000000 = 255.255.240.0
```
- **1er** = Netzwerkanteil
- **0er** = Host-Anteil

**Eigene IP anzeigen:**
```bash
ip addr
```

---

## HTTP & HTTPS

**HTTP = HyperText Transfer Protocol**
Die "Sprache" zwischen Browser und Webserver.

```
Browser          Webserver
   │                 │
   │── GET / ──────►│
   │◄─ 200 OK + HTML─│
```

**HTTPS = HTTP + Verschlüsselung (Secure)**
Ohne HTTPS kann jeder im gleichen Netzwerk den Traffic mitlesen.

**HTTP Status Codes:**
| Code | Bedeutung |
|---|---|
| 200 | OK – alles gut |
| 301 | Weitergeleitet |
| 404 | Nicht gefunden |
| 500 | Serverfehler |

**HTTP Versionen:**
| Version | Merkmal |
|---|---|
| HTTP/1.1 | Älterer Standard |
| HTTP/2 | Schneller, moderner Standard |

---

## Ports

Ports sind wie Türnummern – sie sagen welcher Dienst auf dem Server gemeint ist.

```
185.125.190.82:80    ← HTTP
185.125.190.82:443   ← HTTPS
185.125.190.82:22    ← SSH
```

**Wichtigste Standard-Ports:**
| Port | Dienst |
|---|---|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 3306 | MySQL |
| 5432 | PostgreSQL |

---

## curl

`curl` = Browser ohne Darstellung – holt Inhalte von URLs.

```bash
curl http://google.com          # Ganzen HTML-Code holen
curl -I http://google.com       # Nur Header anzeigen
curl -I https://www.google.com  # HTTPS Header
```

**Beispiel Weiterleitungskette:**
```
http://google.com       → 301 (HTTP zu HTTPS)
https://google.com      → 301 (zu www.google.com)
https://www.google.com  → 200 ✅
```

---

## Neue Befehle

| Befehl | Bedeutung |
|---|---|
| `nslookup domain` | DNS Abfrage |
| `ip addr` | Eigene IP-Adressen anzeigen |
| `curl URL` | Inhalt einer URL abrufen |
| `curl -I URL` | Nur HTTP-Header abrufen |
| `sudo apt-get update` | Paketlisten aktualisieren |
| `sudo apt install paket` | Paket installieren |
