SELECT * 
FROM KMS_Case kc  
LIMIT 10;

----- 1. Which product category had the highest sales?

SELECT "Product Category", SUM(Sales) AS Total_Sales
FROM KMS_Case kc  
GROUP BY "Product Category"
ORDER BY Total_Sales DESC
LIMIT 1;


-------- 2. Top 3 and Bottom 3 regions in terms of sales

SELECT Region, SUM(Sales) AS Total_Sales
FROM KMS_Case kc  
GROUP BY Region
ORDER BY Total_Sales DESC
LIMIT 3;

----- Bottom 3

SELECT Region, SUM(Sales) AS Total_Sales
FROM KMS_Case kc  
GROUP BY Region
ORDER BY Total_Sales ASC
LIMIT 3;

------------3. What were the total sales of appliances in Ontario? (use sub category)

SELECT SUM(Sales) AS Total_Appliance_Sales
FROM  KMS_Case kc
WHERE "Product Sub-Category" = 'Appliances'
  AND Province = 'Ontario';

------- 4. Advice to increase revenue from bottom 10 customers

SELECT "Customer Name", SUM(Sales) AS Total_Sales
FROM KMS_Case kc
GROUP BY "Customer Name"
ORDER BY Total_Sales ASC
LIMIT 10;

--- Analysis 
SELECT "Customer Name", COUNT(*) AS Num_Orders, SUM(Sales) AS Total_Sales, "Customer Segment"
FROM KMS_Case kc
WHERE "Customer Name" IN (
    SELECT "Customer Name"
    FROM KMS_Case kc
    GROUP BY "Customer Name"
    ORDER BY SUM(Sales) ASC
    LIMIT 10
)
GROUP BY "Customer Name", "Customer Segment"
ORDER BY Total_Sales ASC;

----“Management should consider offering exclusive promotions to low-performing customers, bundling frequently purchased sub-categories, and improving engagement for the ‘Consumer’ segment using 
----email campaigns or loyalty programs.”


------ 5. Which shipping method had the highest shipping cost?

SELECT "Ship Mode", SUM("Shipping Cost") AS Total_Shipping_Cost
FROM KMS_Case kc
GROUP BY "Ship Mode"
ORDER BY Total_Shipping_Cost DESC
LIMIT 1;

------------ 6. Who are the most valuable customers & what do they purchase?

SELECT "Customer Name", SUM(Sales) AS Total_Sales
FROM KMS_Case kc
GROUP BY "Customer Name"
ORDER BY Total_Sales DESC
LIMIT 5;

------ Step 2: What they purchase

SELECT "Customer Name", "Product Category", COUNT(*) AS Num_Purchases
FROM KMS_Case kc
WHERE "Customer Name" IN (
    SELECT "Customer Name"
    FROM KMS_Case kc
    GROUP BY "Customer Name"
    ORDER BY SUM(Sales) DESC
    LIMIT 5
)
GROUP BY "Customer Name", "Product Category"
ORDER BY "Customer Name", Num_Purchases DESC;


------7. Which small business customer had the highest sales?

SELECT "Customer Name", SUM(Sales) AS Total_Sales
FROM KMS_Case kc
WHERE "Customer Segment" = 'Small Business'
GROUP BY "Customer Name"
ORDER BY Total_Sales DESC
LIMIT 1;

------ 8. Which Corporate Customer placed the most number of orders (2009–2012)?

SELECT "Customer Name", COUNT(*) AS Num_Orders
FROM KMS_Case kc
WHERE "Customer Segment" = 'Corporate'
  AND substr("Order Date", -4) BETWEEN '2009' AND '2012'
GROUP BY "Customer Name"
ORDER BY Num_Orders DESC
LIMIT 1;


------ 9. Which consumer customer was most profitable?

SELECT "Customer Name", SUM(Profit) AS Total_Profit
FROM KMS_Case kc
WHERE "Customer Segment" = 'Consumer'
GROUP BY "Customer Name"
ORDER BY Total_Profit DESC
LIMIT 1;



----------- 11. Did shipping cost align with order priority?

SELECT "Order Priority", "Ship Mode", COUNT(*) AS Num_Orders, SUM("Shipping Cost") AS Total_Cost
FROM KMS_Case kc
GROUP BY "Order Priority", "Ship Mode"
ORDER BY "Order Priority", "Ship Mode";

