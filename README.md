# Pewlett-Hackard-Analysis

## Overview of the analysis:

Due to the amount of people retiring, Pewlett-Hackard, needs to know the number of retiring employees per title and also to the employees who are eligible to participate in a mentorship program. In order to acomplish this, we used PostgreSQL and pgAdmin.

## Results:

#### 1) Retirement Titles table:

In order to get our first database we created a Retirement Titles table that holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955. So, we first:

- Retrieve the ```emp_no```, ```first_name```, and ```last_name``` columns from the Employees table
- Retrieve the ```title```, ```from_date```, and ```to_date``` columns from the Titles table
- Created a retirement_titles using the ```INTO``` clause
- We ```LEFT JOIN``` both tables on the primary key ```emp_no```
- Filtered the data on the ```birth_date``` column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number
- Finally, we exported the Retirement Titles table from the previous step as retirement_titles.csv 

![retirement_titles](https://user-images.githubusercontent.com/78564912/140099186-cea90dbd-9b23-40e5-923e-0e50eb2d95cf.png)

SEE FULL CODE:

```
-- 1. DATABASE 1: Retirement titles
SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	ti.title,
	ti.from_date,
	ti.to_date

--INTO retirement_titles

FROM employees as emp
LEFT JOIN title as ti
ON (emp.emp_no=ti.emp_no)
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no ASC
```

#### 2) Unique Titles table:

Since our previous table included duplicated entries for some employees because they have switched titles over the years, we used ```DISTINCT ON``` statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause, in this case ```emp_no```.

![unique_titles](https://user-images.githubusercontent.com/78564912/140174484-84572939-0790-4c3f-9f14-2979e92ddbf2.png)

SEE FULL CODE:

```
--2. DATABASE 2: Unique titles

--REMOVE DUPLICATES

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name, rt.last_name, rt.title

--INTO unique_titles

FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- 3. DATABASE 3: Retiring titles
SELECT COUNT(ut.title),title

--INTO retiring_titles

FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;

```

#### 3) Count Retiring Titles:

From our the unique tables we applied a ```COUNT``` to and a ```GROUP BY``` in order to get the total retiring titles, which give us an overwiew of the person that will be needed to be replaced.

![count](https://user-images.githubusercontent.com/78564912/140184223-0f7b9c51-14ac-425a-bff2-5406063734f3.png)

SEE FULL CODE:

```
SELECT COUNT(ut.title),title

--INTO retiring_titles

FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;

```

#### 4) Mentorship Eligibility table:

Finally, a table was created which holds the employees who are eligible to participate in a mentorship program.

For this we:

- Retrieved the ```emp_no```, ```first_name```, ```last_name```, and ```birth_date``` columns from the Employees table.
- Retrieved the ```from_date``` and ```to_date``` columns from the Department Employee table.
- Retrieved the ```title column``` from the Titles table.
- Used a ```DISTINCT ON``` statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
- Created mentor_elegibility table with the ```INTO``` clause.
- ```INNER JOIN``` the Employees and the Department Employee tables on the primary key, which is emp_no 
- ```INNER JOIN``` the Employees and the Titles tables on the primary key.
- Filtered the data on the ```to_date``` column to all the current employees, then filter the data on the ```birth_date``` columns to get all the employees whose birth dates are - between January 1, 1965 and December 31, 1965.
- Ordered the table by the employee number.
- Exported the Mentorship Eligibility table as mentorship_eligibilty.csv

![mentorship](https://user-images.githubusercontent.com/78564912/140182236-a028b086-be14-445f-9fc8-5a7baa86012b.png)

SEE FULL CODE:

```
-- 1. Mentorship elegibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title

--INTO mentorship_elegibility
	
FROM employees as e
	INNER JOIN dept_emp as de
		ON (e.emp_no=de.emp_no)
	INNER JOIN title as ti
		ON(e.emp_no=ti.emp_no)	
WHERE(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	 AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no 
```

## Summary:

After analyzing our retiring titles table we can conclude that around 90,000 employees that will be needed to be replaced, where the title or position 'Senior Engineer' is the position with the most persons to be replaced, representing 32.5% of the whole sample, whereas P&H will only repleace two Managers, representing 0.0002%.

By contrasting the count for the mentorship candidates vs. the count of persons to be leaving P&H (table 3 'Count Retiring Titles'), we can observe that the mentorship candidates are not enough to cover the retirements that will take place in a few months.

For example: 

For Senior Staff positions there a are only 569 candidates for the mentorship program and there will be leaving +29,000 people from this same positon. So we can conclude that H&P needs to begin a program for hiring external candidates to fill the positions soon.

On the other hand, H&P can consider to 'relax' in certain way the requirements for the mentorship programs and begin a internal recruitment (Internal Staff table below), since there are a lot of people and talent inside the company already that can be considered for the new job vacancies.

#### Count for the Mentorship Candidates

![mentor_count](https://user-images.githubusercontent.com/78564912/140241134-46e542a2-8be9-43e2-85a4-7a7317e9f865.png)

#### Count Retiring Titles Table

![count](https://user-images.githubusercontent.com/78564912/140241403-855914bc-7a85-401e-9692-9a4cf3cb36af.png)

#### Internal Staff table

![Internal_staff](https://user-images.githubusercontent.com/78564912/140242132-ae1f9afc-4ce0-43a6-82e2-6337cd20cbe0.png)
