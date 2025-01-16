import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://postgres:postgres@localhost:5432/ny_taxi')

engine.connect

df = pd.read_csv('green_tripdata_2019-10.csv', nrows=100)

# print(df)
df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

df_iter = pd.read_csv('green_tripdata_2019-10.csv',iterator=True, chunksize=100000)
df = next(df_iter)



print(pd.io.sql.get_schema(df, name = 'green_taxi_data', con=engine))

#df.to_sql(name="green_taxi_data", con=engine, if_exists="replace")

