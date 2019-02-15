-------------------------------------
-- Generating Database: TEST
-------------------------------------
CREATE SCHEMA IF NOT EXISTS schema1;
USE SCHEMA schema1;
CREATE or REPLACE TABLE "table1"
AS
SELECT
   dateadd(day, uniform(1, 100, random(10002)), date_trunc(day, current_date))::DATE as "column1",
   (date_part(epoch_second, current_date) + (uniform(1, 100, random(10003))))::timestamp as "column2",
   rpad(lpad(uniform(1, 100, random(10004))::varchar,length(100),'0'),10, 'abcdefghifklmnopqrstuvwxyz')::varchar(10) as "column3",
   rpad(lpad(uniform(1, 100, random(10005))::varchar,length(100),'0'),10, 'abcdefghifklmnopqrstuvwxyz')::char(10) as "column4",
   uniform(1,100 , random(10006))::bigint as "column5",
   uniform(1,100 , random(10007))::integer as "column6",
   uniform(1,100 , random(10008))::double as "column7",
   uniform(1,100 , random(10009))::float as "column8",
   uniform(1,100 , random(10010))::number(10,2) as "column9"
from table(generator(rowcount => 10000));
 
