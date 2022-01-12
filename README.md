## Vagrant & Ansible 를 이용한 서버구성 자동화
- ### 필요한 도구
    - VirtualBox
    - Vagrant
    - Ansible


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
- ### control node 에 ansible 설치
    ```bash
    $ sudo yum update -y
    $ sudo yum install -y ansible
    $ which ansible
    $ ansible --version
    ```
- ### configuration 수정
    ```bash
    $ sudo vi /etc/ansible/hosts
    # Ex 1: Ungrouped hosts, specify before any group headers.
    192.168.1.12

    $ sudo ansible all -i hosts --list-hosts
      hosts (1):
        192.168.1.12
    ```
- ### control node 에서 ssh 키 생성
    ```bash
    $ sudo ssh-keygen

    $ sudo ls -l /root/.ssh
    total 8
    -rw-------. 1 root root 1679 Jan 10 07:26 id_rsa
    -rw-r--r--. 1 root root  401 Jan 10 07:26 id_rsa.pub
    ````
- ### ansible-client 에서
    - #### ssh config 수정
        ```bash
        $ sudo vi /etc/ssh/sshd_config
        PasswordAuthentication yes

        $ sudo systemctl restart sshd
        ```
- ### ansible-server 에서 ansible-client 로 ssh 키 전송
    ```bash
    $ ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.1.12
    /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"
    /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
    /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
    vagrant@192.168.1.12's password:

    Number of key(s) added: 1

    Now try logging into the machine, with:   "ssh 'vagrant@192.168.1.12'"
    and check to make sure that only the key(s) you wanted were added.
    ```
- ### ansible-client 에서 ssh 키 등록됐는지 확인
    ```bash
    $ cat ~/.ssh/authorized_keys
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZPF+rCyAs3UVnd2F7G0XT4w+m0sifYmCqs0ZcHTWb/6N/zsDpUUdMyNWmo0m9FwdPMioezRgOHmuL7Jp/FwfRQki1QMA/COBdvi9385ywqeN8lP7+WmZw0nLxHAj8rju8H9s+6uz7kJN+ItcuFNObO1/7RrItVBYD5MnU64Z0xxiOivcnMeltwW32XDi25zElG8bcsqfnWdpOhestDMT1ezu/ngowH+SoBucK8KQAz9yAhMxCMdDsM9+VcsncjPbsmth31Rv/icPWLCP2mtDYoI7IWHmuSzYw/m2Du/TlJdnzKcDumPPSJ4gej0i9ZLv+6rB+mwAgtBjQODGb504n vagrant@ansible-server
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
        $ sudo ansible-playbook -i hosts tomcat-setup.yml
        ```
