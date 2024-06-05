# SQL Project: Analyzing Population Growth Data

This project demonstrates how to analyze population growth data using PostgreSQL. The data is sourced from [Our World in Data](https://ourworldindata.org/population-growth), which provides comprehensive datasets on global population trends.

## Getting Started

### Prerequisites

- PostgreSQL installed on your system
- SQL editor such as DBeaver

### Downloading the Dataset

1. Visit the [Our World in Data Population Growth page](https://ourworldindata.org/population-growth).
2. Scroll down to the "Explore Data on Population Growth" section.
3. Click on the "Download" button at the bottom of the interactive visualization.
4. Select "Full CSV" to download the dataset.

### Importing the Data into PostgreSQL

1. Open your SQL editor and connect to your PostgreSQL database.
2. Execute the following SQL script to create the necessary table and import the data:

```sql
DROP TABLE IF EXISTS population_and_demography;

CREATE TABLE population_and_demography (
    "Country name" VARCHAR,
    "Year" INT,
    "Population" BIGINT,
    "Population of children under the age of 1" BIGINT,
    "Population of children under the age of 5" BIGINT,
    "Population of children under the age of 15" BIGINT,
    "Population under the age of 25" BIGINT,
    "Population aged 15 to 64 years" BIGINT,
    "Population older than 15 years" BIGINT,
    "Population older than 18 years" BIGINT,
    "Population at age 1" BIGINT,
    "Population aged 1 to 4 years" BIGINT,
    "Population aged 5 to 9 years" BIGINT,
    "Population aged 10 to 14 years" BIGINT,
    "Population aged 15 to 19 years" BIGINT,
    "Population aged 20 to 29 years" BIGINT,
    "Population aged 30 to 39 years" BIGINT,
    "Population aged 40 to 49 years" BIGINT,
    "Population aged 50 to 59 years" BIGINT,
    "Population aged 60 to 69 years" BIGINT,
    "Population aged 70 to 79 years" BIGINT,
    "Population aged 80 to 89 years" BIGINT,
    "Population aged 90 to 99 years" BIGINT,
    "Population older than 100 years" BIGINT,
    "population__all__20_24__records" BIGINT,
    "population__all__25_29__records" BIGINT,
    "population__all__30_34__records" BIGINT,
    "population__all__35_39__records" BIGINT,
    "population__all__40_44__records" BIGINT,
    "population__all__45_49__records" BIGINT,
    "population__all__50_54__records" BIGINT,
    "population__all__55_59__records" BIGINT,
    "population__all__60_64__records" BIGINT,
    "population__all__65_69__records" BIGINT,
    "population__all__70_74__records" BIGINT,
    "population__all__75_79__records" BIGINT,
    "population__all__80_84__records" BIGINT,
    "population__all__85_89__records" BIGINT,
    "population__all__90_94__records" BIGINT,
    "population__all__95_99__records" BIGINT
);

\copy population_and_demography FROM 'your-folder/population-and-demography.csv' WITH (FORMAT csv, HEADER true);
```

### Data Overview

The CSV file (`population-and-demography.csv`) contains the following columns:
- **Country name**: Name of the country or region.
- **Year**: The year of the recorded data.
- **Population**: Total population of the country/region.
- **Population of children under the age of 1**: Population of children aged less than 1 year.
- **Population of children under the age of 5**: Population of children aged less than 5 years.
- **Population of children under the age of 15**: Population of children aged less than 15 years.
- **Population under the age of 25**: Population aged less than 25 years.
- **Population aged 15 to 64 years**: Population aged between 15 and 64 years.
- **Population older than 15 years**: Population aged more than 15 years.
- **Population older than 18 years**: Population aged more than 18 years.
- **Population at age 1**: Population aged 1 year.
- **Population aged 1 to 4 years**: Population aged between 1 and 4 years.
- **Population aged 5 to 9 years**: Population aged between 5 and 9 years.
- **Population aged 10 to 14 years**: Population aged between 10 and 14 years.
- **Population aged 15 to 19 years**: Population aged between 15 and 19 years.
- **Population aged 20 to 29 years**: Population aged between 20 and 29 years.
- **Population aged 30 to 39 years**: Population aged between 30 and 39 years.
- **Population aged 40 to 49 years**: Population aged between 40 and 49 years.
- **Population aged 50 to 59 years**: Population aged between 50 and 59 years.
- **Population aged 60 to 69 years**: Population aged between 60 and 69 years.
- **Population aged 70 to 79 years**: Population aged between 70 and 79 years.
- **Population aged 80 to 89 years**: Population aged between 80 and 89 years.
- **Population aged 90 to 99 years**: Population aged between 90 and 99 years.
- **Population older than 100 years**: Population aged more than 100 years.
- **Various age-specific population records**: Population counts for specific age ranges (e.g., 20-24, 25-29).
