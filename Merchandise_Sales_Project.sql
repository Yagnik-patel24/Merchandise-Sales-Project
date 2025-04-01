--------------  Merchandise-Sales-Project---------------By-------------------------Yagnik Patel----------------------------------------------
-- 1. What are the overall sales performance metrics for the merchandise store?
SELECT 
     COUNT(DISTINCT Order_ID) AS Total_Order,
     SUM(Quantity) AS Total_Units_Sold,
	 SUM(Total_Sales) AS Total_Revenue,
     ROUND(AVG(Rating),2) AS Average_Rating,
     ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales;

-- 2. What are the total revenue, total units sold, percentage contribution to overall revenue, average customer rating, and average sales per order for each product category, ranked by revenue?
SELECT 
	Product_Category, 
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
	SUM(Total_Sales) AS Total_Revenue,
	ROUND(SUM(Total_Sales)*100 / (SELECT SUM(Total_Sales) FROM merch_sales),2) AS Percentage_Total_Revenue,
    ROUND(AVG(Rating),2) AS Average_Rating,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_Category
ORDER BY Total_Revenue DESC;

-- 3. What are the total revenue, total units sold, percentage contribution to total revenue, average customer rating, and average sales per order for each product, ranked by revenue?
SELECT 
	Product_ID, 
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Total_Sales) AS Total_Revenue,
    ROUND(SUM(Total_Sales)*100 / (SELECT SUM(Total_Sales) FROM merch_sales),2) AS Percentage_Total_Revenue,
    ROUND(AVG(Rating),2) AS Average_Rating,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_ID
ORDER BY Total_Revenue DESC;

-- 4. What are the total revenue, total units sold, percentage contribution to overall sales, average customer rating, and average sales per order for each order location, ranked by revenue?
SELECT 
	Order_Location, 
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Total_Sales) AS Total_Revenue,
    ROUND(SUM(Total_Sales)*100 / (SELECT SUM(Total_Sales) FROM merch_sales),2) AS Percentage_Total_Revenue,
    ROUND(AVG(Rating),2) AS Average_Rating,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Order_Location
ORDER BY Total_Revenue DESC;

-- 5. How do sales, revenue, percentage contribution, customer ratings, and average sales per order compare between male and female buyers?
SELECT 
	Buyer_Gender, 
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Total_Sales) AS Total_Revenue,
    ROUND(SUM(Total_Sales)*100 / (SELECT SUM(Total_Sales) FROM merch_sales),2) AS Percentage_Total_Revenue,
    ROUND(AVG(Rating),2) AS Average_Rating,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Buyer_Gender
ORDER BY Total_Revenue DESC;

-- 6. How do sales, revenue, percentage contribution, customer ratings, and average sales per order compare between domestic and international shipping orders?
SELECT 
	International_Shipping, 
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Total_Sales) AS Total_Revenue,
    ROUND(SUM(Total_Sales)*100 / (SELECT SUM(Total_Sales) FROM merch_sales),2) AS Percentage_Total_Revenue,
    ROUND(AVG(Rating),2) AS Average_Rating,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY International_Shipping
ORDER BY Total_Revenue DESC;

-- 7. How do sales, order distribution, revenue, and customer ratings compare between free and paid shipping orders?
SELECT CASE 
           WHEN Shipping_Charges = 0 THEN 'Free Shipping'
           ELSE 'Paid Shipping'
       END AS Shipping_Type,
       COUNT(DISTINCT Order_ID) AS Total_Order,
       SUM(Quantity) AS Total_Units_Sold,
       ROUND(SUM(Quantity) * 100.0 / (SELECT SUM(Quantity) FROM merch_sales),2) AS Percentage_Of_Orders,
       SUM(Total_Sales) AS Total_Sales,
	   ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order,
       ROUND(AVG(Rating),2) AS Average_Rating
FROM merch_sales
GROUP BY Shipping_Type
ORDER BY Percentage_Of_Orders DESC;

-- 8. What is the Monthly sales trend for each product in terms of total units sold, revenue, and average sales per order?"
SELECT 
	Product_ID, 
	DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month, 
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
	SUM(Total_Sales) AS Monthly_Revenue,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_ID, Order_Month
ORDER BY Order_Month,Monthly_Revenue;

-- 9. What is the Quaterly sales trend for each product in terms of total units sold, revenue, and average sales per order?
SELECT 
	Product_ID, 
    YEAR(Order_Date) AS Order_Year,
	QUARTER(Order_Date) AS Order_Quarter, 
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
	SUM(Total_Sales) AS Quarterly_Revenue,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_ID ,Order_Year,Order_Quarter
ORDER BY Order_Year,Order_Quarter,Quarterly_Revenue DESC;

