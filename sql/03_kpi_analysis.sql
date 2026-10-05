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
SELECT TOP(10)
    pickup_location_id,
    COUNT(*) trip_count,
    ROUND(AVG(total_amount), 2) AS avg_revenue_per_trip
FROM
    dbo.yellow_trips
GROUP BY
    pickup_location_id
HAVING
    COUNT(*) >= 10000
ORDER BY
    AVG(total_amount) DESC;

-- Which hours of the day have the highest yellow taxi demand in janurary 2026
WITH CTE AS (
    SELECT
        CAST(pickup_datetime AS DATE) pickup_date,
        DATENAME(WEEKDAY, pickup_datetime) AS week_day,
        COUNT(*) AS trip_count
    FROM
        dbo.yellow_trips
    GROUP BY
        CAST(pickup_datetime AS DATE),
        DATENAME(WEEKDAY, pickup_datetime)
)

SELECT
    week_day,
    CAST(AVG(trip_count) AS DECIMAL(10, 2)) AS average_trip_count
FROM
    CTE
GROUP BY
    week_day
ORDER BY
    CAST(AVG(trip_count) AS DECIMAL(10, 2)) DESC;

-- Which hours generate the most revenue?
SELECT
    DATEPART(HOUR, pickup_datetime) pickup_hour,
    COUNT(*) AS trip_count,
    SUM(total_amount) AS total_revenue
FROM
    dbo.yellow_trips
GROUP BY
    DATEPART(HOUR, pickup_datetime)
ORDER BY
    SUM(total_amount) DESC;

-- Which day of the week generates the highest average revenue per day?
WITH CTE AS (
    SELECT
        CAST(pickup_datetime AS DATE) AS pickup_date,
        DATENAME(WEEKDAY, pickup_datetime) AS weekday,
        SUM(total_amount) AS revenue
    FROM
        dbo.yellow_trips
    GROUP BY
        CAST(pickup_datetime AS DATE), DATENAME(WEEKDAY, pickup_datetime)
)

SELECT
    weekday,
    CAST(AVG(revenue) AS DECIMAL(10, 2)) avg_daily_revenue
FROM
    CTE
GROUP BY
    weekday
ORDER BY
    CAST(AVG(revenue) AS DECIMAL(10, 2)) DESC;