# Walmart Sales Data Analysis with SQL 

![walmart1](https://github.com/user-attachments/assets/d961b0f2-3b30-47ba-8637-46259f276513)

## Table Of Contents
- [Introduction](#Introduction)
- [Project Overview](#Project-Overview)
- [Project Objective](#Project-Objective)
- [Data Cleaning](#Data-Cleaning)
- [Data Exploration and Insights Derived](#Exploration-&-Insights-Derived)
- [Recommendation](#Recommendation)
- [Repository Contents](#Repository-Contents)
- [Conclusion](#Conclusion)

  
## Introduction
- This project involves analyzing Walmart sales data to gain insights into product performance, customer behavior, and sales trends. 
Using SQL, the dataset was queried to answer specific business questions, enhancing data-driven decision-making

## Project-Overview
The dataset provides comprehensive sales information, including details on products, customer types, payment methods, and sales across different branches and cities.

Number of Rows & Columns Before Cleaning:
- Rows: 1,000
- Columns: 17

Columns Included:
1. Invoice ID: Unique identifier for each transaction.
2. Branch: Store branch where the sale was made.
3. City: City where the branch is located.
4. Customer type: Type of customer (e.g., Member, Normal).
5. Gender: Gender of the customer.
6. Product line: Product category of the item sold.
7. Unit price: Price per unit of the product.
8. Quantity: Number of units sold.
9. Tax 5%: 5% VAT on the transaction.
10. Total: Revenue generated (including VAT).
11. Date: Date of the transaction.
12. Time: Time of purchase.
13. Payment: Payment method used (e.g., Cash, Credit Card).
14. cogs: Cost of Goods Sold. 
15. gross margin percentage: the percentage of revenue remaining after a branch subtracts its cogs
16. gross income: the total income from all sources, before taxes and other deductions are subtracted
17. Rating: Customer's rating for a particular walmart branch.

<img width="939" alt="walmart" src="https://github.com/user-attachments/assets/fa9abb58-5c01-47b1-9346-2c89f19efa11" />

## Project-Objective
- Problem Statement
Walmart aims to understand customer buying behavior, product performance, and sales trends to optimize inventory, enhance marketing strategies, and improve customer satisfaction. 

- Generic Question
1.	How many unique cities does the data have?
2.	In which city is each branch?
- Product
1.	How many unique product lines does the data have?
2.	What is the most common payment method?
3.	What is the most selling product line?
4.	What is the total revenue by month?
5.	What month had the largest COGS?
6.	What product line had the largest revenue?
7.	What is the city with the largest revenue?
8.	What product line had the largest VAT?
9.	Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
10.	Which branch sold more products than average product sold?
11.	What is the most common product line by gender?
12.	What is the average rating of each product line?
- Sales
1.	Number of sales made in each time of the day per weekday
2.	Which of the customer types brings the most revenue?
3.	Which city has the largest tax percent/ VAT (Value Added Tax)?
4.	Which customer type pays the most in VAT?
- Customer
1.	How many unique customer types does the data have?
2.	How many unique payment methods does the data have?
3.	What is the most common customer type?
4.	Which customer type buys the most?
5.	What is the gender of most of the customers?
6.	What is the gender distribution per branch?
7.	Which time of the day do customers give most ratings?
8.	Which time of the day do customers give most ratings per branch?
9.	Which day of the week has the best avg ratings?
10.	Which day of the week has the best average ratings per branch?

## Data-Cleaning
- Renamed some Columns name for easy access and reference
```sql
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
```
- Modified the date field to the standardized "%YYYY-%m-%d" format and Time field to TIME Datatype
```sql
SET SQL_SAFE_UPDATES = 0;

UPDATE walmartsalesdata
SET Date = STR_TO_DATE(Date, "%YYYY-%m-%d");
ALTER TABLE walmartsalesdata
MODIFY COLUMN Date DATE;

ALTER TABLE walmartsalesdata
MODIFY COLUMN Time TIME;
```
- Added and populated a new Column called Time_of_Day for later reference in the analysis
```sql
ALTER TABLE walmartsalesdata
ADD COLUMN Time_of_Day TEXT;

UPDATE walmartsalesdata
SET Time_of_Day = CASE WHEN Time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
				       WHEN Time BETWEEN "12:00:01" AND "16:00:00" THEN "Afternoon"
                       ELSE "Evening" END;
```

## Exploration-&-Insights-Derived
1. Unique Cities and Branch Locations: 3 unique cities with branches in each.
2. Product Lines Analysis: 6 unique product lines with Electronics as the most selling.
- Fashion is the most common product line among female customers while
- Electronics is popular among males.
3. Payment Methods: Ewallet is the most preferred payment method.
4. Revenue Analysis:
- Highest revenue recorded in January.
- Largest COGS occurred in February.
5. Food and beverages contributed the most to total revenue and VAT.
6. City-Wise Revenue: Naypyitaw has the largest revenue contribution.
7. Branch Sales Comparison: Branch C sold more products than the average product sales across all branches.
8. Sales Distribution by Time and Day: Peak sales during late evenings.
9. Customer Ratings and Feedback:
- Highest average rating for Fashion products.
- Positive feedback is most common in the afternoon. 
10. Customer Type Analysis:
- Member customers bring in the most revenue.
11. Demographics and Customer Behavior: Majority of customers are female.
12 Gender distribution varies by branch, with Branch A having a higher percentage of male customers.
13. Customer Feedback Trends:
- Most ratings are given in the afternoon.
- Mondays has the best average ratings overall.

## Recommendation
- Inventory Optimization: Stock more Electronics and Fashion products to meet high demand.
- Targeted Marketing: Target male customers for Electronics and female customers for Fashion.
- Customer Retention Strategies: Provide personalized offers to Normal customers to boost VAT contributions.
- Feedback Collection: Collect feedback actively in the afternoon for more engagement.

## Repository-Contents
- WalmartSalesData.csv: Contains the raw sales data used for analysis.
- WalmartSalesData.sql: Contains the SQL queries used for data cleaning, analysis, and insight extraction.
- Business Questions To Answer.docx: Document outlining the business questions guiding the analysis.
  
## Conclusion
This analysis provides valuable insights into Walmart's sales performance, customer preferences, and product trends. These insights can be leveraged to enhance inventory management, marketing strategies, and customer engagement.
