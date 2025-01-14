# Greelight

Greenlight is a REST API built with Go 1.23 to get movies informations. It was developed following the [Let's Go Further](https://lets-go-further.alexedwards.net/) book by Alex Edwards. It implements the following concepts:

- Configuration management
- Logging and error handling
- SQL Database connection pool
- Database migrations
- Middlewares
- Filtering, sort and pagination
- IP based rate limiting
- Graceful shutdown with OS signals
- Email sending
- Authentication and permission-based authorization
- Cross Origin Requests
- Reverse proxy with IP fowarding

## Getting stated

### Makefile

To help manage and execute the project, there's a Makefile with some actions available. To list the actions and it's description you can run the following command:
```sh
$ make help
```

### Enviroment Variables

To run the make actions and adicional setups without any issue you must create a `.env` file based on the [.env.example](./.env.example).

### Docker Container

This project use a PostgreSQL database to data persistence. A `docker-compose.yaml` file is available to setup a simple postgres image. You can get and install the Docker tooling following the [official documentation](https://docs.docker.com/get-started/get-docker/).

To pull the image and start the container you can run the following command:

```sh
$ docker compose up -d
```

### Database Migrations

To run migrations related actions it's required install the [migration tool](https://github.com/golang-migrate/migrate/tree/master/cmd/migrate#installation) e.g: 

```sh
$ cd /tmp
$ curl -L https://github.com/golang-migrate/migrate/releases/download/v4.16.2/migrate.linux-amd64.tar.gz | tar xvz
$ mv migrate ~/go/bin/
```

## Dependencies

- [julienschmidt/httprouter](https://github.com/julienschmidt/httprouter): A lightweight high performance HTTP request router.
- [lib/pq](https://github.com/lib/pq): A pure Go postgres driver for Go's database/sql package.
- [go-mail/mail](https://github.com/go-mail/mail): A simple and efficient package to send emails.
- [tomasen/realip](https://github.com/tomasen/realip): A package used to get client's real public IP.
