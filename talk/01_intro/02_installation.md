## Installation

Ansible wird einfach über den Packet manager installiert, oder über pip.

```shell
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

----

## Prüfen ob alles geht

Prüfen ob ansible "funktioniert"

```shell
# ansible --version
ansible 2.5.0
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.12 (default, Dec  4 2017, 14:50:18) [GCC 5.4.0 20160609]
```

Note: [Weitere Infos](https://docs.ansible.com/ansible/intro_installation.html)
