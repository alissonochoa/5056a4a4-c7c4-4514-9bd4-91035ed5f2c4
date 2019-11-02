-- TUTORING EXERCISES
-- A) GET THE AVERAGE COURSE LENGHT (YEARS) OF THE DEPARTMENT OF STATISTICS
SELECT
    AVG(years)
FROM
    course c
WHERE
c.department = 'Statistics'
;

-- B) GET ALL COURSES WITH MORE THAN 15 APPROVED STUDENTS
SELECT
    count (*) AS "n_students", c.name
FROM
    enrollment e INNER JOIN course c on e.course_id = c.id
WHERE
    e.approved = 1
GROUP BY
    c.name
HAVING
    count(*) > 15
;

-- C) GET ALL COURSES WITH MORE THAN 15 FEMALE STUDENTS
SELECT
    count(s.gender),
    c.name
FROM
    student s INNER JOIN enrollment e on s.id = e.student_id INNER JOIN course c on e.course_id = c.id
WHERE
    gender = 'female' AND e.approved = 1
GROUP BY
    c.name
HAVING
    count(*) > 15
ORDER BY 1
;

-- D) GET THE AVERAGE AGE PER GENDER AND COURSE
SELECT
    AVG(age) AS "Average Age",
    c.name AS "Course Name",
    s.gender AS "Gender"
FROM
    student s INNER JOIN enrollment e on s.id = e.student_id INNER JOIN course c on e.course_id = c.id
WHERE
    e.approved = 1
GROUP BY
    c.name,
    s.gender

;





