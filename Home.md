# Ansible Schulung

[[_TOC_]]

## Getting Started

### [Installation](https://docs.ansibe.com/ansible/intro_installation.html)

Ansible wird einfach über den Packet manager installiert, oder über pip.
```shell
pip install ansible
```

Prüfen ob ansible "funktioniert"
```shell
ansible --version
```
### Ansible Erstes Verständniss

Ansible ist als CLI Tool nutzbar und kann somit sehr einfach ausgeführt werden.

Erstellen wir im ersten beispiel einen neuen User:
```shell
# ansible localhost -m "user" -a "name=kathie state=present home=/home/kathie"

ubuntu | SUCCESS => {
    "changed": true,
    "comment": "",
    "create_home": true,
    "group": 1000,
    "home": "/home/kathie",
    "name": "kathi",
    "shell": "",
    "state": "present",
    "system": false,
    "uid": 1000
}
```
Ansible hat die "Resource" user mit dem namen kathie angelegt.
Was passiert wenn wir diesen Command nocheinmal ausführen?

```shell
# ansible localhost -m "user" -a "name=kathie state=present home=/home/kathie"
ubuntu | SUCCESS => {
    "append": false,
    "changed": false,
    "comment": "",
    "group": 1000,
    "home": "/home/kathie",
    "move_home": false,
    "name": "kathie",
    "shell": "",
    "state": "present",
    "uid": 1000
}
```

Verändern wir nun das comment des Users und schauen was passiert.
```shell
# ansible localhost -m "user" -a "name=kathie state=present home=/home/kathie comment='Kathie Wiese"

ubuntu | SUCCESS => {
    "append": false,
    "changed": true,
    "comment": "Kathie Wiese",
    "group": 1000,
    "home": "/home/kathi",
    "move_home": false,
    "name": "kathi",
    "shell": "",
    "state": "present",
    "uid": 1000
}
```

Dabei fällt aus, dass changed nun wieder auf true steht und der comment nun nicht mehr leer ist.

#### Zusammenfassung
Ansible ist eine "configuration Management", eine Sprache um infrastruktur zu beschreiben.

## Allgemeines zu ansible
### Was ist ansible
1. ansible ist eine simple "automation-language"
2. außerdem ist ansible auch die "automation engine" die "playbooks" ausführt

### Kernziele
* Einfachheit
    * "Human readable"
    * simples yaml Format
    * jeder soll Ansible lesen und verstehen können ohne es zu kennen
    * simple Struktur, Code wird immer von oben nach unten ausgeführt (in order)
    * schnell "produktiv" gehen
* Powerfull
    * ist "einfach" Anwendbar auf bestehende Infrastruktur
    * workflow automatisierung
    * "Lifecycle" automatisierung
* Agentless
    * benötigt nur SSH Zugriff (oder WinRM)
        * keine weiteren Firewall configs nötig...
    * keine "clients" die man ausnutzen oder aktuell halten muss.

### Zielsetzung
Ansible versucht jeden schnell an die Automatisierung von IT-Infrastruktur/Prozessen zu bringen und dabei kompläxität zu verringern.
### Unterschied zu Anderen Programmiersprachen
Ansible ist eine Sprache die den zu erreichenden zustand beschreibt. nicht wie man zu dem Zustand kommt.

### Was kann ansible
* Config Management
* App Deployment
* Provisionierung
* Continous Delivery
* Security Compliance
* Orchistration

## Architektur & Aufbau
 --- Bild User -> Playbook -> Inventory/Plugins/Modules/API -> Infrastruktur -> Rechner
                                                                             -> Networking
                                                                             -> Cloud

## Ansible ausführen

* ansible <inventory> -m
* ansible-playbook -i <inventory> <playbook.yml>
* ansible tower

### Adhoc Befehle
```shell
ansible <inventory> options
ansible localhost -a /bin/date
ansible localhost -m ping
ansible localhost -m apt -a "name=vi state=latest"
```
### Check mode
Prüft die gegebene Situation auf dem System, ändert aber nichts.
Nicht alle Module untertzüzen den check mode, diese werden übersprungen.

### Module
* Kontrollieren system resourcen
* Ansible besitzt ~ 450 Standart module
    * Ziel: einfachheit

## Ansible language basics

### Playbooks
#### Part 1
* geschrieben in yaml format
* diese beschreiben den Endzustand von "Etwas"
* Komplexität variiert
#### Part 2
* ein playbook benutzt "plays"
* ein play benutzt "tasks"
* ein task benutzt "module"
    * Diese laufen sequentiell ab
bsp
* Handlers werden von task am ende eines Plays angestoßen
bsp

### Modules
http://docs.ansible.com/ansible/devel/modules/modules_by_category.html
bsp.:

### Variablen
* Diese helfen Playbooks unterschiedlic auszuführen
* Diese kann man beziehen aus:
    * Playbooks selbst
    * Files
    * Inventory (group vars, host vars)
    * Command Line
    * vom Ziel System (Facts)
    * Ansible Tower

### Inventories
Ansible benötigt eine liste von Zielen auf denen die Playbooks ausgeführt werden können.
* Statisch eingetragene Server
* Custom geschriebene dinge
* Dynamische generierte Server listen aus Cloud anbietern oder sonsigem (AWS, Consul, Google, uvm...)


# Erweitert

## Loops
http://docs.ansible.com/ansible/devel/user_guide/playbooks_loops.html
http://docs.ansible.com/ansible/latest/user_guide/playbooks_special_topics.html

## Rollen

## Ansible Galaxy
## Testen
