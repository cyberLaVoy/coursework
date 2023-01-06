*******LAB05*******

--------------
SHOW tables
--------------
SELECT *
FROM authors
--------------
SELECT emp_id, emp_name
FROM employees
--------------
SELECT state
FROM publishers
--------------
SELECT title_id, title_name, price
FROM titles
ORDER BY price DESC
--------------
SELECT title_id, title_name, type
FROM titles
WHERE type='children'
--------------
SELECT title_id, title_name
FROM titles
WHERE type!='history' AND type!='biography'
--------------
SELECT au_id, au_fname, au_lname, phone
FROM authors
WHERE phone LIKE '%549%'
--------------
SELECT au_id, au_fname, au_lname, zip
FROM authors
WHERE zip BETWEEN 90000 AND 99999
--------------
SELECT au_id, au_fname, au_lname, state
FROM authors
WHERE state='NY' OR state='CA'



*******LAB06*******

--------------
SELECT title_id, title_name, price, "0.10" AS "discount", price*.9 AS "New Price"
FROM titles
--------------
SELECT CONCAT(au_lname, ", ", au_fname) AS "name"
FROM authors
--------------
SELECT CONCAT(UPPER(SUBSTR(au_lname, 1, 3)), SUBSTR(phone, 9, 4)) AS "Search ID", CONCAT(au_lname, ", ", au_fname) AS "name"
FROM authors
--------------
SELECT au_lname, LENGTH(au_lname) AS "length"
FROM authors
--------------
SELECT title_id, title_name, SUBSTR(pubdate, 1, 4) AS "year"
FROM titles
--------------
SELECT title_id, title_name, pubdate, DATE_ADD(pubdate, INTERVAL 28 YEAR) AS "copyright date"
FROM titles
--------------
SELECT title_id, title_name, price, IF (type="history", price*.9, price*.8) AS "New Price"
FROM titles
--------------
SELECT title_id, title_name, IF (price IS NULL, "priceless", price) AS "retail"
FROM titles
--------------
SELECT NOW() AS "Current Time"
--------------
SELECT SUBSTRING_INDEX(USER(), '@', -1)  AS "Server"



*******LAB07*******

--------------
SELECT ROUND(AVG(price), 2) AS 'Average Price'
FROM titles
--------------
SELECT COUNT(title_id) AS 'Qty'
FROM titles
--------------
SELECT SUM(sales*price) AS 'Volume'
FROM titles
--------------
SELECT type, ROUND(AVG(pages), 0) AS 'Average Pages'
FROM titles
GROUP BY type
--------------
SELECT type, ROUND(AVG(pages), 0) AS 'Average Pages'
FROM titles
GROUP BY type
HAVING AVG(pages) > 500
--------------
SELECT type, ROUND(AVG(pages), 0) AS 'Average Pages'
FROM titles
GROUP BY type
HAVING AVG(pages) > 500
ORDER BY AVG(pages) ASC
--------------
SELECT COUNT(DISTINCT state) AS 'Number of States'
FROM authors
--------------
SELECT state, COUNT(au_id) AS '# of Authors'
FROM authors
GROUP BY state
--------------
SELECT type, COUNT(title_id) AS '# of books'
FROM titles
GROUP BY type
HAVING type!='children'
--------------
SELECT type, COUNT(title_id) AS '# of books'
FROM titles
GROUP BY type
HAVING COUNT(title_id) >= 3
ORDER BY type



*******LAB08*******

--------------
SELECT titles.title_id, titles.title_name, publishers.pub_id, publishers.pub_name
FROM titles
LEFT JOIN publishers
ON titles.pub_id=publishers.pub_id
--------------
SELECT titles.title_id, titles.title_name, authors.au_lname
FROM (titles, authors)
INNER JOIN title_authors
ON titles.title_id=title_authors.title_id and authors.au_id=title_authors.au_id
--------------
SELECT titles.title_id, titles.title_name, publishers.pub_id, publishers.pub_name
FROM titles
LEFT JOIN publishers
ON titles.pub_id=publishers.pub_id
WHERE publishers.state='CA'
--------------
SELECT titles.type, COUNT(titles.type)
FROM titles
LEFT JOIN publishers
ON titles.pub_id=publishers.pub_id
WHERE publishers.state='CA'
GROUP BY titles.type
--------------
SELECT COUNT(emp_id) AS '# Employees', SUM(sales) AS 'Total Sales'
FROM empsales
--------------
SELECT COUNT(empsales.emp_id) AS '# Employees', SUM(sales) AS 'Total Sales'
FROM empsales
LEFT JOIN employees
ON empsales.emp_id=employees.emp_id
--------------
SELECT empsales.emp_id, employees.emp_name, empsales.sales
FROM employees
RIGHT JOIN empsales
ON employees.emp_id=empsales.emp_id
--------------
SELECT employees.emp_id, employees.emp_name, empsales.sales
FROM employees
LEFT JOIN empsales
ON employees.emp_id=empsales.emp_id
--------------
SELECT empsales.emp_id, employees.emp_name, empsales.sales
FROM employees
RIGHT JOIN empsales
ON employees.emp_id=empsales.emp_id
--------------
SELECT hier.emp_id, one.emp_name, hier.boss_id, two.emp_name
FROM hier
LEFT JOIN employees one
ON hier.emp_id = one.emp_id
LEFT JOIN employees two
ON  hier.boss_id = two.emp_id



