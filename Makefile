NAME := nginx-openresty-prometheus-example
GITCOMMIT := $(shell git rev-parse --short=10 HEAD 2>/dev/null)

BASE_IMAGE_URL := github.com/marc-barry/$(NAME)
IMAGE_URL := $(BASE_IMAGE_URL):$(GITCOMMIT)

image-create:
	docker build --pull -t ${IMAGE_URL} .

run: image-create
	docker run -p 127.0.0.1:80:80/tcp -p 127.0.0.1:8080:8080/tcp -p 127.0.0.1:9145:9145/tcp -it ${IMAGE_URL}