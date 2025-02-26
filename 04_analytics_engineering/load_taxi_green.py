import dlt
import requests
import pandas as pd
import io
import time

# Constants
BASE_URL = "https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_"
YEARS = ["2019", "2020"]
MONTHS = [f"{i:02d}" for i in range(1, 13)]  # January to December


# Function to generate download URLs
def get_urls():
    return [f"{BASE_URL}{year}-{month}.csv.gz" for year in YEARS for month in MONTHS]


# Function to fetch and process Parquet data with retry logic
def fetch_parquet_data(url, retries=3, delay=5):
    print(f"[INFO] Starting download: {url}")

    for attempt in range(retries):
        try:
            response = requests.get(url, timeout=30)

            if response.status_code == 200:
                print(f"[SUCCESS] Downloaded: {url}")
                return pd.read_csv(io.BytesIO(response.content), compression="gzip").astype(str)

            print(
                f"[WARNING] Attempt {attempt+1}/{retries} failed for {url} (Status: {response.status_code}). Retrying in {delay} seconds..."
            )

        except requests.RequestException as e:
            print(
                f"[ERROR] Network error on {url}: {e}. Retrying in {delay} seconds..."
            )

        time.sleep(delay)

    print(f"[ERROR] Failed to download data after {retries} attempts: {url}")
    raise Exception(f"Failed to download data after {retries} attempts: {url}")


# Define the API resource for NYC taxi data
@dlt.resource(name="green_trip_data")
def ny_taxi():
    for url in get_urls():
        try:
            yield fetch_parquet_data(url)  # Yield DataFrame so dlt can process it
        except Exception as e:
            print(f"[ERROR] Skipping {url} due to error: {e}")


# Initialize dlt pipeline with correct GCP authentication
pipeline = dlt.pipeline(
    pipeline_name="taxi_rides_ny_pipeline",
    destination="bigquery",  # Change to 'bigquery' or 'duckdb' if needed
    dataset_name="trips_data_all",
)

# Run the pipeline and load data
print("[INFO] Starting data ingestion pipeline...")
load_info = pipeline.run(
    ny_taxi, loader_file_format="parquet"
)  # Supports parquet, csv, jsonl
print("[INFO] Data ingestion completed.")
print(load_info)