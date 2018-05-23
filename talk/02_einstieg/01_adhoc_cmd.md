## Ansible erstes Verständnis

Ansible ist als CLI Tool nutzbar und kann somit sehr einfach ausgeführt werden.

Erstellen wir im ersten Beispiel einen neuen Nutzer:

### Erstes beispiel

```shell
ansible localhost -m "user" -a "name=kathie state=present home=/home/kathie"
```

```shell
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

Ansible hat die "Resource" User mit dem namen Kathie angelegt.

----

### Das Selbe nochmal

Was passiert, wenn wir dieses Kommando noch einmal ausführen?

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

----

### Das Selbe ein wenig anders

Verändern wir nun den Kommentar (comment) des Nutzers und schauen was passiert.

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

Dabei fällt auf, dass "changed" nun wieder auf "true" steht und der Kommentar nun nicht mehr leer ist.

----

### ansible adhoc commands

ansible ist ein CLI Tool, das einfach einzusetzen ist.

```shell
# ansible localhost -m "user" -a "name=kathie state=present home=/home/kathie comment='Kathie Wiese"
```

* localhost beschreibt hier die Hosts auf denen der Lauf ausgeführt werden soll.
* -m gibt das Modul an, das ausgeführt werden soll
* -a Beschreibt die Parameter für das Modul, das mit -m übergeben wurde z.B. "user"

----

#### Check mode

Prüft die gegebene Situation auf dem System, ändert aber nichts.
Nicht alle Module unterstützen den check mode, diese werden übersprungen.
Dieser kann mit -C benutzt werden

```shell
ansible localhost -C -m package -a "name=vi state=latest"
```

#### Beispiele

```shell
ansible <inventory> options
ansible localhost -a /bin/date
ansible localhost -m ping
ansible localhost -m package -a "name=vi state=latest"
ansible localhost -C -m package -a "name=vi state=latest"
```
