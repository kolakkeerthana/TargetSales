--- to check for the factors affecting Target sales


--- type of products sold(to being with the let's check if there are products which are sold repeatedly)
SELECT 
    p.product_category, 
    COUNT(*) AS total_items_sold
FROM 
    order_items oi
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    p.product_category
ORDER BY 
    total_items_sold DESC;
--- bed table bath category are sold the highest and insurance services being the least.



--- calculating the duration of the time taken to deliver items.  
SELECT 
    CAST (order_delivered_customer_date AS TIMESTAMP) - CAST( order_purchase_timestamp AS TIMESTAMP) AS delivery_duration,
	p.product_category
FROM 
    orders o
JOIN 
	order_items oi ON oi.order_id = o.order_id
JOIN 
	products p ON oi.product_id = p.product_id
ORDER BY
	delivery_duration, p.product_category;

	
--- check this brooo!!!(calculating the duration but considering the average if the product has been purchased more than once.)
SELECT 
    AVG(CAST (order_delivered_customer_date AS TIMESTAMP) - CAST( order_purchase_timestamp AS TIMESTAMP)) AS average_delivery_duration,
	p.product_category,
	count (*) as Number_of_items_sold
FROM 
    orders o
JOIN 
	order_items oi ON oi.order_id = o.order_id
JOIN 
	products p ON oi.product_id = p.product_id
GROUP BY
	p.product_category
ORDER BY
	Number_of_items_sold DESC;


--- Number of images each product_category has and the number of items sold. 
SELECT 
    product_category, 
    ROUND(AVG(product_photos_qty)) AS avg_photos_per_product,
	count(*) AS total_orders
FROM 
    products p
JOIN 
	order_items oi ON oi.product_id= p.product_id
GROUP BY 
    product_category
ORDER BY 
    total_orders DESC;


--- to check if there are any returning customers
SELECT 
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    orders AS o
GROUP BY 
    o.customer_id
HAVING 
    COUNT(DISTINCT o.order_id) > 1;



