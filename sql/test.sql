-- SELECT
--     SUM(CASE WHEN TRY_CONVERT(DATETIME2(0), tpep_pickup_datetime) IS NULL THEN 1 ELSE 0 END)
--         AS bad_pickup_datetime,

--     SUM(CASE WHEN TRY_CONVERT(DATETIME2(0), tpep_dropoff_datetime) IS NULL THEN 1 ELSE 0 END)
--         AS bad_dropoff_datetime,

--     SUM(CASE WHEN TRY_CONVERT(DECIMAL(10,2), trip_distance) IS NULL THEN 1 ELSE 0 END)
--         AS bad_trip_distance,

--     SUM(CASE WHEN TRY_CONVERT(SMALLINT, PULocationID) IS NULL THEN 1 ELSE 0 END)
--         AS bad_pickup_location,

--     SUM(CASE WHEN TRY_CONVERT(SMALLINT, DOLocationID) IS NULL THEN 1 ELSE 0 END)
--         AS bad_dropoff_location,

--     SUM(CASE WHEN TRY_CONVERT(TINYINT, payment_type) IS NULL THEN 1 ELSE 0 END)
--         AS bad_payment_type

-- FROM [stg_yellow_trips].[yellow_tripdata_2026-01_cleaned];

-- SELECT TOP 1000
-- FROM [dbo].[yellow_trips];

-- SELECT COUNT(*) AS row_count
-- FROM [dbo].[yellow_trips];

-- TRUNCATE TABLE dbo.yellow_trips;

-- SELECT 1 AS connection_test;