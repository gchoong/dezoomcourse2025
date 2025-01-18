# Question 1 

-pip --version

## Answer: 24.3.1

# Question 3

## Work

SELECT
     COUNT(*) AS trip_count
 FROM
     green_taxi_data
 WHERE
     lpep_pickup_datetime >= '2019-10-01' AND
     lpep_dropoff_datetime < '2019-11-01' AND trip_distance > 1 and trip_distance <= 3

## Answer : 104802, 198924

# Question 4

## Work 

select lpep_pickup_datetime,max(tri
 p_distance) from green_taxi_data group by lpep_pickup_datetime
  order by max(trip_distance) desc

## Answer 2019-10-31

# Question 5

## Work

select "PULocationID",sum(total_amount) as agg_total from green_taxi_data
where lpep_pickup_datetime::date = '2019-10-18'
group by 
"PULocationID" order by agg_total desc

## Answer
East Harlem North, East Harlem South, Morningside Heights

# Commands
## Creating the postgres database in docker and also adding in the network configs 
docker run -it \
  -e POSTGRES_DB=ny_taxi \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -v ./ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:17-alpine

## accessing the postgres with pgcli
pgcli \
	-h  localhost -p 5432 \
	-u postgres \
	-d ny_taxi

## Using PGAdmin to connect with postgresql
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin \
  dpage/pgadmin4
  