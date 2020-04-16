-------------------------------------
-- Generating Database: TEST
-------------------------------------
CREATE TRANSIENT SCHEMA IF NOT EXISTS schema1 DATA_RETENTION_TIME_IN_DAYS=0;
USE SCHEMA schema1;
CREATE or REPLACE TABLE table1
AS
SELECT
   dateadd(day, uniform(1, 1234, random(10002)), date_trunc(day, current_date))::date as column1,
   (date_part(epoch_second, current_date) + (uniform(1, 1234, random(10003))))::timestamp as column2,
   randstr(uniform(1,10, random(10004)),uniform(1,1234,random(10004)))::varchar(10) as column3,
   rpad(uniform(1, 1234, random(10005))::varchar,10, 'abcdefghifklmnopqrstuvwxyz')::char(10) as column4,
   uniform(1,1234 , random(10006))::bigint as column5,
   uniform(1,1234 , random(10007))::integer as column6,
   uniform(1,1234 , random(10008))::double as column7,
   uniform(1,1234 , random(10009))::float as column8,
   uniform(1,1234 , random(10010))::number(10,2) as column9,
   rpad((seq8()+1)::varchar,10, 'abcdefghifklmnopqrstuvwxyz')::char(10) as column10,
   (seq8()+1)::bigint as column11,
   (uniform(1,2 , random(10013))-1)::boolean as column12,
   null::integer as column13,
   (case when uniform(1,1000,random(20015))<=300 then null else dateadd(day, uniform(1, 1234, random(10015)), date_trunc(day, current_date)) end)::date as column101,
   (case when uniform(1,1000,random(20016))<=300 then null else (date_part(epoch_second, current_date) + (uniform(1, 1234, random(10016)))) end)::timestamp as column102,
   (case when uniform(1,1000,random(20017))<=300 then null else randstr(uniform(1,10, random(10017)),uniform(1,1234,random(10017))) end)::varchar(10) as column103,
   (case when uniform(1,1000,random(20018))<=300 then null else rpad(uniform(1, 1234, random(10018))::varchar,10, 'abcdefghifklmnopqrstuvwxyz') end)::char(10) as column104,
   (case when uniform(1,1000,random(20019))<=300 then null else uniform(1,1234 , random(10019)) end)::bigint as column105,
   (case when uniform(1,1000,random(20020))<=300 then null else uniform(1,1234 , random(10020)) end)::integer as column106,
   (case when uniform(1,1000,random(20021))<=300 then null else uniform(1,1234 , random(10021)) end)::double as column107,
   (case when uniform(1,1000,random(20022))<=300 then null else uniform(1,1234 , random(10022)) end)::float as column108,
   (case when uniform(1,1000,random(20023))<=300 then null else uniform(1,1234 , random(10023)) end)::number(10,2) as column109,
   (case when uniform(1,1000,random(20024))<=300 then null else rpad((seq8()+1)::varchar,10, 'abcdefghifklmnopqrstuvwxyz') end)::char(10) as column110,
   (case when uniform(1,1000,random(20025))<=300 then null else (seq8()+1) end)::bigint as column111,
   (case when uniform(1,1000,random(20026))<=300 then null else (uniform(1,2 , random(10026))-1) end)::boolean as column112,
   null::integer as column113
from table(generator(rowcount => 10000));
 
