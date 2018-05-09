## Ansible - Playbooks

Der eben erstellte User sollte noch existieren, versuchen wir ihn nun wieder zu löschen.
Hierfür benutzen wir nun einen "task" und das Subtool "ansible-playbook"

### Zu Beginn
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

Nach dem Speichern kann man nun folgenden Befehl ausführen:

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

Ein weiteres Ausführen des Befehls wird keine Änderungen vornehmen:

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

----

### ansible-playbook

Ansible playbook ist das tool um ansible "plays" und "playbooks" auszuführen.

* Ein Playbook benutzt "plays"
* Ein Play benutzt "tasks"
* Ein Task benutzt "module"
  * Diese laufen sequentiell ab

----

#### Host & Users

Für jeden Play oder Playbook muss man sich entscheiden, für welchen Host und mit welchem User dieser ausgeführt werden soll.

```yml
# examples/plays/user_absent.yml
---
- hosts: localhost # diese Zeile beschreibt, für welche hosts der Play oder das Playbook ausgeführt werden soll.
  remote_user: root # beschreibt, als welcher user der Play ausgeführt werden soll.
```

[Genaueres Infos](http://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html)

----

#### Modul Deklarierung

Schauen wir uns die Deklaration eines "modules" unter dem Punkt: "Tasks" genauer an.
Es gibt viele verschiedene Module in Ansible und diese sind immmer recht ähnlich aufgebaut.
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

----

#### Tasks

Solche "snippets" werden Tasks genannt. Diese beinhalten einzelne Module für eine bestimmte Gruppe von Hosts.

Dies ist auch immernoch mit "ansible" ausfühbar:

```shell
ansible localhost -m user -a "name=kathie comment='Kathie Wiese' state=absent"
```

Was das user Modul sonst noch so kann findet man hier: http://docs.ansible.com/ansible/latest/modules/user_module.html

----

#### Module

* Kontrollieren System-Resourcen
* Ansible besitzt ~ 450 standard Module
  * Ziel: Einfachheit

### Beispiele

Weitere kleine Beispiele liegen in examples/plays
[Infos zu Standard-Modulen](http://docs.ansible.com/ansible/devel/modules/modules_by_category.html)

### Ein wenig Mehr

Nun haben wir einen kleinen Task erledigt, machen wir nun etwas mehr.
Installieren wir SSHD und sorgen dafür das er beim Systemstart immer ausgeführt wird, eigentlich sollte hier nichts passieren.

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

Der einzige große Unterschied zu vorher ist, das wir eine weitere Task-Definition haben, auch ohne großes Ansible-Verständis ist dieser "Definition leicht lesbar".

Ergebnis:

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