*******LAB09*******

--------------
SELECT spj.jid
FROM spj
JOIN s ON s.sid=spj.sid
WHERE s.city = 'London'
--------------
SELECT jid
FROM spj
WHERE sid IN (SELECT sid
FROM s
WHERE city = 'London')
--------------
SELECT DISTINCT spj.jid
FROM spj
JOIN p ON p.pid=spj.pid
WHERE p.color = 'red'
--------------
SELECT DISTINCT jid
FROM spj
WHERE pid IN (SELECT pid
FROM p
WHERE color = 'red')
--------------
SELECT jid, pid, sid, qty
FROM spj
WHERE qty > (SELECT avg(qty)
FROM spj)
--------------
SELECT DISTINCT sid
FROM spj  AS spj1
WHERE NOT EXISTS
(SELECT *
FROM p
WHERE NOT EXISTS
(SELECT *
FROM spj  AS spj2
WHERE (spj1.sid = spj2.sid)
AND (spj2.pid = p.pid)))



*******LAB10*******

--------------
SELECT city from s
UNION
SELECT city from j
--------------
SELECT city from s
UNION
SELECT city from p
UNION
SELECT city from j
--------------
SELECT DISTINCT s.city
FROM s
INNER JOIN j
ON s.city = j.city
--------------
SELECT DISTINCT s.city
FROM s
INNER JOIN (p, j)
ON s.city = j.city and j.city = p.city and p.city = s.city
--------------
SELECT city from s
WHERE city NOT IN (SELECT city from p)
UNION
SELECT city from j
WHERE city NOT IN (SELECT city from p)



*******LAB11*******

--------------
INSERT INTO titles
(title_id,title_name,pub_id,price,contract)
VALUES
('T14','OCA','P02',29.95,1)
--------------
INSERT INTO titles
(title_id,title_name,pub_id,price,contract)
VALUES
('T15','OCP','P02',39.95,0)
--------------
INSERT INTO titles
(title_id,title_name,pub_id,price,contract)
VALUES
('T16','A+','P02',29.95,0)
--------------
INSERT INTO titles
(title_id,title_name,pub_id,price,contract)
VALUES
('T17','NET+','P02',29.95,0)
--------------
INSERT INTO titles
(title_id,title_name,pub_id,price,contract)
VALUES
('T18','LINUX+','P02',29.95,0)
--------------
INSERT INTO title_authors
VALUES
('T14', 'A05', 1, 1.00)
--------------
INSERT INTO title_authors
VALUES
('T15', 'A05', 1, 1.00)
--------------
INSERT INTO title_authors
VALUES
('T16', 'A05', 1, 1.00)
--------------
INSERT INTO title_authors
VALUES
('T17', 'A05', 1, 1.00)
--------------
INSERT INTO title_authors
VALUES
('T18', 'A05', 1, 1.00)
--------------
UPDATE titles
SET sales = 0
WHERE title_id in ('T14','T15','T16','T17','T18')
--------------
UPDATE titles
SET pubdate = '2011-01-01'
WHERE title_id in ('T14','T15','T16','T17','T18')
--------------
UPDATE titles
SET type = 'computer'
WHERE title_id in ('T14','T15','T16','T17','T18')
--------------
CREATE TABLE abc_authors AS
(SELECT * FROM authors
WHERE au_id IN (SELECT au_id FROM title_authors
WHERE title_id IN (SELECT title_id FROM titles
WHERE type = 'psychology')))
--------------
CREATE TABLE abc_titles AS
(SELECT * FROM titles
WHERE type ='psychology')
--------------
CREATE TABLE abc_publishers AS
(SELECT * FROM publishers
WHERE pub_id IN (SELECT pub_id FROM titles
WHERE type = 'psychology'))
--------------
CREATE TABLE abc_title_authors AS
(SELECT * FROM title_authors
WHERE title_id IN (SELECT title_id FROM titles
WHERE type = 'psychology'))
--------------
DELETE FROM titles
WHERE type = 'psychology'
--------------
DELETE FROM publishers
WHERE pub_id NOT IN (SELECT pub_id FROM titles)
--------------
DELETE FROM title_authors
WHERE title_id NOT IN (SELECT title_id FROM titles)
--------------
DELETE FROM authors
WHERE au_id NOT IN (SELECT au_id FROM title_authors)
--------------
UPDATE titles
SET price = price * .8
WHERE type = 'history'
--------------
select * from publishers
--------------
select * from authors
--------------
select * from title_authors
--------------
select * from titles
--------------
select * from abc_publishers
--------------
select * from abc_authors
--------------
select * from abc_title_authors
--------------
select * from abc_titles



