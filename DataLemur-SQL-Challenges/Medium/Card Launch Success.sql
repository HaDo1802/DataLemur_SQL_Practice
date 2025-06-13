SELECT card_name,
       issued_amount
FROM
(
    SELECT card_name,
          issued_amount,
          DENSE_RANK() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) AS rank
    FROM monthly_cards_issued
) AS TP
WHERE rank = 1
ORDER BY issued_amount DESC;

--- Another solution: using CTE and JOIN:
'''WITH launch_months AS (
  SELECT 
    card_name,
    MIN(issue_year * 100 + issue_month) AS launch_date_key
  FROM monthly_cards_issued
  GROUP BY card_name
)

SELECT 
  m.card_name,
  m.issued_amount
FROM monthly_cards_issued m
JOIN launch_months l
  ON m.card_name = l.card_name
  AND (m.issue_year * 100 + m.issue_month) = l.launch_date_key
ORDER BY m.issued_amount DESC;''
