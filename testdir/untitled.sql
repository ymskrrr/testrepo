select
     tmp.type
    ,max(case tmp.seq when 1 then tmp.qualification_id else null end) as qualification_id1
    ,max(case tmp.seq when 2 then tmp.qualification_id else null end) as qualification_id2
    ,max(case tmp.seq when 3 then tmp.qualification_id else null end) as qualification_id3
    ,max(case tmp.seq when 4 then tmp.qualification_id else null end) as qualification_id4
from
(
    select
         employee_id
        ,qualification_id
        ,row_number() over (partition by employee_id) as seq
    from
        mysql_jobs
) tmp
group by
    tmp.type




SELECT
  A.部品コード
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '04' THEN A.数量 ELSE 0 END) AS "4月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '05' THEN A.数量 ELSE 0 END) AS "5月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '06' THEN A.数量 ELSE 0 END) AS "6月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '07' THEN A.数量 ELSE 0 END) AS "7月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '08' THEN A.数量 ELSE 0 END) AS "8月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '09' THEN A.数量 ELSE 0 END) AS "9月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '10' THEN A.数量 ELSE 0 END) AS "10月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '11' THEN A.数量 ELSE 0 END) AS "11月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '12' THEN A.数量 ELSE 0 END) AS "12月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '01' THEN A.数量 ELSE 0 END) AS "1月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '02' THEN A.数量 ELSE 0 END) AS "2月"
, SUM(CASE SUBSTRING(A.年月日,5,2) WHEN '03' THEN A.数量 ELSE 0 END) AS "3月"
  FROM [dbo].[部品発注表] A
 WHERE B.年度 = '2014'
 GROUP BY A.部品コード
 ORDER BY A.部品コード;



SELECT 
  time,
  COUNT(1) AS cnt
FROM
(
 SELECT 
   type,
   TD_TIME_FORMAT(time,'yyyy-MM-dd','JST') AS date_time,
   TD_TIME_FORMAT(TD_SCHEDULED_TIME(),'yyyy-MM-dd','JST') AS now_datetime
 FROM mysql_jobs
 WHERE 
  time < TD_SCHEDULED_TIME()
  AND time >= TD_TIME_ADD(TD_SCHEDULED_TIME(),'-64d','JST')
) monthly
WHERE (MONTH(now_datetime)- MONTH(date_time)) IN (0, 1, -11)
GROUP BY
  date_time
