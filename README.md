# Modelling Lapsed Policies in Home Insurance
This repository explores the home insurance 2007-2012 dataset found on [Kaggle](https://www.kaggle.com/ycanario/home-insurance).
The aim was to explore this dataset, finding some interesting features, and then produce a model to predict future lapsed policies. 
The structure of the repository is as follows:
* The `EDA` folder provides a notebook and SQL scripts for exploratory data analysis as well as some feature engineering.
* The `Modelling` folder contains a notebook with the remainder of feature engineering, and model development.

This repository makes use of Python and SQL. In order to replicate the results, you will need to download the data from Kaggle and update local file paths to your data sources.
You will also need the Python packages listed in `requirements.txt`. Finally you will need access to a SQL database of your choice. This project made use of Google BigQuery, which has a free tier for storing data and performing queries.

## EDA 
The EDA README in the EDA folder goes into more details on EDA undertaken. After some exploring of the raw data, understanding which fields might be useful and might not, the following were used in modelling:
* QUOTE_DATE, DATE, date that the quote was made.
* COVER_START, DATE, date of start of policy.
* CLAIM3YEARS, BOOLEAN, loss in last 3 years.
* P1_EMP_STATUS, STRING, client professional status.
* BUS_USE, BOOLEAN, Commercial use indicator. 	
* AD_BUILDINGS, BOOLEAN, Building coverage - Self damage.
* RISK_RATED_AREA_B, INTEGER, Geographical Classification of Risk - Building.
* SUM_INSURED_BUILDINGS, INTEGER, Assured Sum - Building.
* NCD_GRANTED_YEARS_B,	INTEGER, Bonus Malus - Building. 
* AD_CONTENTS, BOOLEAN, Coverage of personal items - Self Damage. 
* RISK_RATED_AREA_C, INTEGER, Geographical Classification of Risk - Personal Objects.
* SUM_INSURED_CONTENTS, INTEGER,  Assured Sum - Personal Items. 
* NCD_GRANTED_YEARS_C, INTEGER, Malus Bonus - Personal Items.
* CONTENTS_COVER, BOOLEAN, Coverage - Personal Objects indicator.	
* BUILDINGS_COVER, BOOLEAN, Cover - Building indicator. 
* SPEC_SUM_INSURED, INTEGER, Assured Sum - Valuable Personal Property.
* SPEC_ITEM_PREM, FLOAT, Premium - Personal valuable items.
* UNSPEC_HRP_PREM, FLOAT, Unknown. 
* P1_DOB, DATE, client date of birth.
* P1_MAR_STATUS, STRING, Marital status of the client. 
* P1_SEX, STRING, gender of client.	
* APPR_ALARM, BOOLEAN, Appropriate alarm.
* APPR_LOCKS, BOOLEAN, appropriate locks.
* BEDROOMS, INTEGER, bedrooms. 
* WALL_CONSTRUCTION, INTEGER, Code of the type of wall construction.
* FLOODING, BOOLEAN, House susceptible to floods. 
* MAX_DAYS_UNOCC, INTEGER, Number of days unoccupied. 
* NEIGH_WATCH, BOOLEAN,	Vigils of proximity present. 
* OWNERSHIP_TYPE,	INTEGER, Type of membership. 
* PROP_TYPE,	INTEGER, Type of property. 
* SEC_DISC_REQ, BOOLEAN, Reduction of premium for security. 
* YEARBUILT	INTEGER, Year of construction. 
* PAYMENT_METHOD,	STRING, Method of payment.
* LEGAL_ADDON_PRE_REN,	BOOLEAN, Option "Legal Fees" included before 1st renewal. 
* LEGAL_ADDON_POST_REN,	BOOLEAN, Option "Legal Fees" included after 1st renewal. 
* HOME_EM_ADDON_PRE_REN,	BOOLEAN	"Emergencies" option included before 1st renewal.
* HOME_EM_ADDON_POST_REN,	BOOLEAN	Option "Emergencies" included after 1st renewal.
* GARDEN_ADDON_PRE_REN,	BOOLEAN Option "Gardens" included before 1st renewal. 
* GARDEN_ADDON_POST_REN,	BOOLEAN	Option "Gardens" included after 1st renewal. 
* KEYCARE_ADDON_PRE_REN,	BOOLEAN. Option "Replacement of keys" included before 1st renewal. 
* KEYCARE_ADDON_POST_REN,	BOOLEAN	Option "Replacement of keys" included after 1st renewal. 
* HP2_ADDON_POST_REN,	BOOLEAN	Option "HP2" included after renewal. 
* MTA_FLAG	BOOLEAN, Mid-Term Adjustment indicator. 
* LAST_ANN_PREM_GROSS,	FLOAT, Premium - Total for the previous year. 
* POL_STATUS,STRING, policy status. 

Most were used in their raw state, however a few new features were also derived from these. 

## Modelling
In the modelling phase we explored the use of three different models to predict whether a future policy had lapsed or not.
For more details please see the modelling README in the modelling folder.

In the end, the most performant model was an [XGBoost model](https://xgboost.readthedocs.io/en/latest/), providing an accuracy of 63%, precision of 60%, and recall of 53%. 
The features that the model found most useful in its construction were LAST_ANN_PREM_GROSS (raw), QUOTE_TO_COVER_DAYS (derived), DOB_YEAR (derived), RISK_RATED_AREA_C (raw), 
RISK_RATED_AREA_B (raw), COVER_DAY (derived), UNSPEC_HRP_PREM (raw), DOB_DAY (derived).

## Further steps
The model produced in the end did not appear to suffer from underfitting or overfitting as the training and validation losses were both quite low and close to each other.
However the metrics obtained were still not great. Future steps would be to look back at the dataset, diving more into some of the features that were omitted and seeing if some of them provided some use after all.
Another route would be to research useful features in the lapsed policy prediction space, and see if any of these could be derived from the data provided.
Finally, it would be worth exploring some neural network architectures to see if they could capture the behaviour better. 
