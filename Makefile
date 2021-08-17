push: build
	docker push scravy/bitbucket-pipeline-base-docker:full

build:
	docker build -t scravy/bitbucket-pipeline-base-docker:full .

