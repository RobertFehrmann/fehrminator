create transient schema if not exists schema1 data_retention_time_in_days=0;  create or replace table schema1.table1 as select
      dateadd(day,uniform(1,100 , random(10001)),current_date)::date as column1
      ,(date_part(epoch_second, current_date)+(uniform(1,100, random(10002))))::timestamp as column2
      ,rpad(uniform(1,100 , random(10003))::varchar,uniform(length(100),10,random(10003+20000)),'abcdefghifklmnopqrstuvwxyz')::varchar(10) as column3
      ,rpad(uniform(1,100 , random(10004))::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column4
      ,uniform(1,100 , random(10005))::bigint as column5
      ,uniform(1,100 , random(10006))::integer as column6
      ,uniform(1,100 , random(10007))::double as column7
      ,uniform(1,100 , random(10008))::float as column8
      ,uniform(1,100 , random(10009))::number(10,2) as column9
      ,null::integer as column10
      ,dateadd(day,uniform(1,100 , random(10011)),current_date)::date as column101
      ,(date_part(epoch_second, current_date)+(uniform(1,100, random(10012))))::timestamp as column102
      ,rpad(uniform(1,100 , random(10013))::varchar,uniform(length(100),10,random(10013+20000)),'abcdefghifklmnopqrstuvwxyz')::varchar(10) as column103
      ,rpad(uniform(1,100 , random(10014))::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column104
      ,uniform(1,100 , random(10015))::bigint as column105
      ,uniform(1,100 , random(10016))::integer as column106
      ,uniform(1,100 , random(10017))::double as column107
      ,uniform(1,100 , random(10018))::float as column108
      ,uniform(1,100 , random(10019))::number(10,2) as column109
      ,null::integer as column110
   from table(generator(rowcount => 10000)); 


