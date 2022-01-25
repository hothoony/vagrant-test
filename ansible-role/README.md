# Ansible Role

- ## roles 폴더 생성
    - role 은 roles 폴더 아래에 위치해야 한다
    ```bash
    $ mkdir roles
    $ cd roles
    ```

- ## role 생성
    ```bash
    # ansible-galaxy init 롤이름
    ```

    ```bash
    # roles 폴더 아래에서 생성한다
    $ cd roles
    
    # web, was, db 생성
    $ ansible-galaxy init web
    - Role web was created successfully
    
    $ ansible-galaxy init was
    - Role was was created successfully
    
    $ ansible-galaxy init db
    - Role db was created successfully
    ```
    
    ```bash
    # 생성결과 확인
    $ tree
    .
    ├── db
    │   ├── defaults
    │   │   └── main.yml
    │   ├── files
    │   ├── handlers
    │   │   └── main.yml
    │   ├── meta
    │   │   └── main.yml
    │   ├── README.md
    │   ├── tasks
    │   │   └── main.yml
    │   ├── templates
    │   ├── tests
    │   │   ├── inventory
    │   │   └── test.yml
    │   └── vars
    │       └── main.yml
    ├── was
    │   ├── defaults
    │   │   └── main.yml
    │   ├── files
    │   ├── handlers
    │   │   └── main.yml
    │   ├── meta
    │   │   └── main.yml
    │   ├── README.md
    │   ├── tasks
    │   │   └── main.yml
    │   ├── templates
    │   ├── tests
    │   │   ├── inventory
    │   │   └── test.yml
    │   └── vars
    │       └── main.yml
    └── web
        ├── defaults
        │   └── main.yml
        ├── files
        ├── handlers
        │   └── main.yml
        ├── meta
        │   └── main.yml
        ├── README.md
        ├── tasks
        │   └── main.yml
        ├── templates
        ├── tests
        │   ├── inventory
        │   └── test.yml
        └── vars
            └── main.yml
    ```

- ## role 구성요소
    - defaults
    - files
    - handlers
    - meta
    - tasks
    - templates
    - tests
    - vars

- ## hosts 파일 생성
    ```bash
    $ vi hosts
    [web]
    192.168.1.11

    [was]
    192.168.1.21

    [db]
    192.168.1.31
    ```

- ## role-playbook.yml
    ```yaml
    ---
    - hosts: web
    roles:
        - web

    - hosts: was
    roles:
        - was

    - hosts: db
    roles:
        - db
    ```
- ## playbook 실행
    ```bash
    $ ansible-playbook role-playbook.yml -i hosts
    ```
