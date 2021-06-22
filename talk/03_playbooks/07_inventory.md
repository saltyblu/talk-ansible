### Hosts und Gruppen

Ansible benutzt dafür eine "Inventory Datei", diese liegt zuallererst in /etc/ansible/inventory, dies ist aber auf viele Arten änderbar. z.B. mit -i.

```shell
cat examples/inventory/static_inventory
```
```yaml
localhost

[webservers] # definiert eine Gruppe von Servern
foo.example.com # definiert die Rechner in der Gruppe
bar.example.com:1337

[dbservers]
one.example.com ansible_host=192.168.0.66 ansible_port=5512 # der Host hat keinen DNS Eintrag deshalb kann dieser verändert werden.
two.example.com
three.example.com
```

Es gibt noch weitere Methoden wie INI und YAML Format.

#### Pattern

Um es mal erwähnt zu haben, auch Patterns sind möglich.

```yaml
[desktop]
pc-bn-[01:50]

```

#### Connection Types

Sowie connection Types

```yaml
[client]
localhost              ansible_connection=local
other1.example.com     ansible_connection=ssh        ansible_user=mpdehaan
```

#### Aufgabe

* Schreibt ein Inventory für euren Play und führt diesen über eine Gruppe aus. Das Inventory könnt ihr mit -i angeben.

```shell
ansible-playbook -i inventory play.yaml
```

### Host & Gruppen Variablen

Es ist möglich, für Hosts und Gruppen Variablen festzulegen, diese können in Plays individuell genutzt werden.

### Standard Gruppen

* all
  * Beinhaltet alle hosts
* ungrouped
  * Beinhaltet alle hosts die in keiner weiteren Gruppe sind.

### Aufgabe

Ändert euren Play so ab, dass dieser von eurem Rechner eine anderes System provisioniert.

## [Ansible - Roles](http://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)

ansible-galaxy ist hier dein Freund und Helfer.
