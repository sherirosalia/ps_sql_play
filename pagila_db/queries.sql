
-- Practice queries using Pagila database

select a.actor_id, a.first_name, a.last_name, fa.film_id, fa.film_id, 
f.title, l.name as language
from actor as a
inner join film_actor as fa
on (a.actor_id = fa.actor_id)
inner join film as f
on (fa.film_id = f.film_id)
inner join language as l
on (f.language_id = l.language_id)
where l.name = 'English';

select round(avg(rental_duration)) from film;

select title, round(avg(rental_duration), 2) as avg_rent_time from film
group by title
order by avg_rent_time desc;

-- max and min to rent film in stores
select min(rental_rate), max(rental_rate)
from film;

-- avg cost to rent in store
select round(avg(rental_rate), 2) as avg_rent
from film;

-- avg cost to rent by rating, two methods
--- using column names
select rating as rated, round(avg(rental_rate), 2) as avg_rent
from film
group by rating;

--- Alternate using column numbers instead of name
SELECT rating, 
ROUND(AVG(rental_rate), 2) AS avg_rent
FROM film
GROUP BY 1
ORDER BY 2;

-- cheapest avg cost to rent by rating, avg cost and most expensive
select rating as rated, round(avg(rental_rate), 2) as rental_avg, 
min(rental_rate) as cheapest,
max(rental_rate) as most_expensive
from film as avg_rent
group by rating;

-- cost to replace all films in database
select sum(replacement_cost) as total_replacement_cost from film;

-- Alternate
SELECT rating, CAST(SUM(replacement_cost) as money), 
        to_char(SUM(replacement_cost), 'L9,999.99')
FROM film
GROUP BY 1
ORDER BY 2;
        
-- cost to replace all films by rating
select rating, sum(replacement_cost) 
from film
group by rating;

-- longest and shortest movie time
select min(length) as shortest_movie_time, 
max(length) as longest_movie_time
from film;





