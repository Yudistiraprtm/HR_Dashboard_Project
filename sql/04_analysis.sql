SELECT MIN(age) AS youngest, MAX(age) AS oldest FROM hr;

SELECT COUNT(*) AS underage FROM hr WHERE age < 18;

SELECT COUNT(*) AS active_employees FROM hr WHERE termdate IS NULL;

SELECT COUNT(*) AS terminated_employees FROM hr WHERE termdate IS NOT NULL;

SELECT location, COUNT(*) AS total_employees
FROM hr
GROUP BY location;