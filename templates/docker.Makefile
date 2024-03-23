# Makefile
# for 
# Docker container/image management

## Variables/Ingredients

### Images

#### General
CONTEXT ?= . # The context is also known as the current working directory when the image is built

#### Stage 1 (Base)
STAGE_1_IMAGE_NAME ?= [author]/[image-name]
STAGE_1_IMAGE_TAG ?= [tag|version]
STAGE_1_BUILD_ARGS ?= 
STAGE_1_DOCKERFILE ?= /path/to/custom/Dockerfile

#### Stage N (Multistaged build - Add-on Dockerfiles)
STAGE_2_IMAGE_NAME ?= [author]/[image-name] # Use the same name as the previous stage's image to build on top of it
STAGE_2_IMAGE_TAG ?= [tag|version] # Use the same tag as the previous stage's image to build on top of it; Use a different tag to switch between versions
STAGE_2_BUILD_ARGS ?= --build-arg "[ARGUMENT_VARIABLE]=[value]" # Set build arguments
STAGE_2_DOCKERFILE ?= /path/to/stage-2/custom/Dockerfile

### Containers
CONTAINER_IMAGE_NAME ?= [target-image-name] # Specify the target image you wish to startup the container with
CONTAINER_IMAGE_TAG ?= [target-image-tag] # Specify the tag/version of the target image you chose to startup the container with
CONTAINER_NAME ?= [container-name]
CONTAINER_OPTS ?= --restart=unless-stopped # Other Options; i.e. --user=${USER}, --workdir=/projects
CONTAINER_PORT_FORWARDING ?=    # Port Forward/Translate/Map from host system to container; -p "[host-ip-address]:[host-system-port]:[container-port]"
CONTAINER_MOUNT_VOLUMES ?=      # Mount Host System Volume; -v "[host-system-volume]:[container-volume]:[permissions]"
CONTAINER_PASSTHROUGH_DEVICE ?= # --device "[host-system-device-file]:[container-mount-point]"
CONTAINER_EXEC ?= ${SHELL} # Command to execute

### System
SHELL := /bin/bash
.PHONY := help build-stage-1 run
.DEFAULT_RULES := help

## Recipe/Targets
help:
	## Display help message
	@echo -e "[+] help : Display Help message"
	@echo -e "[+] build-stage-1 : Build Stage 1 (Base) image from multi-stage build"
	@echo -e "[+] build-stage-N : Build Stage N image from multi-stage build"
	@echo -e "[+] run : Startup a container from an image"
	@echo -e "[+] enter : Chroot and enter the container"
	@echo -e "[+] exec : Execute command in container"
	@echo -e "[+] start : Start the container if stopped and exists"
	@echo -e "[+] stop : Stop the container if running"
	@echo -e "[+] restart : Restart the container if running"
	@echo -e "[+] remove : Remove the container if exists"
	@echo -e "[+] logs : Display logs of the container"
	@echo -e "[+] proc : Display processes of the container"

build-stage-1:
	## Build image from Dockerfile
	@docker build \
		-t ${STAGE_1_IMAGE_NAME}:${STAGE_1_IMAGE_TAG} \
		${STAGE_1_BUILD_ARGS} \
		-f ${STAGE_1_DOCKERFILE} \
		${CONTEXT}

build-stage-2:
	## Build stage 2 image from Dockerfile
	## - Use this as a template to add for every new build stage you wish to create
	@docker build \
		-t ${STAGE_2_IMAGE_NAME}:${STAGE_2_IMAGE_TAG} \
		${STAGE_2_BUILD_ARGS} \
		-f ${STAGE_2_DOCKERFILE} \
		${CONTEXT}

run:
	## Startup a container from an image
	@docker run -itd \
		--name=${CONTAINER_NAME} \
		${CONTAINER_OPTS} \
		-e SHELL=${SHELL} \
		${CONTAINER_PORT_FORWARDING} \
		${CONTAINER_MOUNT_VOLUMES} \
		${CONTAINER_IMAGE_NAME}:${CONTAINER_IMAGE_TAG}

start:
	## Start the container if stopped and exists
	@docker start ${CONTAINER_NAME}

stop:
	## Stop the container if running
	@docker stop ${CONTAINER_NAME}

restart:
	## Restart the container if running
	@docker restart ${CONTAINER_NAME}

remove:
	## Remove the container if exists
	@docker rm ${CONTAINER_NAME}

logs:
	## Display logs of the container
	@docker logs ${CONTAINER_NAME}

proc:
	## Display processes of the container
	@test -n "${CONTAINER_NAME}" && \
		docker ps | grep ${CONTAINER_NAME} || \
		docker ps

enter:
	## Chroot and enter the container
	@docker exec -it ${CONTAINER_NAME} ${SHELL}

exec:
	## Execute command in container
	@docker exec -it ${CONTAINER_NAME} ${CONTAINER_EXEC}

