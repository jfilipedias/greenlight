include .env
export

# ==================================================================================== #
# HELPERS
# ==================================================================================== #

## help: prints this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

.PHONY: confirm
confirm:
	@echo 'Are you sure? [y/N]' && read ans && [ $${ans:-N} = y ]

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #

## run/api: run the cmd/api application
.PHONY: run/api
run/api:
	go run ./cmd/api -db-dsn=${DATABASE_DSN} -smtp-username=${SMTP_USERNAME} -smtp-password=${SMTP_PASSWORD}

## help/api: prints the cmd/api application help message
.PHONY: help/api
help/api:
	go run ./cmd/api -help

## migrations/new name=$1: create a new database migration
.PHONY: migrations/new
migrations/new:
	@echo 'Creating migration files for ${name}...'
	migrate create -seq -ext sql -dir ./migrations ${name}

## migrations/up: apply all up database migrations
.PHONY: migrations/up
migrations/up: confirm
	@echo 'Running up migrations...'
	migrate -path ./migrations -database ${DATABASE_DSN} up

# ==================================================================================== #
# QUALITY CONTROL
# ==================================================================================== #

## tidy: format all .go files and tidy module dependencies
.PHONY: tidy
tidy:
	@echo 'Formatting .go files...'
	go fmt ./...
	@echo 'Tidying module dependencies...'
	go mod tidy

## audit: run quality control checks
.PHONY: audit
audit:
	@echo 'Checking module dependencies'
	go mod tidy -diff
	go mod verify
	@echo 'Vetting code...'
	go vet ./...
	staticcheck ./...
	@echo 'Running tests...'
	go test -race -vet=off ./...
