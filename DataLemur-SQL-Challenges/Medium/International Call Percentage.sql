SELECT round(100*avg(case when p2.country_id !=p3.country_id then 1 else 0 end),1) as international_calls_pct
FROM phone_calls p1
join phone_info p2
on p1.caller_id	= p2.caller_id
join phone_info p3
on p1.receiver_id	= p3.caller_id;