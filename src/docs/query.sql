-- get customer lists with bouns
SELECT 
	first_name,
    last_name,
    points * points AS bouns
FROM customers;

-- Get state list from customers
SELECT 
	DISTINCT state
FROM customers;

-- Get products list
SELECT
	name,
    unit_price,
    unit_price * 1.1 AS new_price
FROM products;

-- Get customers where the points is greater than 2000 and first_name not equal to Elka
SELECT 
	first_name,
    points
FROM customers
WHERE points > 2000 AND first_name != "Elka";

-- Get orders where the shipped_date is greated than 2018-01-01
SELECT *
FROM orders
WHERE shipped_date > "2018-01-01";

-- Get customers where state is VA or TX and points greater than or equal to 2000
SELECT *
FROM customers
WHERE (state = "VA" || state = "TX") AND points >= 2000;

SELECT *
FROM customers
WHERE NOT (state = "VA" || state = "TX");

-- Get orders where the total_price is greater than 30. (total_price = unit_price * quantity)
SELECT 
	*,
    (unit_price * quantity) AS total_price
FROM order_items
WHERE order_id = 6 AND (unit_price * quantity) > 30;

-- Get customers who is in the state VA and TX
SELECT * 
FROM customers
WHERE state IN ("VA","TX");

-- Get customers who is not in the state VA and TX
SELECT * 
FROM customers
WHERE state NOT IN ("VA","TX");

-- Get products where quantity_in_stock is 49 or 38 or 72
SELECT * 
FROM products
WHERE quantity_in_stock IN (49,38,72);

-- Get customers whose points in between 1000 and 2000
SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 2000

-- Get customers where address contains trail or avenue and phone ends with 6 or 7
SELECT * 
FROM customers
WHERE (address LIKE "%trail%" OR address LIKE "%avenue%")
AND (phone LIKE "%6" OR phone LIKE "%4");

-- Get customers where address contains tail or avenue
SELECT * 
FROM customers
WHERE address REGEXP "trail|avenue";

-- Get customers where first_name contains elka or ambur and last_name ends with ey or on 
-- and last name starts with my or se and last_name contains b followed by u or r
SELECT * 
FROM customers
WHERE first_name REGEXP "elka|ambur"
AND (last_name LIKE "%ey" OR last_name LIKE "%on")
AND (last_name LIKE "my%" OR last_name LIKE "se%")
AND last_name REGEXP "br|bu";

-- Get customers who dont have phone
SELECT * 
FROM customers
WHERE phone IS NULL;

-- Get customers who have phone
SELECT * 
FROM customers
WHERE phone IS NOT NULL;

-- Get customers in alphabetical order
SELECT * 
FROM customers
ORDER BY first_name ASC, last_name DESC;

-- Get first 5 customers data
SELECT *
FROM customers
LIMIT 5;

-- Get customers data for page 3 each page contains 2 customer data
SELECT *
FROM customers
LIMIT 2 OFFSET 4;

-- Get the orders list with user details
SELECT order_id, C.customer_id, first_name, last_name, phone, address, order_date, status, shipped_date
FROM orders as O
JOIN customers AS C ON C.customer_id = O.customer_id;

-- Get the order list with user and order status details
SELECT order_id,order_date,O.customer_id,first_name,last_name,name
FROM orders O
JOIN customers C
ON C.customer_id = O.customer_id
JOIN order_statuses OS
ON OS.order_status_id = O.status;

-- Get payment list with user, payment and invoice details
SELECT P.payment_id,P.client_id,P.date,P.amount,PM.name as payment_method,C.name as customer_name,C.phone,C.address,P.invoice_id,invoice_date
FROM sql_invoicing.payments P
JOIN sql_invoicing.clients C
ON P.client_id = C.client_id
JOIN sql_invoicing.payment_methods PM
ON PM.payment_method_id = P.payment_id
JOIN sql_invoicing.invoices I
ON I.invoice_id = P.invoice_id;

-- Get all products that have been ordered by customer
SELECT P.product_id, P.name, O.quantity
FROM products P
LEFT JOIN order_items O
ON P.product_id = O.product_id;

-- Get all orders with user, shipper and order status details
SELECT order_date,O.order_id,first_name,O.shipper_id,OS.name AS status
FROM orders O
JOIN customers C
ON C.customer_id = O.customer_id  
LEFT JOIN shippers S
ON S.shipper_id = O.shipper_id
JOIN order_statuses OS
ON OS.order_status_id = O.status;

-- Get all payment details with client and payment method details
SELECT date,C.name AS client,amount,PM.name AS name
FROM payments P
JOIN payment_methods PM
ON PM.payment_method_id = P.payment_method
JOIN clients C
USING (client_id);

-- Get all customer and categorize based on the points the customer have
SELECT customer_id, first_name, points, "BRONZE" AS type
FROM customers
WHERE points < 2000
UNION
SELECT customer_id, first_name, points, "SILVER" AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id, first_name, points, "GOLD" AS type
FROM customers
WHERE points > 3000;

-- Add 50 points to customers birth date is less than 1990-01-01
UPDATE customers
SET points = points+50
WHERE birth_date > "1990-01-01";

-- Update order table comment where the customer has more than 3000 points
UPDATE orders
SET comments = "Loreum Ispum"
WHERE customer_id IN (
	SELECT customer_id 
    FROM customers
	WHERE points > 3000
);
