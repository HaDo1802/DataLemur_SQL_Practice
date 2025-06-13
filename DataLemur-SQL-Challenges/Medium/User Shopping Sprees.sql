with cte_table as (
select *, 
(day_extract - INTERVAL '1 day' *row_number () over( PARTITION by user_id order by day_extract asc )) as group_key 
FROM (SELECT user_id, DATE( transaction_date) as day_extract
FROM transactions) as t
                  ) 
select user_id
from cte_table
group by user_id, group_key
having count(*) >=3
ORDER BY user_id;
-- I leveraged the "gaps and islands" technique to solve this problem. The idea is to identify sequences of consecutive days for each user by calculating a "group_key" that remains constant for consecutive days. This is achieved by subtracting a row number (which increments with each day) from the actual date. When the difference between the date and the row number is the same, it indicates that the days are consecutive.
-- After establishing these groups, I then group the results by user_id and the calculated group_key, counting the number of days in each group. Finally, I filter to include only those users who have at least one group with three or more consecutive days, ensuring that the output is sorted by user_id.
-- This approach effectively identifies users with at least three consecutive transaction days.
-- Reference:
-- https://stackoverflow.com/questions/2793838/find-consecutive-dates-in-sql