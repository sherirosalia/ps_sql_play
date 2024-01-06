
-- Practice queries using Pagila database

SELECT a.actor_id, a.first_name, a.last_name, fa.film_id, fa.film_id, 
f.title, l.name AS language
FROM actor AS a
INNER JOIN film_actor AS fa
ON (a.actor_id = fa.actor_id)
INNER JOIN film AS f
ON (fa.film_id = f.film_id)
INNER JOIN language AS l
ON (f.language_id = l.language_id)
WHERE l.name = 'English'
;

SELECT round(avg(rental_duration)) FROM film;

SELECT title, round(avg(rental_duration), 2) AS avg_rent_time FROM film
GROUP BY title
ORDER BY avg_rent_time DESC;

-- max and min to rent film in stores
SELECT MIN(rental_rate), MAX(rental_rate)
FROM film
;

-- avg cost to rent in store
SELECT round(avg(rental_rate), 2) AS avg_rent
FROM film
;

-- avg cost to rent by rating, two methods
--- using column names
SELECT rating AS rated, round(avg(rental_rate), 2) AS avg_rent
FROM film
GROUP BY rating
;

--- Alternate using column numbers instead of name
SELECT rating, 
ROUND(AVG(rental_rate), 2) AS avg_rent
FROM film
GROUP BY 1
ORDER BY 2
;

-- cheapest avg cost to rent by rating, avg cost and most expensive
SELECT rating AS rated, round(avg(rental_rate), 2) AS rental_avg, 
min(rental_rate) AS cheapest,
max(rental_rate) AS most_expensive
FROM film AS avg_rent
GROUP BY rating
;

-- cost to replace all films in database
SELECT sum(replacement_cost) AS total_replacement_cost FROM film;

-- Alternate
SELECT rating, CAST(SUM(replacement_cost) as money), 
        to_char(SUM(replacement_cost), 'L9,999.99')
FROM film
GROUP BY 1
ORDER BY 2
;
        
-- cost to replace all films by rating
SELECT rating, SUM(replacement_cost) 
FROM film
GROUP BY rating
;

-- longest and shortest movie time
SELECT MIN(length) AS shortest_movie_time, 
MAX(length) AS longest_movie_time
FROM film
;


-- using city and country tables determine number of 
-- cities in each country from the database in descending order

SELECT country.country, COUNT(city.city) AS city_count
FROM country 
INNER JOIN city 
ON (country.country_id = city.country_id)
GROUP BY 1
ORDER BY 2 DESC
;


-- count of length of films by rental rate
SELECT DISTINCT rental_rate as rate, COUNT(length) as film_count, length
FROM film
GROUP BY  length, rate
ORDER BY length DESC
;
--- or
SELECT DISTINCT rental_rate as rate, COUNT(length) as film_count, length
FROM film
GROUP BY  length, rate
ORDER BY film_count DESC
;


-- Retreive the latest rental for each 
-- customer's first and last name and email address. 
-- Retrdieve the latest rental date for each title
-- helpfuL: https://stackoverflow.com/questions/19027881/select-rows-based-on-last-date
-- helpful: https://stackoverflow.com/questions/3800551/select-first-row-in-each-group-by-group/7630564#7630564
SELECT DISTINCT ON(f.title ) *, c.first_name, c.last_name, c.email, 
r.rental_date
FROM customer as c
JOIN rental as r
ON (c.customer_id = r.customer_id)
JOIN inventory as i
ON (r.inventory_id = i.inventory_id)
JOIN film as f
ON (i.film_id = f.film_id)
ORDER  BY f.title, c.customer_id, r.rental_date DESC NULLS LAST;

;

-- * The last query only returned 958 movies, which means 42 movies are not being rented. 
-- We know that there are 1,000 movies in the `film` table. 
-- Retrieve the film titles of the 42 movies that are not in the `inventory` table. 
SELECT f.title
FROM film as f
WHERE f.film_id NOT IN (SELECT film_id from inventory)

