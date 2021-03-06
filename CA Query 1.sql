#For each store list the number of different customers who rent films

select 
	dim_store.store_id as 'Store Number', 
    count(dim_customer.customer_id) as 'Number of active customer'
from dim_store
inner join dim_customer
	on dim_store.store_id = dim_customer.customer_store_id
#Makes sure the customer is an active customer
where dim_customer.customer_active = 1	
group by store_id;