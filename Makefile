SHELL=/bin/bash

usage=make <target>

include .env

.PHONY: clean

build:
	docker-compose build --no-cache 

push:
	docker-compose push

run:
	docker-compose up &

stop:
	docker-compose down

ssh-key: clean
	mkdir -p ssh
	ssh-keygen -t rsa -b 4096 -C '' -f ./ssh/id_rsa -q -N ''
	chmod 400 ./ssh/id_rsa

network:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' app
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bastion

clean:
	rm -rf ssh/id_rsa*

