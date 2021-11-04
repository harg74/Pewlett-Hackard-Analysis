
-- DELIVERABLE 1
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
WHERE (emp.birth_date NOT BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no ASC

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


--DELIVERABLE 2
-- 1. Mentorship elegibility
SELECT COUNT(DISTINCT ON (e.emp_no)) e.emp_no,
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

--****ADDITIONAL QUERIES****

SELECT count (title), title
FROM mentorship_elegibility AS me
GROUP BY me.title
ORDER BY count DESC

SELECT emp.emp_no,
	emp.first_name,
	emp.last_name,
	ti.title,
	ti.from_date,
	ti.to_date

INTO not_retirement_titles

FROM employees as emp
LEFT JOIN title as ti
ON (emp.emp_no=ti.emp_no)
WHERE (emp.birth_date NOT BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp.emp_no ASC

SELECT DISTINCT ON (nrt.emp_no) nrt.emp_no,
    nrt.first_name, nrt.last_name, nrt.title

INTO nr_unique_titles

FROM not_retirement_titles as nrt
ORDER BY nrt.emp_no, nrt.to_date DESC;


--NOT RETIRING TITLES
SELECT COUNT(nrut.title),title

INTO nr_retiring_titles

FROM nr_unique_titles as nrut
GROUP BY nrut.title
ORDER BY count DESC;

SELECT * FROM nr_retiring_titles


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






