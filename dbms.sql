CREATE DATABASE STUDENTRECORDS_DB;
USE STUDENTRECORDS_DB;

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(100)
);
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT
);
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
CREATE TABLE Faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
INSERT INTO Students (first_name, last_name, phone, address) VALUES
('Anil', 'Sharma', '9841234567', 'Kathmandu, Nepal'),
('Sunita', 'Bhandari', '9812345678', 'Pokhara, Nepal'),
('Rajesh', 'Gupta', '9807654321', 'Bihar, India'),
('Sneha', 'Koirala', '9841122334', 'Lalitpur, Nepal'),
('Arjun', 'Singh', '9811122233', 'Delhi, India'),
('Sita', 'Thapa', '9845566778', 'Chitwan, Nepal'),
('Manoj', 'Pandey', '9803344556', 'Varanasi, India'),
('Deepa', 'Rai', '9814455667', 'Dharan, Nepal'),
('Ramesh', 'Yadav', '9846677889', 'Birgunj, Nepal'),
('Kiran', 'Joshi', '9809988776', 'Mumbai, India');

INSERT INTO Courses (course_name, credits) VALUES
('Mathematics', 4),
('Physics', 3),
('Chemistry', 4),
('Biology', 3),
('Computer Science', 5),
('Economics', 3),
('History', 3),
('Literature', 4),
('Psychology', 3),
('Sociology', 3);

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-15'),
(2, 3, '2024-01-16'),
(3, 5, '2024-01-17'),
(4, 2, '2024-01-18'),
(5, 4, '2024-01-19'),
(6, 6, '2024-01-20'),
(7, 7, '2024-01-21'),
(8, 8, '2024-01-22'),
(9, 9, '2024-01-23'),
(10, 10, '2024-01-24');

