-------------------------------------
-- Generating Database: TEST
-------------------------------------
CREATE TRANSIENT SCHEMA IF NOT EXISTS schema1 DATA_RETENTION_TIME_IN_DAYS=0;
USE SCHEMA schema1;
CREATE or REPLACE TABLE table1
AS
SELECT
   dateadd(day, uniform(1, 100, random(10002)), date_trunc(day, current_date))::date as column1,
   (date_part(epoch_second, current_date) + (uniform(1, 100, random(10003))))::timestamp as column2,
   rpad(uniform(1, 100, random(10004))::varchar,uniform(length(100),10,random(30004)), 'abcdefghifklmnopqrstuvwxyz')::varchar(10) as column3,
   rpad(uniform(1, 100, random(10005))::varchar,10, 'abcdefghifklmnopqrstuvwxyz')::char(10) as column4,
   uniform(1,100 , random(10006))::bigint as column5,
   uniform(1,100 , random(10007))::integer as column6,
   uniform(1,100 , random(10008))::double as column7,
   uniform(1,100 , random(10009))::float as column8,
   uniform(1,100 , random(10010))::number(10,2) as column9,
   null::integer as column10,
   (case when uniform(1,1000,random(20011))<=300 then null else dateadd(day, uniform(1, 100, random(10012)), date_trunc(day, current_date)) end)::date as column101,
   (case when uniform(1,1000,random(20011))<=300 then null else (date_part(epoch_second, current_date) + (uniform(1, 100, random(10013)))) end)::timestamp as column102,
   (case when uniform(1,1000,random(20011))<=300 then null else rpad(uniform(1, 100, random(10014))::varchar,uniform(length(100),10,random(30014)), 'abcdefghifklmnopqrstuvwxyz') end)::varchar(10) as column103,
   (case when uniform(1,1000,random(20011))<=300 then null else rpad(uniform(1, 100, random(10015))::varchar,10, 'abcdefghifklmnopqrstuvwxyz') end)::char(10) as column104,
   (case when uniform(1,1000,random(20011))<=300 then null else uniform(1,100 , random(10016)) end)::bigint as column105,
   (case when uniform(1,1000,random(20011))<=300 then null else uniform(1,100 , random(10017)) end)::integer as column106,
   (case when uniform(1,1000,random(20011))<=300 then null else uniform(1,100 , random(10018)) end)::double as column107,
   (case when uniform(1,1000,random(20011))<=300 then null else uniform(1,100 , random(10019)) end)::float as column108,
   (case when uniform(1,1000,random(20011))<=300 then null else uniform(1,100 , random(10020)) end)::number(10,2) as column109,
   null::integer as column110
from table(generator(rowcount => 10000));
 
