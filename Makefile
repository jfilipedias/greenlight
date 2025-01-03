.PHONY: tidy clean build run

include .env
export

CMD_DIR=./cmd/api
BINARY_NAME=./bin/api
MIGRATION_DIR=./migrations

confirm:
	@echo 'Are you sure? [y/N]' && read ans && [ $${ans:-N} = y ]

tidy:
	go fmt ./...
	go mod tidy -v

clean:
	rm -f ${BINARY_NAME}

build/api:
	go build -o ${BINARY_NAME} ${CMD_DIR}

run/api:
	go run ${CMD_DIR}

help/api:
	go run ${CMD_DIR} -help

migration/new:
	@echo 'Creating migration files for ${name}...'
	migrate create -seq -ext sql -dir=${MIGRATION_DIR} ${name}

migration/up: confirm
	@echo 'Running up migrations...'
	migrate -path ${MIGRATION_DIR} -database ${DATABASE_DSN} up


migration/down: confirm
	@echo 'Running down migrations...'
	migrate -path ${MIGRATION_DIR} -database ${DATABASE_DSN} down 1