INSERT INTO Grades (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(2, 3, 'B'),
(3, 5, 'A'),
(4, 2, 'C'),
(5, 4, 'B'),
(6, 6, 'A'),
(7, 7, 'C'),
(8, 8, 'B'),
(9, 9, 'A'),
(10, 10, 'B');

INSERT INTO Departments (department_name) VALUES
('Science'),
('Arts'),
('Commerce'),
('Engineering'),
('Medicine'),
('Law'),
('Education'),
('Agriculture'),
('Management'),
('Tourism');

INSERT INTO Faculty (faculty_name, department_id) VALUES
('Dr. Ram Acharya', 1),
('Dr. Anjali Khadka', 2),
('Prof. Rajiv Verma', 4),
('Dr. Suresh Singh', 3),
('Dr. Meena Joshi', 5),
('Dr. Bishnu Tiwari', 6),
('Prof. Rekha Adhikari', 7),
('Dr. Prakash Yadav', 8),
('Prof. Ramesh Thapa', 9),
('Dr. Sudha Shrestha', 10);

-- inner join
SELECT Students.first_name, Students.last_name, Courses.course_name, Grades.grade
FROM Students
INNER JOIN Grades ON Students.student_id = Grades.student_id
INNER JOIN Courses ON Grades.course_id = Courses.course_id;

 -- left join
SELECT Students.first_name, Students.last_name, Courses.course_name
FROM Students
LEFT JOIN Enrollments ON Students.student_id = Enrollments.student_id
LEFT JOIN Courses ON Enrollments.course_id = Courses.course_id;

-- right join
SELECT Faculty.faculty_name, Departments.department_name
FROM Faculty
RIGHT JOIN Departments ON Faculty.department_id = Departments.department_id;

-- full outer join
SELECT Students.first_name, Courses.course_name
FROM Students
LEFT JOIN Enrollments ON Students.student_id = Enrollments.student_id
LEFT JOIN Courses ON Enrollments.course_id = Courses.course_id
UNION
SELECT Students.first_name, Courses.course_name
FROM Students
RIGHT JOIN Enrollments ON Students.student_id = Enrollments.student_id
RIGHT JOIN Courses ON Enrollments.course_id = Courses.course_id;

-- selection operation
SELECT * FROM Students WHERE address LIKE '%Nepal';

-- projection operation
SELECT first_name, last_name, phone FROM Students;

-- cross product operation
SELECT * FROM Students CROSS JOIN Courses;

-- cartesian product using UNION 
SELECT first_name as NAME FROM Students 
WHERE address LIKE '%Nepal'
UNION
SELECT faculty_name as NAME FROM FACULTY ;

-- selction 
SELECT *FROM STudents WHERE address LIKE '%Nepal';

-- projection
SELECT first_name, last_name, phone FROM Students;
-- specific querying
SELECT first_name, last_name FROM Students s
WHERE EXISTS (
    SELECT 1 FROM Enrollments e WHERE e.student_id = s.student_id AND e.course_id = 5
);
 
 -- unnormalized form
CREATE TABLE Unnormalized (
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    courses VARCHAR(255), 
    grades VARCHAR(255) 
);
INSERT INTO Unnormalized (student_id, first_name, last_name, courses, grades)
 VALUES
(1, 'Anil', 'Sharma', 'Mathematics, Physics', 'A, B'),
(2, 'Sunita', 'Bhandari', 'Chemistry, Biology', 'C, A');

-- 1nf form
CREATE TABLE Students_1NF (
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    course_name VARCHAR(100),
    grade CHAR(2),
    PRIMARY KEY (student_id, course_name)
);

INSERT INTO Students_1NF (student_id, first_name, last_name, course_name, grade)
 VALUES
(1, 'Anil', 'Sharma', 'Mathematics', 'A'),
(1, 'Anil', 'Sharma', 'Physics', 'B'),
(2, 'Sunita', 'Bhandari', 'Chemistry', 'C'),
(2, 'Sunita', 'Bhandari', 'Biology', 'A');

-- 2nf form
CREATE TABLE Students_2NF (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
INSERT INTO Students_2NF (student_id, first_name, last_name) VALUES
(1, 'Anil', 'Sharma'),
(2, 'Sunita', 'Bhandari');

CREATE TABLE Enrollments_2NF (
    student_id INT,
    course_name VARCHAR(100),
    grade CHAR(2),
    PRIMARY KEY (student_id, course_name),
    FOREIGN KEY (student_id) REFERENCES Students_2NF(student_id)
);
INSERT INTO Enrollments_2NF (student_id, course_name, grade) VALUES
(1, 'Mathematics', 'A'),
(1, 'Physics', 'B'),
(2, 'Chemistry', 'C'),
(2, 'Biology', 'A');


-- 3nf form
CREATE TABLE Students_3NF (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
CREATE TABLE Courses_3NF (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);
CREATE TABLE Enrollments_3NF (
    student_id INT,
    course_id INT,
    grade CHAR(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students_3NF(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses_3NF(course_id)
);

INSERT INTO Students_3NF (student_id, first_name, last_name) 
VALUES (1, 'Anil', 'Sharma'), (2, 'Sunita', 'Bhandari');
INSERT INTO Courses_3NF (course_id, course_name) 
VALUES (1, 'Mathematics'), (2, 'Physics'), (3, 'Chemistry'), (4, 'Biology');
INSERT INTO Enrollments_3NF (student_id, course_id, grade) 
VALUES (1, 1, 'A'), (1, 2, 'B'), (2, 3, 'C'), (2, 4, 'A');

-- transaction processes

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction_error`()
BEGIN
    START TRANSACTION;
    UPDATE Grades SET grade = 'B' WHERE student_id = 1 AND course_id = 1;

    UPDATE Grades SET grade = 'A' WHERE student_id = 999 AND course_id = 1;
    -- Commit transaction (will not be reached if error occurs)
    COMMIT;
END $$
DELIMITER ;
;
CALL transaction_error();

-- without rollback
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction_success`()
BEGIN
    START TRANSACTION;
    UPDATE Grades SET grade = 'A' WHERE student_id = 1 AND course_id = 1;
    UPDATE Grades SET grade = 'B' WHERE student_id = 2 AND course_id = 3;
    COMMIT;
END $$
DELIMITER ;
CALL transaction_success();

-- with rollback
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction_with_commit_rollback`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Transaction failed, rollback executed' AS message;
    END;
    START TRANSACTION;
    UPDATE Students SET phone = 'ErrorPhoneNumber' WHERE student_id = 1;
    INSERT INTO Enrollments (student_id, course_id, enrollment_date)
    VALUES (1, 9999, '2024-02-01');
    COMMIT;
    SELECT 'Transaction successful, changes committed' AS message;
END $$
DELIMITER ;
CALL transaction_with_commit_rollback();

