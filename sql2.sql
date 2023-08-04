-- Find all employees

SELECT *
FROM employee;

-- Find all clients

SELECT *
FROM client;

-- Find all employees ordered by salary

SELECT *
FROM employee
ORDER BY salary ASC; -- asc is not necessary here

SELECT *
FROM employee
ORDER BY salary DESC;

-- Find all employees ordered by sex then name

SElECT * 
FROM employee
ORDER BY sex,first_name, last_name;

-- Find first 5 employees in the table

SELECT *
FROM employee
LIMIT 5;

-- Find first and last names of all employees

SELECT first_name,last_name
FROM employee;

-- Find the forename and surname of all employees

SELECT first_name AS forename, last_name AS surname
FROM employee;

-- Find out all the different genders

SELECT DISTINCT sex -- distinct keyword is useful to find out the values that are 
FROM employee;      -- stored in a particular column

-- Find the number of employees

SELECT COUNT (emp_id) AS numberOfEmployees
FROM employee;

SELECT COUNT (super_id) AS employeesWithSupervisors
FROM employee;

-- Find the number of female employees born after 1970

SELECT COUNT (emp_id) AS femalesBornAfter1970
FROM employee
WHERE sex = 'F' AND birth_date >= '1971-01-01'

-- Find the average of all salaries of male employees

SELECT AVG (salary)
FROM employee
WHERE sex = 'M'

-- Find the sum of all salaries

SELECT SUM (salary)
FROM employee

-- Find out how many males and how many females

SELECT COUNT (sex), sex -- this is an example of aggregation
FROM employee
GROUP BY sex;

-- Find the total sales of each salesman

SELECT SUM (total_sales) AS totalSales, emp_id AS employeeID
FROM works_with
GROUP BY emp_id;


-- WILDCARDS --
-- % = any # characters, _ = one character

-- Find any client's who are an LLC

SELECT *
FROM client
WHERE client_name LIKE '%LLC'; -- one % at the beginning will look for the '' at the end

-- Find any branch suppliers who are in the label business

SELECT * 
FROM branch_supplier
WHERE supplier_name LIKE '%Label%'; -- two % will look for any instance of the''

-- Find any employee born in October

SELECT * 
FROM employee
WHERE birth_date LIKE '____-10';

-- Find any clients who are schools

SELECT *
FROM client
WHERE client_name LIKE '%school%';

-- Find a list of all clients & branch suppliers' names

SELECT client_name AS clientsANDsuppliers, client.branch_id
FROM client 
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- Find a list of all money spent or earned by the company

SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

-- ** union only works with the same data type **

-- Find all the branches and the name of their managers

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id; -- returns the managers and all the other employees as well

-- RIGHT JOIN will do the opposite; include all the branch names and their managers
-- also even if they did not have managers

-- FULL OUTER JOIN combines both left and right joins

-- Find names of all employees who have 
-- sold over 30,000 to a single client

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

-- Find all clients who are held by the branch that Micheal Scott manages
-- Assume you know Micheal's ID

SELECT client.client_name
FROM client
WHERE client.branch_id = (
    SELECT employee.branch_id
    FROM employee
    WHERE employee.emp_id = 
    LIMIT 1
);

