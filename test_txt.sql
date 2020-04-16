create transient schema if not exists schema1 data_retention_time_in_days=0;  create or replace table schema1.table1 as select
      dateadd(day,uniform(1,1234 , random(10001)),current_date)::date as column1
      ,(date_part(epoch_second, current_date)+(uniform(1,1234, random(10002))))::timestamp as column2
      ,randstr(uniform(1,10, random(10003)),uniform(1,1234,random(10003)))::varchar(10) as column3
      ,rpad(uniform(1,1234 , random(10004))::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column4
      ,uniform(1,1234 , random(10005))::bigint as column5
      ,uniform(1,1234 , random(10006))::integer as column6
      ,uniform(1,1234 , random(10007))::double as column7
      ,uniform(1,1234 , random(10008))::float as column8
      ,uniform(1,1234 , random(10009))::number(10,2) as column9
      ,rpad(seq8()::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column10
      ,seq8()::bigint as column11
      ,(uniform(1,2,random(10012))-1)::boolean as column12
      ,null::integer as column13
      ,dateadd(day,uniform(1,1234 , random(10014)),current_date)::date as column101
      ,(date_part(epoch_second, current_date)+(uniform(1,1234, random(10015))))::timestamp as column102
      ,randstr(uniform(1,10, random(10016)),uniform(1,1234,random(10016)))::varchar(10) as column103
      ,rpad(uniform(1,1234 , random(10017))::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column104
      ,uniform(1,1234 , random(10018))::bigint as column105
      ,uniform(1,1234 , random(10019))::integer as column106
      ,uniform(1,1234 , random(10020))::double as column107
      ,uniform(1,1234 , random(10021))::float as column108
      ,uniform(1,1234 , random(10022))::number(10,2) as column109
      ,rpad(seq8()::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column110
      ,seq8()::bigint as column111
      ,(uniform(1,2,random(10025))-1)::boolean as column112
      ,null::integer as column113
   from table(generator(rowcount => 10000)); 


