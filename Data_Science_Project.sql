"Scenario: Data Scientist at USDA (United States Department of Agriculture)"

"Context: 

You are a Data Scientist working at the USDA. Your department has been tracking the production of various agricultural commodities across different states. 

Your datasets include: `milk_production`, `cheese_production`, `coffee_production`, `honey_production`, `yogurt_production`, and a `state_lookup` table. "

"The data spans multiple years and states, with varying levels of production for each commodity.Your manager has requested that you generate insights from 
this data to aid in future planning and decision-making. You'll need to use SQL queries to answer the questions that come up in meetings, reports, or 
strategic discussions." 

"Objectives: Assess state-by-state production for each commodity. "
       "1. Identify trends or anomalies.
        2. Offer data-backed suggestions for areas that may need more attention."


--NOTE: All answer entries are numeric and only numbers and periods.


--Q1. Find the total milk production for the year 2023. (Answer: 91812000000)
SELECT sum(mp.Value) as total_milk_production
FROM milk_production mp
WHERE mp.Year = 2023;


--Q3. Show coffee production data for the year 2015. (Answer: 6600000)
SELECT sum(cp.Value) as total_coffee_production
FROM coffee_production cp 
WHERE cp.Year  = 2015;


--Q4. Find the average honey production for the year 2022. (Answer: 3133275)
SELECT avg(hp.Value) as average_cofee_production
FROM honey_production hp
WHERE hp.Year  = 2022;

--Q5. Get the state names with their corresponding ANSI codes from the state_lookup table. What number is Iowa? (Answer: 19)
SELECT sl.State, sl.State_ANSI 
FROM state_lookup sl
WHERE sl.State LIKE "Iowa"



--Q6. Find the highest yogurt production value for the year 2022. (Answer: 793256000)
SELECT max(yp.Value) as State_ANSI_Code
FROM yogurt_production yp
WHERE yp.Year  = 2022;

--Q7. Find states where both honey and milk were produced in 2022. Did State_ANSI "35" produce both honey and milk in 2022? (Answer: No)
SELECT DISTINCT hp.State_ANSI 
FROM honey_production hp 
INNER JOIN milk_production mp on hp.State_ANSI = mp.State_ANSI 
WHERE hp.Year = 2022 
AND mp.Year = 2022

--Q8. Find the total yogurt production for states that also produced cheese in 2022. (Answer: 1171095000)
SELECT sum(yp.Value) 
FROM yogurt_production yp 
WHERE yp.Year = 2022 
AND yp.State_ANSI IN (SELECT DISTINCT cp.State_ANSI FROM cheese_production cp WHERE cp.Year = 2022);

--Q9. Which states had cheese production greater than 100 million in April 2023? How many states are there? (Answer: 2)
SELECT State_ANSI 
FROM cheese_production cp
WHERE cp.Year = 2023 AND cp.Period = 'APR' AND cp.Value > 100000000;

--Q10. What is the total value of coffee production for 2011? (Answer: 7600000)
SELECT cp.Year, SUM(cp.Value) 
FROM coffee_production cp
GROUP BY cp.Year;

--Q11. Find the average honey production for 2022. (Answer: 63133275)
SELECT AVG(hp.Value) 
FROM honey_production hp 
WHERE hp.Year = 2022;

--Q12. What is the State_ANSI code for Florida? (Answer: 12)
SELECT * 
FROM state_lookup sl;


--Q13. For a cross-commodity report, can you list all states with their cheese production values, even if they didn't produce any cheese in April of 2023? What is the total for NEW JERSEY? (Answer: State:NEW JERSEY, State_ANSI:34, Value:4889000, Year:2023	APR
SELECT* 
FROM state_lookup sl 
LEFT JOIN cheese_production cp
ON sl.State_ANSI = cp.State_ANSI 
AND cp.Year = 2023 
AND cp.Period = 'APR';

--Q14. Can you find the total yogurt production for states in the year 2022 which also have cheese production data from 2023? (Answer: 1171095000)
SELECT sum(yp.Value) 
FROM yogurt_production yp 
WHERE yp.Year = 2022 
AND yp.State_ANSI IN (SELECT DISTINCT cp.State_ANSI 
FROM cheese_production cp 
WHERE cp.Year = 2022);

--Q15. List all states from state_lookup that are missing from milk_production in 2023. How many states are there? (Answer: 26)
SELECT sl.State
FROM state_lookup sl
LEFT JOIN milk_production mp 
ON sl.State_ANSI = mp.State_ANSI 
AND mp.Year = 2023
WHERE mp.State_ANSI IS NULL;

--Q16. List all states with their cheese production values, including states that didn't produce any cheese in April 2023. Did Delaware produce any cheese in April 2023? (Answer: No)
SELECT sl.State, cp.Value
FROM state_lookup sl
LEFT JOIN cheese_production cp 
ON sl.State_ANSI = cp.State_ANSI 
AND cp.Year = 2023 
AND cp.Period = 'APR';

--Q17. Find the average coffee production for all years where the honey production exceeded 1 million. (Answer: 6426666.67)
SELECT AVG(cp.Value)
FROM coffee_production cp
WHERE cp.Year IN (
    SELECT hp.Year FROM honey_production hp WHERE hp.Value > 1000000
);
