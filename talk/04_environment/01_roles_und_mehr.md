### Struktur

```shell
ansible-galaxy init ansible-nginx
```

```shell
ansible-nginx/
|-- README.md
|-- defaults
|   `-- main.yml
|-- files
|-- handlers
|   `-- main.yml
|-- meta
|   `-- main.yml
|-- tasks
|   `-- main.yml
|-- templates
|-- tests
|   |-- inventory
|   `-- test.yml
`-- vars
    `-- main.yml
```

#### Aufgabe

Machen wir aus dem bisherigen Play ein richtiges Playbook.

### [Includes](https://docs.ansible.com/ansible/2.4/playbooks_reuse_includes.html)

### [Handlers](http://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html#handlers-running-operations-on-change)

## [Ansible-Environment](http://docs.ansible.com/ansible/latest/reference_appendices/config.html#ansible-configuration-settings)

Ansible ist auf viele Arten Konfigurierbar. Standard-Suchpfade für ansible.cfg sind:

* ANSIBLE_CONFIG (environment variablen sollten sie gesetzt sein)
* ansible.cfg (im aktuellen Verzeichnis)
* ~/.ansible.cfg (im User Home)
* /etc/ansible/ansible.cfg

### [Ansible Konfigurations Datei](http://docs.ansible.com/ansible/latest/installation_guide/intro_configuration.html)

Sample

```shell
[defaults]
inventory         = ./inventory
host_key_checking = False
log_path          = /tmp/ansible.log
roles_path        = ./roles
```

### [Mehr zu ansible-galaxy](http://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html)

ansible Galaxy ist eine Webseite, auf der man seine Playbooks hochladen und "veröffentlichen" kann.
Dort findet man auch viele bereits fertige Playbooks, welche aber mit Vorsicht zu genießen sind, meist erfüllen sie nicht genau den Zweck. Allerdings sind diese sehr gut für Anregungen oder als Ausgangspunkt, sofern die Lizens dies zulässt.

#### [requirements.yml](http://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html#installing-multiple-roles-from-a-file)

Installieren von dependencies aus der galaxy ist möglich.

```yml
# from galaxy
- src: yatesr.timezone

# from GitHub
- src: https://github.com/bennojoy/nginx

# from GitHub, overriding the name and specifying a specific tag
- src: https://github.com/bennojoy/nginx
  version: master
  name: nginx_role

# from a webserver, where the role is packaged in a tar.gz
- src: https://some.webserver.example.com/files/master.tar.gz
  name: http-role

# from Bitbucket
- src: git+http://bitbucket.org/willthames/git-ansible-galaxy
  version: v1.4

# from Bitbucket, alternative syntax and caveats
- src: http://bitbucket.org/willthames/hg-ansible-galaxy
  scm: hg

# from GitLab or other git-based scm
- src: git@gitlab.company.com:mygroup/ansible-base.git
  scm: git
  version: "0.1"  # quoted, so YAML doesn't parse this as a floating-point value
```

### Aufgabe

Erstellt ein gekapseltes environment, was ansibleenv heißt und roles aus ansibleenv/roles bezieht.

## Erweitert

### [Ansible Galaxy](http://docs.ansible.com/ansible/latest/reference_appendices/galaxy.html)

* https://galaxy.ansible.com/

### [Tests](http://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html)

* Check Mode
* Playbooks Tests
* [Asserts](http://docs.ansible.com/ansible/latest/reference_appendices/test_strategies.html)

### [Jinja2](https://docs.ansible.com/ansible/devel/user_guide/playbooks_templating.html)
