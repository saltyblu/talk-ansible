# Ansible Schulung

[[_TOC_]]

## [Installation](https://docs.ansibe.com/ansible/intro_installation.html)

Ansible wird einfach über den Packet manager installiert, oder über pip.
```shell
pip install ansible
```

Prüfen ob ansible "funktioniert"
```shell
ansible --version
```
## Ansible erstes Verständniss

Ansible ist als CLI Tool nutzbar und kann somit sehr einfach ausgeführt werden.

### Begin
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
    "home": "/home/kathie",
    "move_home": false,
    "name": "kathie",
    "shell": "",
    "state": "present",
    "uid": 1000
}
```

Dabei fällt aus, dass changed nun wieder auf true steht und der comment nun nicht mehr leer ist.

### ansible adhoc commands

ansible ist ein CLI Tool dies einfach einzusetzen ist.
```shell
# ansible localhost -m "user" -a "name=kathie state=present home=/home/kathie comment='Kathie Wiese"
```
* localhost beschreibt hier die hosts auf denen es ausgeführt werden soll.
* -m gibt das Modul an das ausgeführt werden soll
* -a Beschreibt die Parameter für das Modul, wessen mit -m übergeben wurde z.B. "user"

#### Weitere Beispiele
```shell
ansible <inventory> options
ansible localhost -a /bin/date
ansible localhost -m ping
ansible localhost -m apt -a "name=vi state=latest"
ansible localhost -C -m apt -a "name=vi state=latest"
```
#### Check mode
Prüft die gegebene Situation auf dem System, ändert aber nichts.
Nicht alle Module untertzüzen den check mode, diese werden übersprungen.
Dieser kann mit -C benutzt werden

## Was ist ansible
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

## Learning Ansible - Playbooks

Der Eben erstelle User sollte noch existieren, versuchen wir ihn nun wieder zu löschen.
Hierfür benutzen wir nun einen "task" und subtool "ansible-playbook"

### Begin
Erstellen wir eine Datei auf dem Server mit folgendem Inhalt:

```yml
---
- hosts: localhost
  tasks:
  - name: ensure user Kathie Wiese
    user:
      name: kathie
      comment: "Kathie Wiese"
      state: absent
```
Nach dem speichern kann man nun folgenden Befehl ausführen.

```shell
# ansible-playbook user_absent.yml

PLAY [localhost] **************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [localhost]

TASK [ensure user Kathie Wiese] ***********************************************************************************************************************************************************************************
changed: [localhost]

PLAY RECAP ********************************************************************************************************************************************************************************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0
```

Ein weiteres ausführen des Befehls wird keine änderungen vornehmen:
```shell
# ansible-playbook user_absent.yml

PLAY [localhost] **************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [localhost]

TASK [ensure user Kathie Wiese] ***********************************************************************************************************************************************************************************
ok: [localhost]

PLAY RECAP ********************************************************************************************************************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0
```

Cool, somit habt ihr euren ersten play geschrieben und ausgeführt.

### ansible-playbook
Ansible playbook ist das tool um ansible "plays" und "playbooks" auszuführen.
* ein playbook benutzt "plays"
* ein play benutzt "tasks"
* ein task benutzt "module"
    * Diese laufen sequentiell ab

#### Host & Users

Für jeden Play oder Playbook muss man sich entscheiden für welchen Host und mit welchem User dies ausgeführt wird.

```yml
# examples/plays/user_absent.yml
---
- hosts: localhost # diese Zeile beschreibt für welche hosts der Play oder das Playbook ausgeführt werden soll.
  remote_user: root # beschreib als welcher user der play ausgeführt werden soll.
```
Genaueres zu hosts und deren patterns findet man hier: http://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html


#### Module Declaration

Schauen wir uns die deklaration eines "modules" unter dem Punkt tasks genauer an.
Es gibt viele verschiedene module in ansible und diese sind immmer recht gleich aufgebaut.
Bleiben wir bei unserer "Kathie"

```yml
# examples/plays/user_absent.yml
- name: "ensure user Kathie Wiese" # ein task braucht immer einen namen der dann zur laufzeit angezeigt wird
  user: # das modul in unserem falle user
    # die "übergabe Werte" des User-Moduls
    name: kathie
    comment: "Kathie Wiese"
    state: absent
```
#### Tasks
Ansible "snippets" werden Tasks genannt. Diese beinhalten einzelne Module für eine bestimmte Gruppe von Hosts.

Dies ist auch immernoch mit ansible ausfühbar:
```shell
ansible localhost -m user -a "name=kathie comment='Kathie Wiese' state=absent"
```
Was das user Modul sonst noch so kann findet man hier: http://docs.ansible.com/ansible/latest/modules/user_module.html

#### Module
* Kontrollieren system resourcen
* Ansible besitzt ~ 450 standard Module
    * Ziel: einfachheit

### Weiteres kleine Beispiele
Weitere kleine Beispiele liegen in examples/plays

Hier findet man alle ansible standard Module: http://docs.ansible.com/ansible/devel/modules/modules_by_category.html

### Ein wenig mehr

Nun haben wir einen kleinen task erledigt, machen wir nun etwas mehr.
Installieren wir SSHD und sorgen dafür das er beim systemstart immer ausgeführt wird, eigentlich sollte hier nichts passieren.
```yml
---
- hosts: localhost
  remote_user: root
  tasks:
  - name: ensure package ssh
    package:
      name: openssh-server
      state: present
  - name: ensure that ssh server is running
    service:
      name: sshd
      enabled: true
      state: started
```

Der Einzig große unterschied zu vorher hier das wir eine weitere Task definition haben, auch ohne großes ansible verständiss ist dieser "Definition leicht lesbar".

Ergebniss:
```shell
PLAY [localhost] **************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [localhost]

TASK [ensure package ssh] ***************************************************************************************************************************************************************************************
changed: [localhost]

TASK [ensure that ssh server is running] *******************************************************************************************************************************************************************************
changed: [localhost]

PLAY RECAP ********************************************************************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0
```

Lasst uns das Prüfen.
```shell
# systemctl status sshd
```

### Files
Ansible kann nicht packages und user verwalten sondern auch Dateien, heirfür gibt es mehrere Möglichkeiten.


### Variablen
* Diese helfen Playbooks unterschiedlic auszuführen
* Diese kann man beziehen aus:
    * Playbooks selbst
    * Files
    * Inventory (group vars, host vars)
    * Command Line
    * vom Ziel System (Facts)
    * Ansible Tower

### Facts

### Templates
#### Begin

### Loops
#### Begin
http://docs.ansible.com/ansible/devel/user_guide/playbooks_loops.html
http://docs.ansible.com/ansible/latest/user_guide/playbooks_special_topics.html

### Inventories
#### Begin
Ansible benötigt eine liste von Zielen auf denen die Playbooks ausgeführt werden können.
* Statisch eingetragene Server
* Custom geschriebene dinge
* Dynamische generierte Server listen aus Cloud anbietern oder sonsigem (AWS, Consul, Google, uvm...)

### Roles
#### Begin


### Handlers
## Erweitert

### Ansible Galaxy
### Tests
#### Check Mode
#### Playbooks Tests

#### Asserts
### Jinja2
