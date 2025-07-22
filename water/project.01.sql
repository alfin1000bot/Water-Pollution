create database project;
use alfin;
select * from water_pollution;

#1 write a query to name the countries with contamination higher than all countries in a specifc region;
select country,contaminant_lvl from water_pollution where contaminant_lvl> all(select contaminant_lvl from water_pollution
  WHERE Region = 'west');
  
#2 write a sql query to retrieve Countries that have ever recorded cholera cases
SELECT DISTINCT Country FROM water_pollution as wp WHERE EXISTS (SELECT 1 FROM water_pollution
WHERE Country = wp.Country AND Cholera_Cases > 0);

#3 write a query to select the countries with infant mortality rate greater than all the countries in central region
select country,infant_mortality_rate from water_pollution where infant_mortality_rate > all(select infant_mortality_rate 
    from water_pollution where region = 'central');

#4 write a query to retrieve the top 5 regions on the basis of total diseased cases
SELECT country, SUM(Cholera_Cases + Typhoid_Cases + Diarrhea_Cases) AS total_disease FROM water_pollution
GROUP BY country ORDER BY total_disease DESC LIMIT 5;

#5 Retrieve the names of where nitrate level is below average but lead is above
SELECT Country FROM water_pollution GROUP BY Country HAVING AVG(Nitrate_Level) < (SELECT AVG(Nitrate_Level) FROM water_pollution)
AND AVG(Lead_Concentration) > (SELECT AVG(Lead_Concentration) FROM water_pollution);

#6 Select the Countries with extreme rainfall but low access to clean water
SELECT Country, AVG(Rainfall ) AS rain, AVG(Clean_Water) AS clean_access
FROM water_pollution GROUP BY Country HAVING rain > 1000 AND clean_access < 600;

#7 select the name of countries with all three diseases below  average
SELECT distinct Country FROM water_pollution WHERE Cholera_Cases < (
SELECT AVG(Cholera_Cases) FROM water_pollution)AND Typhoid_Cases< (SELECT AVG(Typhoid_Cases) FROM water_pollution)
AND Diarrhea_Cases < (SELECT AVG(Diarrhea_Cases) FROM water_pollution);

#8 Retrieve the top 5 countries with worst average turbidity
SELECT Country, AVG(Turbidity) AS avg_turbidity FROM water_pollution GROUP BY Country ORDER BY avg_turbidity DESC LIMIT 5;

#9 select the Count of records with all three diseases above average
SELECT COUNT(*) FROM water_pollution WHERE Diarrhea_Cases > (SELECT AVG(Diarrhea_Cases) FROM water_pollution)
AND Cholera_Cases > (SELECT AVG(Cholera_Cases) FROM water_pollution) AND Typhoid_Cases > (SELECT AVG(Typhoid_Cases) FROM water_pollution);

#10 Retrieve the Top 5 regions by average clean water across years
SELECT Region, AVG(clean_water) AS avg_clean FROM water_pollution GROUP BY Region
ORDER BY avg_clean DESC LIMIT 5;

#11 select Countries with GDP < 5000 and poor clean water access
SELECT Country, AVG(clean_water) AS avg_clean FROM water_pollution WHERE GDP_per_Capita < 5000
GROUP BY Country HAVING avg_clean < 70;

#12 select Countries with clean_water lower than any country 
SELECT Country, clean_water FROM water_pollution WHERE clean_water < ANY
(SELECT MAX(clean_water) FROM water_pollution GROUP BY Country);

#13 Countries with Nitrate_Level greater than some other countries
SELECT DISTINCT Country FROM water_pollution WHERE Nitrate_Level > SOME
(SELECT AVG(Nitrate_Level)FROM water_pollution GROUP BY Country);

#14 select Countries with average clean water availability more than 40%
SELECT Country, AVG(clean_water) AS avg_clean FROM water_pollution
GROUP BY Country HAVING AVG(clean_water) > 40;

#15  select Regions where average diarrhea cases lower than 500
SELECT Region, AVG(Diarrhea_Cases) AS avg_diarrhea FROM water_pollution
GROUP BY Region HAVING AVG(Diarrhea_Cases) < 300;

#16 select Countries that have recorded typhoid or diarrhea cases
SELECT DISTINCT Country,Typhoid_Cases,Diarrhea_Cases FROM water_pollution WHERE Country IN (SELECT Country FROM water_pollution
WHERE Typhoid_Cases > 0 OR Diarrhea_Cases > 0);

#17 select the name of countries which are not in certain regions
SELECT DISTINCT Country FROM water_pollution
WHERE Region NOT IN ('west', 'central'); 

#18 select Countries where pH level never exceeded 8.5
SELECT DISTINCT Country FROM water_pollution WHERE Country NOT IN (SELECT DISTINCT Country FROM water_pollution WHERE ph_level > 8.5);

#19 select the Countries where average dissolved oxygen is sufficient (>4) but no water treatment
SELECT Country, AVG(Dissolved_Oxygen) AS avg_oxygen FROM water_pollution
WHERE Water_treatment_method = 'None' GROUP BY Country HAVING AVG(Dissolved_Oxygen) > 4;