*******LAB12*******

--------------
DROP TABLE TaxAreaAuthority
--------------
CREATE TABLE TaxAreaAuthority
(
tax_authority CHAR(8) NOT NULL,
tax_area CHAR(8) NOT NULL,
PRIMARY KEY (tax_authority, tax_area)
)
--------------
DROP TABLE TaxRates
--------------
CREATE TABLE TaxRates
(
tax_authority CHAR(8) NOT NULL,
effective DATE NOT NULL,
tax_rate DECIMAL(5,2) NOT NULL,
PRIMARY KEY (tax_authority, effective)
)
--------------
INSERT INTO TaxAreaAuthority VALUES ('city1','city1')
--------------
INSERT INTO TaxAreaAuthority VALUES ('city2','city2')
--------------
INSERT INTO TaxAreaAuthority VALUES ('city3','city3')
--------------
INSERT INTO TaxAreaAuthority VALUES ('county1','city1')
--------------
INSERT INTO TaxAreaAuthority VALUES ('county1','city2')
--------------
INSERT INTO TaxAreaAuthority VALUES ('county2','city3')
--------------
INSERT INTO TaxAreaAuthority VALUES ('state1','city1')
--------------
INSERT INTO TaxAreaAuthority VALUES ('state1','city2')
--------------
INSERT INTO TaxAreaAuthority VALUES ('state1','city3')
--------------
INSERT INTO TaxRates VALUES ('city1','1993-01-01','1')
--------------
INSERT INTO TaxRates VALUES ('city1','1994-01-01','1.5')
--------------
INSERT INTO TaxRates VALUES ('city2','1993-09-01','1.5')
--------------
INSERT INTO TaxRates VALUES ('city2','1994-01-01','2')
--------------
INSERT INTO TaxRates VALUES ('city2','1995-01-01','2.5')
--------------
INSERT INTO TaxRates VALUES ('city3','1993-01-01','1.9')
--------------
INSERT INTO TaxRates VALUES ('city3','1993-07-01','2.3')
--------------
INSERT INTO TaxRates VALUES ('county1','1993-01-01','2.3')
--------------
INSERT INTO TaxRates VALUES ('county1','1994-10-01','2.5')
--------------
INSERT INTO TaxRates VALUES ('county1','1995-01-01','2.7')
--------------
INSERT INTO TaxRates VALUES ('county2','1993-01-01','2.4')
--------------
INSERT INTO TaxRates VALUES ('county2','1994-01-01','2.7')
--------------
INSERT INTO TaxRates VALUES ('county2','1995-01-01','2.8')
--------------
INSERT INTO TaxRates VALUES ('state1','1993-01-01','0.5')
--------------
INSERT INTO TaxRates VALUES ('state1','1994-01-01','0.8')
--------------
INSERT INTO TaxRates VALUES ('state1','1994-07-01','0.9')
--------------
INSERT INTO TaxRates VALUES ('state1','1994-10-01','1.1')
--------------
SELECT tax_authority AS 'city2 is in the following county:'
FROM TaxAreaAuthority
WHERE tax_area ='city2' and tax_authority LIKE 'county%'
--------------
SELECT tax_authority AS 'city2 is in the following state:'
FROM TaxAreaAuthority
WHERE tax_area ='city2' and tax_authority LIKE 'state%'
--------------
SELECT @city_rate := tax_rate
FROM TaxRates
WHERE tax_authority = 'city2' and effective <= '1994-11-01'
ORDER BY effective DESC
LIMIT 1
--------------
SELECT @county_rate := tax_rate
FROM TaxRates
WHERE effective <='1994-11-01' AND tax_authority IN (SELECT tax_authority
FROM TaxAreaAuthority
WHERE tax_area ='city2' and tax_authority LIKE 'county%')
ORDER BY effective DESC
LIMIT 1
--------------
SELECT @state_rate := tax_rate
FROM TaxRates
WHERE effective <='1994-11-01' AND tax_authority IN (SELECT tax_authority
FROM TaxAreaAuthority
WHERE tax_area ='city2' and tax_authority LIKE 'state%')
ORDER BY effective DESC
LIMIT 1
--------------
SELECT ROUND(@city_rate + @county_rate + @state_rate, 2) AS 'Tax rate for city2 on Nov 1 1994:'



*******SQL_SECURITY*******

