# Akash SSH Boilerplate


## Prerequisite

### Create .env file
```
ACCOUNT=<docker account>
APP_REPOSITORY=<docker repository>
APP_TAG=<docker image tag>
BASTION_HOST_REPOSITORY=<docker repository>
BASTION_HOST_TAG=<docker image tag>
SSH_USER=<ssh user>
SSH_PORT=<ssh port to be exposed>
SSH_PUBLIC_KEY=<ssh public key>
SUBNET=<custom subnet for docker network e.g. 172.30.0.0/16>
```

## Commands

### Generate ssh key
    mkdir -p ssh
	ssh-keygen -t rsa -b 4096 -C '' -f ./ssh/id_rsa -q -N ''
	chmod 400 ./ssh/id_rsa

### Build
	docker-compose build --no-cache 

### Push docker image to remote repository
	docker-compose push

### Run docker locally
    docker-compose up

### Stop containers
    docker-compose down

### Get docker cointainer IP
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container>

### SSH into a bastion host
    eval `ssh-agent -s`
	ssh-add ./ssh/id_rsa
	ssh -A <ssh user>@<provider> -p <provider generated port>



<em>Alternatively you can use `make` command (see Makefile)</em>