-- 10. What is the Yearly sales trend for each product in terms of total units sold, revenue, and average sales per order? 
SELECT 
	Product_ID, 
    YEAR(Order_Date) AS Order_Year,
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
	SUM(Total_Sales) AS Quarterly_Revenue,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_ID ,Order_Year
ORDER BY Order_Year,Quarterly_Revenue DESC;

-- 11. How do Monthly sales trends vary across product categories, and which categories generate the highest revenue?
SELECT 
	Product_Category, 
	DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month, 
	COUNT(DISTINCT Order_ID) AS Total_Order,
	SUM(Quantity) AS Total_Units_Sold,
	SUM(Total_Sales) AS Monthly_Revenue,
	ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_Category, Order_Month
ORDER BY Order_Month,Monthly_Revenue DESC;

-- 12. How do Quaterly sales trends vary across product categories, and which categories generate the highest revenue? 
SELECT 
	Product_Category, 
    YEAR(Order_Date) AS Order_Year,
	QUARTER(Order_Date) AS Order_Quarter, 
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
	SUM(Total_Sales) AS Quarterly_Revenue,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_Category,Order_Year,Order_Quarter
ORDER BY Order_Year,Order_Quarter,Quarterly_Revenue DESC;

-- 13. How do Yearly sales trends vary across product categories, and which categories generate the highest revenue? 
SELECT 
	Product_Category, 
    YEAR(Order_Date) AS Order_Year,
    COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
	SUM(Total_Sales) AS Quarterly_Revenue,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_Category ,Order_Year
ORDER BY Order_Year,Quarterly_Revenue DESC;

-- 14. Which age group contributes the most to sales across different product categories?
SELECT 
	Product_Category, 
       CASE 
           WHEN Buyer_Age BETWEEN 18 AND 20 THEN '18-20'
           WHEN Buyer_Age BETWEEN 21 AND 25 THEN '21-25'
           WHEN Buyer_Age BETWEEN 26 AND 30 THEN '26-30'
           WHEN Buyer_Age BETWEEN 31 AND 35 THEN '30-35'
           ELSE '35+' 
       END AS Age_Group,
       COUNT(DISTINCT Order_ID) AS Total_Order,
       SUM(Quantity) AS Total_Units_Sold,
       SUM(Total_Sales) Total_Revenue,
	   ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Product_Category, Age_Group
ORDER BY Product_Category, Total_Units_Sold DESC;

-- 15. Which product has the highest revenue in each product category?
WITH Ranked_Products AS (
    SELECT 
        Product_Category,
        Product_ID,
        COUNT(DISTINCT Order_ID) AS Total_Order,
        SUM(Quantity) AS Total_Units_Sold,
        SUM(Total_Sales) AS Total_Revenue,
        ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order,
        ROUND(AVG(Rating),2) AS Average_Rating,
        RANK() OVER (PARTITION BY Product_Category ORDER BY SUM(Total_Sales) DESC) AS Rank1
    FROM merch_sales
    GROUP BY Product_Category, Product_ID
)
SELECT 
    Product_Category,
    Product_ID,
    Total_Order,
    Total_Units_Sold,
    Total_Revenue,
    Average_Sales_Per_Order,
    Average_Rating
FROM Ranked_Products
WHERE Rank1 = 1
ORDER BY Product_Category;

-- 16. Which products experience the highest demand fluctuations?
SELECT 
	Product_ID, 
	Product_Category, 
	ROUND(STDDEV(Quantity),2) AS Demand_Fluctuation
FROM merch_sales
GROUP BY Product_ID, Product_Category
ORDER BY Demand_Fluctuation DESC;

-- 17. What is the monthly trend in total orders, units sold, and revenue?
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Total_Units_Sold,
	SUM(Total_Sales) AS Total_Revenue,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Year, Month
ORDER BY Year, Month;

-- 18. How does international shipping impact sales across product categories?
SELECT 
	International_Shipping, 
    Product_Category, 
    Product_ID,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) Total_Units_Sold,
    SUM(Total_Sales) AS Total_Revenue,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY International_Shipping, Product_Category, Product_ID
ORDER BY International_Shipping DESC, Total_Revenue DESC;

-- 19. How do shipping charges impact order volume, revenue, and customer satisfaction?
SELECT 
	Shipping_Charges, 
    International_Shipping,
	COUNT(DISTINCT Order_ID) AS Total_Order,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Total_Sales) AS Total_Revenue,
    ROUND(SUM(Total_Sales)*100 / (SELECT SUM(Total_Sales) FROM merch_sales),2) AS Percentage_Total_Revenue,
    ROUND(AVG(Rating),2) AS Average_Rating,
    ROUND(AVG(Total_Sales),2) AS Average_Sales_Per_Order
FROM merch_sales
GROUP BY Shipping_Charges,International_Shipping
ORDER BY Shipping_Charges;




