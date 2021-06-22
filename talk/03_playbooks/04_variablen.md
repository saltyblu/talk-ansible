## [Ansible - Variablen](http://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)

* Variablen helfen Playbooks unterschiedlich auszuführen
* Diese kann man aus mehreren Quellen beziehen:
  * Command Line
  * Den Playbooks selbst
  * Files
  * Inventory (group vars, host vars)
  * Vom Ziel System (Facts)
  * Ansible Tower

Variablen werden in Ansible fast immer mit {{ }} umklammert und in Playbooks zusätzlich mit "".
Dies ist ein sehr komplexes Thema, deshalb wird auch hier nur auf die Basics eingegangen.

----

### Variable auf der Kommando Zeile

Variablen in der Commandline werden mittels -e key=value angegeben, diese können dann im kompletten Ansible-Kontext verwendet werden.

#### Beispiel

htop installieren:

```shell
ansible localhost -e htop_ensure=present -m package -a "name=htop state={{ htop_ensure }}"
```

htop deinstallieren:

```shell
ansible localhost -e htop_ensure=present -m package -a "name=htop state={{ htop_ensure }}"
```

----

### Variablen im Playbook

```yaml
---
- hosts: localhost
  remote_user: root
  vars:
    user_comment: "Kathie Wiese"
  tasks:
  - name: ensure user Kathie Wiese
    user:
      name: kathie
      comment: "{{ user_comment }}"
      state: present
```

----

### Facts

#### Variablen vom Ziel System

```shell
ansible localhost -m setup
```

```yml
localhost | SUCCESS => {
    "ansible_facts": {
        "ansible_apparmor": {
            "status": "disabled"
        },
        "ansible_architecture": "x86_64",
        "ansible_bios_date": "07/04/2017",
        "ansible_bios_version": "1.3.7",
        "ansible_cmdline": {
            "acpi_backlight": "vendor",
            "cryptdevice": "/dev/nvme0n1p2:cryptroot",
            "initrd": "\\initramfs-linux.img",
            "root": "/dev/mapper/cryptroot",
            "rw": true
        },
        "ansible_date_time": {
            "date": "2018-04-17",
            "day": "17",
            "epoch": "1523978477",
            "hour": "15",
            "iso8601": "2018-04-17T15:21:17Z",
            "iso8601_basic": "20180417T152117234552",
            "iso8601_basic_short": "20180417T152117",
            "iso8601_micro": "2018-04-17T15:21:17.234600Z",
            "minute": "21",
            "month": "04",
            "second": "17",
            "time": "15:21:17",
            "tz": "UTC",
            "tz_offset": "+0000",
            "weekday": "Tuesday",
            "weekday_number": "2",
            "weeknumber": "16",
            "year": "2018"
        },
...
```

Wow, was ein Haufen, all diese Variablen sind im ansible Play nutzbar.
Dieser Vorgang nennt sich bei Playbooks gathering_facts und wird vor jedem Play für jeden Host ausgeführt.
Dies kann man aber auch deaktivieren, falls man diese Variablen nicht braucht:

```yml
hosts: localhost
remote_user: root
gathering_facts: no # deaktiviert diese
tasks:
...
```

### [Register](http://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#registered-variables)

### [Variablen Scope](http://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable)
