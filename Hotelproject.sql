/* 1.Write a query to retrieve the names and ratings of all hotels with a rating of 4.0 or higher.*/
SELECT Hotel_name, Rating
from finalhotel
where Rating >= 4;

/* 2.Find the total number of hotels located in 'Ambaji' */
Select count(Hotel_name) AS Hotels_near_ambaji
from finalhotel
where Destination_name = 'ambaji';

/* 3.List the names of all hotels that have 'Swimming Pool' as one of their facilities. */
SELECT Hotel_name, Facilities 
From finalhotel
Where Facilities = 'Swimming Pool'
Group by Hotel_name;

/* 4.Retrieve the Hotel name and Actual price for the 5 most expensive hotels. */
SELECT Hotel_name, Actual_price
From finalhotel
Order by Actual_price Desc 
Limit 5;

/* 5.Select all distinct Destination name values from the table. */
Select distinct Destination_name
from finalhotel;

/* 6.Calculate the average Actual price for hotels in each Destination name.*/
SELECT   AVG(Actual_price) As Avg_of_actual_price, Destination_name
from finalhotel
Group by Destination_name;

/* 7.Find the hotel with the highest Discount price and its Destination name.*/
SELECT Hotel_name, Destination_name, Discount_price
FROM finalhotel
WHERE Discount_price = (SELECT MAX(Discount_price) FROM finalhotel);

/* 8.Count the number of hotels for each Rating text (e.g., 'Excellent', 'Very Good', 'Good').*/
SELECT Rating_text, COUNT(*) AS total_hotels
FROM finalhotel
GROUP BY Rating_text;

/*9.Retrieve all columns for hotels that have an Actual price between 3000 and 5000.*/
Select * From finalhotel
Where Actual_price between 3000 and 5000;

/*10.List the Hotel name, Rating, and Facilities for all hotels where the Hotel name starts with 'Hotel'.*/
SELECT Hotel_name, Rating, Facilities
FROM finalhotel
WHERE Hotel_name LIKE 'Hotel%';

/*11.Write a query to find the Hotel name and Actual price for all hotels whose 
Actual price is greater than the average Actual price of all hotels in the table.*/
SELECT Hotel_name, Actual_price
From finalhotel
Where Actual_price > (SELECT AVG(Actual_price) As Avg_Actual_Price from finalhotel );

/*12.Determine the Destination name with the largest number of hotels that have a rating of 4.0 or higher.*/
SELECT Destination_name, COUNT(*) AS hotel_count
FROM finalhotel
WHERE Rating >= 4.0
GROUP BY Destination_name
ORDER BY hotel_count DESC
LIMIT 1;

/*13.For each Destination name, find the hotel with the lowest Discount price. */
SELECT Destination_name, Hotel_name, Discount_price
FROM (
    SELECT Destination_name, Hotel_name, Discount_price,
           RANK() OVER (PARTITION BY Destination_name ORDER BY Discount_price ASC) AS rnk
    FROM finalhotel
) t
WHERE rnk = 1;

/* 14.Use a CASE statement to create a new column called Price_Category based on 
the Actual price: 'Budget' (less than $2000), 'Mid-Range' ($2000 to $5000), and 'Premium' (over $5000). 
Display the Hotel name, Actual price, and the new Price_Category. */

SELECT Hotel_name,
       Actual_price,
       CASE 
           WHEN Actual_price < 2000 THEN 'Budget'
           WHEN Actual_price BETWEEN 2000 AND 5000 THEN 'Mid-Range'
           WHEN Actual_price > 5000 THEN 'Premium'
           ELSE 'Unknown'
       END AS Price_Category
FROM finalhotel;

/*15.Calculate the average discount percentage for each Destination name. The discount percentage 
is calculated as $((\\text{Actual price} - \\text{Discount price}) / \\text{Actual price}) \* 100$. */

SELECT Destination_name,
       AVG(((Actual_price - Discount_price) / Actual_price) * 100) AS avg_discount_percentage
FROM finalhotel
GROUP BY Destination_name;

