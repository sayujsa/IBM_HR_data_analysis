use project_2;


DESCRIBE hr_1;
DESCRIBE hr_2;


## Average Attrition rate for all Departments
SELECT department, concat(round(sum(attrition = 'yes')/(select sum(attrition = 'yes') from hr_1) * 100, 2), "%") as 'attrition rate'
FROM hr_1
GROUP BY department;


## Average Hourly rate of Male Research Scientist
SELECT jobrole, ROUND(AVG(hourlyrate), 2) AS 'Average Hourly Rate'
FROM hr_1
WHERE gender = 'male' AND jobrole = 'Research Scientist'
GROUP BY jobrole;


##  Attrition rate Vs Monthly income stats
SELECT 
	CONCAT(FLOOR(hr_2.MonthlyIncome/5000)*5000, " - ", FLOOR(hr_2.MonthlyIncome/5000)*5000+4999) AS "income range", 
	 concat(round(sum(attrition = 'yes')/(select sum(attrition = 'yes') from hr_1) * 100, 2), "%") as "attrition rate", 
    sum(attrition = 'yes') as "number of attritions\n(yes)"
FROM hr_2
INNER JOIN hr_1 ON hr_1.EmployeeNumber = hr_2.`Employee ID`
WHERE hr_2.MonthlyIncome IS NOT NULL
GROUP BY `income range`
ORDER BY `income range`;


## Average working years for each Department
SELECT department, ROUND(AVG(totalworkingyears), 2) as "average working years"
FROM hr_1
JOIN hr_2 ON hr_1.employeenumber = hr_2.`Employee ID`
GROUP BY department
ORDER BY department;


## Job Role Vs Work life balance
SELECT jobrole,
	CONCAT(ROUND(AVG(worklifebalance = 1)*100, 2), "%") as "1",
    CONCAT(ROUND(AVG(worklifebalance = 2)*100, 2), "%") as "2",
    CONCAT(ROUND(AVG(worklifebalance = 3)*100, 2), "%") as "3",
    CONCAT(ROUND(AVG(worklifebalance = 4)*100, 2), "%") as "4"
FROM hr_1
JOIN hr_2 ON hr_1.employeenumber = hr_2.`Employee ID`
GROUP BY jobrole
ORDER BY jobrole;


## Attrition rate Vs Years since last promotion relation
SELECT 
	CONCAT(FLOOR(yearssincelastpromotion/5)*5, " - ", FLOOR(yearssincelastpromotion/5)*5+4) as "years since last promotion bins",
     concat(round(sum(attrition = 'yes')/(select sum(attrition = 'yes') from hr_1) * 100, 2), "%") as "attrition rate",
    SUM(attrition = 'yes') as "number of attritions\n(yes)"
FROM hr_2
JOIN hr_1 ON hr_1.employeenumber = hr_2.`Employee ID`
GROUP BY `years since last promotion bins`
ORDER BY `years since last promotion bins`;
























