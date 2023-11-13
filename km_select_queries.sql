


current_date() as record_create_date,
to_varchar(CURRENT_DATE(), 'yyyy-mm-dd') as TRANSACTION_DT

CURRENT_TIMESTAMP() as RECORD_CREATE_TIME,
CURRENT_USER() as RECORD_CREATED_BY_USER,
CURRENT_ROLE() as RECORD_CREATED_BY_ROLE,


---add/subtract days to/from current date/time
to_varchar(dateadd(day, 2, CURRENT_DATE()), 'yyyy-mm-dd') as S_TRANSACTION_DATE,
--subtract random days from current date/time
to_varchar(dateadd(day, (uniform(0, 5, random())*-1),CURRENT_DATE()), 'yyyy-mm-dd') as S_TRANSACTION_DATE,
dateadd(day,(uniform(0, 4, random())*-1),current_timestamp()) as TRANSACTION_DTTM,


---using datetimes: string->datetime->string
WITH file_data as (SELECT '20231025104914_debit.txt' as file_name)
SELECT concat(to_char(TO_TIMESTAMP(substring(file_name,0,8), 'YYYYMMDD'), 'YYYY-MM-DD'), ' ', to_char(TO_TIMESTAMP(substring(file_name,9,6), 'HH24MISS'), 'HH24:MI:SS')) as file_time
 FROM file_data;
--> 2023-10-25 10:49:14


-----append random number to a string to make it unique
concat(TRANSACTION_ID, uniform(0, 1000, random())) as TRANSACTION_ID,


---using regexp in filter & regexp_substr()
set audit_dt_p = '20231024';

with test_data AS (
 SELECT '/2023-10-24/20231024123456_debit.txt' as metadata
 UNION ALL
 SELECT '/2023-10-24/20231024123457_credit.txt' as metadata
)
select  regexp_substr(metadata,'[0-9]{14}.*_.*') as file_name
 FROM test_data
 WHERE 1=1 
   AND metadata regexp concat('.*/', $audit_dt_p, '[0-9]{6}.*_debit.*')  --for debit
   --AND metadata regexp concat('.*/', '20231024', '[0-9]{6}.*')  --for all files
;
