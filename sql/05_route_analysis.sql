-- Which pickup → dropoff routes have the highest trip demand?
SELECT TOP(10)
    d.pickup_location_id,
    t1.borough pickup_borough,
    t1.zone pickup_zone,
    d.dropoff_location_id,
    t2.borough dropoff_borough,
    t2.zone dropoff_zone,
    COUNT(*) trip_count
FROM
    dbo.yellow_trips d
JOIN
    dbo.taxi_zone_lookup_clean t1
ON
    d.pickup_location_id = t1.location_id
JOIN
    dbo.taxi_zone_lookup_clean t2
ON
    d.dropoff_location_id = t2.location_id
GROUP BY
    d.pickup_location_id,
    t1.borough,
    t1.zone,
    d.dropoff_location_id,
    t2.borough,
    t2.zone
ORDER BY
    COUNT(*) DESC;

-- Which routes generate the highest total revenue?
SELECT TOP(10)
    d.pickup_location_id,
    t1.borough pickup_borough,
    t1.zone pickup_zone,
    d.dropoff_location_id,
    t2.borough dropoff_borough,
    t2.zone dropoff_zone,
    SUM(total_amount) total_revenue
FROM
    dbo.yellow_trips d
JOIN
    dbo.taxi_zone_lookup_clean t1
ON
    d.pickup_location_id = t1.location_id
JOIN
    dbo.taxi_zone_lookup_clean t2
ON
    d.dropoff_location_id = t2.location_id
GROUP BY
    d.pickup_location_id,
    t1.borough,
    t1.zone,
    d.dropoff_location_id,
    t2.borough,
    t2.zone
ORDER BY
    SUM(total_amount) DESC;


-- Which high-volume routes generate the highest average revenue per trip?
SELECT TOP(10)
    d.pickup_location_id,
    t1.borough pickup_borough,
    t1.zone pickup_zone,
    d.dropoff_location_id,
    t2.borough dropoff_borough,
    t2.zone dropoff_zone,
    COUNT(*) trip_count,
    SUM(total_amount) total_revenue,
    CAST(SUM(total_amount)/ COUNT(*) AS DECIMAL(10,2)) avg_revenue_per_trip
FROM
    dbo.yellow_trips d
JOIN
    dbo.taxi_zone_lookup_clean t1
ON
    d.pickup_location_id = t1.location_id
JOIN
    dbo.taxi_zone_lookup_clean t2
ON
    d.dropoff_location_id = t2.location_id
GROUP BY
    d.pickup_location_id,
    t1.borough,
    t1.zone,
    d.dropoff_location_id,
    t2.borough,
    t2.zone
HAVING
    SUM(total_amount) > 0
    AND
    COUNT(*) >= 1000
ORDER BY
    SUM(total_amount)/ COUNT(*) DESC;

-- What are the major airport travel patterns?
SELECT TOP(10)
    d.pickup_location_id,
    t1.borough pickup_borough,
    t1.zone pickup_zone,
    d.dropoff_location_id,
    t2.borough dropoff_borough,
    t2.zone dropoff_zone,
    COUNT(*) trip_count,
    SUM(total_amount) total_revenue,
    CAST(SUM(total_amount)/ COUNT(*) AS DECIMAL(10,2)) avg_revenue_per_trip
FROM
    dbo.yellow_trips d
JOIN
    dbo.taxi_zone_lookup_clean t1
ON
    d.pickup_location_id = t1.location_id
JOIN
    dbo.taxi_zone_lookup_clean t2
ON
    d.dropoff_location_id = t2.location_id
GROUP BY
    d.pickup_location_id,
    t1.borough,
    t1.zone,
    d.dropoff_location_id,
    t2.borough,
    t2.zone
HAVING
    d.pickup_location_id IN (132, 138)
ORDER BY
    COUNT(*) DESC;