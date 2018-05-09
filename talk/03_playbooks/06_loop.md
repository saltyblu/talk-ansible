## [Ansible - Einfache Schleifen](http://docs.ansible.com/ansible/devel/user_guide/playbooks_loops.html)

In Ansible sind Schleifen möglich um komplexere Aufgaben zu erledigen.

http://docs.ansible.com/ansible/devel/user_guide/playbooks_loops.html
http://docs.ansible.com/ansible/latest/user_guide/playbooks_special_topics.html

## [Ansible - When Statement](http://docs.ansible.com/ansible/latest/user_guide/playbooks_conditionals.html)

## [Ansible - Inventories](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)

### Zu Beginn

Ansible benötigt eine Liste von Zielen auf denen die Playbooks ausgeführt werden können.

* Statisch eingetragene Server
* Custom geschriebenes Zeug
* Dynamische generierte Server Listen aus der Cloud oder sonstigem Tools (AWS, Consul, Google, uvm...)

Zurück zum Anfang:

```shell
ansible localhost -m user -a "name=kathi state=absent"
```

Hier an zweiter Stelle sagen wir ansible auf welchen Hosts das Modul ausgeführt werden soll.
Bei ansible-playbook tun wir dies im Playbook.

```yaml
- hosts: localhost #<----
  remote_user: root
  tasks:
  - name: ensure user Kathie Wiese
    user:
      name: kathie
      comment: "Kathie Wiese"
      state: absent
```

Woher bezieht ansible diese Daten?
