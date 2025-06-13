SELECT round(100*avg(case when call_category	= 'n/a' then 1 when call_category	is NULL then 1 else 0 end),1) as uncategorised_call_pct
FROM callers;