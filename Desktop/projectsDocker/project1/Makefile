DOCKERHUB_USER = dimych
IMAGE = myappw
TAG = latest
NAME = myapps
PORT = 3000
GIT_SHA = $(shell git describe --always --dirty --abbrev=7)
 
.PHONY: build run stop rm rmi ps logs sh tag push login release restart up
 
build:
	docker build -t $(IMAGE):$(TAG) .
 
run:
	docker run -d --name $(NAME) -p $(PORT):$(PORT) $(IMAGE):$(TAG)
 
stop:
	docker stop $(NAME)
 
rm:
	docker rm $(NAME)
 
rmi:
	docker rmi $(IMAGE):$(TAG)
 
ps:
	docker ps --filter "name=$(NAME)"
 
logs:
	docker logs -f $(NAME)
 
sh:
	docker exec -it $(NAME) sh
 
tag:
	docker tag $(IMAGE):$(TAG) $(DOCKERHUB_USER)/$(IMAGE):$(TAG)
	docker tag $(IMAGE):$(TAG) $(DOCKERHUB_USER)/$(IMAGE):$(GIT_SHA)
 
login:
	docker login -u $(DOCKERHUB_USER)
 
push: tag
	docker push $(DOCKERHUB_USER)/$(IMAGE):$(TAG)
	docker push $(DOCKERHUB_USER)/$(IMAGE):$(GIT_SHA)
 
up: build run
 
restart: stop rm build run
 
release: build tag push