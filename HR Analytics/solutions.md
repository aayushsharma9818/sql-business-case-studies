-- 1. Overall Attrition Rate
SELECT 
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS attrition_rate_pct
FROM hr_data;


-- 2. Attrition by Department
SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS attrition_rate_pct
FROM hr_data
GROUP BY Department
ORDER BY attrition_rate_pct DESC;


-- 3. Attrition by Job Role
SELECT 
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM hr_data
GROUP BY JobRole
ORDER BY attrition_count DESC;


-- 4. Average Tenure by Department
SELECT 
    Department,
    ROUND(AVG(YearsAtCompany), 2) AS avg_tenure_years
FROM hr_data
GROUP BY Department;


-- 5. Salary vs Attrition
SELECT 
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM hr_data
GROUP BY Attrition;


-- 6. Job Satisfaction vs Attrition
SELECT 
    JobSatisfaction,
    COUNT(*) AS employee_count,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM hr_data
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;


-- 7. Attrition by Age Group
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Above 50'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM hr_data
GROUP BY age_group;


-- 8. Attrition by Tenure Group
SELECT 
    CASE 
        WHEN YearsAtCompany < 2 THEN '0-2 years'
        WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 years'
        ELSE '5+ years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM hr_data
GROUP BY tenure_group;
