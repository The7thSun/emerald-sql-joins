CREATE TABLE "cohort" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(30),
	"start_date" DATE
	);
	
CREATE TABLE "student" (
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(80) NOT NULL,
	"cohort_id" INT REFERENCES "cohort"
	);
	
INSERT INTO "cohort" ("name", "start_date")
VALUES ('Emerald', '6/6/2023'), ('Deneb', '10/3/2017'), ('Diamond', '4/30/2023');

INSERT INTO "student" ("name", "cohort_id")
VALUES ('Sam', 1), ('Zach', 1), ('Emma', 2), ('Steven', 3);

SELECT * from "cohort";

SELECT * from "student";

-- Get back information about students and cohorts together!
-- A JOIN makes it possible for us to view student data and cohort data together
SELECT * from "student"
JOIN "cohort" ON "cohort"."id" = "student".cohort_id;

-- Both of these are valid! 

-- SELECT * FROM "many"
-- JOIN "one" ON "one"."id" = "many"."one_id";

-- SELECT * FROM "one"
-- JOIN "many" ON "many"."one_id" = "one"."id";

-- This won't work! "name" is ambiguous
SELECT "name", "start_date" FROM "cohort"
JOIN "student" ON "cohort"."id" = "student"."cohort_id";

-- We need to specify which table the "name" column should come from
SELECT "cohort"."name", "student"."name" FROM "cohort"
JOIN "student" ON "cohort"."id" = "student"."cohort_id";

-- We can use aliases to name the columns we get back
SELECT "cohort"."name" AS "cohort_name", "student"."name" AS "student_name" FROM "cohort"
JOIN "student" ON "cohort"."id" = "student"."cohort_id";

-- Select all the students from Emerald
SELECT * FROM "cohort"
JOIN "student" ON "cohort"."id" = "student"."cohort_id"
WHERE "cohort"."name" LIKE 'Emerald';

-- count all students with the aggregate function count
SELECT count(*) FROM "student";

-- count all students in a cohort
SELECT count(*) FROM "student"
JOIN "cohort" ON "cohort"."id" = "student"."cohort_id"
WHERE "cohort"."name" LIKE 'Emerald';

--MAX: If we had an age column student, we could find the student
-- with the highest age
SELECT MAX("student"."age") from "student";

-- MAX: Find the most recent date
SELECT MAX("start_date") from "cohort";

-- MIN: Find the oldest date
SELECT MIN("start_date") FROM "cohort";

-- Other useful aggregate functions: AVG, SUM
-- SUM will add selected fields together
SELECT SUM("id") FROM "student";

SELECT AVG("id") FROM "student";

-- Count all students in a cohort and group by cohort name
SELECT "cohort"."name", count(*) FROM "student"
JOIN "cohort" ON "cohort"."id" = "student"."cohort_id"
GROUP BY "cohort"."name"
ORDER BY count DESC;

-- Insert a cohort with no students (needed for following examples)
INSERT INTO "cohort" ("name", "start_date") VALUES ('Iolite', '07/10/2023');

-- Insert a student without a cohort (needed for following examples)
INSERT INTO "student" ("name") VALUES 'Holly';

-- INNER JOIN: Get back all students with a cohort AND all cohorts with students
SELECT "cohort"."name" AS "cohort_name", "student"."name" AS "student_name" FROM "student"
JOIN "cohort" ON "cohort"."id" = "student"."cohort_id";

-- LEFT JOIN: Get back everything from the FROM table, and matching things from the JOIN table
-- (All students, plus cohorts with students)
SELECT "cohort"."name" AS "cohort_name", "student"."name" AS "student_name" FROM "student"
LEFT JOIN "cohort" ON "cohort"."id" = "student"."cohort_id";

-- RIGHT JOIN: Get back matching things from the FROM table, and everything from the JOIN table
-- (Students with a cohort, plus all cohorts)
SELECT "cohort"."name" AS "cohort_name", "student"."name" AS "student_name" FROM "student"
RIGHT JOIN "cohort" ON "cohort"."id" = "student"."cohort_id";

-- FULL OUTER JOIN: Get back all things from the FROM table and all things from the JOIN table
SELECT "cohort"."name" AS "cohort_name", "student"."name" AS "student_name" FROM "student"
FULL OUTER JOIN "cohort" ON "cohort"."id" = "student"."cohort_id";
