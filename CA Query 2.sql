#List the 10 most popular movies rented in May 2005

select 
	dim_film.film_title as 'Popular May 2005', 
    count(fact_rental.film_key) as 'Times Rented'
from dim_film 
inner join fact_rental
	on dim_film.film_key = fact_rental.film_key
where fact_rental.rental_date between '2005-05-01 00:00:00' and '2005-06-01 00:00:00'
group by dim_film.film_key order by count(fact_rental.film_key) desc
limit 0, 9;