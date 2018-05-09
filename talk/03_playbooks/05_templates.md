## [Ansible - Simple Templates](http://docs.ansible.com/ansible/latest/modules/template_module.html)

Jetzt hat man all den Kram, wie wendet man das nun sinnvoll an?

### Zu Beginn

```yaml
hosts: localhost
remote_user: root
gathering_facts: no
vars:
  issue_text: "Welcome to my server"
tasks:
  - name: "Templating issue.net"
    template:
      src: issue.net.j2
      dest: /etc/banner/issue.net
      owner: root
      group: root
      mode: 0644
```

```shell
# cat issue.net.j2
Ansible generated message:
{{ issue_text }}
```
