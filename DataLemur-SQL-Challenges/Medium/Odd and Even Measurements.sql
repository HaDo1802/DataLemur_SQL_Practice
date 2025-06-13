with assign as (
SELECT *,
row_number() over( PARTITION by measurement_day order by measurement_time asc) as nth
FROM 
( select
  measurement_value, 
  measurement_time,
  DATE(measurement_time) AS measurement_day
FROM  measurements ) AS T )
select measurement_day,
  sum(CASE WHEN nth%2=1 THEN measurement_value ELSE 0 END) as odd_sum,
  sum(CASE WHEN nth%2=0 THEN measurement_value ELSE 0 END) as even_sum
from assign
group by measurement_day;