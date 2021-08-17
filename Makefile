push: build
	docker push scravy/bitbucket-pipeline-base-docker:latest

build:
	docker build -t scravy/bitbucket-pipeline-base-docker:latest .

