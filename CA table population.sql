use data_mart;

#	Disable safe update to allow updates without primary keys
set sql_safe_updates = 0;	

###	Staff table population ###
drop table if exists staff;
create table data_mart.staff like sakila.staff;
insert into data_mart.staff select * from sakila.staff;

insert into dim_staff(staff_first_name, staff_last_name, staff_id)
(
	select first_name, last_name, staff_id from staff
);

###	Store table population ###
drop table if exists store;
create table data_mart.store like sakila.store;
insert into data_mart.store select * from sakila.store;

insert into dim_store(store_id, store_manager_staff_id)
(
	select store_id, manager_staff_id from store 
);

update dim_store set store_manager_first_name = 
(
	select first_name from staff
    where store_manager_staff_id = staff_id
);

update dim_store set store_manager_last_name = 
(
	select last_name from staff
    where store_manager_staff_id = staff_id
);

#	Extract store address
update dim_store set store_address = 
(
	select address from sakila.address
    where address_id = 
	(
		select address_id from store
		where store_id = dim_store.store_id
	)		
);

#	Extract store district
update dim_store set store_district =
(
	select district from sakila.address
    where address_id =
	(
        select address_id from store
        where store_id = dim_store.store_id
	)
);

#	Extract store postal code
update dim_store set store_postal_code = 
(
	select postal_code from sakila.address
    where address_id =
	(
        select address_id from store
        where store_id = dim_store.store_id
	)
);

#	Extract store phone number
update dim_store set store_phone_number = 
(
	select phone from sakila.address
    where address_id =
	(
        select address_id from store
        where store_id = dim_store.store_id
	)
);

#	Extract store city using city id
update dim_store set store_city = 
(
	select city from sakila.city
    where city_id =
	(
        select city_id from sakila.address
        where address_id = 
		(
            select address_id from store
            where store_id = dim_store.store_id
		)
	)
);

#	Extract store country using city 
update dim_store set store_country = 
(
	select country from sakila.country
    where country_id =
	(
        select country_id from sakila.city
        where city = store_city
	)
);

### Customer table population ###
drop table if exists customer;
create table data_mart.customer like sakila.customer;
insert into data_mart.customer select * from sakila.customer;

insert into dim_customer(customer_id, customer_first_name, customer_last_name, customer_email, customer_active, customer_created)
(
	select customer_id, first_name, last_name, email, active, create_date from customer
);

#	Extract customer address
update dim_customer set customer_address = 
(
	select address from sakila.address
    where address_id = 
	(
		select address_id from customer
		where customer_id = dim_customer.customer_id
	)		
);

#	Extract customer district
update dim_customer set customer_district =
(
	select district from sakila.address
    where address_id =
	(
        select address_id from customer
        where customer_id = dim_customer.customer_id
	)
);

#	Extract customer postal code
update dim_customer set customer_postal_code = 
(
	select postal_code from sakila.address
    where address_id =
	(
        select address_id from customer
        where customer_id = dim_customer.customer_id
	)
);

#	Extract customer phone number
update dim_customer set customer_phone_number = 
(
	select phone from sakila.address
    where address_id =
	(
        select address_id from customer
        where customer_id = dim_customer.customer_id
	)
);

#	Extract customer city 
update dim_customer set customer_city = 
(
	select city from sakila.city
    where city_id =
	(
        select city_id from sakila.address
        where address_id = 
		(
            select address_id from customer
            where customer_id = dim_customer.customer_id
		)
	)
);

#	Extract customer country 
update dim_customer set customer_country = 
(
	select country from sakila.country
    where country_id =
	(
        select country_id from sakila.city
        where city_id = 
        (
			select city_id from sakila.address
            where address = dim_customer.customer_address
        )
	)
);

### Film table population ###
drop table if exists film;
create table data_mart.film like sakila.film;
insert into data_mart.film select * from sakila.film;

insert into dim_film(film_id, film_title, film_description, film_release_year, rental_duration, rental_rate, duration, replacement_cost, rating_code, special_features)
(
	select film_id, title, description, release_year, rental_duration, rental_rate, length, replacement_cost, rating, special_features from film
);

#	Extract film language 
update dim_film set film_language =
(
	select name from sakila.language
    where language_id = 
    (
		select language_id from film
        where film_id = dim_film.film_id
    )
);

#	Extract original film language 
update dim_film set film_original_language =
(
	select name from sakila.language
    where language_id = 
    (
		select original_language_id from film
        where film_id = dim_film.film_id
    )
);

### fact_rental table population
drop table if exists rental;
create table data_mart.rental like sakila.rental;
insert into data_mart.rental select * from sakila.rental;

### Remove temporary tables ###
drop table if exists staff;
drop table if exists store;
drop table if exists customer;
drop table if exists film;
drop table if exists rental;