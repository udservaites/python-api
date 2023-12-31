SHELL := bash
PROJECT_NAME := python_api
DOCKER_NAME := python_api
PORT := 5000

.PHONY: help build-docker run-docker clean stop-docker conda-env lock-conda-env test

help:
	@echo "Please use 'make target' where target is one of"
	@echo "  build-docker          Builds docker container"
	@echo "  run-docker            Runs docker container"
	@echo "  stop-docker           Stops docker container"
	@echo "  clean                 Removes known artifacts created during build steps"
	@echo "  test	           	   Run tests"

build-docker:
	docker build -t $(DOCKER_NAME) -f Dockerfile .
	make clean

run-docker:
	docker run --name $(PROJECT_NAME) --rm -d -p $(PORT):$(PORT) $(DOCKER_NAME)

stop-docker:
	docker rm -f $(PROJECT_NAME)

deploy-server:
	poetry run uvicorn python_api.main:app --reload

deploy-container:
# TODO

create-bottle:
# TODO

import-bottle:
# TODO

clean:
	rm -rf build
	rm -rf dist
	rm -rf *.egg-info
	find . -name ".pytest_cache" | xargs rm -rf
	find . -name "__pycache__" | xargs rm -rf
	rm -rf test/*.txt
	rm -rf test/*.log
	rm -rf test/*.xml

test:
	pytest 