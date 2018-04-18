# Cheat Cheet
- [Modules](#modules)
    - [File](#file)
        - [copy](#copy)
        - [template](#template)
        - [lineinfile](#lineinfile)
    - [package](#package)
    - [service](#service)
    - [debug](#debug)
    - [cron](#cron)
    - [user](#user)
- [Ansible Howto Start](#ansible-howto-start)
    - [Ansible Galaxy](#ansible-galaxy)
- [Inventory Examples](#inventory-examples)
- [Variablen](#variablen)
    - [Im Play definieren](#im-play-definieren)
    - [In Templates](#in-templates)
- [Host and Group Vars](#host-and-group-vars)
- [Variable scoping](#variable-scoping)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

## Modules

### [File](http://docs.ansible.com/ansible/latest/modules/list_of_files_modules.html)
#### [copy](http://docs.ansible.com/ansible/latest/modules/file_module.html)
```yaml
# change file ownership, group and mode. When specifying mode using octal numbers, first digit should always be 0.
- file:
    path: /etc/foo.conf
    owner: foo
    group: foo
    mode: 0644
- file:
    path: /work
    owner: root
    group: root
    mode: 01777
- file:
    src: /file/to/link/to
    dest: /path/to/symlink
    owner: foo
    group: foo
    state: link
- file:
    src: '/tmp/{{ item.src }}'
    dest: '{{ item.dest }}'
    state: link
  with_items:
    - { src: 'x', dest: 'y' }
    - { src: 'z', dest: 'k' }

# touch a file, using symbolic modes to set the permissions (equivalent to 0644)
- file:
    path: /etc/foo.conf
    state: touch
    mode: "u=rw,g=r,o=r"

# touch the same file, but add/remove some permissions
- file:
    path: /etc/foo.conf
    state: touch
    mode: "u+rw,g-wx,o-rwx"

# create a directory if it doesn't exist
- file:
    path: /etc/some_directory
    state: directory
    mode: 0755
```
#### [template](http://docs.ansible.com/ansible/latest/modules/template_module.html)
```yaml
# Example from Ansible Playbooks
- template:
    src: /mytemplates/foo.j2
    dest: /etc/file.conf
    owner: bin
    group: wheel
    mode: 0644

# The same example, but using symbolic modes equivalent to 0644
- template:
    src: /mytemplates/foo.j2
    dest: /etc/file.conf
    owner: bin
    group: wheel
    mode: "u=rw,g=r,o=r"

# Create a DOS-style text file from a template
- template:
    src: config.ini.j2
    dest: /share/windows/config.ini
    newline_sequence: '\r\n'

# Copy a new "sudoers" file into place, after passing validation with visudo
- template:
    src: /mine/sudoers
    dest: /etc/sudoers
    validate: '/usr/sbin/visudo -cf %s'

# Update sshd configuration safely, avoid locking yourself out
- template:
    src: etc/ssh/sshd_config.j2
    dest: /etc/ssh/sshd_config
    owner: root
    group: root
    mode: '0600'
    validate: /usr/sbin/sshd -t -f %s
    backup: yes
```
#### [lineinfile](https://docs.ansible.com/ansible/2.4/lineinfile_module.html)
```yaml
# Before 2.3, option 'dest', 'destfile' or 'name' was used instead of 'path'
- lineinfile:
    path: /etc/selinux/config
    regexp: '^SELINUX='
    line: 'SELINUX=enforcing'

- lineinfile:
    path: /etc/sudoers
    state: absent
    regexp: '^%wheel'

- lineinfile:
    path: /etc/hosts
    regexp: '^127\.0\.0\.1'
    line: '127.0.0.1 localhost'
    owner: root
    group: root
    mode: 0644

- lineinfile:
    path: /etc/httpd/conf/httpd.conf
    regexp: '^Listen '
    insertafter: '^#Listen '
    line: 'Listen 8080'

- lineinfile:
    path: /etc/services
    regexp: '^# port for http'
    insertbefore: '^www.*80/tcp'
    line: '# port for http by default'

# Add a line to a file if it does not exist, without passing regexp
- lineinfile:
    path: /tmp/testfile
    line: '192.168.1.99 foo.lab.net foo'

# Fully quoted because of the ': ' on the line. See the Gotchas in the YAML docs.
- lineinfile:
    path: /etc/sudoers
    state: present
    regexp: '^%wheel\s'
    line: '%wheel ALL=(ALL) NOPASSWD: ALL'

# Yaml requires escaping backslashes in double quotes but not in single quotes
- lineinfile:
    path: /opt/jboss-as/bin/standalone.conf
    regexp: '^(.*)Xms(\\d+)m(.*)$'
    line: '\1Xms${xms}m\3'
    backrefs: yes

# Validate the sudoers file before saving
- lineinfile:
    path: /etc/sudoers
    state: present
    regexp: '^%ADMIN ALL='
    line: '%ADMIN ALL=(ALL) NOPASSWD: ALL'
    validate: '/usr/sbin/visudo -cf %s'
```

### package
```yaml
- name: install ntpdate
  package:
    name: ntpdate
    state: present

# This uses a variable as this changes per distribution.
- name: remove the apache package
  package:
    name: "{{ apache }}"
    state: absent
```

### [service](http://docs.ansible.com/ansible/latest/modules/service_module.html)
```yaml
- name: Start service httpd, if not running
  service:
    name: httpd
    state: started

- name: Stop service httpd, if running
  service:
    name: httpd
    state: stopped

- name: Restart service httpd, in all cases
  service:
    name: httpd
    state: restarted

- name: Reload service httpd, in all cases
  service:
    name: httpd
    state: reloaded

- name: Enable service httpd, and not touch the running state
  service:
    name: httpd
    enabled: yes

- name: Start service foo, based on running process /usr/bin/foo
  service:
    name: foo
    pattern: /usr/bin/foo
    state: started

- name: Restart network service for interface eth0
  service:
    name: network
    state: restarted
    args: eth0
```

### [debug](http://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)
Für mehr informationen was ansible tut und wie es Verbindungen aufbaut.
```shell
ansible --help
<snip>
  -v, --verbose         verbose mode (-vvv for more, -vvvv to enable
                        connection debugging)
</snip>
```

Das Debug Module
```yaml
# Example that prints the loopback address and gateway for each host
- debug:
    msg: "System {{ inventory_hostname }} has uuid {{ ansible_product_uuid }}"

- debug:
    msg: "System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}"
  when: ansible_default_ipv4.gateway is defined

- shell: /usr/bin/uptime
  register: result

- debug:
    var: result
    verbosity: 2

- name: Display all variables/facts known for a host
  debug:
    var: hostvars[inventory_hostname]
    verbosity: 4
```

### [cron](http://docs.ansible.com/ansible/latest/modules/cron_module.html)
```yaml
# Ensure a job that runs at 2 and 5 exists.
# Creates an entry like "0 5,2 * * ls -alh > /dev/null"
- cron:
    name: "check dirs"
    minute: "0"
    hour: "5,2"
    job: "ls -alh > /dev/null"

# Ensure an old job is no longer present. Removes any job that is prefixed
# by "#Ansible: an old job" from the crontab
- cron:
    name: "an old job"
    state: absent

# Creates an entry like "@reboot /some/job.sh"
- cron:
    name: "a job for reboot"
    special_time: reboot
    job: "/some/job.sh"

# Creates an entry like "PATH=/opt/bin" on top of crontab
- cron:
    name: PATH
    env: yes
    value: /opt/bin

# Creates an entry like "APP_HOME=/srv/app" and insert it after PATH
# declaration
- cron:
    name: APP_HOME
    env: yes
    value: /srv/app
    insertafter: PATH

# Creates a cron file under /etc/cron.d
- cron:
    name: yum autoupdate
    weekday: 2
    minute: 0
    hour: 12
    user: root
    job: "YUMINTERACTIVE: 0 /usr/sbin/yum-autoupdate"
    cron_file: ansible_yum-autoupdate

# Removes a cron file from under /etc/cron.d
- cron:
    name: "yum autoupdate"
    cron_file: ansible_yum-autoupdate
    state: absent

# Removes "APP_HOME" environment variable from crontab
- cron:
    name: APP_HOME
    env: yes
    state: absent
```
### [user](http://docs.ansible.com/ansible/latest/modules/user_module.html)
```yaml
- name: Add the user 'johnd' with a specific uid and a primary group of 'admin'
  user:
    name: johnd
    comment: John Doe
    uid: 1040
    group: admin

- name: Add the user 'james' with a bash shell, appending the group 'admins' and 'developers' to the user's groups
  user:
    name: james
    shell: /bin/bash
    groups: admins,developers
    append: yes

- name: Remove the user 'johnd'
  user:
    name: johnd
    state: absent
    remove: yes

- name: Create a 2048-bit SSH key for user jsmith in ~jsmith/.ssh/id_rsa
  user:
    name: jsmith
    generate_ssh_key: yes
    ssh_key_bits: 2048
    ssh_key_file: .ssh/id_rsa

- name: Added a consultant whose account you want to expire
  user:
    name: james18
    shell: /bin/zsh
    groups: developers
    expires: 1422403387
```

## Ansible Howto Start

### Ansible Galaxy
```shell
ansible-galaxy init <name>
```

## [Inventory Examples](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)
* [Static Inventory](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)
* [Dynamic Inventory](http://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#intro-dynamic-inventory)


## [Variablen](http://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html)
### Im Play definieren
```yaml
- hosts: webservers
  vars:
    http_port: 80
```

### In Templates
```shell
My amp goes to {{ max_amp_value }}
```
```yaml
variable: "My amp goes to {{ max_amp_value }}"
```
Oneline Template example (anlehnung an adhoc command)
```yaml
template: src=foo.cfg.j2 dest={{ remote_install_path }}/foo.cfg
```

## [Host and Group Vars](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)
## [Variable scoping](http://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable)
