## vagrant 실행
```bash
$ vagrant up
```

## vagrant status
```bash
$ vagrant status
Current machine states:

default                   running (docker)

The container is created and running. You can stop it using
`vagrant halt`, see logs with `vagrant docker-logs`, and
kill/destroy it with `vagrant destroy`.
```

## docker-exec
```bash
$ vagrant docker-exec -it default -- /bin/bash
```

### stop
```bash
$ vagrant stop
```

### destroy
```bash
$ vagrant destroy -f
```