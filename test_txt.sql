create schema if not exists schema1;  create or replace table schema1."table1" as select
      dateadd(day,uniform(1,100 , random(10001)),current_date)::date as "column1"
      ,(date_part(epoch_second, current_date)+(uniform(1,100, random(10002))))::timestamp as "column2"
      ,rpad(lpad(uniform(1,100 , random(10003))::varchar, length(100),'0'),10,'abcdefghifklmnopqrstuvwxyz')::varchar(10) as "column3"
      ,rpad(lpad(uniform(1,100 , random(10004))::varchar, length(100),'0'),10,'abcdefghifklmnopqrstuvwxyz')::char(10) as "column4"
      ,uniform(1,100 , random(10005))::bigint as "column5"
      ,uniform(1,100 , random(10006))::integer as "column6"
      ,uniform(1,100 , random(10007))::double as "column7"
      ,uniform(1,100 , random(10008))::float as "column8"
      ,uniform(1,100 , random(10009))::number(10,2) as "column9"
   from table(generator(rowcount => 10000)); 


