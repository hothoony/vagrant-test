# ansible 명령어 파라미터
- -m, module
- -a, arguments

# ansible 명령어 사용법
## uptime
```bash
$ ansible all -m shell -a "uptime" -k
SSH password:
```

## disk usage
```bash
$ ansible all -m shell -a "df -h"
```

## memory
```bash
$ ansible all -m shell -a "free -h" -k
SSH password:
```

## create user
```bash
$ ansible all -m user -a "name=bloter password=1234" -l
SSH password:
```

## file transfer
```bash
$ ansible nginx -m copy -a "src=./bloter.file dest=/tmp"
SSH password:
```

## httpd 설치
```bash
$ ansible nginx -m yum -a "name=httpd state=present" -k
SSH password:
```

## firewall 해제
```bash
$ ansible nginx -m shell -a "systemctl stop firewalld" -k
SSH password:
```

# playbook
- 아래 명령은 실행한 만큼 내용이 추가됨
  ```bash
  $ echo -e "[bloter]\n192.168.1.13" >> /etc/ansible/hosts
  $ cat /etc/ansible/hosts
  ```

- playbook 으로 실행하면 한번만 추가됨 (멱등성: 여러번 실행해도 결과가 다르지 않음)
  ```bash
  $ vi bloter.yml
  ---
  - name: Ansible_vim
  hosts: localhost

  tasks:
      - name: add ansible hosts
      blockinfile:
          path: /etc/ansible/hosts
          block:
          [bloter]
          192.168.1.13
  ```
  ```bash
  $ ansible-playbook bloter.yml
  ```
- ### nginx.yml
  ```bash
  ---
  - hosts: nginx
    remote_user: root
    tasks:
      - name: install epel-release
        yum: name=epel-release state=latest
      - name: install nginx
        yum: name=nginx state=present
      - name: upload default index.html
        copy: src=index.html dest=/usr/share/nginx/html/ mode=0644
      - name: start nginx
        service: name=nginx state=started
  ```

## ansible.cfg
```bash
$ vi /etc/ansible/ansible.cfg
## before
#stdout_callback = skippy

## after
stdout_callback = debug
```
