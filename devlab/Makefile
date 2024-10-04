
.DEFAULT_GOAL := help
include .env

define HELP

Available commands:

- build: Build all the images from the downloaded infrastructure components. After this execute "make run", followed by "make deploy" and then "make app".

- run: This will call core.
- deploy: This will create the Kafka topics.
- run_app: Run workload creator/the Golang app.
- stop_app: Stop the workload creator/the Golang app.

- stop: Stop the project.
- down: Tear down the project, clean directories.
- ps: Show all running containers.

- logs: Show logs.

- watch: Watch logs.


endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help


build: 
	cd connect; make build

run:
	docker compose -p timeseries up -d  broker schema-registry control-center connect mongodb 

deploy:  createtopics createsink

createtopics:
	cd creTopics; ./creTopics.sh

createsink:
	cd creConnect; ./cremongoatlassinks.sh

down:	
	docker compose down
	cd data; rm -rf mongodb 

app:
	docker compose -p timeseries up -d  broker shadowtraffic

stop:
	docker compose -p timeseries stop shadowtraffic

ps:
	docker compose ps

logs:
	docker compose logs

logsf:
	docker compose logs -f

watch:
	watch docker compose ps

