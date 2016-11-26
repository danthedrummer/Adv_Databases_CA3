drop database if exists data_mart;

create database data_mart;

use data_mart;

create table dim_store(
	store_key int(8) unsigned not null auto_increment primary key,
    store_id int(8) not null,
    store_address varchar(64) not null,
    store_district varchar(20) not null,
    store_postal_code varchar(10) not null,
    store_phone_number varchar(20) not null,
    store_city varchar(50) not null,
    store_country varchar(50) not null,
    store_manager_staff_id int(8) unsigned not null,
    store_manager_first_name varchar(45) not null,
    store_manager_last_name varchar(45) not null,
    store_version_number smallint(5) unsigned not null,
    store_valid_from date not null,
    store_valid_through date not null
    );
    
create table dim_film(
	film_key int(8) unsigned not null auto_increment primary key,
    film_title varchar(64) not null,
    film_description text(255) not null,
    film_release_year smallint(5) unsigned not null,
    film_language varchar(20) not null,
    film_original_language varchar(20) not null,
    rental_duration tinyint(3) unsigned not null,
    rental_rate decimal(4, 2) not null,
    duration int(8) unsigned not null,
    replacement_cost decimal(5, 2) not null,
    rating_code enum('G','PG','PG-13','R','NC-17') not null,
    rating_text varchar(30) not null,
    has_trailers enum('Yes','No') not null,
    has_commentaries enum('Yes','No') not null,
    has_deleted_scenes enum('Yes','No') not null,
    has_behind_the_scenes enum('Yes','No') not null
);

create table dim_customer(
	customer_key int(8) unsigned not null auto_increment primary key,
    customer_id int(8) unsigned not null,
    customer_first_name varchar(45) not null,
    customer_last_name varchar(45) not null,
    customer_email varchar(50) not null,
    customer_active char(3) not null,
    customer_created date not null,
    customer_address varchar(64) not null,
    customer_district varchar(20) not null,
    customer_postal_code varchar(10) not null,
    customer_phone_number varchar(20) not null,
    customer_city varchar(50) not null,
    customer_country varchar(50) not null,
    customer_version_number smallint(5) unsigned not null,
    customer_valid_from date not null,
    customer_valid_through date not null
);

create table dim_staff(
	staff_key int(8) unsigned not null auto_increment primary key,
    staff_first_name varchar(45) not null,
    staff_last_name varchar(45) not null,
    staff_id int(8) unsigned not null,
    staff_store_id int(8) unsigned not null,
    staff_version_number smallint(5) unsigned not null,
    staff_valid_from date not null,
    staff_valid_through date not null,
    staff_active char(3) not null
);

create table fact_rental(
	rental_id int(8) unsigned not null auto_increment primary key,
    customer_key int(8) unsigned not null,
    foreign key (customer_key) references dim_customer(customer_key),
    staff_key int(8) unsigned not null,
    foreign key (staff_key) references dim_staff(staff_key),
    film_key int(8) unsigned not null,
    foreign key (film_key) references dim_film(film_key),
    store_key int(8) unsigned not null,
    foreign key (store_key) references dim_store(store_key),
    rental_date timestamp not null,
    return_date timestamp not null,
    count_returns int(10) not null,
    count_rentals int(10) unsigned not null
);