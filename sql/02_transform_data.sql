INSERT INTO dbo.yellow_trips (
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    ratecode_id,
    store_and_fwd_flag,
    pickup_location_id,
    dropoff_location_id,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    airport_fee,
    cbd_congestion_fee,
    is_negative_total,
    is_matched_reversal
)

SELECT
    TRY_CONVERT(TINYINT, VendorID) AS vendor_id,
    TRY_CONVERT(DATETIME2(0), tpep_pickup_datetime) AS pickup_datetime,
    TRY_CONVERT(DATETIME2(0), tpep_dropoff_datetime) AS dropoff_datetime,
    TRY_CONVERT(TINYINT, passenger_count) AS passenger_count,
    TRY_CONVERT(DECIMAL(10,2), trip_distance) AS trip_distance,
    TRY_CONVERT(SMALLINT, RatecodeID) AS ratecode_id,
    CASE 
        WHEN store_and_fwd_flag = 'Y' THEN CAST(1 AS BIT)
        WHEN store_and_fwd_flag = 'N' THEN CAST(0 AS BIT)
        ELSE NULL
    END AS store_and_fwd_flag,
    TRY_CONVERT(SMALLINT, PULocationID) AS pickup_location_id,
    TRY_CONVERT(SMALLINT, DOLocationID) AS dropoff_location_id,
    TRY_CONVERT(TINYINT, payment_type) AS payment_type,
    TRY_CONVERT(DECIMAL(10,2), fare_amount) AS fare_amount,
    TRY_CONVERT(DECIMAL(10,2), extra) AS extra,
    TRY_CONVERT(DECIMAL(10,2), mta_tax) AS mta_tax,
    TRY_CONVERT(DECIMAL(10,2), tip_amount) AS tip_amount,
    TRY_CONVERT(DECIMAL(10,2), tolls_amount) AS tolls_amount,
    TRY_CONVERT(DECIMAL(10,2), improvement_surcharge) AS improvement_surcharge,
    TRY_CONVERT(DECIMAL(10,2), total_amount) AS total_amount,
    TRY_CONVERT(DECIMAL(10,2), congestion_surcharge) AS congestion_surcharge,
    TRY_CONVERT(DECIMAL(10,2), airport_fee) AS airport_fee,
    TRY_CONVERT(DECIMAL(10,2), cbd_congestion_fee) AS cbd_congestion_fee,
    CASE 
        WHEN is_negative_total = 'True' THEN CAST(1 AS BIT)
        WHEN is_negative_total = 'False' THEN CAST(0 AS BIT)
    END AS is_negative_total,
    CASE
        WHEN is_matched_reversal = 'True' THEN CAST(1 AS BIT)
        WHEN is_matched_reversal = 'False' THEN CAST(0 AS BIT)
    END AS is_matched_reversal
FROM [stg_yellow_trips].[yellow_tripdata_2026-01_cleaned];