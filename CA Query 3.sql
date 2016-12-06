#Which staff members have rented out Spanish movies the greatest number of times

select 
	dim_staff.staff_first_name as 'Staff Member', 
    count(fact_rental.film_key) as 'Number of Spanish films rented out'
from dim_staff
inner join fact_rental
	on dim_staff.staff_key = fact_rental.staff_key
inner join dim_film
	on fact_rental.film_key = dim_film.film_key
where dim_film.film_language = 'Spanish'
group by dim_staff.staff_first_name desc;