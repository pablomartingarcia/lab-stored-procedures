-- 1. 

DELIMITER //

CREATE PROCEDURE GetCustomersRentingActionMovies()
BEGIN
    select first_name, last_name, email
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = "Action"
    group by first_name, last_name, email;
END //

DELIMITER ;

CALL GetCustomersRentingActionMovies();

-- 2. 

DELIMITER //

CREATE PROCEDURE GetCustomersRentingMoviesByCategory(IN categoryName VARCHAR(255))
BEGIN
    SELECT first_name, last_name, email
    FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON film.film_id = inventory.film_id
    JOIN film_category ON film_category.film_id = film.film_id
    JOIN category ON category.category_id = film_category.category_id
    WHERE category.name = categoryName
    GROUP BY first_name, last_name, email;
END //

DELIMITER ;

CALL GetCustomersRentingMoviesByCategory('Animation');

-- 3. 

SELECT category.name AS category_name, COUNT(film.film_id) AS num_movies_released
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

DELIMITER //

CREATE PROCEDURE FilterCategoriesByMovieCount(IN minMovieCount INT)
BEGIN
    SELECT category.name AS category_name, COUNT(film.film_id) AS num_movies_released
    FROM category
    JOIN film_category ON category.category_id = film_category.category_id
    JOIN film ON film_category.film_id = film.film_id
    GROUP BY category.name
    HAVING COUNT(film.film_id) > minMovieCount;
END //

DELIMITER ;

CALL FilterCategoriesByMovieCount(60);