
-- What is the average cost to rent a film in the stores?
SELECT ROUND(AVG(rental_rate),2 )avg_rent FROM film;

-- What is the average rental cost of films by rating? On average, what is the cheapest rating of films to rent? Most expensive?
SELECT rating, ROUND(AVG(rental_rate),2 )avg_rent 
FROM film
GROUP BY rating
;

-- How much would it cost to replace all the films in the database?
SELECT SUM(replacement_cost)replacement_cost
FROM film
;


-- How much would it cost to replace all the films in each ratings category?
SELECT rating, SUM(replacement_cost)replacement_cost 
FROM film
GROUP BY rating
;

-- How long is the longest movie in the database? The shortest?
SELECT MIN(length) as shortest_length, MAX(length) as longest_length 
FROM film
;
-- How many languages?
SELECT COUNT(DISTINCT original_language_id) FROM film;


-- Determine the count of actor first names with the names ordered in descending order.

SELECT first_name, COUNT(first_name) as name_count
FROM actor
GROUP BY first_name
ORDER BY first_name DESC
;

-- Determine the average rental duration for each rating rounded to two decimals. Order these in ascending order.
SELECT rating, ROUND(AVG(rental_duration),2) AS avg_rent_time 
FROM film
GROUP BY rating
ORDER BY avg_rent_time ASC
;

-- Determine the top 10 average replacement costs for movies, ordered by their length.
SELECT length movie_length, ROUND(AVG(replacement_cost), 2)avg_repl_cost 
FROM film
GROUP BY length
ORDER BY length DESC

LIMIT 10
;	

-- ALTERNATE CAST AS MONEY
SELECT length movie_length, CAST(ROUND(AVG(replacement_cost), 2) AS MONEY) avg_repl_cost 
FROM film
GROUP BY length
ORDER BY length DESC

LIMIT 10;

-- Using the city and country tables, determine the count of countries in descending order.

SELECT c.country AS country_name, COUNT(c.country) AS country_count
FROM country as c
JOIN city as ct
ON (ct.country_id = c.country_id)
GROUP BY country_name
ORDER BY country_name DESC;

-- List the names and ID numbers of cities that are in the following list: `Qalyub`, `Qinhuangdao`, `Qomsheh`, `Quilmes`.
SELECT city, city_id 
FROM city 
WHERE position(city in ARRAY_TO_STRING(ARRAY['Qalyub', 'Qinhuangdao', 'Qomsheh', 'Quilmes'],','))>0;
-- ALTERNATE simpler:
SELECT city, city_id 
FROM city 
WHERE city IN ('Qalyub', 'Qinhuangdao', 'Qomsheh', 'Quilmes')

-- Display the districts in the above list of cities.
SELECT c.city, c.city_id, a.district
FROM address as a
JOIN city as c
ON (c.city_id = a.city_id)
WHERE POSITION(c.city in ARRAY_TO_STRING(ARRAY['Qalyub', 'Qinhuangdao', 'Qomsheh', 'Quilmes'],','))>0;

-- USING SUBQUERY:
SELECT district 
FROM address
WHERE city_id in (
    SELECT city_id
    FROM city
    WHERE city in ('Qalyub', 'Qinhuangdao', 'Qomsheh', 'Quilmes')
)


-- Using subqueries, find the first and last names of customers who reside in cities that begin with the letter *Q*.
SELECT customer.first_name, customer.last_name
FROM customer 
WHERE customer.address_id IN 
	(SELECT address.address_id 
	FROM address 
	WHERE city_id IN
	 (SELECT city_id
	  FROM city
	  WHERE city LIKE 'Q%')
	)
;

-- number of copies of film that exists in inventory... using subquery-not join

SELECT f.title, 
(SELECT count (i.film_id) FROM inventory AS i
WHERE f.film_id = i.film_id)
FROM film AS f
;

-- same query with join
SELECT f.title, COUNT(i.film_id) AS count_of_films 
FROM film as f, inventory as i
WHERE
(f.film_id = i.film_id)
GROUP BY f.title
ORDER BY count_of_films DESC
;

-- Create View title_count using subquery above 

CREATE VIEW title_count AS
SELECT f.title, 
(SELECT count (i.film_id) FROM inventory AS i
WHERE f.film_id = i.film_id)
FROM film AS f
;

-- query view
select * from title_count where count >7;

-- drop view
drop view title_count;


-- * Using subqueries, identify all actors who appear in the film 
-- ALTER VICTORY in the `pagila` database.
SELECT first_name, last_name 
FROM actor
WHERE actor_id IN 
	(SELECT actor_id FROM film_actor 
	WHERE film_id IN 
	 (SELECT film_id 
	  FROM film
	  WHERE title = 'ALTER VICTORY')
	)
;

-- Using subqueries, display the titles of films 
-- that were rented out by an employee named Jon Stephens.

SELECT title FROM film
WHERE film_id IN 
	(SELECT inventory_id FROM inventory
	WHERE inventory_id IN
	 ( SELECT inventory_id FROM RENTAL
		WHERE staff_id IN 
	  	(SELECT staff_id FROM staff
		WHERE last_name = 'Stephens' AND first_name = 'Jon') ) )
		;

-- union example
SELECT actor_id as id, first_name, last_name 
FROM ACTOR
WHERE actor_id between 1 AND 5
UNION
SELECT customer_id as id, first_name, last_name
FROM customer
WHERE customer_id BETWEEN 6 AND 10;
-- view/beginning normalization of fulltext column in film
CREATE VIEW string_split AS
SELECT SPLIT_PART(fulltext:: TEXT, ' ', 3) AS split_stuff
FROM film ;

-- BEAR GRACELAND actors subquery

select a.first_name, a.last_name
from actor as a
where a.actor_id in (
	select fa.actor_id 
	from film_actor as fa
		where fa.film_id in (
			select f.film_id 
			from film as f
			where f.title = 'BEAR GRACELAND')) 
	;

select count(split_stuff) from string_split
WHERE split_stuff LIKE '%canadian%';

-- find max number of columns for fulltext split
select max(array_length(string_to_array(fulltext:: TEXT, ' '), 1))
from film;