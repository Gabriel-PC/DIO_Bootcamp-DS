use azure_company;

insert into employee(Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Dno)
					 values ('John', 'B', 'Smith', 123456789, '1965-01-09', 'Fondren, Houston, Texas 731, Estados Unidos', 'M', 30000, 5), -- 333445555, 
							('Franklin', 'T', 'Wong', 333445555, '1955-12-08', 'Voss, Houston, Texas 638, Estados Unidos', 'M', 40000, 5), -- 888665555, 
                            ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', 'Castle, Spring, Texas 3321, Estados Unidos', 'F', 25000, 4), -- 987654321, 
                            ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', 'Berry, Bellaire, Texas 291, Estados Unidos', 'F', 43000, 4), -- 888665555, 
                            ('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', 'Fire Oak, Humble, Texas 975, Estados Unidos', 'M', 38000,5), --  333445555, 
                            ('Joyce', 'A', 'English', 453453453, '1972-07-31', 'Rice, Houston, Texas 5631, Estados Unidos', 'F', 25000, 5), -- 333445555, 
                            ('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', 'Dallas, Houston, Texas 980, Estados Unidos', 'M', 25000, 4), -- 987654321, 
                            ('James', 'E', 'Borg', 888665555, '1937-11-10', 'Stone, Houston, Texas 450, Estados Unidos', 'M', 55000, 1); -- NULL, 
-- erro (`azure_company`.`employee`, CONSTRAINT `fk_employee` FOREIGN KEY (`Super_ssn`) REFERENCES `employee` (`Ssn`) ON DELETE SET NULL ON UPDATE CASCADE)

-- Desligando o safe update
SET SQL_SAFE_UPDATES=0;

-- Atualizar os registros com os valores corretos para Super_ssn
UPDATE employee
SET Super_ssn = 333445555 WHERE Ssn = 123456789;
UPDATE employee
SET Super_ssn = 888665555 WHERE Ssn = 333445555;
UPDATE employee
SET Super_ssn = 987654321 WHERE Ssn = 999887777;
UPDATE employee
SET Super_ssn = 888665555 WHERE Ssn = 987654321;
UPDATE employee
SET Super_ssn = 333445555 WHERE Ssn = 666884444;
UPDATE employee
SET Super_ssn = 333445555 WHERE Ssn = 453453453;
UPDATE employee
SET Super_ssn = 987654321 WHERE Ssn = 987987987;
UPDATE employee
SET Super_ssn = NULL WHERE Ssn = 888665555;

insert into dependent values (333445555, 'Alice', 'F', '1986-04-05', 'Daughter'),
							 (333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
                             (333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
                             (987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
                             (123456789, 'Michael', 'M', '1988-01-04', 'Son'),
                             (123456789, 'Alice', 'F', '1988-12-30', 'Daughter'),
                             (123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse');

insert into departament values ('Research', 5, 333445555, '1988-05-22','1986-05-22'),
							   ('Administration', 4, 987654321, '1995-01-01','1994-01-01'),
                               ('Headquarters', 1, 888665555,'1981-06-19','1980-06-19');

insert into dept_locations values (1, 'Houston, Texas, Estados Unidos'),
								 (4, 'Stafford, Texas, Estados Unidos'),
                                 (5, 'Bellaire, Texas, Estados Unidos'),
                                 (5, 'Sugar Land, Texas, Estados Unidos'),
                                 (5, 'Houston, Texas, Estados Unidos');

insert into project values ('ProductX', 1, 'Bellaire, Texas, Estados Unidos', 5),
						   ('ProductY', 2, 'Sugar Land, Texas, Estados Unidos', 5),
						   ('ProductZ', 3, 'Houston, Texas, Estados Unidos', 5),
                           ('Computerization', 10, 'Stafford, Texas, Estados Unidos', 4),
                           ('Reorganization', 20, 'Houston, Texas, Estados Unidos', 1),
                           ('Newbenefits', 30, 'Stafford, Texas, Estados Unidos', 4)
;

insert into works_on values (123456789, 1, 32.5),
							(123456789, 2, 7.5),
                            (666884444, 3, 40.0),
                            (453453453, 1, 20.0),
                            (453453453, 2, 20.0),
                            (333445555, 2, 10.0),
                            (333445555, 3, 10.0),
                            (333445555, 10, 10.0),
                            (333445555, 20, 10.0),
                            (999887777, 30, 30.0),
                            (999887777, 10, 10.0),
                            (987987987, 10, 35.0),
                            (987987987, 30, 5.0),
                            (987654321, 30, 20.0),
                            (987654321, 20, 15.0),
                            (888665555, 20, 0.0);

-- Consultas SQL

select * from employee;
select Ssn, count(Essn) from employee e, dependent d where (e.Ssn = d.Essn) group by Ssn;
select * from dependent;

SELECT Bdate, Address FROM employee
WHERE Fname = 'John' AND Minit = 'B' AND Lname = 'Smith';

select * from departament where Dname = 'Research';

SELECT Fname, Lname, Address
FROM employee, departament
WHERE Dname = 'Research' AND Dnumber = Dno;

select * from project;
--
--
--
-- Expressões e concatenação de strings
--
--
-- recuperando informações dos departamentos presentes em Stafford
select Dname as Department, Mgr_ssn as Manager from departament d, dept_locations l
where d.Dnumber = l.Dnumber;

-- padrão sql -> || no MySQL usa a função concat()
select Dname as Department, concat(Fname, ' ', Lname) from departament d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

-- recuperando info dos projetos em Stafford
select * from project, departament where Dnum = Dnumber and Plocation = 'Stafford';

-- recuperando info sobre os departamentos e projetos localizados em Stafford
SELECT Pnumber, Dnum, Lname, Address, Bdate
FROM project, departament, employee
WHERE Dnum = Dnumber AND Mgr_ssn = Ssn AND
Plocation = 'Stafford';

SELECT * FROM employee WHERE Dno IN (3,6,9);

--
--
-- Operadores lógicos
--
--

SELECT Bdate, Address
FROM EMPLOYEE
WHERE Fname = ‘John’ AND Minit = ‘B’ AND Lname = ‘Smith’;

SELECT Fname, Lname, Address
FROM EMPLOYEE, DEPARTaMENT
WHERE Dname = 'Research' AND Dnumber = Dno;

--
--
-- Expressões e alias
--
--

-- recolhendo o valor do INSS-*
select Fname, Lname, Salary, Salary*0.011 from employee;
select Fname, Lname, Salary, Salary*0.011 as INSS from employee;
select Fname, Lname, Salary, round(Salary*0.011,2) as INSS from employee;

-- definir um aumento de salário para os gerentes que trabalham no projeto associado ao ProdutoX
select e.Fname, e.Lname, 1.1*e.Salary as increased_sal from employee as e,
works_on as w, project as p where e.Ssn = w.Essn and w.Pno = p.Pnumber and p.Pname='ProductX';

-- concatenando e fornecendo alias
select Dname as Department, concat(Fname, ' ', Lname) as Manager from departament d, dept_locations l, employee e
where d.Dnumber = l.Dnumber and Mgr_ssn = e.Ssn;

-- recuperando dados dos empregados que trabalham para o departamento de pesquisa
select Fname, Lname, Address from employee, departament
	where Dname = 'Research' and Dnumber = Dno;

-- definindo alias para legibilidade da consulta
select e.Fname, e.Lname, e.Address from employee e, departament d
	where d.Dname = 'Research' and d.Dnumber = e.Dno;