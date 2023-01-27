-- Pizza_Metrics

--1. How many pizzas were ordered?

SELECT COUNT(*) as Total_Orders
FROM customer_orders

/*
Steps:
Using the COUNT function to find total orders.

Answer:
	Total_Orders
		14
*/

--2.How many unique customer orders were made?

SELECT COUNT(Distinct order_id)as unique_orders
FROM customer_orders

/*
Steps:
Used the COUNT, DISTINCT and GROUP BY functions to find unique orders by Customer.

Answer:
unique_orders
	10
*/

-- 3.How many successful orders were delivered by each runner?

SELECT 
	runner_id,
	COUNT(order_id)as successful_orders  
FROM runner_orders
WHERE cancellation =' '
GROUP BY runner_id

/*
Steps:
Used the COUNT ,WHERE and GROUP BY functions to find successfull orders by runners.

Answer:
runner_id	successfull_orders
	1			4
	2			3
	3			1
*/

-- 4.How many of each type of pizza was delivered?

SELECT pizza_name as type_of_pizza, COUNT(order_id) as Number_of_Orders
FROM customer_orders c
JOIN pizza_names p
ON c.pizza_id = p.pizza_id
GROUP BY pizza_name 

/*
Steps:
Used the COUNT and GROUP BY functions to find number of orders for each type of pizza.
Use JOIN to merge customer_orders and pizza_names tables as pizza id from both tables.

Answer:
type_of_pizza	Number_of_Orders
	Meatlovers		10
	Vegetarian		4
*/

-- 5.How many Vegetarian and Meatlovers were ordered by each customer?

Select customer_id, COUNT(1) as Total_orders,pizza_name as type_of_pizza
FROM customer_orders
JOIN pizza_names 
ON customer_orders.pizza_id = pizza_names.pizza_id
GROUP BY customer_id,pizza_name
ORDER BY customer_id

/*
Steps:
Used the COUNT, GROUP BY,ORDER BY functions to find number of orders for each type of pizza by each customer.
Joined the table customer_orders and pizza_names as pizza id from both tables.

Answer:
customer_id		Total_orders	type_of_pizza
	101				2			Meatlovers
	101				1			Vegetarian
	102				2			Meatlovers
	102				1			Vegetarian
	103				3			Meatlovers
	103				1			Vegetarian
	104				3			Meatlovers
	105				1			Vegetarian
*/

-- 6.What was the maximum number of pizzas delivered in a single order?

SELECT Top 1 count(customer_id) as no_of_pizzas
FROM customer_orders
GROUP BY order_id
ORDER BY count(customer_id) DESC

/*
Steps: 
Used Count,GROUP BY and ORDER BY to get maximum no of pizzas  delivered in a single order.

Answer:

no_of_pizzas
	3
*/

-- 7.For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT 
	c.customer_id,
	SUM(
	CASE WHEN c.exclusions != '' OR c.extras != '' THEN 1
	ELSE 0
	END) AS at_least_1_change,
	SUM(
	CASE WHEN c.exclusions = '' OR c.extras = '' THEN 1
	ELSE 0
	END) AS no_change
FROM customer_orders c
JOIN runner_orders r
ON c.order_id = r.order_id
WHERE r.distance != ''
GROUP BY c.customer_id

/*
Steps:
 Joined Customer_orders and runer_orders on order id.
 Used case when to count pizzas with at least 1 change and no change

 Answer:
 customer_id	at_least_1_change	no_change
	101				0					2
	102				0					3
	103				3					3
	104				2					2	
	105				1					1
*/

-- 8.How many pizzas were delivered that had both exclusions and extras?
SELECT 
	SUM(
	CASE
		WHEN c.exclusions != '' AND c.extras != '' THEN 1
		ELSE 0 
	END) AS pizza_count_w_exclusions_extras
FROM customer_orders c
JOIN runner_orders r
ON c.order_id = r.order_id
WHERE r.distance != ''

/*
Steps :
	Joined Customer_orders and runer_orders on order id.
	Used case when to count pizzas that had both exclusions and extras.

Answer:
	pizza_count_w_exclusions_extras
				1
*/

-- 9. What was the total volume of pizzas ordered for each hour of the day?

SELECT 
	DATEPART(HOUR,order_time) AS hour_of_day,
	Count(order_id) AS pizza_count
FROM customer_orders
GROUP BY DATEPART(HOUR,order_time)

/*
Steps:
Used datepart function to get hour of day and count for total count.

Answer:

hour_of_day	pizza_count
	11			1
	13			3
	18			3
	19			1
	21			3
	23			3
*/

--10. What was the volume of orders for each day of the week?

SELECT DATENAME(WEEKDAY,order_time) as Day_of_week,
		COUNT(Order_id) as total_pizza_ordered
FROM customer_orders
GROUP BY DATENAME(WEEKDAY,order_time)

/*
Steps:
Used datename to get day of week and count and group by to get total_pizza_ordered by day.

Answer:
Day_of_week	total_pizza_oredered
	Friday			1
	Saturday		5
	Thursday		3
	Wednesday		5
*/