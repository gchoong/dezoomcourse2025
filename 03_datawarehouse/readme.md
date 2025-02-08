# Making the External Table

```
CREATE OR REPLACE EXTERNAL TABLE `zoomcamp-03-450318.nytaxi_yellow.external_yellow_tripdata`
OPTIONS(
    format = 'PARQUET',
    -- you can get all files stored in the bucket with *
    uris=['gs://zoomcamp-03-450318-tf-bucket/*'] 
)
```

# Question 1 
```
select count(*) from `nytaxi_yellow.external_yellow_tripdata`;
```
# Question 2 
```
CREATE OR REPLACE TABLE `zoomcamp-03-450318.nytaxi_yellow.yellow_tripdata`
AS SELECT * FROM `zoomcamp-03-450318.nytaxi_yellow.external_yellow_tripdata`
```
```
select distinct count(PULocationID) from `nytaxi_yellow.external_yellow_tripdata`
```

# Question 5
```
CREATE OR REPLACE TABLE zoomcamp-03-450318.nytaxi_yellow.partitioned_yellow_2024
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS(
  SELECT * FROM `zoomcamp-03-450318.nytaxi_yellow.yellow_tripdata`
)
```

# Question 6
```
select distinct VendorID from zoomcamp-03-450318.nytaxi_yellow.yellow_tripdata
where tpep_dropoff_datetime >= '2024-03-01' and 
tpep_dropoff_datetime <= '2024-03-15'
```