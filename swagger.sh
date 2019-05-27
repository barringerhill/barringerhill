#!/bin/bash
#
# Lark Swagger
readonly SWAGER_UI='swaggerapi/swagger-ui';
readonly SWAGER_EDITOR='swaggerapi/swagger-editor';

### Swagger-UI
# 
# You can pull a pre-built docker image of the swagger-ui directly from Docker Hub:
# 
# ```
# docker pull swaggerapi/swagger-ui
# docker run -p 80:8080 swaggerapi/swagger-ui
# ```
# 
# Will start nginx with swagger-ui on port 80.
# 
# Or you can provide your own swagger.json on your host
# 
# ```
# docker run -p 80:8080 -e SWAGGER_JSON=/foo/swagger.json -v /bar:/foo swaggerapi/swagger-ui
# ```
# 
# The base URL of the web application can be changed by specifying the `BASE_URL` environment variable:
# 
# ```
# docker run -p 80:8080 -e BASE_URL=/swagger -e SWAGGER_JSON=/foo/swagger.json -v /bar:/foo swaggerapi/swagger-ui
# ```
# 
# This will serve Swagger UI at `/swagger` instead of `/`.
# 
# For more information on controlling Swagger UI through the Docker image, see the Docker section of the [Configuration documentation][0]
#
# [0]: https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/configuration.md#docker
###
ui() {
    echo "\033[0;32mStart docker container ${SWAGER_EDITOR} at 3000...\033[0m"
    if ! docker ps | grep "${SWAGER_UI}" > '/dev/null' 2>&1; then
	echo "Start docker container ${SWAGER_UI} ..."
	docker rm "${SWAGER_UI}" > '/dev/null' 2>&1
	docker run -p 80:3000 swaggerapi/swagger-ui
	echo 'Input C-c to stop...'
    fi
}

### Swagger-Editor
# 
# ## Running the image from DockerHub
# There is a docker image published in [DockerHub][0]
# 
# To use this, run the following:
# 
# ```
# docker pull swaggerapi/swagger-editor
# docker run -d -p 80:8080 swaggerapi/swagger-editor
# ```
# 
# This will run Swagger Editor (in detached mode) on port 80 on your machine, so you can open it by navigating to `http://localhost` in your browser.
# 
# ## Building and running an image locally
# 
# To build and run a docker image with the code checked out on your machine, run the following from the root directory of the project:
# 
# ```
# # Install npm packages (if needed)
# npm install
# 
# # Build the app
# npm run build
# 
# # Build an image
# docker build -t swagger-editor .
# 
# # Run the container
# docker run -d -p 80:8080 swagger-editor
# 
# ```
# 
# You can then view the app by navigating to `http://localhost` in your browser.
#
# [0]: https://hub.docker.com/r/swaggerapi/swagger-editor/
###
editor() {
    if ! docker ps | grep "${SWAGER_EDITOR}" > '/dev/null' 2>&1; then
	echo "\033[0;32mStart docker container ${SWAGER_EDITOR} at 5000...\033[0m"
	docker rm "${SWAGER_EDITOR}" > '/dev/null' 2>&1
	docker run -d -p 80:8080 swaggerapi/swagger-editor
    fi
}

### Usage
usage() {
    cat <<EOF
Usage: sh swagger.sh <COMMAND>

Command:
	ui       ~>   open swagger-ui
	editor   ~>   open swagger-editor
	all      ~>   open swagger-ui and swagger-editor
	usage    ~>   show usage
EOF
}

### COMMANDS
readonly COMMAND="$1";
case "${COMMAND}" in
    ui)
	ui
	;;
    editor)
	editor
	;;
    all)
	ui
	editor
	;;
    *)
	usage
	;;
esac
