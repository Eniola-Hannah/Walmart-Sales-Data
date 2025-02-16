ALTER TABLE walmartsalesdata
RENAME COLUMN `Invoice ID` TO InvoiceID;
ALTER TABLE walmartsalesdata
RENAME COLUMN `Customer type` TO CustomerType;
ALTER TABLE walmartsalesdata
RENAME COLUMN `Product line` TO Productline;
ALTER TABLE walmartsalesdata
RENAME COLUMN `Unit price` TO UnitPrice;
ALTER TABLE walmartsalesdata
RENAME COLUMN `Tax 5%` TO Tax;
ALTER TABLE walmartsalesdata
RENAME COLUMN cogs TO COGS;
ALTER TABLE walmartsalesdata
RENAME COLUMN `gross margin percentage` TO GrossMarginPercentage;
ALTER TABLE walmartsalesdata
RENAME COLUMN `gross income` TO GrossIncome;
ALTER TABLE walmartsalesdata
RENAME COLUMN Total TO Revenue;

SET SQL_SAFE_UPDATES = 0;

UPDATE walmartsalesdata
SET Date = STR_TO_DATE(Date, "%YYYY-%m-%d");
ALTER TABLE walmartsalesdata
MODIFY COLUMN Date DATE;
ALTER TABLE walmartsalesdata
MODIFY COLUMN Time TIME;

ALTER TABLE walmartsalesdata
ADD COLUMN Time_of_Day TEXT;
UPDATE walmartsalesdata
SET Time_of_Day = CASE WHEN Time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
				       WHEN Time BETWEEN "12:00:01" AND "16:00:00" THEN "Afternoon"
                       ELSE "Evening" END;


-- GENERIC QUESTION
-- 1.	How many unique cities does the data have?
SELECT COUNT(DISTINCT City) FROM walmartsalesdata;

-- 2.	In which city is each branch?
SELECT DISTINCT City, Branch FROM walmartsalesdata;



-- PRODUCT
-- 1.	How many unique product lines does the data have?
SELECT COUNT(DISTINCT Productline) FROM walmartsalesdata;

-- 2.	What is the most common payment method?
SELECT Payment, COUNT(Payment) AS commonPaymentMethod FROM walmartsalesdata
GROUP BY Payment ORDER BY Payment DESC LIMIT 1;

-- 3.	What is the most selling product line?
SELECT Productline, SUM(Quantity) AS quantitySold FROM walmartsalesdata
GROUP BY Productline ORDER BY mostSellingProduct DESC LIMIT 1;

-- 4.	What is the total revenue by month?
SELECT MONTH(Date) FROM walmartsalesdata;
SELECT MONTH(Date) AS Month_num, MONTHNAME(Date) AS Month_name, CONCAT("$", ROUND(SUM(Revenue), 2)) AS TotalRevenue FROM walmartsalesdata
GROUP BY Month_num, Month_name ORDER BY Month_num;

-- 5.	What month had the largest COGS?
-- COGS ~ Cost of goods sold
SELECT MONTHNAME(Date) AS Month, CONCAT( "$", ROUND(SUM(COGS), 2)) largest_CGOS FROM walmartsalesdata
GROUP BY Month ORDER BY largest_CGOS DESC LIMIT 1;

-- 6.	What product line had the largest revenue?
SELECT Productline, ROUND(SUM(Revenue), 2) AS productRevenue FROM walmartsalesdata
GROUP BY Productline ORDER BY productRevenue DESC LIMIT 1;

-- 7.	What is the city with the largest revenue?
SELECT City, ROUND(SUM(Revenue)) AS cityRevenue FROM walmartsalesdata
GROUP BY City ORDER BY cityRevenue DESC LIMIT 1;

-- 8.	What product line had the largest VAT?
-- VAT ~ Value added Tax
SELECT Productline, CONCAT("$", ROUND(SUM(Tax))) AS largestVAT FROM walmartsalesdata
GROUP BY Productline ORDER BY largestVAT DESC LIMIT 1;

-- 9.	Fetch each product line and add a column to those product line showing "Good", "Bad". Good if "its" greater than average sales
SELECT Productline, IF(AVG(COGS) > 307.587380, "Good", "Bad") AS newColumn FROM walmartsalesdata
GROUP BY Productline;

-- 10.	Which branch sold more products than average product sold?   |   More product == Much quantity

