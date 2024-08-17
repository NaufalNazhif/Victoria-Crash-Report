-- 10 Year recap by type

SELECT
  EXTRACT(YEAR FROM ACCIDENT_DATE) as year,
  CASE
    WHEN LOWER(ACCIDENT_TYPE_DESC) LIKE '%no collision%' THEN 'Other accident'
    WHEN LOWER(ACCIDENT_TYPE_DESC) LIKE '%collision%' THEN 'Collision'
    WHEN LOWER(ACCIDENT_TYPE_DESC) LIKE '%struck%' THEN 'Struck'
    ELSE ACCIDENT_TYPE_DESC
  END AS accident_type,
  COUNT(ACCIDENT_TYPE_DESC) as total
FROM Project_1.vic_roadcrash
WHERE EXTRACT(YEAR FROM ACCIDENT_DATE) > 2013
GROUP BY 1,2
ORDER BY 1,2

--------------------------------------
-- Collision type class

SELECT
  CASE
    WHEN LOWER(ACCIDENT_TYPE_DESC) LIKE '%no collision%' THEN 'Other accident'
    ELSE ACCIDENT_TYPE_DESC
  END AS accident_type,
  COUNT(accident_type) as total
FROM Project_1.vic_roadcrash
WHERE LOWER(ACCIDENT_TYPE_DESC) LIKE '%collision%'
AND EXTRACT(YEAR FROM ACCIDENT_DATE) > 2013
GROUP BY 1

--------------------------------------
-- Type of road

SELECT
  CASE
    WHEN ROAD_GEOMETRY_DESC IN ('Cross intersection', 'T intersection', 'Multiple intersection', 'Y intersection') THEN 'Intersection'
    WHEN ROAD_GEOMETRY_DESC IN ('Unknown', 'Dead end', 'Road closure', 'Private property') THEN 'Other'
    ELSE ROAD_GEOMETRY_DESC
  END AS road_type,
  COUNT(ROAD_GEOMETRY_DESC) as total
FROM Project_1.vic_roadcrash
WHERE EXTRACT(YEAR FROM ACCIDENT_DATE) > 2013
GROUP BY 1
ORDER BY 2 DESC

--------------------------------------
-- average roadcrash everyhour

WITH cte AS(
SELECT
  EXTRACT(YEAR FROM ACCIDENT_DATE) as year,
  EXTRACT(HOUR FROM ACCIDENT_TIME) AS hour,
  COUNT(ACCIDENT_TIME) as total
FROM Project_1.vic_roadcrash
WHERE EXTRACT(YEAR FROM ACCIDENT_DATE) > 2013
GROUP BY 1,2
ORDER BY 1,2
)

SELECT
  hour,
  ROUND(AVG(total)) as average
FROM CTE
GROUP BY 1
ORDER BY 1

--------------------------------------
-- RMA

SELECT
  RMA,
  COUNT(RMA) AS total
FROM Project_1.vic_roadcrash
WHERE EXTRACT(YEAR FROM ACCIDENT_DATE) > 2013
GROUP BY 1
ORDER BY 2 DESC

--------------------------------------
-- Light Condition

SELECT
  LIGHT_CONDITION,
  SUM(LIGHT_CONDITION) AS total
FROM Project_1.vic_roadcrash
WHERE EXTRACT(YEAR FROM ACCIDENT_DATE) > 2013
GROUP BY 1
ORDER BY 1