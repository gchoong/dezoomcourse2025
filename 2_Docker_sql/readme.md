#Question 1 

-pip --version

# Commands
## Creating the postgres database in docker
docker run -it \
  -e POSTGRES_DB=ny_taxi \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -v ./ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --name pgdatabase \
  postgres:17-alpine

## accessing the postgres with pgcli
pgcli \
	-h  localhost -p 5432 \
	-u postgres \
	-d ny_taxi