# Einfach mal was machen

## Vorbereitung

Man braucht ein wenig für eine Spielwiese
### Installation
```shell
pip install ansible
```

### Inventory
```shell
echo "ubuntu ansible_host=<ip here> ansible_port=22 ansible_user=root" > inventory
```

## Playground

```shell
$ ansible ubuntu -m ping

```
```shell
ubuntu | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

```shell
$ ansible ubuntu -m package -a "name=openssh-server state=present"

```
```shell
ubuntu | SUCCESS => {
    "cache_update_time": 1523956675,
    "cache_updated": false,
    "changed": false
}
```

```shell
$ ansible ubuntu -m package -a "name=htop state=present"
```