--------------
DROP TABLE payroll
--------------
CREATE TABLE payroll
(
dept SMALLINT,
manager CHAR(1),
name VARCHAR(30),
birth_date DATE,
salary INT
)
--------------
INSERT INTO payroll VALUES ('1','Y','BOB','1981/01/01','50000')
--------------
INSERT INTO payroll VALUES ('1','N','BILL','1982/02/02','40000')
--------------
INSERT INTO payroll VALUES ('1','N','BOYD','1983/03/03','70000')
--------------
INSERT INTO payroll VALUES ('2','Y','JIM','1984/04/04','40000')
--------------
INSERT INTO payroll VALUES ('2','N','JANET','1985/05/05','50000')
--------------
INSERT INTO payroll VALUES ('2','N','JACK','1986/06/06','60000')
--------------
INSERT INTO payroll VALUES ('3','Y','MARY','1987/07/07','50000')
--------------
INSERT INTO payroll VALUES ('3','N','MARTHA','1988/08/08','70000')
--------------
INSERT INTO payroll VALUES ('3','N','MARTY','1989/09/09','90000')
--------------
DROP USER 'BOB'@'localhost'
--------------
DROP USER 'BILL'@'localhost'
--------------
DROP USER 'BOYD'@'localhost'
--------------
DROP USER 'JIM'@'localhost'
--------------
DROP USER 'JANET'@'localhost'
--------------
DROP USER 'JACK'@'localhost'
--------------
DROP USER 'MARY'@'localhost'
--------------
DROP USER 'MARTHA'@'localhost'
--------------
DROP USER 'MARTY'@'localhost'
--------------
CREATE USER 'BOB'@'localhost' IDENTIFIED BY 'password'
--------------
CREATE USER 'BILL'@'localhost' IDENTIFIED BY 'password'
--------------
CREATE USER 'BOYD'@'localhost' IDENTIFIED BY 'password'
--------------
CREATE USER 'JIM'@'localhost' IDENTIFIED BY 'password'
--------------
CREATE USER 'JANET'@'localhost' IDENTIFIED BY 'password'
--------------
CREATE USER 'JACK'@'localhost' IDENTIFIED BY 'password'
--------------
CREATE USER 'MARY'@'localhost' IDENTIFIED BY 'password'
--------------
CREATE USER 'MARTHA'@'localhost' IDENTIFIED BY 'password'
--------------
CREATE USER 'MARTY'@'localhost' IDENTIFIED BY 'password'
--------------
GRANT SELECT (dept, manager, name, birth_date, salary) ON flame_company.payroll TO 'BOB'@'localhost'
--------------
GRANT SELECT (dept, manager, name, birth_date) ON flame_company.payroll TO 'BILL'@'localhost'
--------------
GRANT SELECT (dept, manager, name, birth_date) ON flame_company.payroll TO 'BOYD'@'localhost'
--------------
GRANT SELECT (dept, manager, name, birth_date, salary) ON flame_company.payroll TO 'JIM'@'localhost'
--------------
GRANT SELECT (dept, manager, name, birth_date) ON flame_company.payroll TO 'JANET'@'localhost'
--------------
GRANT SELECT (dept, manager, name, birth_date) ON flame_company.payroll TO 'JACK'@'localhost'
--------------
GRANT ALL ON flame_company.payroll TO 'MARY'@'localhost'
--------------
GRANT SELECT (dept, manager, name, birth_date, salary), UPDATE (birth_date) ON flame_company.payroll TO 'MARTHA'@'localhost'
--------------
GRANT SELECT (dept, manager, name, birth_date) ON flame_company.payroll TO 'MARTY'@'localhost'
--------------
SHOW GRANTS FOR 'BOB'@'localhost'
--------------
SHOW GRANTS FOR 'BILL'@'localhost'
--------------
SHOW GRANTS FOR 'BOYD'@'localhost'
--------------
SHOW GRANTS FOR 'JIM'@'localhost'
--------------
SHOW GRANTS FOR 'JANET'@'localhost'
--------------
SHOW GRANTS FOR 'JACK'@'localhost'
--------------
SHOW GRANTS FOR 'MARY'@'localhost'
--------------
SHOW GRANTS FOR 'MARTHA'@'localhost'
--------------
SHOW GRANTS FOR 'MARTY'@'localhost'
--------------
DROP USER 'BOB'@'localhost'
--------------
DROP USER 'BILL'@'localhost'
--------------
DROP USER 'BOYD'@'localhost'
--------------
DROP USER 'JIM'@'localhost'
--------------
DROP USER 'JANET'@'localhost'
--------------
DROP USER 'JACK'@'localhost'
--------------
DROP USER 'MARY'@'localhost'
--------------
DROP USER 'MARTHA'@'localhost'
--------------
DROP USER 'MARTY'@'localhost'



