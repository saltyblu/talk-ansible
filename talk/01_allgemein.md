# Allgemeines
## Was ist ansible
1. ansible ist eine simple "automation-language"
2. außerdem ist ansible auch die "automation engine" die "playbooks" ausführt

## Kernziele
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

## Zielsetzung
Ansible versucht jeden schnell an die Automatisierung von IT-Infrastruktur/Prozessen zu bringen und dabei kompläxität zu verringern.
## Unterschied zu Anderen Programmiersprachen
Ansible ist eine Sprache die den zu erreichenden zustand beschreibt. nicht wie man zu dem Zustand kommt.

## Was kann ansible
* Config Management
* App Deployment
* Provisionierung
* Continous Delivery
* Security Compliance
* Orchistration
