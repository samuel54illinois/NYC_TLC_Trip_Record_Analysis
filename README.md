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