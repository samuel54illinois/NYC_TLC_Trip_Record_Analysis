TRUNCATE TABLE dbo.nyc_weather_hourly;

SELECT COUNT(*) FROM dbo.nyc_weather_hourly;

SELECT
    COUNT(*) AS row_count,
    MIN(TRY_CONVERT(DATETIME2(0), date)) AS first_hour,
    MAX(TRY_CONVERT(DATETIME2(0), date)) AS last_hour
FROM dbo.nyc_weather_hourly;

DROP TABLE dbo.nyc_weather_hourly_clean;

CREATE TABLE dbo.nyc_weather_hourly_clean (
    weather_hour DATETIME2(0) PRIMARY KEY,
    temperature_2m DECIMAL(10,4) NOT NULL,
    precipitation DECIMAL(10,4) NOT NULL,
    rain DECIMAL(10,4) NOT NULL,
    snowfall DECIMAL(10,4) NOT NULL,
    wind_speed_10m DECIMAL(10,4) NOT NULL
);

INSERT INTO dbo.nyc_weather_hourly_clean (
    weather_hour,
    temperature_2m,
    precipitation,
    rain,
    snowfall,
    wind_speed_10m
)

SELECT
    TRY_CONVERT(DATETIME2(0), date) AS weather_hour,
    TRY_CONVERT(DECIMAL(10,4), temperature_2m) AS temperature_2m,
    TRY_CONVERT(DECIMAL(10,4), precipitation) AS precipitation,
    TRY_CONVERT(DECIMAL(10,4), rain) AS rain,
    TRY_CONVERT(DECIMAL(10,4), snowfall) AS snowfall,
    TRY_CONVERT(DECIMAL(10,4), wind_speed_10m) AS wind_speed_10m
FROM
    [dbo].[nyc_weather_hourly];