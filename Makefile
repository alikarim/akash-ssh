SHELL=/bin/bash

usage=make <target>


ifeq ($(UNAME_S),Darwin)
	sedopt := -i
else
	sedopt := -i ''
endif


include .env

.PHONY: clean

sdl:
	mkdir -p deploy
	filename="$$(date +%m-%d-%Y-%H:%M).yaml"; \
	\cp sdl.template.yaml deploy/$$filename; \
	sed $(sedopt) -e 's/{{APP_IMAGE}}/$(ACCOUNT)\/$(APP_REPOSITORY):$(APP_TAG)/g' deploy/$$filename; \
	sed $(sedopt) -e 's/{{BASTION_IMAGE}}/$(ACCOUNT)\/$(BASTION_HOST_REPOSITORY):$(BASTION_HOST_TAG)/g' deploy/$$filename; \
	sed $(sedopt) -e "s|{{SSH_PUBLIC_KEY}}|$(SSH_PUBLIC_KEY)|g" deploy/$$filename; \
	sed $(sedopt) -e "s|{{SSH_USER}}|$(SSH_USER)|g" deploy/$$filename; \
	sed $(sedopt) -e "s|{{SSH_PORT}}|$(SSH_PORT)|g" deploy/$$filename

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

	ssh_public_key=$$(cat ./ssh/id_rsa.pub); \
	sed $(sedopt) -e "s|SSH_PUBLIC_KEY=.*|SSH_PUBLIC_KEY=$$ssh_public_key|g" .env

network:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' app
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' bastion

clean:
	rm -rf ssh/id_rsa*
	rm -rf deploy

