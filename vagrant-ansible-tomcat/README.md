## ansible-server 에서 실행

- ## hosts 정보 등록
    ```bash
    $ vi hosts
    [tomcat-server]
    192.168.1.21

    $ cat hosts
    [tomcat-servers]
    192.168.1.21

    $ ll
    -rw-rw-r--. 1 vagrant vagrant  30 Jan 24 07:17 hosts
    -rw-rw-r--. 1 vagrant vagrant 742 Jan 24 07:33 tomcat-setup.yml
    ```

- ## ping 테스트
    ```bash
    $ ansible all -m ping -i hosts
    ```

- ## ansible playbook 실행 
    ```bash
    $ ansible-playbook -i hosts tomcat-setup.yml --check

    $ ansible-playbook -i hosts tomcat-setup.yml
    ```
