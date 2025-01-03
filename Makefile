include .env
export

CMD_DIR=./cmd/api
BINARY_NAME=./bin/api
MIGRATION_DIR=./migrations

## help: prints this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

.PHONY: confirm
confirm:
	@echo 'Are you sure? [y/N]' && read ans && [ $${ans:-N} = y ]

## tidy: format code and fix modules related problems
.PHONY: tidy
tidy: confirm
	go fmt ./...
	go mod tidy -v

## clean: remove built binary
.PHONY: clean
clean: confirm
	rm -f ${BINARY_NAME}

## build/api: compile the cmd/api application
.PHONY: build/api
build/api:
	go build -o ${BINARY_NAME} ${CMD_DIR}

## run/api: run the cmd/api application
.PHONY: run/api
run/api:
	go run ${CMD_DIR}

## help/api: prints the cmd/api application help message
.PHONY: help/api
help/api:
	go run ${CMD_DIR} -help

## migrations/new name=$1: create a new database migration
.PHONY: migrations/new
migrations/new:
	@echo 'Creating migration files for ${name}...'
	migrate create -seq -ext sql -dir=${MIGRATION_DIR} ${name}

## migrations/up: apply all up database migrations
.PHONY: migrations/up
migrations/up: confirm
	@echo 'Running up migrations...'
	migrate -path ${MIGRATION_DIR} -database ${DATABASE_DSN} up
