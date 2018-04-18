# Spaß mit Flaggen

Lass uns das Pferd mal anders aufziehen.


# Beispiele


## Google Hangouts


## SSH Geopip
* https://www.axllent.org/docs/view/ssh-geoip/



# Schneller anfang
```shell
$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible
```

```shell
$ ansible-galaxy init sshgeoip
$ cd sshgeoip/tests
$ ln -s ../../sshgeoip sshgeoip
$ sudo ansible-playbook test.yml
```

# Mal was ändern
```shell
vim sshgeoip/tasks/main.yml
```
```yaml
---

- name: Install geoip-bin
  package:
    name: geoip-bin
    state: installed
```

```shell
$ ansible-galaxy init sshgeoip
$ cd sshgeoip/tests
$ ln -s ../../sshgeoip sshgeoip
$ sudo ansible-playbook test.yml
```
Was ist passiert?
