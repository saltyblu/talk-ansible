#### Datei Verwaltung

Ansible kann nicht nur Pakete und Benutzer verwalten sondern auch Dateien, heirfür gibt es mehrere Möglichkeiten.

Zurück zu unserem vorherigen Beispiel sshd, lass uns dieses etwas erweitern.

```yaml
<snip>
  - name: ensure etc/banner
    file:
      state: directory
      dest: /etc/banner
      owner: root
  - name: copy isssue.net
    copy:
      src: issue.net
      dest: /etc/banner/issue.net
      owner: root
  - name: Enable issue.net Banner
    lineinfile:
      path: /etc/ssh/sshd_config
      regexp: '^Banner='
      line: 'Banner=/etc/banner/issue.net'
</snip>

```

```shell
PLAY [localhost] ***************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [ensure etc/banner] *******************************************************
changed: [localhost]

TASK [copy isssue.net] *********************************************************
changed: [localhost]

TASK [Enable issue.net Banner] *************************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=3    unreachable=0    failed=0
```

All diese Module sind Standard-Module und lange nicht alle, was machen diese denn genau?
[Eine Liste aller "File" Module](http://docs.ansible.com/ansible/latest/modules/list_of_files_modules.html)

##### Module: file

Dieses Modul beschreibt den Zustand einer Datei.
http://docs.ansible.com/ansible/devel/modules/file_module.html

##### Module: copy

Kopiert Daten vom "Server" System zum Ziel System.
http://docs.ansible.com/ansible/latest/modules/copy_module.html#copy

##### Module: lineinfile

Es ist auch möglich, nur einzelne Teile einer Datei zu verändern und den Rest unverändert zu lassen.
http://docs.ansible.com/ansible/latest/modules/lineinfile_module.html#lineinfile

----

#### Zusammenfassung

Nun haben wir schon einiges gesehen:

* Ansible Plays
* Das Zusammenführen von mehreren Tasks in einem Play
* Manipulation von "services", Dateien, Paketen und Benutzern
