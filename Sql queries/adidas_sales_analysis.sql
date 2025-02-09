CREATE DATABASE adidas_sales_db;
USE adidas_sales_db;

-- Rename table for easier reference
RENAME TABLE `adidas us sales datasets` TO adidas;

-- Check data
SELECT * FROM adidas;
SHOW COLUMNS FROM adidas;

-- Convert Invoice Date to DATE format
UPDATE adidas
SET `Invoice Date` = STR_TO_DATE(`Invoice Date`, '%m/%d/%Y');
ALTER TABLE adidas
MODIFY `Invoice Date` DATE;

-- Convert Price per Unit to INT and remove '$'
UPDATE adidas 
SET `Price per Unit` = REPLACE(`Price per Unit`, '$', '');
ALTER TABLE adidas
MODIFY `Price per Unit` INT;

-- Convert Units Sold to INT and remove ','
UPDATE adidas 
SET `Units Sold` = REPLACE(`Units Sold`, ',', '');
DELETE FROM adidas WHERE `Units Sold` = 0;
ALTER TABLE adidas
MODIFY `Units Sold` INT;

-- Convert Total Sales to INT and remove '$' and ','
UPDATE adidas 
SET `Total Sales` = REPLACE(REPLACE(`Total Sales`, '$', ''), ',', '');
ALTER TABLE adidas
MODIFY `Total Sales` INT;

-- Convert Operating Profit to INT and remove '$' and ','
UPDATE adidas 
SET `Operating Profit` = REPLACE(REPLACE(`Operating Profit`, '$', ''), ',', '');
ALTER TABLE adidas
MODIFY `Operating Profit` INT;

-- Convert Operating Margin to INT and remove '%'
UPDATE adidas 
SET `Operating Margin` = REPLACE(`Operating Margin`, '%', '');
ALTER TABLE adidas
MODIFY `Operating Margin` INT;

-- Check for missing values
SELECT COUNT(*) FROM adidas;
SELECT * FROM adidas WHERE `Retailer` IS NULL;
SELECT * FROM adidas WHERE `Retailer ID` IS NULL OR `Retailer ID` = 0;
SELECT * FROM adidas WHERE `Invoice Date` IS NULL;
SELECT * FROM adidas WHERE `Region` IS NULL;
SELECT * FROM adidas WHERE `State` IS NULL;
SELECT * FROM adidas WHERE `City` IS NULL;

-- Check for duplicates
SELECT `Invoice Date`, `Retailer ID`, `Product`, `Region`, `State`, `City`, `Units Sold`, `Price per Unit`, COUNT(*)
FROM adidas 
GROUP BY `Invoice Date`, `Retailer ID`, `Product`, `Region`, `State`, `City`, `Units Sold`, `Price per Unit`
HAVING COUNT(*) > 1;

-- Adding Category column
ALTER TABLE adidas ADD COLUMN category VARCHAR(255) AFTER city;
UPDATE adidas SET category = `Product`;
UPDATE adidas SET category = 
CASE
    WHEN category LIKE "%Footwear%" THEN "footwear"
    WHEN category LIKE "%Apparel%" THEN "apparel"
    ELSE "other"
END;

-- Adding Gender column
ALTER TABLE adidas ADD COLUMN gender VARCHAR(255) AFTER `Product`;
UPDATE adidas SET gender = 
CASE
    WHEN `Product` LIKE "Men%" THEN "male"
    WHEN `Product` LIKE "Women%" THEN "female"
    ELSE "other"
END;

-- Adding Month column
ALTER TABLE adidas ADD COLUMN `month` VARCHAR(255) AFTER `Invoice Date`;
UPDATE adidas SET `month` = MONTHNAME(`Invoice Date`);

-- Sales Performance Insights
-- 1. Total Revenue Generated
SELECT SUM(`Total Sales`) AS `Total Sales` FROM adidas;

-- 2. Top 5 States and Cities by Total Sales
SELECT state, city, SUM(`Total Sales`) AS total_sales
FROM adidas 
GROUP BY state, city
ORDER BY total_sales DESC LIMIT 5;

-- 3. Revenue by Product Category
SELECT category, SUM(`Total Sales`) AS total_sales
FROM adidas 
GROUP BY category 
ORDER BY total_sales DESC;

-- 4. Highest Units Sold by Category
SELECT category, SUM(`Units Sold`) AS total_units_sold
FROM adidas 
GROUP BY category
ORDER BY total_units_sold DESC;

-- 5. Highest Operating Profit by Category
SELECT category, SUM(`Operating Profit`) AS total_operating_profit
FROM adidas 
GROUP BY category
ORDER BY total_operating_profit DESC;

-- Gender-Based Sales Insights
-- 6. Total Sales by Gender
SELECT gender, SUM(`Total Sales`) AS total_sales
FROM adidas
GROUP BY gender
ORDER BY total_sales DESC;

-- 7. Most Profitable Gender-Based Category
SELECT gender, SUM(`Operating Profit`) AS total_profit
FROM adidas
GROUP BY gender
ORDER BY total_profit DESC;

-- 8. Best-Selling Product for Each Gender
SELECT gender, `Product`, `Total Sales`
FROM (
    SELECT gender, `Product`, SUM(`Total Sales`) AS `Total Sales`,
           RANK() OVER(PARTITION BY gender ORDER BY SUM(`Total Sales`) DESC) AS rnk 
    FROM adidas
    GROUP BY gender, `Product`
) ranked_product
WHERE rnk = 1;

-- Time-Based Sales Insights
-- 15. Monthly Sales Trend
SELECT `month`, SUM(`Total Sales`) AS total_sales
FROM adidas
GROUP BY `month`
ORDER BY total_sales DESC LIMIT 1;

