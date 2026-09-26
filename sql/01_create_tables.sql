CREATE TABLE IF NOT EXISTS taxi_zones (
    location_id INTEGER PRIMARY KEY,
    borough VARCHAR(50),
    zone VARCHAR(100),
    service_zone VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS yellow_trips (
    trip_id BIGSERIAL PRIMARY KEY,
    vendor_id SMALLINT,
    pickup_datetime TIMESTAMP NOT NULL,
    dropoff_datetime TIMESTAMP NOT NULL,
    passenger_count SMALLINT,
    trip_distance DOUBLE PRECISION NOT NULL,
    ratecode_id SMALLINT,
    store_and_fwd_flag CHAR(1),
    pickup_location_id INTEGER NOT NULL,
    dropoff_location_id INTEGER NOT NULL,
    payment_type SMALLINT NOT NULL,

    fare_amount NUMERIC(10,2) NOT NULL,
    extra NUMERIC(10,2) NOT NULL,
    mta_tax NUMERIC(10,2) NOT NULL,
    tip_amount NUMERIC(10,2) NOT NULL,
    tolls_amount NUMERIC(10,2) NOT NULL,
    improvement_surcharge NUMERIC(10,2) NOT NULL,
    total_amount NUMERIC(10,2) NOT NULL,
    congestion_surcharge NUMERIC(10,2),
    airport_fee NUMERIC(10,2),
    cbd_congestion_fee NUMERIC(10,2),

    is_negative_total BOOLEAN NOT NULL,
    is_matched_reversal BOOLEAN NOT NULL,

    FOREIGN KEY (pickup_location_id)
        REFERENCES taxi_zones(location_id),

    FOREIGN KEY (dropoff_location_id)
        REFERENCES taxi_zones(location_id)
);