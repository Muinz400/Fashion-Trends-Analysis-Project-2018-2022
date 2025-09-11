-- CREATE products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(100),
    pattern VARCHAR(100),
    color VARCHAR(100),
    material VARCHAR(100)
);

SELECT * FROM products


-- CREATE brand Table
CREATE TABLE brands (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(100)
);

SELECT * FROM brands


-- CREATE sales Table
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    brand_id INT REFERENCES brands(brand_id),
    season VARCHAR(50),
    price NUMERIC(10,2),
    discount NUMERIC(5,2),
    sales_count INT,
    reviews_count INT,
    average_rating NUMERIC(3,2),
    last_stock_date DATE,
    wish_list_count INT,
    year_of_sale INT
);

SELECT * FROM sales


-- Optional staging table to load raw CSV data
CREATE TABLE staging_fashion (
    product_id INT,
    product_name VARCHAR(255),
    gender VARCHAR(50),
    category VARCHAR(100),
    pattern VARCHAR(100),
    color VARCHAR(100),
    age_group VARCHAR(50),
    season VARCHAR(50),
    price NUMERIC(10,2),
    material VARCHAR(100),
    sales_count INT,
    reviews_count INT,
    average_rating NUMERIC(3,2),
    out_of_stock_times INT,
    brand VARCHAR(100),
    discount NUMERIC(5,2),
    last_stock_date DATE,
    wish_list_count INT,
    month_of_sale INT,
    year_of_sale INT
);

-- Insert unique brand names into the brands table.
-- Each brand gets a generated brand_id (SERIAL).
INSERT INTO brands (brand_name)
SELECT DISTINCT brand
FROM staging_fashion
WHERE brand IS NOT NULL;


-- Insert unique products into the products table.
-- Products are identified by product_id and include descriptive attributes.
INSERT INTO products (product_id, product_name, category, pattern, color, material)
SELECT DISTINCT product_id, product_name, category, pattern, color, material
FROM staging_fashion
WHERE product_id IS NOT NULL;



-- Insert sales transactions into the sales table.
-- Links product_id to products and brand_id to brands.
-- Contains metrics like sales_count, discount, reviews, etc.
INSERT INTO sales (
    product_id,
    brand_id,
    season,
    price,
    discount,
    sales_count,
    reviews_count,
    average_rating,
    last_stock_date,
    wish_list_count,
    year_of_sale
)
SELECT 
    s.product_id,
    b.brand_id,
    s.season,
    s.price,
    s.discount,
    s.sales_count,
    s.reviews_count,
    s.average_rating,
    s.last_stock_date,
    s.wish_list_count,
    s.year_of_sale
FROM staging_fashion s
JOIN brands b ON s.brand = b.brand_name;


SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.pattern,
    p.color,
    p.material,
    s.season,
    s.year_of_sale,
    s.sales_count,
    s.price,
    s.discount,
    s.reviews_count,
    s.average_rating,
    s.wish_list_count,
    s.last_stock_date,
    b.brand_name
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN brands b ON s.brand_id = b.brand_id;



/* 1. Seasonal Fashion Trends
Which product categories dominate in each 
season (Spring, Summer, Fall, Winter)?
Do customer preferences shift depending on the season?
*/

SELECT category,
       season,
       SUM(sales.sales_count) AS total_sales
FROM products
JOIN sales
ON products.product_id = sales.product_id
GROUP BY 1, 2
ORDER BY total_sales DESC;


/*
2. Product category Performance Analysis
Question: Which category products have the highest total sales and best average ratings?
Tests: JOIN on products + sales, SUM, AVG.
Extension: Use a CTE to filter top 3 brands per year.
*/

SELECT category,
       SUM(sales_count) AS total_sales,
       AVG(average_rating) AS ratings 
FROM products
JOIN sales
ON products.product_id = sales.product_id
GROUP BY category
ORDER BY total_sales DESC, ratings DESC;



/*
3. Do Discounts Actually Boost Sales?

Question: Is there a correlation between higher discounts and higher sales counts?
Tests: CASE WHEN to create discount buckets, AVG() sales by bucket.
Extension: Use a subquery to isolate only discounted vs. non-discounted products.
*/

SELECT 
    AVG(sales_count),
    discount_bucket
FROM(
SELECT CASE 
   WHEN discount BETWEEN 0.01 AND 0.09 THEN 'low discount'
   WHEN discount BETWEEN 0.10 AND 0.20 THEN 'high discount'
   ELSE 'no discount'
END AS discount_bucket,
    sales_count
FROM sales) AS average_discount
GROUP BY discount_bucket
ORDER BY discount_bucket DESC; 




/*
4. Optimal Product Mix (High Sales + High Ratings)
Question: Which products balance both high sales and high customer ratings?
Tests: Multi-criteria filtering, subqueries to isolate products above both thresholds.
Extension: Rank products by a combined “popularity score” (e.g., weighted sales + rating).
*/

SELECT product_name,
       SUM(sales_count),
       AVG(average_rating)
FROM products
JOIN sales
ON products.product_id = sales.product_id 
GROUP BY product_name
HAVING SUM(sales_count) > 400
AND AVG(average_rating) > 4.0
ORDER BY SUM(sales_count) DESC




/*
5. Year-over-Year Trend Analysis
Question: How have total sales changed year-over-year, 
and which categories grew the most?
Tests: GROUP BY year_of_sale, CTE to calculate YoY % 
change, maybe a LAG() window function.
*/

WITH category_sales AS (    
    SELECT category,
       year_of_sale,
       SUM(sales_count) AS total_sales
FROM sales
JOIN products
ON sales.product_id = products.product_id
GROUP BY 1, 2
ORDER BY 2 ASC)

SELECT
    category,
    year_of_sale,
    total_sales,
    LAG(total_sales) OVER (PARTITION BY category ORDER BY year_of_sale) AS prev_year_sales
FROM category_sales;
