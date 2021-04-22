# postgis (postgreSQL + geo object support)

- example using postgreSQL13.3, assumes you have postgreSQL running on 5432
- create postgis volume
- restart unless-stopped
- postgres // password1
- expose database on localhost 5433
- example createdb
- example golang-migrate usage

## start postgis with persistent db

1. create volume: `docker volume create pgdata13`
2. start postgis13: `docker run --name some-postgis -v pgdata13:/var/lib/postgresql/data -e POSTGRES_PASSWORD=password1 -p 5433:5432 -d --restart unless-stopped postgis/postgis:13-3.1`

## create a database

1. `docker exec some-postgis bash -c "createdb -U postgres someDb"`

## migrations with golang-migrate

1. `docker run -v $(pwd)/db/postgres/migrations:/migrations --network host migrate/migrate -path=/migrations -database postgres://postgres:password1@localhost:5433/someDb?sslmode=disable up`
