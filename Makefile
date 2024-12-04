.PHONY: tidy clean build run

include .env
export

CMD_DIR=./cmd/api
BINARY_NAME=./bin/api
MIGRATION_DIR=./migrations

tidy:
	go fmt ./...
	go mod tidy -v

clean:
	rm -f $(BINARY_NAME)

build:
	go build -o $(BINARY_NAME) $(CMD_DIR)
	
run:
	go run $(CMD_DIR)

help:
	go run $(CMD_DIR) -help

migration:
	migrate create -seq -ext=sql -dir=$(MIGRATION_DIR) $(name)

migration-up:
	migrate -path=$(MIGRATION_DIR) -database $(DATABASE_DSN) up
