CREATE TABLE appleStore_description_combined AS

Select * FROM appleStore_description1

UNION ALL

Select * FROM appleStore_description2

UNION ALL

Select * FROM appleStore_description3

UNION ALL

Select * FROM appleStore_description4


** EXPLORATORY DATA ANALYSIS**AppleStore

-- check the number of unique apps in both tableApplestoreAppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs 
FROM AppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM appleStore_description_combined

--Check for any missing values 

SELECT COUNT(*) AS MissingValues 
FROM AppleStore
WHERE track_name IS null OR user_rating is null OR prime_genre IS NULL

SELECT COUNT(*) AS MissingValues 
FROM appleStore_description_combined
WHERE app_desc IS null 

-- Find out the number of apps per genreAppleStore

SELECT prime_genre, COUNT(*) AS NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC

--Get an Overview of the apps' ratings

SELECT min(user_rating) AS MinRating,
       max(user_rating) AS MaxRating,
       avg(user_rating) AS AVGRating
FROM AppleStore

--Get the distribution of app prices

SELECT
(price/ 2) *2 AS PriceBinStart,
((price / 2) *2) +2 AS PriceBinEnd,
COUNT(*) AS NumApps
FROM AppleStore

GROUP BY PriceBinStart
ORDER BY PriceBinStart

**DATA ANALYSIS**

--Determine whether paid apps have higher ratings than free apps

SELECT CASE
          WHEN price > 0 THEN 'Paid'
          ELSE 'Free'
     END as App_Type,
     avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY App_Type

--Check if apps with more supported languages have higher ratings

SELECT CASE
       WHEN lang_num <10 THEN '<10 languages'
       WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 languages'
       ELSE '>30 languages'
    END AS language_bucket,
    avg(user_rating) AS AVG_Rating
From AppleStore
GROUP By language_bucket
ORDER by AVG_Rating DESC

--Check genres with low ratings 

SELECT prime_genre,
       avg(user_rating) AS Avg_Rating 
FROM AppleStore
GROUP BY prime_genre
ORDER By avg_Rating ASC

--Check if there is correlation between the length of the app description and the user rating

SELECT CASE
           WHEN length(b.app_desc) <500 THEN 'Short'
           WHEN length(b.app_desc) BETWEEN 500 and 1000 THEN 'Medium'
           ELSE 'Long'
       END AS description_length_bucket,
       avg(a.user_rating) AS average_rating


FROM
    AppleStore AS A   
JOIN   

     appleStore_description_combined AS b

ON
    a.id = b.id
    
    GROUP BY description_length_bucket
    ORDER by average_rating DESC
    

  
 