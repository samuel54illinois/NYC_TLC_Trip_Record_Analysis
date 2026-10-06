-- Create the clean table
CREATE TABLE dbo.taxi_zone_lookup_clean (
    location_id SMALLINT PRIMARY KEY,
    borough NVARCHAR(50) NOT NULL,
    zone NVARCHAR(100) NOT NULL,
    service_zone NVARCHAR(50) NOT NULL
);

INSERT INTO dbo.taxi_zone_lookup_clean (
    location_id,
    borough,
    zone,
    service_zone    
)

-- Import the data
SELECT
    TRY_CONVERT(SMALLINT, location_id) AS location_id,
    TRY_CONVERT(NVARCHAR(50), borough) AS borough,
    TRY_CONVERT(NVARCHAR(100), zone) AS zone,
    TRY_CONVERT(NVARCHAR(50), service_zone) AS service_zone
FROM [dbo].[taxi_zone_lookup];

SELECT * FROM dbo.taxi_zone_lookup_clean;

-- Which named pickup zones have the highest trip demand?
SELECT TOP(10)
    t.location_id,
    t.borough,
    t.zone,
    COUNT(*) AS trip_demand
FROM
    [dbo].[taxi_zone_lookup_clean] t
JOIN
    [dbo].[yellow_trips] y
ON
    t.location_id = y.pickup_location_id
GROUP BY
    t.location_id,
    t.borough,
    t.zone
ORDER BY
    COUNT(*) DESC;

-- Which borough has the highest total pickup demand?
SELECT TOP(10)
    t.borough,
    COUNT(*) AS trip_demand
FROM
    [dbo].[taxi_zone_lookup_clean] t
JOIN
    [dbo].[yellow_trips] y
ON
    t.location_id = y.pickup_location_id
GROUP BY
    t.borough
ORDER BY
    COUNT(*) DESC;

-- Which named pickup zones generated the highest total revenue in January 2026?
SELECT TOP(10)
    t.location_id,
    t.borough,
    t.zone,
    SUM(total_amount) AS total_revenue
FROM
    [dbo].[taxi_zone_lookup_clean] t
JOIN
    [dbo].[yellow_trips] y
ON
    t.location_id = y.pickup_location_id
GROUP BY
    t.location_id,
    t.borough,
    t.zone
ORDER BY
    SUM(total_amount) DESC;

-- Average revenue per trip by zone
SELECT TOP(10)
    t.location_id,
    t.borough,
    t.zone,
    COUNT(*) AS trip_count,
    SUM(total_amount) AS total_amount,
    CAST(SUM(total_amount)/COUNT(*) AS DECIMAL(10,2)) AS avg_revenue_per_trip
FROM
    [dbo].[taxi_zone_lookup_clean] t
JOIN
    [dbo].[yellow_trips] y
ON
    t.location_id = y.pickup_location_id
GROUP BY
    t.location_id,
    t.borough,
    t.zone
HAVING
    COUNT(*) > 10000
ORDER BY
    SUM(total_amount)/COUNT(*) DESC;

-- Which borough generates the most total revenue?
SELECT TOP(10)
    t.borough,
    SUM(total_amount) AS total_revenue
FROM
    [dbo].[taxi_zone_lookup_clean] t
JOIN
    [dbo].[yellow_trips] y
ON
    t.location_id = y.pickup_location_id
GROUP BY
    t.borough
ORDER BY
    SUM(total_amount) DESC;

-- Which named dropoff zones receive the most trips?
SELECT TOP(10)
    y.dropoff_location_id,
    t.borough,
    t.zone,
    COUNT(*) AS trip_count
FROM
    [dbo].[taxi_zone_lookup_clean] t
JOIN
    [dbo].[yellow_trips] y
ON
    t.location_id = y.dropoff_location_id
GROUP BY
    y.dropoff_location_id,
    t.borough,
    t.zone
ORDER BY
    COUNT(*) DESC;


-- Which pickup zones combine high demand + high revenue most strongly?
SELECT TOP(10)
    t.location_id,
    t.borough,
    t.zone,
    COUNT(*) AS trip_count,
    SUM(total_amount) AS total_revenue,
    CAST(SUM(total_amount)/COUNT(*) AS DECIMAL(10,2)) AS avg_revenue_per_trip
FROM
    [dbo].[taxi_zone_lookup_clean] t
JOIN
    [dbo].[yellow_trips] y
ON
    t.location_id = y.pickup_location_id
GROUP BY
    t.location_id,
    t.borough,
    t.zone
HAVING
    COUNT(*) >= 50000
    AND
    SUM(total_amount) >= 1500000
ORDER BY
    SUM(total_amount)/COUNT(*) DESC;