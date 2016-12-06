#Identify customer who have movies that haven't been returned yet and list the film title

select 
	dim_customer.customer_first_name as 'First Name', 
	dim_customer.customer_last_name as 'Last Name',
    dim_film.film_title as 'Film Name'
from dim_customer
inner join fact_rental
	on dim_customer.customer_key = fact_rental.customer_key
inner join dim_film
	on fact_rental.film_key = dim_film.film_key
where fact_rental.return_date is null;
		