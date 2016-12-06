drop database if exists data_mart;

create database data_mart;

use data_mart;

create table dim_store(
	store_key int(8) unsigned not null auto_increment primary key,
    store_id int(8) not null,
    store_address varchar(64),
    store_district varchar(20),
    store_postal_code varchar(10),
    store_phone_number varchar(20),
    store_city varchar(50),
    store_country varchar(50),
    store_manager_staff_id int(8) unsigned,
    store_manager_first_name varchar(45),
    store_manager_last_name varchar(45)
    );
    
create table dim_film(
	film_key int(8) unsigned not null auto_increment primary key,
    film_title varchar(64) not null,
    film_description text(255),
    film_release_year smallint(5) unsigned,
    film_language varchar(20),
    rental_duration tinyint(3) unsigned not null default '3',
    rental_rate decimal(4, 2) not null default '4.99',
    duration int(8) unsigned,
    replacement_cost decimal(5, 2) not null default '19.99',
    rating_code enum('G','PG','PG-13','R','NC-17') default 'G',
    special_features set('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes')
);

create table dim_customer(
	customer_id int(8) unsigned not null auto_increment primary key,
    customer_store_id int(8) unsigned not null,
    customer_first_name varchar(45) not null,
    customer_last_name varchar(45) not null,
    customer_email varchar(50),
    customer_active char(3),
    customer_created date,
    customer_address varchar(64),
    customer_district varchar(20),
    customer_postal_code varchar(10),
    customer_phone_number varchar(20),
    customer_city varchar(50),
    customer_country varchar(50)
);

create table dim_staff(
	staff_key int(8) unsigned not null auto_increment primary key,
    staff_first_name varchar(45) not null,
    staff_last_name varchar(45) not null,
    staff_id int(8) unsigned not null,
    staff_store_id int(8) unsigned
);

create table fact_rental(
	rental_id int(8) unsigned not null auto_increment primary key,
    customer_id int(8) unsigned,
    foreign key (customer_id) references dim_customer(customer_id),
    staff_key int(8) unsigned,
    foreign key (staff_key) references dim_staff(staff_key),
    film_key int(8) unsigned,
    foreign key (film_key) references dim_film(film_key),
    store_key int(8) unsigned,
    foreign key (store_key) references dim_store(store_key),
    rental_date datetime,
    return_date datetime
);