-- What each branch sold on an average 
SELECT Branch, AVG(Quantity) AS avg_quantity FROM walmartsalesdata
GROUP BY Branch;
-- The entire overall average sales
SELECT AVG(Quantity) AS avg_quantity FROM walmartsalesdata;
-- Now combinig the two query to get the branch that sold more products than average product sold
SELECT Branch, AVG(COGS) AS avg_quantity FROM walmartsalesdata
GROUP BY Branch
HAVING avg_quantity > 5.5100;

-- 11.	What is the most common product line by gender?
SELECT Gender, Productline, COUNT(Productline) AS mostcommon_gender FROM walmartsalesdata
GROUP BY Gender, Productline
ORDER BY mostcommon_gender DESC LIMIT 1;

-- 12.	What is the average rating of each product line?
SELECT Productline, ROUND(AVG(Rating), 2) AS averageRating FROM walmartsalesdata
GROUP BY Productline;



-- SALES
-- 1.	Number of sales made in each time of the day per weekday
SELECT MIN(Time), Max(Time) FROM walmartsalesdata;

SELECT Time_of_Day, COUNT(Quantity) AS sales_made FROM walmartsalesdata
WHERE DAYNAME(Date) NOT IN ("Saturday", "Sunday")
GROUP BY Time_of_Day ORDER BY sales_made DESC;
                
-- 2.	Which of the customer types brings the most revenue?
SELECT CustomerType, SUM(COGS) AS mostRevenue FROM walmartsalesdata
GROUP BY CustomerType ORDER BY mostRevenue DESC LIMIT 1;

-- 3.	Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT City, ROUND(SUM(Tax), 2) AS largest_tax FROM walmartsalesdata
GROUP BY City ORDER BY largest_tax DESC LIMIT 1;

-- 4.	Which customer type pays the most in VAT?
SELECT CustomerType, ROUND(SUM(Tax), 2) AS the_most_VAT FROM walmartsalesdata
GROUP BY CustomerType ORDER BY the_most_VAT DESC LIMIT 1;



-- CUSTOMER
-- 1.	How many unique customer types does the data have?
SELECT COUNT(DISTINCT CustomerType) FROM walmartsalesdata;

-- 2.	How many unique payment methods does the data have?
SELECT COUNT(DISTINCT Payment) FROM walmartsalesdata;

-- 3.	What is the most common customer type?
SELECT CustomerType, COUNT(CustomerType) AS most_common_customertype FROM walmartsalesdata
GROUP BY CustomerType ORDER BY most_common_customertype DESC LIMIT 1;

-- 4.	Which customer type buys the most?
SELECT CustomerType, ROUND(SUM(Quantity), 2) AS the_most_sales FROM walmartsalesdata
GROUP BY CustomerType ORDER BY the_most_sales DESC LIMIT 1;

-- 5.	What is the gender of most of the customers?
SELECT Gender, COUNT(Gender) AS most_common_customers FROM walmartsalesdata
GROUP BY Gender ORDER BY most_common_customers DESC LIMIT 1;

-- 6.	What is the gender distribution per branch?
SELECT Branch, Gender, COUNT(Gender) FROM walmartsalesdata
GROUP BY Branch, Gender ORDER BY Branch;

-- 7.	Which time of the day do customers give most ratings?
SELECT Time_of_Day, ROUND(AVG(Rating), 2) AS no_of_rating from walmartsalesdata
GROUP BY Time_of_Day ORDER BY no_of_rating DESC LIMIT 1;

-- 8.	Which time of the day do customers give most ratings per branch?
SELECT Branch, Time_of_Day, ROUND(AVG(Rating), 2) AS no_of_rating from walmartsalesdata
GROUP BY Branch, Time_of_Day ORDER BY no_of_rating DESC LIMIT 1;

-- 9. Which day of the week has the best avg ratings?
SELECT DAYNAME(Date) AS week_day, ROUND(AVG(rating), 2) best_avg_rating FROM walmartsalesdata
GROUP BY week_day ORDER BY best_avg_rating DESC LIMIT 1;

-- 10.	Which day of the week has the best average ratings per branch?
SELECT Branch, DAYNAME(Date) AS week_day, ROUND(AVG(rating), 2) best_avg_rating FROM walmartsalesdata
GROUP BY Branch, week_day ORDER BY best_avg_rating DESC LIMIT 1;


SELECT * FROM walmartsalesdata;