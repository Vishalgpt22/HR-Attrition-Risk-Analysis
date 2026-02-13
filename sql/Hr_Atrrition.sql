create database Hr_Attrition;

select * from employee_attrition;

-- Duplicate Employee IDs check
SELECT Employee_ID, COUNT(*) 
FROM employee_attrition
GROUP BY Employee_ID
HAVING COUNT(*) > 1;

-- Invalid Attrition Risk Values
SELECT DISTINCT Attrition_Risk_Level
FROM employee_attrition;

-- Attrition Risk Distribution
SELECT Attrition_Risk_Level, COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY Attrition_Risk_Level
order by employee_count desc;

-- Attrition by Job Role
SELECT Job_Role, Attrition_Risk_Level, COUNT(*) as employee_count
FROM employee_attrition
GROUP BY Job_Role, Attrition_Risk_Level
order by Attrition_Risk_Level ;

-- Attrition by Age Group
SELECT  Age_Group,Attrition_Risk_Level,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY Age_Group, Attrition_Risk_Level
ORDER BY Age_Group;

-- Income Band VS Attrition
SELECT  Income_Band, Attrition_Risk_Level,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY Income_Band, Attrition_Risk_Level
ORDER BY Income_Band;

-- Work Life Balance Impact
SELECT Work_Life_Balance, Attrition_Risk_Level,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY Work_Life_Balance, Attrition_Risk_Level
ORDER BY Work_Life_Balance;

-- Promotion Gap Analysis
SELECT Promotion_Gap, Attrition_Risk_Level, COUNT(*) as employee_count
FROM employee_attrition
GROUP BY Promotion_Gap, Attrition_Risk_Level
order by Attrition_Risk_Level ;

-- Overworked employee Analysis
SELECT Over_worked_Flag, Attrition_Risk_Level,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY Over_worked_Flag, Attrition_Risk_Level
order by Over_worked_Flag;

-- High Risk Employees
SELECT *
FROM employee_attrition
WHERE Attrition_Risk_Level = 2;

-- Avg metrics by attrition risk
SELECT Attrition_Risk_Level,
    ROUND(AVG(Monthly_Income),2) AS avg_income,
    ROUND(AVG(Avg_Monthly_Hours),2) AS avg_monthly_hours,
    ROUND(AVG(Years_at_Company),2) AS avg_tenure
FROM employee_attrition
GROUP BY Attrition_Risk_Level;

-- Attrition percentage by job role
SELECT  Job_Role,  Attrition_Risk_Level,
    COUNT(*) AS employee_count,
    ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY Job_Role), 2 ) AS attrition_percentage
FROM employee_attrition
GROUP BY Job_Role, Attrition_Risk_Level
ORDER BY Job_Role;

-- High-Risk Employees View
CREATE VIEW high_risk_employees AS
SELECT *
FROM employee_attrition
WHERE Attrition_Risk_Level = 2;

-- Attrition Summary View
CREATE VIEW vw_attrition_summary AS
SELECT 
    Job_Role,
    Age_Group,
    Income_Band,
    Promotion_Gap,
   Over_worked_Flag,
    Attrition_Risk_Level,
    COUNT(*) AS employee_count
FROM employee_attrition
GROUP BY 
    Job_Role,
    Age_Group,
    Income_Band,
    Promotion_Gap,
    Over_worked_Flag,
    Attrition_Risk_Level;


SELECT * FROM vw_attrition_summary;

SELECT * FROM high_risk_employees;

