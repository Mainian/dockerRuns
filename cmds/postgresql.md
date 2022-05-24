# postgreSQL

- create postgreSQL volume
- restart unless-stopped
- postgres // password1
- expose database on localhost 5432

`docker volume create pgdata`

`docker run --name some-postgres -v pgdata:/var/lib/postgresql/data -e POSTGRES_PASSWORD=password1 -p 5432:5432 -d --restart unless-stopped postgres:14`
