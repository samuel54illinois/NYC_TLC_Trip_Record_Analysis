# Imports
import os
import pandas as pd

from dotenv import load_dotenv
from sqlalchemy import create_engine

# Load in the information from the env file
load_dotenv()

# Create the engine and then copy in everything
engine = create_engine(
    f"postgresql+psycopg://"
    f"{os.getenv('DB_USER')}:"
    f"{os.getenv('DB_PASSWORD')}@"
    f"{os.getenv('DB_HOST')}:"
    f"{os.getenv('DB_PORT')}/"
    f"{os.getenv('DB_NAME')}"
)

# Read in the files
zones = pd.read_csv("data/raw/taxi_zone_lookup.csv")

# Rename the columns
zones = zones.rename(columns={
    "LocationID": "location_id",
    "Borough": "borough",
    "Zone": "zone",
    "service_zone": "service_zone"
})

# Load it into the data table
# zones.to_sql(
#     "taxi_zones",
#     engine,
#     if_exists="append", # this is important because we have manually created the schema
#     index=False
# )

trips = pd.read_csv(
    "data/processed/yellow_tripdata_2026-01_cleaned.csv"
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

trips['pickup_datetime'] = pd.to_datetime(trips['pickup_datetime'])
trips['dropoff_datetime'] = pd.to_datetime(trips['dropoff_datetime'])
trips["store_and_fwd_flag"] = (
    trips["store_and_fwd_flag"]
    .map({"Y": True, "N": False})
)

print(trips.dtypes)

trips.to_sql(
    "yellow_trips",
    engine,
    if_exists="append",
    index=False,
    chunksize=1000,
    method="multi"
)