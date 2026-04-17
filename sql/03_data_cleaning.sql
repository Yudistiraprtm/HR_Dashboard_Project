SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN STR_TO_DATE(birthdate, '%m/%d/%Y')
    WHEN birthdate LIKE '%-%' AND LENGTH(birthdate)=8 THEN STR_TO_DATE(birthdate, '%m-%d-%y')
    WHEN birthdate LIKE '%-%' THEN STR_TO_DATE(birthdate, '%m-%d-%Y')
    ELSE NULL
END;

UPDATE hr
SET birthdate = DATE_SUB(birthdate, INTERVAL 100 YEAR)
WHERE birthdate > CURDATE();

UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN STR_TO_DATE(hire_date, '%m/%d/%Y')
    WHEN hire_date LIKE '%-%' THEN STR_TO_DATE(hire_date, '%m-%d-%Y')
    ELSE NULL
END;

UPDATE hr
SET termdate = CASE
    WHEN termdate IS NOT NULL AND TRIM(termdate) != '' 
    THEN DATE(STR_TO_DATE(TRIM(termdate), '%Y-%m-%d %H:%i:%s UTC'))
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE,
MODIFY COLUMN hire_date DATE,
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());