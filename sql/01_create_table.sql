DROP TABLE [dbo].[yellow_trips];

CREATE TABLE dbo.yellow_trips(
    -- Creating a primary key for this table
    trip_id BIGINT IDENTITY(1,1) PRIMARY KEY,

    vendor_id TINYINT,
    pickup_datetime DATETIME2(0) NOT NULL,
    dropoff_datetime DATETIME2(0) NOT NULL,
    
    passenger_count TINYINT NULL,
    trip_distance DECIMAL(10,2) NOT NULL,
    ratecode_id SMALLINT NULL,
    store_and_fwd_flag BIT NULL,

    pickup_location_id SMALLINT NOT NULL,
    dropoff_location_id SMALLINT NOT NULL,
    payment_type TINYINT NOT NULL,

    fare_amount DECIMAL(10,2) NOT NULL,
    extra DECIMAL(10,2) NOT NULL,
    mta_tax DECIMAL(10,2) NOT NULL,
    tip_amount DECIMAL(10,2) NOT NULL,
    tolls_amount DECIMAL(10,2) NOT NULL,
    improvement_surcharge DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    congestion_surcharge DECIMAL(10,2) NULL,
    airport_fee DECIMAL(10,2) NULL,
    cbd_congestion_fee DECIMAL(10,2) NULL,
    is_negative_total BIT NOT NULL,
    is_matched_reversal BIT NOT NULL
)