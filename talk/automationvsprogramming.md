# Allgemeines zu automatisierung

## Was ist ansible? 
Ansible ist ein sogenanntes Konfigurationsmanagement/Konfigurationsmanagementsystem, in dieser Gruppe befinden sich auch diverse andere Tools
* terraform
* puppet
* chef
* salt
* cobbler

## Ziele von Konfigurationmanagementsystemen
* Anforderungen an die Infrastruktur manifestieren
* Nachvollziehbarkeit von Konfigurations anpassungen
* Manuelle Arbeiten minimieren
* Zustände des Systems definieren und reprodozieren können
* Testbarkeit der Infrastruktur erhöhen

## Programmiertyp von ansible 
Puppet und Chef sind deklarative Tools/Programmiersprachen. 
* hier steht die Beschreibung des Problems im Vordergrund.

Genaueres dazu findet man hier: https://de.wikipedia.org/wiki/Deklarative_Programmierung

Ansible wirkt auf den ersten Blick auch wie eine deklarative Programmiersprache ist aber in Wirklichkeit eine imperative Sprache, da Tasks beschrieben werden und diese von Oben nach unten Abgearbeitet werden..
Ansible muss auch wie alle anderen Tools für Idempotenz sorgen, bedeutet das mehrfache Ausführung eins Tasks oder Playbooks zum selben Ergebniss  führt. 

## Fazit Ansible und Co. vs Golang Java und Co. 
Golang Java und derivate sind imperative Proggramiersprachen. Puppet Chef und im Ansatz auch Ansible sind deklarativ.

### Einfach gehlaten
Als Entwickler (Golang, Java und Co.) beschreibt man den Weg (zum Ziel)! 
Mit Automatisierungsprachen beschreibt man das Ziel (ohne den Weg)!


### Quellen: 
* https://jaxenter.de/ansible-puppet-chef-vergleich-54794
* Wikipedia: 
  * https://de.wikipedia.org/wiki/Deklarative_Programmierung
  * https://de.wikipedia.org/wiki/Imperative_Programmierung

(mit Vorbehalt ohne gewähr.)
