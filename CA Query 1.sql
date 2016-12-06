#For each store list the number of different customers who rent films

select dim_store.store_id, count(dim_customer.customer_id) 
from dim_store
inner join dim_customer
on dim_store.store_id = dim_customer.customer_store_id
where dim_customer.customer_active = 1
group by store_id;