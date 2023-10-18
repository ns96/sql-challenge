/*
Data Analysis Queries
*/

/*
List the employee number, last name, first name, sex, and salary of each employee

ANSWER (Top 5):
258641	"Aamodt"	"Abdelkader"	42414
258005	"Aamodt"	"Adhemar"		40000
455773	"Aamodt"	"Aemilian"		77921
436560	"Aamodt"	"Alagu"			55415
266651	"Aamodt"	"Aleksander"	53016
*/
SELECT employees.emp_no AS "Employee Number", employees.last_name AS "Last Name", 
	employees.first_name AS "First Name", salary.salary AS "Salary"
FROM employees 
	JOIN salary ON (salary.emp_no = employees.emp_no)
ORDER BY employees.last_name, employees.first_name;

/*
List the first name, last name, and hire date for the employees who were hired in 1986

ANSWER (Top 5)
"Cusworth"	"Eran"	1986
"Zallocco"	"Bojan"	1986
"Demizu"	"Nevio"	1986
"Vecchi"	"Ziva"	1986
"Speek"		"Mohit"	1986
*/
SELECT last_name AS "Last Name", first_name AS "First Name",
	 EXTRACT(YEAR FROM hire_date) AS "Hire Year"
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

/*
List the manager of each department along with their department number, 
department name, employee number, last name, and first name

ANSWER (Top 5)
"d001"	"Marketing"			110022	"Markovitch"	"Margareta"
"d001"	"Marketing"			110039	"Minakawa"		"Vishwani"
"d002"	"Finance"			110085	"Alpin"			"Ebru"
"d002"	"Finance"			110114	"Legleitner"	"Isamu"
"d003"	"Human Resources"	110183	"Ossenbruggen"	"Shirish"
*/
SELECT departments.dept_no As "Department Number", departments.dept_name As "Department Name",
	dept_manager.emp_no AS "Manager Employee Number", employees.last_name AS "Last Name",
	employees.first_name AS "First Name"
FROM departments
	JOIN dept_manager ON (dept_manager.dept_no = departments.dept_no)
		JOIN employees ON (dept_manager.emp_no = employees.emp_no);

/*
List the department number for each employee along with that employee’s employee number, 
last name, first name, and department name

ANSWER (Top 5)
"d005"	"Development"			10001	"Facello"	"Georgi"
"d003"	"Human Resources"		10005	"Maliniak"	"Kyoichi"
"d004"	"Production"			10010	"Piveteau"	"Duangkaew"
"d006"	"Quality Management"	10010	"Piveteau"	"Duangkaew"
"d009"	"Customer Service"		10011	"Sluis"		"Mary"
*/
SELECT departments.dept_no As "Department Number", departments.dept_name As "Department Name",
	dept_emp.emp_no AS "Employee Number", employees.last_name AS "Last Name",
	employees.first_name AS "First Name" 
FROM departments
	JOIN dept_emp ON (dept_emp.dept_no = departments.dept_no)
		JOIN employees ON (dept_emp.emp_no = employees.emp_no);

/*
List first name, last name, and sex of each employee whose first name is Hercules and whose last 
name begins with the letter B

ANSWER (Top 5)
"Hercules"	"Baer"		"M"
"Hercules"	"Biron"		"F"
"Hercules"	"Birge"		"F"
"Hercules"	"Berstel"	"F"
"Hercules"	"Bernatsky"	"M"
*/
SELECT first_name AS "First Name", last_name AS "Last Name", sex AS "Gender"
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

/*
List each employee in the Sales department, including their employee number, 
last name, and first name

ANSWER (Top 5)
10002	"Simmel"		"Bezalel"
10016	"Cappelletti"	"Kazuhito"
10034	"Swan"			"Bader"
10041	"Lenart"		"Uri"
10050	"Dredge"		"Yinghua"
*/
SELECT employees.emp_no AS "Employee Number", employees.last_name AS "Last Name", 
	employees.first_name AS "First Name"
FROM employees
	JOIN dept_emp ON (dept_emp.emp_no = employees.emp_no)
		JOIN departments ON (departments.dept_no = dept_emp.dept_no)
WHERE departments.dept_name = 'Sales';

/*
List each employee in the Sales and Development departments, including their 
employee number, last name, first name, and department name 

ANSWER (Top 5)
10001	"Facello"	"Georgi"	"Development"
10002	"Simmel"	"Bezalel"	"Sales"
10006	"Preusig"	"Anneke"	"Development"
10008	"Kalloufi"	"Saniya"	"Development"
10012	"Bridgland"	"Patricio"	"Development"
*/
SELECT employees.emp_no AS "Employee Number", employees.last_name AS "Last Name", 
	employees.first_name AS "First Name", departments.dept_name AS "Department"
FROM employees
	JOIN dept_emp ON (dept_emp.emp_no = employees.emp_no)
		JOIN departments ON (departments.dept_no = dept_emp.dept_no)
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

/*
List the frequency counts, in descending order, of all the employee last names 
(that is, how many employees share each last name)

ANSWER (Top 5)
"Baba"		226
"Coorg"		223
"Gelosh"	223
"Farris"	222
"Sudbeck"	222
*/
SELECT last_name AS "Last Name", COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC; 