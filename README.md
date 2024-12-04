# Greelight

## Getting stated

Install the [migration tool](https://github.com/golang-migrate/migrate/tree/master/cmd/migrate#installation) e.g: 

```sh
$ cd /tmp
$ curl -L https://github.com/golang-migrate/migrate/releases/download/v4.16.2/migrate.linux-amd64.tar.gz | tar xvz
$ mv migrate ~/go/bin/
```

To create a new migration you can run: 
```sh
$ make migration name=your_migration_name
# Or
$ migrate create -seq -ext=.sql -dir=./migrations your_migration_name
```

To apply the migrations you can run:

```sh
$ make migration-up
# Or
$ migrate -path=./migrations -database=<your-postgres-dsn> up
```

