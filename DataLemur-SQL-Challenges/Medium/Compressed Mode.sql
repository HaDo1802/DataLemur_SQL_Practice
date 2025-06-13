SELECT item_count 
 FROM items_per_order
where order_occurrences in 
(select max(order_occurrences) from items_per_order)
order by item_count asc;