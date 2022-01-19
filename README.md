## Vagrant & Ansible 를 이용한 서버구성 자동화
- ### 필요한 도구
    - Vagrant
    - Ansible
    - VirtualBox


## 개요
- ### Vagrant
    - 가상머신(ex VirtualBox)을 프로비저닝 할 수 있게 해준다 (Provisioning)
    - 설정파일: Vagrantfile
- ### Ansible
    - yaml 파일로 인프라 구성을 자동화 한다


## Vagrant
- ### Vagrant 설치
    ```bash
    $ brew install vagrant
    $ vagrant plugin install vagrant-vbguest --plugin-version 0.21
    $ vagrant plugin install vagrant-disksize
    ```


- ### Vagrant 설정
    ```bash
    $ mkdir vagrant-test

    $ cd vagrant-test

    $ vagrant init

    # vagrant 설정 편집
    $ vi ./Vagrantfile

    # vagrant 시스템 기동
    $ vagrant up

    # vagrant ssh 접속
    $ vagrant ssh web01
    ```


- ### Vagrant 명령어
    ```bash
    $ vagrant help

    # 버전
    $ vagrant -v
    $ vagrant --version

    # vm 시작
    $ vagrant up
    $ vagrant up --debug

    # vm 중지
    $ vagrant halt

    # vm 삭제
    $ vagrant destroy
    $ vagrant destroy -f

    $ vagrant reload

    $ vagrant provision

    # ssh 접속
    $ vagrant ssh

    # plugin 설치
    $ vagrant plugin install vagrant-vbguest
    $ vagrant plugin install vagrant-vbguest --plugin-version 0.21

    # plugin 삭제
    $ vagrant plugin uninstall vagrant-vbguest
    ```


## Ansible
- ### ansible-server 에 ansible 설치
    ```bash
    $ sudo yum update -y
    $ sudo yum install -y ansible

    $ which ansible
    /usr/bin/ansible

    $ $ ansible --version
    ansible 2.9.25
      config file = /etc/ansible/ansible.cfg
      configured module search path = [u'/home/vagrant/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
      ansible python module location = /usr/lib/python2.7/site-packages/ansible
      executable location = /usr/bin/ansible
      python version = 2.7.5 (default, Apr  2 2020, 13:16:51) [GCC 4.8.5 20150623 (Red Hat 4.8.5-39)]
    ```
- ### ansible-server 에서 configuration 수정
    ```bash
    $ sudo vi /etc/ansible/hosts
    # Ex 2: A collection of hosts belonging to the 'webservers' group
    [was]
    192.168.1.21
    192.168.1.22

    # ansible-client 에 ssh public key 등록한 후에 테스트
    $ ansible all --list-hosts
        hosts (2):
          192.168.1.21
          192.168.1.22
    ```
