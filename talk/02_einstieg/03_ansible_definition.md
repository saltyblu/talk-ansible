## Was ist ansible

* ansible ist eine simple "automation-language"
* außerdem ist ansible auch die "automation engine" die "playbooks" ausführt

### Was kann ansible

* Config Management
* App Deployment
* Provisionierung
* Continous Delivery
* Security Compliance
* Orchistration

----

## Kernziele

* Einfachheit
  * "Human readable"
  * Simples yaml Format
  * Jeder soll Ansible lesen und verstehen können ohne es zu kennen
  * Simple Struktur, Code wird immer von oben nach unten ausgeführt (in order)
  * Schnell "produktiv" gehen
* Powerfull
  * "einfach" anwendbar auf bestehende Infrastruktur
  * Workflow Automatisierung
  * "Lifecycle" Automatisierung
* Agentless
  * benötigt nur SSH Zugriff (oder WinRM)
    * keine weiteren Firewall-Konfigurationen nötig...
  * keine "clients", die man ausnutzen oder aktuell halten muss.

### Zielsetzung

Ansible versucht, jeden schnell an die Automatisierung von IT-Infrastruktur/Prozessen zu bringen und dabei Komplexität zu verringern.

----

## Unterschied zu anderen Programmiersprachen

Ansible ist eine Sprache, die den zu erreichenden Zustand beschreibt, nicht wie man zu dem Zustand kommt.

## Architektur & Aufbau Bild

![ansible architecture](talk/02_einstieg/ansible_architecture.png "Ansible Architecture")

[Quelle](https://www.ansible.com/resources/videos/quick-start-video)
