-- Does precipitation affect hourly taxi demand?
WITH CTE AS (
    SELECT
        DATETRUNC(HOUR, y.pickup_datetime) hour,
        COUNT(*) trip_count,
        SUM(y.total_amount) total_revenue,
        w.temperature_2m,
        w.precipitation,
        w.rain,
        w.snowfall
    FROM
        [dbo].[yellow_trips] y
    JOIN
        [dbo].[nyc_weather_hourly_clean] w
    ON
        DATETRUNC(HOUR, y.pickup_datetime) = DATETRUNC(HOUR, w.weather_hour)
    GROUP BY
        DATETRUNC(HOUR, y.pickup_datetime),
        w.temperature_2m,
        w.precipitation,
        w.rain,
        w.snowfall
)

SELECT
    CASE 
        WHEN precipitation > 0 THEN 'Precipitation'
        ELSE 'Dry'
    END,
    COUNT(*) AS hours_observed,
    CAST(AVG(trip_count) AS DECIMAL(10,4)) AS avg_hourly_trip_count
FROM
    CTE
GROUP BY
    CASE 
        WHEN precipitation > 0 THEN 'Precipitation'
        ELSE 'Dry'
    END;