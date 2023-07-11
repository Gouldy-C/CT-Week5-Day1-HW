--Week 5 - Monday Questions

--1. How many actors are there with the last name ‘Wahlberg’?

SELECT
	last_name ,
	COUNT(last_name)
FROM
	actor
WHERE
	last_name = 'Wahlberg'
GROUP BY
	last_name;

--2. How many payments were made between $3.99 and $5.99?

SELECT
	COUNT(payment_id)
FROM
	payment
WHERE
	amount BETWEEN 3.99 AND 5.99;

--3. What films does the store have the most of? (search in inventory)

--All
SELECT
	film_id,
	COUNT(film_id) AS counted
FROM
	inventory
GROUP BY
	film_id
HAVING
	COUNT(film_id) = 8
ORDER BY
	counted DESC;

--Store 1
SELECT
	film_id,
	COUNT(film_id) AS counted
FROM
	inventory
WHERE
	store_id = 1
GROUP BY
	film_id
HAVING
	COUNT(film_id) = 4
ORDER BY
	counted DESC;


--Store 2
SELECT
	film_id,
	COUNT(film_id) AS counted
FROM
	inventory
WHERE
	store_id = 2
GROUP BY
	film_id
HAVING
	COUNT(film_id) = 4
ORDER BY
	counted DESC;

--4. How many customers have the last name ‘William’?

SELECT
	last_name,
	COUNT(last_name)
FROM
	customer
WHERE
	last_name = 'William'
GROUP BY
	last_name;


SELECT
	last_name,
	COUNT(last_name)
FROM
	customer
WHERE
	last_name LIKE 'William%'
GROUP BY
	last_name;

--5. What store employee (get the id) sold the most rentals?

SELECT
	staff_id ,
	COUNT(staff_id) AS counted
FROM
	rental
GROUP BY
	staff_id
ORDER BY
	Counted DESC;

--6. How many different district names are there?

SELECT
	COUNT(subquery.district) AS districts_count
FROM
	( SELECT DISTINCT district
	FROM address) AS SUBQUERY;


--7. What film has the most actors in it? (use film_actor table and get film_id)
SELECT SUBQUERY.film_id
FROM (
    SELECT film_id, COUNT(actor_id) AS actor_count
    FROM film_actor
    GROUP BY film_id
) AS SUBQUERY
WHERE SUBQUERY.actor_count = (
    SELECT MAX(actor_count)
    FROM (
        SELECT film_id, COUNT(actor_id) AS actor_count
        FROM film_actor
        GROUP BY film_id
    ) AS MAX_SUBQUERY
)


--8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)

SELECT COUNT(SUB.last_name)
FROM(SELECT last_name
	FROM customer
	WHERE last_name LIKE '%es') AS SUB;

--9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers with ids between 380 and 430? (use group by and having > 250)

SELECT amount , COUNT(amount) 
FROM payment
WHERE customer_id BETWEEN 380 AND 430
GROUP BY amount 
HAVING COUNT(amount) > 250;

--10. Within the film table, how many rating categories are there? And what rating has the most movies total?
SELECT SUB.rating
FROM(SELECT DISTINCT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC ) AS SUB