- ### ansible-server 에서 ssh 키 생성
    ```bash
    $ ssh-keygen -f ~/.ssh/id_rsa -P ''

    $ ls -l ~/.ssh
    -rw-------. 1 vagrant vagrant 1679 Jan 13 02:40 id_rsa
    -rw-r--r--. 1 vagrant vagrant  404 Jan 13 02:40 id_rsa.pub
    ````
- ### ansible-client 에서 ssh config 수정
    ```bash
    # PasswordAuthentication yes 로 수정
    $ sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

    $ sudo systemctl restart sshd
    ```
- ### ansible-server 에서 ansible-client 로 ssh public 키 전송
    ```bash
    $ ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.1.21
    $ ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.1.22
    ```
    ```bash
    $ ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.1.21
    /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"
    /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
    /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
    vagrant@192.168.1.21's password:

    Number of key(s) added: 1

    Now try logging into the machine, with:   "ssh 'vagrant@192.168.1.21'"
    and check to make sure that only the key(s) you wanted were added.
    ```
    ```bash
    $ ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.1.22
    /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"
    The authenticity of host '192.168.1.22 (192.168.1.22)' can't be established.
    ECDSA key fingerprint is SHA256:fl4vkIqXIHgp/QnjjH7rqX9sVFV8VpICv/SplpvhMAQ.
    ECDSA key fingerprint is MD5:3f:cf:13:40:52:47:e4:25:2f:a7:12:c6:04:2b:bc:e1.
    Are you sure you want to continue connecting (yes/no)? yes
    /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
    /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
    vagrant@192.168.1.22's password:

    Number of key(s) added: 1

    Now try logging into the machine, with:   "ssh 'vagrant@192.168.1.22'"
    and check to make sure that only the key(s) you wanted were added.
    ```
- ### ansible-client 에서 ssh 키 등록됐는지 확인
    ```bash
    $ ssh vagrant@192.168.1.21 'cat ~/.ssh/authorized_keys'
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFygdj25I7lsSw3giOsj1AjdFR3htdSB4Fd/4fz/+uSyp1dNBGnKtmcVfVrdv4LsZI1CDue0g7+OvECDmJhkUtkeVa/y1SfBDl4LlT9FDUHnXugXR0z4Yp2T6x2xcH3DUyBYn/IKfIwwgHTzeISFLbmWoXDtH+E92bIB2YBsRF+SiST+Ez4Hc0RV9cdKwDeagAz56bJ3UFdN+oLcZRuDvAbjg5Y+e9RECzptEIiZX86hdP0j1Puqp2Nl/QNAK6Jo9PUXQN+iJMQF5EgPkJbYmTBjPZj8oo8b4D4cKegoLT3tO11+LI95ijfussOJvbgaCZgdAtyrhJNgBxmg+1X/gN vagrant@ansible-server
    ```
    ```bash
    $ ssh vagrant@192.168.1.22 'cat ~/.ssh/authorized_keys'
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFygdj25I7lsSw3giOsj1AjdFR3htdSB4Fd/4fz/+uSyp1dNBGnKtmcVfVrdv4LsZI1CDue0g7+OvECDmJhkUtkeVa/y1SfBDl4LlT9FDUHnXugXR0z4Yp2T6x2xcH3DUyBYn/IKfIwwgHTzeISFLbmWoXDtH+E92bIB2YBsRF+SiST+Ez4Hc0RV9cdKwDeagAz56bJ3UFdN+oLcZRuDvAbjg5Y+e9RECzptEIiZX86hdP0j1Puqp2Nl/QNAK6Jo9PUXQN+iJMQF5EgPkJbYmTBjPZj8oo8b4D4cKegoLT3tO11+LI95ijfussOJvbgaCZgdAtyrhJNgBxmg+1X/gN vagrant@ansible-server
    ```
- ### ansible-playbook
    - ### config 파일 생성
        ```bash
        $ sudo vi /etc/ansible/tomcat-setup.yml
        ```
        ```yaml
        - name: install tomcat server
          hosts: all
          become: true

          tasks:
          - name: install OpenJDK
            apt: 
              name: openjdk-11-jre-headless
              
          - name: download tomcat server packages
            get_url:
              url: https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz
              dest: /usr/local

          - name: extract tomcat packages
            unarchive:
              src: /usr/local/apache-tomcat-9.0.56.tar.gz
              dest: /usr/local
              remote_src: yes

          - name: start tomcat server
            shell: nohup /usr/local/apache-tomcat-9.0.56/bin/startup.sh
        ```
    - ### config 파일 실행
        ```bash
        $ sudo ansible-playbook tomcat-setup.yml
        ```
    - ### list hosts
        ```bash
        $ ansible all --list-hosts
          hosts (2):
            192.168.1.21
            192.168.1.22
        ```
    - ### ping check
        ```bash
        $ ansible all -m ping
        192.168.1.21 | SUCCESS => {
            "ansible_facts": {
                "discovered_interpreter_python": "/usr/bin/python"
            },
            "changed": false,
            "ping": "pong"
        }
        ```
    