#20 select Regions where average pH level is outside the safe range (6.5–7.5)
SELECT Region, AVG(ph_level) AS avg_ph FROM water_pollution GROUP BY Region HAVING AVG(ph_level) between 6.5 and 7.5;

#21 select all the details of country with the highest rainfall
SELECT * FROM water_pollution WHERE Country IN (SELECT Country FROM water_pollution
  GROUP BY Country HAVING MAX(Rainfall) > 1500);

#22 select distinct countries that have reported pH levels within neutral range
SELECT DISTINCT Country FROM water_pollution WHERE Country IN (SELECT Country FROM water_pollution WHERE ph_level BETWEEN 6.5 AND 7);

#23 select distinct countries with no access to clean water
SELECT distinct Country FROM water_pollution WHERE Country NOT IN (SELECT Country
FROM water_pollution WHERE clean_water = 0);

#24 select the top 5 most acidic water samples (lowest ph)
SELECT Country, Water_Source, ph_level FROM water_pollution
ORDER BY ph_level ASC LIMIT 5;

#25 Retrieve Countries with lowest average healthcare index
SELECT Country, AVG(Healthcare_index) AS avg_health FROM water_pollution GROUP BY Country
ORDER BY avg_health ASC LIMIT 5 ;

#26 select Countries with water sources containing the word 'River'
SELECT DISTINCT Country FROM water_pollution WHERE Country IN ( SELECT Country FROM water_pollution WHERE Water_Source LIKE '%River%');

#27 select Countries with no record of using "Filtration" in treatment
SELECT DISTINCT Country FROM water_pollution WHERE Country IN (SELECT Country FROM water_pollution
WHERE Water_treatment_method not LIKE '%Filtration%');

#28 Get countries whose names contain the word "gla" and have typhoid cases
SELECT DISTINCT Country FROM water_pollution WHERE Country IN (SELECT Country FROM water_pollution
WHERE Country LIKE '%gla%' AND Typhoid_Cases > 0);

#29 List countries with water source name not containing 'Lake'
SELECT distinct Country FROM water_pollution WHERE Country IN
   (SELECT Country FROM water_pollution WHERE Water_Source not LIKE '%Lake%');
   
#30 select Countries where the pH level is lower than all other countries
SELECT distinct Country FROM water_pollution WHERE ph_level < ALL (SELECT ph_level FROM water_pollution
WHERE Country <> water_pollution.Country);

#31 select Countries with a lower nitrate level than all other records
SELECT distinct Country FROM water_pollution WHERE Nitrate_Level < ALL(SELECT Nitrate_Level
FROM water_pollution WHERE Nitrate_Level IS NOT NULL AND Country <> water_pollution.Country);

#32 Find countries where Dissolved Oxygen is lower than all others
SELECT distinct Country FROM water_pollution WHERE Dissolved_Oxygen < ALL(SELECT Dissolved_Oxygen FROM water_pollution
WHERE Dissolved_Oxygen IS NOT NULL AND Country <> water_pollution.Country);

#33 select Countries that have ever had more than the average typhoid cases
SELECT DISTINCT Country FROM water_pollution as wp WHERE EXISTS (SELECT 1 FROM water_pollution WHERE Country = wp.Country
AND Typhoid_Cases > (SELECT AVG(Typhoid_Cases) FROM water_pollution));

#34 select Total rainfall in the year with highest lead concentration
SELECT SUM(Rainfall) FROM water_pollution WHERE Year = (SELECT Year FROM water_pollution
ORDER BY Lead_Concentration DESC LIMIT 1);

#35 Countries with clean water , and average clean water above 60%
SELECT Country, AVG(clean_water) AS avg_clean FROM water_pollution WHERE clean_water IS NOT NULL GROUP BY Country
HAVING AVG (clean_water)> 50;

#36 select Water sources with lead concentration data, having average lead above 0.01
SELECT Water_Source, AVG(Lead_Concentration) AS avg_lead FROM water_pollution
WHERE Lead_Concentration IS NOT NULL GROUP BY Water_Source HAVING AVG(Lead_Concentration) > 2.2;

#37 Countries using filtration, with total diarrhea cases above 5000
SELECT Country, SUM(Diarrhea_Cases) AS total_diarrhea FROM water_pollution WHERE Water_treatment_method LIKE '%filtration%'
GROUP BY Country HAVING SUM(Diarrhea_Cases) > 5000;

#38 Select countries with average pH level not equal to 7
SELECT Country, AVG(ph_level) AS avg_ph FROM water_pollution
GROUP BY Country HAVING avg_ph <> 7;

#39 select Water treatment methods used in countries starting with 'M', with more than 3 records
SELECT country,Water_treatment_method, COUNT(*) AS usage_count FROM water_pollution WHERE Country LIKE 'M%'
GROUP BY country,Water_treatment_method HAVING COUNT(*) > 4;
 
#40 Reduce lead concentration by 10% for countries with high healthcare index
UPDATE water_pollution
SET Lead_Concentration = Lead_Concentration * 0.9
WHERE Healthcare_index > 80;
