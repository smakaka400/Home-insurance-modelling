# Home Insurance EDA and Feature Engineering

This folder contains the EDA and most of the feature engineering for the home insurance dataset.

Firstly, we used the [pandas-profiling library](https://github.com/pandas-profiling/pandas-profiling) to automatically generate
a comprehensive data report on all the fields available, saving the report as a HTML file. The report was generated on
a subset of 1% of the raw data due to hardware constraints.

From this report we could easily see statistics like the ranges of data, what percentage of a column's fields were missing data, etc.
This would allow us to quickly identify if any fields would not be suitable for use. Using this report we very quickly identified the following:

* **66 variables** (+ 1 more from the random sampling index)
* “i” field is just the row number so can be dropped, along with df_index and Police - **dropped**
* Out of a random 1% sample of data majority of fields had 26% missing values - **lots of imputation required**
* Quote date is format MM/DD/YYYY, cover start is DD/MM/YYYY, P1_DOB is DD/MM/YYYY - **fixed by loading into Google BigQuery**
* Several fields with >50% missing values so can be dropped: MTA_Date, MTA_APRP, MTA_FAP, CAMPAIGN_DESC, CLERICAL, P1_PT_EMP_STATUS - **dropped**
* Several fields with constant/near constant values so potentially dropped: HP3_ADDON_POST_REN, HP3_ADDON_PRE_REN, HP2_ADDON_PRE_REN, HP1_ADDON_POST_REN, HP1_ADDON_PRE_REN, OCC_STATUS, LISTED, ROOF_CONSTRUCTION, P1_POLICY_REFUSED, paying_guests  all have a value with 10 or fewer occurrences - **dropped**
* SUBSIDENCE, SAFE_INSTALLED have values with 20 or fewer occurrences - **dropped**
* MAX_DAYS_UNOCC has nan hardcoded but otherwise decent, same with SUM_INSURED_BUILDINGS - **fixed by loading into Google BigQuery**
* Payment_frequency is either nan hardcoded or 1 - **dropped**

We could also see that the POL_STATUS field had 3 categories: Lapsed, Live, and Cancelled. This was identified as the label that we wish to use for predictions.

Following this, we loaded the raw data into [Google BigQuery](https://cloud.google.com/bigquery), Google Cloud's managed SQL data warehouse. 
Here we performed an initial query (`stripped_data.sql` in the `SQL_scripts folder`) to strip the raw data of the fields that we were not interested in. Subsequent adhoc SQL queries on stripped data revealed:
* only 476 policies where QUOTE_DATE was later than COVER_START. These were kept in, although it might make sense to remove them 
* 0 occurrences where POL_STATUS was null and COVER_START was not null, or vice-versa
* Lots of fields with 26% missing values, just like POL_STATUS and COVER_START
* Most of the time that QUOTE_DATE is null when COVER_START isn’t, is because COVER_START is before 1st Jan 2007

Therefore we can drop rows that have null COVER_START, as we would need this information for future cases regardless.
This was performed in `cleaned_data.sql`, along with constructing the label for training, data conversions and imputations in case there were NULL values still present.
Most of the fields appeared to be discretely categorical (even the integer fields) and so NULLs were imputed with the mode for that field. Exceptions to this were:
* QUOTE_DATE, DATE, date that quote was made. Impute with 1992-11-05 (min cover start)
* SPEC_ITEM_PREM, FLOAT, Premium - Personal valuable items. Impute with 2.51 (average rounded to 2 dp)
* UNSPEC_HRP_PREM, FLOAT, Unknown. Impute with 5.65 (average rounded to 2 dp)
* P1_DOB, DATE, client date of birth. Impute with 1939-11-09 (average date of birth)
* LAST_ANN_PREM_GROSS, FLOAT, Premium - Total for the previous year. Impute with 188.37 (mean)

Finally, in `feature_data_sql` we added a few more features, replacing the date fields with the year, month and day split out separately.
We also introduced a new field counting the number of days between QUOTE_DATE and COVER_START. We then split the full data into training, validation and test sets based on QUOTE_DATE.



   