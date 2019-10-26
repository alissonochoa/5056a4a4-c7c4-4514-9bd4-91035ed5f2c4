/*
 SECTION: Group exercises
 DESCRIPTION: Write a valid SQL query to solve each problem.
 */


-- A) Get all the unique department names.
SELECT DISTINCT department FROM course;

-- B) Get the top 10 female students (first_name, last_name, age, gpa) with the best GPA scores and order by age (asc).
SELECT
	first_name AS "First Name", -- "renombrar", 'cadenas de texto'
	last_name AS "Last Name",
	age AS "Age",
	gpa AS "GPA"
FROM
	student
WHERE
	gender = 'female'
ORDER BY
	gpa DESC, --descendiente
	age ASC,
	first_name ASC,
	last_name ASC
LIMIT 10 -- solo 10 personas
;

-- C) Count the number of male/female students that are at least 25 years old.
SELECT
	gender AS "Gender",
	count(gender) AS "Count" -- para que funciones tiene que haber un GROUP BY
FROM
	student
WHERE
	age >= 25
GROUP BY gender
;

-- D) Get the number of male/female students that were accepted
SELECT
    gender,
    count(gender)
FROM
    student INNER JOIN enrollment ON student.id = enrollment.student_id -- INNER JOIN = product cartesiano
WHERE
    enrollment.approved = 1
GROUP BY
    gender
;
-- E) Get the min, average, and max GPA of the accepted male students that are less than 20 years old.
SELECT
    MIN(gpa),
    AVG(gpa),
    MAX(gpa)
FROM
    student INNER JOIN enrollment ON student.id = enrollment.student_id
WHERE
    enrollment.approved = 1
    AND student.gender = 'male'
;
-- F) Get the number of enrollments to courses that take longer than 2 years to finalize.

-- G) Get the number of male/female student that will take a course from the 'Statistics' department.


/*
 SECTION: Individual exercises
 DESCRIPTION: Write a valid SQL query to solve each problem.
 */

-- A) Count the number of courses per department

-- B) How many male/female students were accepted?

-- C) How many students were accepted per course?

-- D) What's the average age and gpa per course?

-- E) Get the average number of years the enrolled (approved) female student will study.

