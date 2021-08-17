push: build
	docker push scravy/bitbucket-pipeline-base-docker:ubuntu-slim

build:
	docker build -t scravy/bitbucket-pipeline-base-docker:ubuntu-slim .
