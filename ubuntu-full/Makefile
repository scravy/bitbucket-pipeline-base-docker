push: build
	docker push scravy/bitbucket-pipeline-base-docker:ubuntu-full

build:
	docker build --platform linux/amd64 --progress plain --no-cache -t scravy/bitbucket-pipeline-base-docker:ubuntu-full .

