SELECT EXTRACT(YEAR FROM QUOTE_DATE) AS QUOTE_YEAR,
EXTRACT(MONTH FROM QUOTE_DATE) AS QUOTE_MONTH,
EXTRACT(DAY FROM QUOTE_DATE) AS QUOTE_DAY,
EXTRACT(YEAR FROM COVER_START) AS COVER_YEAR,
EXTRACT(MONTH FROM COVER_START) AS COVER_MONTH,
EXTRACT(DAY FROM COVER_START) AS COVER_DAY,
EXTRACT(YEAR FROM P1_DOB) AS DOB_YEAR,
EXTRACT(MONTH FROM P1_DOB) AS DOB_MONTH,
EXTRACT(DAY FROM P1_DOB) AS DOB_DAY,
DATE_DIFF(COVER_START, QUOTE_DATE, DAY) AS QUOTE_TO_COVER_DAYS,
* EXCEPT (QUOTE_DATE, COVER_START, P1_DOB) FROM
home-insurance-modelling.cleaned_data.cleaned_data
WHERE QUOTE_DATE < "2009-01-01"
--WHERE QUOTE_DATE BETWEEN "2009-01-01" AND "2010-12-31"
--WHERE QUOTE_DATE >= "2011-01-01"