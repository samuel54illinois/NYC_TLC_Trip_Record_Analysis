# NYC_TLC_Trip_Record_Analysis

          NYC TLC
       Trip Records
            │
            ▼
     Python ingestion
            │
            ▼
     Data validation
            │
            ▼
     SQL database
            │
            ├───────────────┐
            │               │
            │           NOAA API
            │               │
            │               ▼
            │        Weather ingestion
            │               │
            └───────┬───────┘
                    ▼
             Analytics tables
                    │
          ┌─────────┼─────────┐
          ▼         ▼         ▼
         SQL     Python     Stats
          │         │         │
          └─────────┼─────────┘
                    ▼
                Dashboard
                    │
                    ▼
            Executive report
                    │
                    ▼
        BUSINESS RECOMMENDATIONS


Documented Steps In Detail:

9/19/2026
    1. Set up the environment (Creating a repository on Github and cloning it to local folder, creating a venv environment)
    2. Downloaded the data from: https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page? (Yellow Taxi Record Janurary 2026)
