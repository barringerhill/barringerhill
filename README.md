# Lazy-swagger

Swagger-ui / Swagger-editor docker scripts wrapper.

_Please install [docker-server](https://www.docker.com/products/docker-desktop) on your pc/server first._

## Usage

```shell
Usage: sh swagger.sh <COMMAND>

Command:
	ui       ~>   open swagger-ui
	editor   ~>   open swagger-editor
	all      ~>   open swagger-ui and swagger-editor
	usage    ~>   show usage
EOF
```

__Note__: if you want to serve your `swagger-ui`, you can export your `SWAGGER_JSON`'s path to `~/.bashrc` that swagger-ui can auto load your api, otherwise, try this:

```
SWAGGER_JSON='/path/to/swagger.json sh swagger.sh <COMMAND>'
```

__Note__: if you want to stop `swagger-editor`, just exec `docker stop swagger-editor`.


## TODO
+ [ ] set `SWAGGER_JSON`
+ [ ] stop docker containers
+ [ ] implement in packages
  + [ ] node or rust? ruby?

## Official Repo
[swagger][0]

## Swagger-UI
 
You can pull a pre-built docker image of the swagger-ui directly from Docker Hub:

```
docker pull swaggerapi/swagger-ui
docker run -p 80:8080 swaggerapi/swagger-ui
```

Will start nginx with swagger-ui on port 80.

Or you can provide your own swagger.json on your host

```
docker run -p 80:8080 -e SWAGGER_JSON=/foo/swagger.json -v /bar:/foo swaggerapi/swagger-ui
```

The base URL of the web application can be changed by specifying the `BASE_URL` environment variable:

```
docker run -p 80:8080 -e BASE_URL=/swagger -e SWAGGER_JSON=/foo/swagger.json -v /bar:/foo swaggerapi/swagger-ui
```

This will serve Swagger UI at `/swagger` instead of `/`.

For more information on controlling Swagger UI through the Docker image, see the Docker section of the [Configuration documentation][1]


## Swagger-Editor

### Running the image from DockerHub
There is a docker image published in [DockerHub][2]

To use this, run the following:

```
docker pull swaggerapi/swagger-editor
docker run -d -p 80:8080 swaggerapi/swagger-editor
```

This will run Swagger Editor (in detached mode) on port 80 on your machine, so you can open it by navigating to `http://localhost` in your browser.

### Building and running an image locally

To build and run a docker image with the code checked out on your machine, run the following from the root directory of the project:

```
# Install npm packages (if needed)
npm install

# Build the app
npm run build

# Build an image
docker build -t swagger-editor .

# Run the container
docker run -d -p 80:8080 swagger-editor

```

You can then view the app by navigating to `http://localhost` in your browser.


[0]: https://github.com/swagger-api/swagger-ui
[1]: https://github.com/swagger-api/swagger-ui/blob/master/docs/usage/configuration.md#docker
[2]: https://hub.docker.com/r/swaggerapi/swagger-editor/
