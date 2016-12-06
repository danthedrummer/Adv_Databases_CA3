#List the 10 most popular movies rented in May 2015

select 
	dim_film.film_title as 'Popular May 2015', 
    count(fact_rental.film_key) as 'Times Rented'
from dim_film
inner join fact_rental
	on dim_film.film_key = fact_rental.film_key
group by dim_film.film_key order by count(fact_rental.film_key) desc
limit 0, 9;