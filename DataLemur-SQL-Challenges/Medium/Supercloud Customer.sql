SELECT c.customer_id
FROM customer_contracts as c
join  products as p 
on c.product_id= p.product_id
group by c.customer_id
having count(distinct p.product_category) =
(select count(distinct product_category) from products);