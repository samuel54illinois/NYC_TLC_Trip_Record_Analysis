# Imports
import os
import pandas as pd

from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

engine = create_engine(
    f"postgresql+psycopg://"
    f"{os.getenv('DB_USER')}:"
    f"{os.getenv('DB_PASSWORD')}@"
    f"{os.getenv('DB_HOST')}:"
    f"{os.getenv('DB_PORT')}/"
    f"{os.getenv('DB_NAME')}"
)

zones = pd.read_csv("../data/raw/taxi_zone_lookup.csv")

zones = zones.rename(columns={
    "LocationID": "location_id",
    "Borough": "borough",
    "Zone": "zone",
    "service_zone": "service_zone"
})

zones.to_sql(
    "taxi_zones",
    engine,
    if_exists="append",
    index=False
)

trips = pd.read_parquet(
    "../data/processed/yellow_tripdata_2026-01_cleaned.csv"
)

trips = trips.rename(columns={
    "VendorID": "vendor_id",
    "tpep_pickup_datetime": "pickup_datetime",
    "tpep_dropoff_datetime": "dropoff_datetime",
    "RatecodeID": "ratecode_id",
    "PULocationID": "pickup_location_id",
    "DOLocationID": "dropoff_location_id",
    "Airport_fee": "airport_fee"
})

trips.to_sql(
    "yellow_trips",
    engine,
    if_exists="append",
    index=False,
    chunksize=10000,
    method="multi"
)