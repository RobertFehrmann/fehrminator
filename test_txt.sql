create transient schema if not exists schema1 data_retention_time_in_days=0;  create or replace table schema1.table1 as select
   column1::date as column1
   ,column2::timestamp as column2
   ,column3::varchar(10) as column3
   ,column4::char(10) as column4
   ,column5::bigint as column5
   ,column6::integer as column6
   ,column7::double as column7
   ,column8::float as column8
   ,column9::number(10,2) as column9
   ,column10::char(10) as column10
   ,column11::bigint as column11
   ,column12::integer as column12
   ,(case when uniform(1,1000,random(20013)) > 300 then column101 else null end)::date as column101
   ,(case when uniform(1,1000,random(20014)) > 300 then column102 else null end)::timestamp as column102
   ,(case when uniform(1,1000,random(20015)) > 300 then column103 else null end)::varchar(10) as column103
   ,(case when uniform(1,1000,random(20016)) > 300 then column104 else null end)::char(10) as column104
   ,(case when uniform(1,1000,random(20017)) > 300 then column105 else null end)::bigint as column105
   ,(case when uniform(1,1000,random(20018)) > 300 then column106 else null end)::integer as column106
   ,(case when uniform(1,1000,random(20019)) > 300 then column107 else null end)::double as column107
   ,(case when uniform(1,1000,random(20020)) > 300 then column108 else null end)::float as column108
   ,(case when uniform(1,1000,random(20021)) > 300 then column109 else null end)::number(10,2) as column109
   ,(case when uniform(1,1000,random(20022)) > 300 then column110 else null end)::char(10) as column110
   ,(case when uniform(1,1000,random(20023)) > 300 then column111 else null end)::bigint as column111
   ,(case when uniform(1,1000,random(20024)) > 300 then column112 else null end)::integer as column112
from ( 
   select
      dateadd(day,uniform(1,1234 , random(10001)),current_date)::date as column1
      ,(date_part(epoch_second, current_date)+(uniform(1,1234, random(10002))))::timestamp as column2
      ,rpad(uniform(1,1234 , random(10003))::varchar,uniform(length(1234),10,random(10003+20000)),'abcdefghifklmnopqrstuvwxyz')::varchar(10) as column3
      ,rpad(uniform(1,1234 , random(10004))::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column4
      ,uniform(1,1234 , random(10005))::bigint as column5
      ,uniform(1,1234 , random(10006))::integer as column6
      ,uniform(1,1234 , random(10007))::double as column7
      ,uniform(1,1234 , random(10008))::float as column8
      ,uniform(1,1234 , random(10009))::number(10,2) as column9
      ,rpad(seq8()::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column10
      ,seq8()::bigint as column11
      ,null::integer as column12
      ,dateadd(day,uniform(1,1234 , random(10013)),current_date)::date as column101
      ,(date_part(epoch_second, current_date)+(uniform(1,1234, random(10014))))::timestamp as column102
      ,rpad(uniform(1,1234 , random(10015))::varchar,uniform(length(1234),10,random(10015+20000)),'abcdefghifklmnopqrstuvwxyz')::varchar(10) as column103
      ,rpad(uniform(1,1234 , random(10016))::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column104
      ,uniform(1,1234 , random(10017))::bigint as column105
      ,uniform(1,1234 , random(10018))::integer as column106
      ,uniform(1,1234 , random(10019))::double as column107
      ,uniform(1,1234 , random(10020))::float as column108
      ,uniform(1,1234 , random(10021))::number(10,2) as column109
      ,rpad(seq8()::varchar,10,'abcdefghifklmnopqrstuvwxyz')::char(10) as column110
      ,seq8()::bigint as column111
      ,null::integer as column112
   from table(generator(rowcount => 10000))); 