-- 16. Best and Worst Revenue Quarters
SELECT QUARTER(`Invoice Date`) AS quarter, SUM(`Total Sales`) AS total_sales
FROM adidas
GROUP BY quarter
ORDER BY total_sales DESC LIMIT 1;

SELECT QUARTER(`Invoice Date`) AS quarter, SUM(`Total Sales`) AS total_sales
FROM adidas
GROUP BY quarter
ORDER BY total_sales ASC LIMIT 1;

-- Sales Method Analysis
-- 17. Revenue by Sales Method
SELECT `Sales Method`, SUM(`Total Sales`) AS total_sales
FROM adidas
GROUP BY `Sales Method`
ORDER BY total_sales DESC;

-- 18. Most Profitable Sales Method
SELECT `Sales Method`, SUM(`Operating Profit`) AS total_profit
FROM adidas
GROUP BY `Sales Method`
ORDER BY total_profit DESC LIMIT 1;

-- 19. Top Retailer by Sales
SELECT retailer, SUM(`Total Sales`) AS total_sales
FROM adidas
GROUP BY retailer
ORDER BY total_sales DESC LIMIT 1;

-- 20. Top Retailer by Units Sold
SELECT retailer, SUM(`Units Sold`) AS total_units_sold
FROM adidas
GROUP BY retailer
ORDER BY total_units_sold DESC LIMIT 1;

-- 21. Highest Operating Profit by Retailer
SELECT retailer, SUM(`Operating Profit`) AS total_profit
FROM adidas
GROUP BY retailer
ORDER BY total_profit DESC LIMIT 1;

-- 22. Best Average Operating Margin by Retailer
SELECT retailer, AVG(`Operating Margin`) AS avg_margin
FROM adidas
GROUP BY retailer
ORDER BY avg_margin DESC LIMIT 1;

-- 23. Top 5 Retailers by Total Sales
SELECT retailer, SUM(`Total Sales`) AS total_sales
FROM adidas
GROUP BY retailer
ORDER BY total_sales DESC LIMIT 5;

-- 24. Top 5 Retailers by Units Sold
SELECT retailer, SUM(`Units Sold`) AS total_units_sold
FROM adidas
GROUP BY retailer
ORDER BY total_units_sold DESC LIMIT 5;

-- 25. Retailer Performance by Category
SELECT retailer, category, SUM(`Total Sales`) AS total_sales
FROM adidas
GROUP BY retailer, category
ORDER BY retailer, total_sales DESC;

-- Units Sold Insights  
-- 26. What is the total number of units sold overall?  
SELECT SUM(`Units Sold`) AS Total_Units_Sold  
FROM adidas;  

-- 27. Which product has the highest total units sold?  
SELECT `Product`, SUM(`Units Sold`) AS Total_Units_Sold  
FROM adidas  
GROUP BY `Product`  
ORDER BY Total_Units_Sold DESC  
LIMIT 1;  

-- 28. Which product category (footwear vs. apparel) has the highest units sold?  
SELECT `Category`, SUM(`Units Sold`) AS Total_Units_Sold  
FROM adidas  
GROUP BY `Category`  
ORDER BY Total_Units_Sold DESC;  

-- 29. Which state has the highest number of units sold?  
SELECT `State`, SUM(`Units Sold`) AS Total_Units_Sold  
FROM adidas  
GROUP BY `State`  
ORDER BY Total_Units_Sold DESC  
LIMIT 1;  

-- 30. Which retailer has the highest average units sold per order?  
SELECT `Retailer`, AVG(`Units Sold`) AS Avg_Units_Sold  
FROM adidas  
GROUP BY `Retailer`  
ORDER BY Avg_Units_Sold DESC  
LIMIT 1;  

-- 31. Trend of total units sold per month  
SELECT `Month`, SUM(`Units Sold`) AS Total_Units_Sold  
FROM adidas  
GROUP BY `Month`  
ORDER BY `Month`;  

-- 32. Which month had the highest number of units sold?  
SELECT `Month`, SUM(`Units Sold`) AS Total_Units_Sold  
FROM adidas  
GROUP BY `Month`  
ORDER BY Total_Units_Sold DESC  
LIMIT 1;  

-- Sales & Profit Analysis  
-- 1. Find the Top 5 Best-Selling Products by Revenue  
SELECT `Product`, SUM(`Total Sales`) AS Total_Revenue  
FROM adidas  
GROUP BY `Product`  
ORDER BY Total_Revenue DESC  
LIMIT 5;  

-- 2. Find the Least Profitable Products  
SELECT `Product`, SUM(`Operating Profit`) AS Total_Profit  
FROM adidas  
GROUP BY `Product`  
ORDER BY Total_Profit ASC  
LIMIT 5;  

-- 3. Monthly Sales Performance  
SELECT `Month`, SUM(`Total Sales`) AS Total_Revenue  
FROM adidas  
GROUP BY `Month`  
ORDER BY `Month`;  

-- Regional Performance Analysis  
-- 4. Top 5 Cities with Highest Sales  
SELECT `City`, SUM(`Total Sales`) AS Total_Revenue  
FROM adidas  
GROUP BY `City`  
ORDER BY Total_Revenue DESC  
LIMIT 5;  

-- Inventory & Product Demand  
-- 5. Find Products with Highest Units Sold  
SELECT `Product`, SUM(`Units Sold`) AS Total_Units  
FROM adidas  
GROUP BY `Product`  
ORDER BY Total_Units DESC  
LIMIT 5;  

-- 6. Compare Sales Method Performance  
SELECT `Sales Method`, SUM(`Total Sales`) AS Total_Revenue  
FROM adidas  
GROUP BY `Sales Method`;  
