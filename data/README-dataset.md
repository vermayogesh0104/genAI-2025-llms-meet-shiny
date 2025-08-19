## Data Dictionary

Source: https://immunizationdata.who.int/global?topic=Provisional-measles-and-rubella-data

###ve  `cases_month.csv`

Distribution of measles and rubella cases by country, year, month and final classification

Number of measles and rubella cases by country, year, month and final classification since 2012. Available for Member States that report monthly/Weekly measles/rubella surveillance data to WHO.

-  `region` (character) - Region name
-  `country` (character) - Country name
-  `iso3` (character) - Three letter country code
-  `year` (double) - Year
-  `month` (double) - Month
-  `measles_suspect` (double) - Suspected measles cases: A suspected case is one in which a patient with fever and maculopapular (non-vesicular) rash, or in whom a health-care worker suspects measles
-  `measles_clinical` (double) - Clinically-compatible measles cases: A suspected case with fever and maculopapular (non-vesicular) rash and at least one of cough, coryza or conjunctivitis, but no adequate clinical specimen was taken and the case has not been linked epidemiologically to a laboratory-confirmed case of measles or other communicable disease
-  `measles_epi_linked` (double) - Epidemiologically-linked measles cases: A suspected case of measles that has not been confirmed by a laboratory, but was geographically and temporally related with dates of rash onset occurring 7–23 days apart from a laboratory-confirmed case or another epidemiologically linked measles case
-  `measles_lab_confirmed` (double) - Laboratory-confirmed measles cases: A suspected case of measles that has been confirmed positive by testing in a proficient laboratory, and vaccine-associated illness has been ruled out
-  `measles_total` (double) - Total measles cases: the sum of clinically-compatible, epidemiologically linked and laboratory-confirmed cases
-  `rubella_clinical` (double) - Clinically-compatible rubella cases
-  `rubella_epi_linked` (double) - Epidemiologically-linked rubella cases
-  `rubella_lab_confirmed` (double) - Laboratory-confirmed rubella cases
-  `rubella_total` (double) - Total rubella cases
-  `discarded` (double) - Discarded cases: A suspected case that has been investigated and discarded as a non-measles (and non-rubella)

### `cases_year.csv`

- `region` (character) - Region name
-  `country` (character) - Country name
-  `iso3` (character) - Three letter country code
-  `year` (character) - Year
-  `total_population` (character) - Country population
-  `annualized_population_most_recent_year_only` (character) - Annualized population 2025
-  `total_suspected_measles_rubella_cases` (character) - Suspected measles/rubella cases: A suspected case is one in which a patient has fever and maculopapular (non-vesicular) rash, or in whom a health-care worker suspects measles (or rubella)
-  `measles_total` (character) - Total measles cases: the sum of clinically-compatible, epidemiologically linked, and laboratory-confirmed cases
-  `measles_lab_confirmed` (character) - Laboratory-confirmed measles cases: A suspected case of measles confirmed positive by testing in a proficient laboratory, with vaccine-associated illness ruled out
-  `measles_epi_linked` (character) - Epidemiologically-linked measles cases: A suspected case not confirmed by a laboratory but geographically and temporally related (rash onset 7–23 days apart) to a laboratory-confirmed or another epidemiologically linked measles case
-  `measles_clinical` (character) - Clinically-compatible measles cases: A suspected case with fever and maculopapular (non-vesicular) rash and at least one of cough, coryza, or conjunctivitis, with no adequate specimen and no epidemiologic link to a lab-confirmed case of measles or other communicable disease
-  `measles_incidence_rate_per_1000000_total_population` (character) - Measles cases per million population
-  `rubella_total` (character) - Total rubella cases
-  `rubella_lab_confirmed` (character) - Laboratory-confirmed rubella cases
-  `rubella_epi_linked` (character) - Epidemiologically-linked rubella cases
-  `rubella_clinical` (character) - Clinically-compatible rubella cases
-  `rubella_incidence_rate_per_1000000_total_population` (character) - Rubella cases per million population
-  `discarded_cases` (character) - Discarded cases: A suspected case that has been investigated and discarded as non-measles (and non-rubella)
-  `discarded_non_measles_rubella_cases_per_100000_total_population` (character) - Discarded cases per million population
