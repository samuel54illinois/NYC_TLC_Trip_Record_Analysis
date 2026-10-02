-- Getting the top 10 zones for picking up people
SELECT TOP(10)
    pickup_location_id,
    COUNT(trip_id) AS trip_count
FROM
    dbo.yellow_trips
GROUP BY
    pickup_location_id
ORDER BY
    COUNT(trip_id) DESC;

-- Which pickup zones generate the most revenue
SELECT TOP(10)
    pickup_location_id,
    SUM(total_amount) AS total_revenue
FROM
    dbo.yellow_trips
GROUP BY
    pickup_location_id
ORDER BY
    SUM(total_amount) DESC;

-- Which pickup zones generate the most revenue per trip?
SELECT
    pickup_location_id,
    COUNT(*) trip_count,
    AVG(total_amount) AS avg_revenue_per_trip
FROM
    dbo.yellow_trips
GROUP BY
    pickup_location_id
HAVING
    COUNT(*) >= 10000
ORDER BY
    AVG(total_amount) DESC;