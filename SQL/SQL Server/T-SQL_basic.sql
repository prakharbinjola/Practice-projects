select FirstName, DateOfJoining
from tbl_Employees
where  EmpID = 115;



--CONCATENATION

select FirstName + ' ' + LastName as EmpName
from tbl_Employees;



--NULL + ANYTHING = NULL

select FirstName + ' ' + isnull(LastName, '') as EmpName,
Salary * 12 AnnualSalary           --as keyword not necessary
from tbl_Employees
where Salary * 12 >= 500000;       --where is executed before select; can't pass alias name in where



--TOP KEYWORD

select Top 5 *
from tbl_Employees;
select Top 10 percent *
from tbl_Employees;



--DISTINCT KEYWORD

select distinct Department
from tbl_Employees;



--OPERATORS
--ARITHMETIC

select *
from tbl_Employees
where Salary <> 50000;             --<> is same as !=

--LOGICAL

select *
from tbl_Employees
where Salary > 50000 and Department = 30; 

--SPECIAL

select *
from tbl_Employees
where FirstName in ('Anadi', 'Raj', 'Ajay');

select *
from tbl_Employees
where Salary between 40000 and 60000;              --both values inclusive

select *
from tbl_Employees
where EmailId like '%gmail%';

select *
from tbl_Employees
where LastName is null;



--ORDER BY

select FirstName, LastName, Salary
from tbl_Employees
order by 2 desc;                  --defaut asc

select FirstName, LastName, Salary * 12 as AnnualSalary
from tbl_Employees
order by AnnualSalary desc, FirstName asc;                  --order by is executed after select; can pass alias name in order by



--SUBQUERIES OR INNERQUERIES OR NESTEDQUERIES                 Used when comparing to an unknown value
--SINGLE ROW SUBQUERY
select *
from tbl_Employees
where Salary >
(select Salary from tbl_Employees where FirstName = 'Mukesh')
and Department = 
(select Department from tbl_Employees where FirstName = 'Mukesh');

--subquery from 2 tables
select *               
from tbl_Employees
where Department = 
(select DeptId from tbl_Departments where DeptName = 'Engineering');

--MULTI ROW SUBQUERY USING ALL, ANY KEYWORDS
select *               
from tbl_Employees
where Salary > ALL 
(select Salary from tbl_Employees where FirstName = 'Raj');      --More than 1 person named Raj present

select *               
from tbl_Employees
where Salary > ALL 
(select Salary from tbl_Employees where FirstName = 'Raj');



--CORRELATED SUBQUERY
select * from tbl_Employees order by Salary desc;
--for each row every row of the table is compared
select FirstName, Salary from tbl_Employees t1
where 3 = 
(select count(distinct Salary) from tbl_Employees t2 where t2.Salary > t1.Salary);     --Nth highest Salary, N - 1 in where clause

select top 1 Salary from 
(select distinct top 3 Salary from tbl_Employees order by Salary desc) as temp               --as keyword necessary here
order by Salary;                              --Nth highest Salary using top, top N in the subquery



--JOINS
--INNER JOIN       default join

select t1.FirstName, t1.Department 
from tbl_Employees t1 join tbl_Departments t2
on t1.Department = t2.DeptId;

----same as
select t1.FirstName, t1.Department 
from tbl_Employees t1, tbl_Departments t2
where t1.Department = t2.DeptId;

--OUTER JOIN
--LEFT OUTER JOIN

select t1.FirstName, t2.DeptName 
from tbl_Employees t1 left outer join tbl_Departments t2
on t1.Department = t2.DeptId;

----RIGHT OUTER JOIN
select t1.FirstName, t2.DeptName  
from tbl_Employees t1 right outer join tbl_Departments t2
on t1.Department = t2.DeptId;

--FULL OUTER JOIN
select t1.FirstName, t2.DeptName  
from tbl_Employees t1 full outer join tbl_Departments t2
on t1.Department = t2.DeptId;

--SELF JOIN
--select * from tbl_Emp;
select t1.EmpName Manager, t2.EmpName Worker
from tbl_Emp t1 join tbl_Emp t2
on t1.EmpId = t2.MgrId;



--SET OPERATORS          multiple statement, single result set; name and no of col must be same
--UNION

select FirstName, LastName, Department 
from tbl_XEmployees
union
select FirstName, LastName, Department 
from tbl_Employees;           --Name and no of col same; intersection(common) visible only once (here, Anjelina)

--UNION ALL
select FirstName, LastName, Department 
from tbl_XEmployees
union all
select FirstName, LastName, Department 
from tbl_Employees           --intersection(common) visible twice (here, Anjelina)
order by 1;                  --order by at last select statement

--INTERSECT           only common records shown
select FirstName, LastName, Department 
from tbl_XEmployees
intersect
select FirstName, LastName, Department 
from tbl_Employees           
order by 1;

----except           shows records from 1st table removing the common elements
select FirstName, LastName, Department 
from tbl_XEmployees
except
select FirstName, LastName, Department 
from tbl_Employees           
order by 1;



--GROUP FUNCTIONS OR AGGREGATE FUNCTIONS                

select sum(Salary) [SUM], max(Salary) [MAX], min(Salary) [MIN], avg(Salary) [AVG], stdev(Salary) [STDEV SAMPLE], stdevp(Salary) [STDEV POPULATION]  
from tbl_Employees;

--cannot use aggregate func in where clause; thus using subquery

--select FirstName
--from tbl_Employees
--where Salary = 
--(select max(Salary) from tbl_Employees);      --will show error



--GROUP BY     homogeneous groups; aggregate func on smaller groups; having clause used to filter

select Department 
from tbl_Employees
group by Department;

select Department, sum(Salary) [Department Sum] 
from tbl_Employees
group by Department;          --used with group func

--HAVING       having used to filter groups, whereas where used to filter records

select Department, sum(Salary) [Department Sum] 
from tbl_Employees
group by Department
having sum(Salary) > 100000;



--DDL         changes the structure or metadata of a database; auto committed not able to rollback

--CREATE

create table tbl_Students
(
	StudentId int,
	FirstName varchar(20),
	LastName varchar(20),
	EmailId varchar(30),
	MobileNo char(10),
	Gender char(1),
	DateOfBirth date,
	CourseId int
)

--ALTER     add, remove or modify and column

alter table tbl_Students 
add Fees numeric(7,2);        --add column

alter table tbl_Students 
alter column Fees numeric(7,2);       --change column

alter table tbl_Students 
drop column Fees;         --delete column

--rename column we have to use pre-defined stored procedure

exec sp_rename 'tbl_Students.DateOfBirth', 'DOB', 'Column'                 --exec is same as execute

--DROP
drop table tbl_Students;



--CHECK CONSTRAINT

create table tbl_Students
(
	StudentId int,
	FirstName varchar(20),
	LastName varchar(20),
	EmailId varchar(30),
	MobileNo char(10),
	Gender char(1) constraint student_gender_chk check(Gender in ('M', 'F')),
	DateOfBirth date,
	Fees numeric(8,2), 
	CourseId int,
	constraint student_mob_un unique(MobileNo),
	constraint student_fees_chk check(Fees >= 500)
)

alter table tbl_Students
drop constraint student_gender_chk;

alter table tbl_Students
add constraint student_gender_chk check(Gender in ('M', 'F'));



--TRUNCATE       delete can be used for same, but delete can be rolled back

truncate table tbl_Students;             --clear data along with memory that's why DDL command
--if delete without truncating memory will not be released



--DML          commands change the data; can be rolled back

create table tbl_Students
(
	StudentId int constraint student_studid_pk primary key,
	FirstName varchar(20) constraint student_firstName_nn not null,
	LastName varchar(20),
	EmailId varchar(30),
	MobileNo char(10),
	Gender char(1) constraint student_gender_chk check(Gender in ('M', 'F')),
	DateOfBirth date,
	Fees numeric(8,2), 
	CourseId int,
	constraint student_mob_un unique(MobileNo),
	constraint student_fees_chk check(Fees >= 500)
)

insert into tbl_Students values
(
	101,
	'Anadi',
	null,
	'anadi@gmail.com',
	'9573856385',
	'M',
	'2000-05-15',
	1000,
	20
)

--DELETE
delete from tbl_Students
where StudentId = 101;



--UPDATE

update tbl_Employees
set LastName = 'asdf'
where LastName is null;     --cannot use '= null'

update tbl_Employees
set LastName = nuLL 
where LastName = 'asDF';

update tbl_Employees
set Salary = Salary + 2000 
where EmpID = 102;

update tbl_Employees
set Department = 
(select Department from tbl_Employees where FirstName = 'Anadi')
where FirstName = 'Vineet';          --update using subquery

--select * from tbl_Employees;



--CONSTRAINTS
--PRIMARY KEY

create table tbl_Students
(
	StudentId int constraint student_studid_pk primary key,    --Column level      
	FirstName varchar(20),
	LastName varchar(20),
	EmailId varchar(30),
	MobileNo char(10),
	Gender char(1),
	DateOfBirth date,
	Fees numeric(8,2), 
	CourseId int,
);

create table tbl_Students
(
	StudentId int,         
	FirstName varchar(20),
	LastName varchar(20),
	EmailId varchar(30),
	MobileNo char(10),
	Gender char(1),
	DateOfBirth date,
	Fees numeric(8,2), 
	CourseId int, 
	constraint student_studentid_pk primary key(StudentId),    --Table level 
);

--drop table tbl_Students;

alter table tbl_Students
drop constraint student_studentid_pk;

--if table already created, first apply the not null constraint
alter table tbl_Students
alter column StudentId int not null;

alter table tbl_Students
add constraint student_studentid_pk primary key(StudentId);

alter table tbl_Students
drop constraint student_studentid_pk;


--NOT NULL
create table tbl_Students
(
	StudentId int,       
	FirstName varchar(20) constraint student_firstname_nn not null,
	LastName varchar(20),
	EmailId varchar(30),
	MobileNo char(10),
	Gender char(1),
	DateOfBirth date,
	Fees numeric(8,2), 
	CourseId int,
);

--drop table tbl_Students;

alter table tbl_Students 
alter column FirstName varchar(20) not null;


--UNIQUE
create table tbl_Students
(
	StudentId int,     
	FirstName varchar(20),
	LastName varchar(20),
	EmailId varchar(30) constraint student_emailid_un unique,   --Column level
	MobileNo char(10),
	Gender char(1),
	DateOfBirth date,
	Fees numeric(8,2), 
	CourseId int,
);

create table tbl_Students
(
	StudentId int,     
	FirstName varchar(20),
	LastName varchar(20),
	EmailId varchar(30),     --Column level
	MobileNo char(10),
	Gender char(1),
	DateOfBirth date,
	Fees numeric(8,2), 
	CourseId int, 
	constraint student_emailid_un unique(EmailId)
);      --for multiple col (unique(a,b,c)) their combination will be considered unique

alter table tbl_Students
drop constraint student_emailid_un;

alter table tbl_Students
add constraint student_emailid_un unique(EmailId);


--FOREIGN KEY
create table tbl_Courses
(
	CourseId int constraint course_courseid_pk primary key,
	CourseName varchar(20)
);

--drop table tbl_Students;

create table tbl_Students
(
	StudentId int,     
	FirstName varchar(20),
	LastName varchar(20),
	EmailId varchar(30),     --Column level
	MobileNo char(10),
	Gender char(1),
	DateOfBirth date,
	Fees numeric(8,2), 
	Course int, 
	constraint student_studentid_pk primary key(StudentId),  
	constraint student_course_fk foreign key(Course) references tbl_Courses(CourseId) on delete set null on update cascade
);

alter table tbl_Students
add constraint student_course_fk foreign key(Course) references tbl_Courses(CourseId);



--INDEX   primary and unique are automatic index

--Non Clustered Index

create nonclustered index Employees_FirstName_Ind
on tbl_Employees(FirstName);        --can pass multiple col under parenthesis



--VIEWS		 contains structure not data
--provides restricted access, DML from views

create view EmpVu20 as
select EmpID, FirstName + ' ' + LastName as EmpName, EmailId, MobileNo, Salary * 12 as AnnualSalary, Department
from tbl_Employees
where Department = 20;

alter view EmpVu20 as
select EmpID, FirstName + ' ' + isnull(LastName, '') as EmpName, EmailId, MobileNo, Salary * 12 as AnnualSalary, Department
from tbl_Employees
where Department = 20;

--select * from EmpVu20;

--DML
--don't update if distinct, group, group by, expression
--don't insert if distinct, group, group by, expression, not null excluded

delete from EmpVu20 
where EmpID = 113;           --deleted from main table as well

--select * from tbl_Employees;       --main table

update EmpVu20
set MobileNo = '9999999999'
where EmpID = 105;         --updated in main table as well

--update EmpVu20
--set EmpName = 'Tom Thomas'
--where EmpID = 105;   --did not run since empname is expression

--WITH CHECK OPTION      constraint

alter view EmpVu20 as
select EmpID, FirstName + ' ' + isnull(LastName, '') as EmpName, EmailId, MobileNo, Salary * 12 as AnnualSalary, Department
from tbl_Employees
where Department = 20
with check option;         --where condition checked in this constraint

update EmpVu20
set Department = 30
where EmpID = 102;       --error because where condition failed

--make view read only
--alter view EmpVu20 as
select EmpID, FirstName + ' ' + isnull(LastName, '') as EmpName, EmailId, MobileNo, Salary * 12 as AnnualSalary, Department
from tbl_Employees
where Department = 20
union
select EmpID, FirstName + ' ' + isnull(LastName, '') as EmpName, EmailId, MobileNo, Salary * 12 as AnnualSalary, Department
from tbl_Employees
where 1 = 2
with check option;       --where condition never be true so no updation

update EmpVu20
set MobileNo = '123456789'
where EmpID = 102;       --error with check condition always false



--T-SQL

begin
	print 'Hello World!!!'
end

begin
	declare @var int;
	set @var = 100;
	print @var;
end     --global variables begin with @@, ';' not necessary

begin
	declare @var int = 200;
	print @var;
end    

begin
	declare @name varchar(20) = 'Anadi';
	declare @sal numeric(8, 2) = 5000;
	print @name;
	print @sal;
	print @name + ' earns ' + cast(@sal as varchar);
end

begin
	declare @name varchar(20);
	declare @sal numeric(8, 2);
	
	select @name = FirstName, @sal = Salary
	from tbl_Employees
	where EmpId = 105;

	print @name + ' earns ' + cast(@sal as varchar);
end



--CONDITIONAL IF-ELSE
begin
	declare @name varchar(20);
	declare @sal numeric(8, 2);
	declare @grade char(1);
	
	select @name = FirstName , @sal = Salary
	from tbl_Employees
	where EmpId = 101;

	if @sal > 50000
		set @grade = 'A'
	else if @sal > 35000
		set @grade = 'B'
	else
		set @grade = 'C'

	print @name + ' is in Grade ' + @Grade;
end       --For 1 line of code in if statement begin-end not necessary
--even variable names are case insensitive

select * from tbl_Employees


begin
	declare @var int;
	set @var = 10;

	if @var = 0
	begin
		print 'Zero'
	end
	else if @var > 0
	begin
		print 'Positive'
	end
	else
	begin
		print 'Negative'
	end
end



--LOOPS
begin
	declare @name varchar(20);
	declare @sal numeric(8, 2);
	declare @grade char(1);
	declare @id int = 101;
	
	while @id <= 110
	begin
	
	select @name = FirstName , @sal = Salary
	from tbl_Employees
	where EmpId = @id;

	if @sal > 50000
		set @grade = 'A'
	else if @sal > 35000
		set @grade = 'B'
	else
		set @grade = 'C'

	print @name + ' is in Grade ' + @Grade;

	set @id += 1;

	end
end



--EXCEPTION HANDLING          try-catch

BEGIN TRY 
SELECT 1/0;
END TRY
BEGIN CATCH
SELECT
	@@ERROR AS ERROR,      --@@ represents global variable, same as error_number
	ERROR_NUMBER() AS ErrorNumber, 
	ERROR_SEVERITY() AS ErrorSeverity,
	ERROR_STATE() AS ErrorState, 
	ERROR_PROCEDURE() AS ErrorProcedure,    --checks error in procedure
	ERROR_LINE() AS ErrorLine,     --line number in the try block
	ERROR_MESSAGE() AS ErrorMessage;
END CATCH   -- as keyword used to name col names from none displayed otherwise


BEGIN TRY 
	declare @name varchar(20) = 'Anadi';
	declare @sal int = 5000;
	print @name + ' earns ' + @sal;
END TRY
BEGIN CATCH
SELECT
	@@ERROR AS ERROR,      
	ERROR_NUMBER() AS ErrorNumber, 
	ERROR_SEVERITY() AS ErrorSeverity,
	ERROR_STATE() AS ErrorState, 
	ERROR_PROCEDURE() AS ErrorProcedure, 
	ERROR_LINE() AS ErrorLine, 
	ERROR_MESSAGE() AS ErrorMessage;
END CATCH



--TRANSACTIONS

begin transaction
	delete from tbl_Employees
	where EmpID = 109;
	print @@trancount;     --counts the number of transactions running

	rollback
	commit
	--table not visible in another script till the transaction is either committed or rolledback

--SAVEPOINTS

select * from tbl_Employees;

begin transaction
	save transaction s1
	delete from tbl_Employees
	where EmpID = 107;

	save transaction s2
	delete from tbl_Employees
	where EmpID = 109;

	rollback transaction s2
	rollback transaction s1
	commit         --once committed till savepoint cannot be rolledback



--CURSORS
--used to retrieve data from result set one row at a time
--update records row by row conditionally
--@@FETCH_STATUS returns the status for last cursor fetch, 0 - means successful, -1 - means unsuccessful

--declare, open, fetch, close, deallocate
--since cursor is declared not created it is not a database object
--fetch can be used multiple times
--deallocate memory


begin
	declare @empid int;
	declare @name varchar(20);
	declare @sal numeric(20);

	declare empcur cursor for
	select EmpID, FirstName, Salary 
	from tbl_Employees
	where Department = 30;

	open empcur;

	fetch next from empcur into @empid, @name, @sal;

	while @@FETCH_STATUS = 0
	begin
		print @name + ' earns ' + cast(@sal as varchar);
		fetch next from empcur into @empid, @name, @sal;       --fetches next record till @@FETCH_STATUS returns -1
	end

	close empcur;
	deallocate empcur;
end

--fetch with conditional
begin transaction
	begin
		declare @empid int;
		declare @name varchar(20);
		declare @sal numeric(20);

		declare empcur cursor for
		select EmpID, FirstName, Salary 
		from tbl_Employees
		where Department = 30;

		open empcur;

		fetch next from empcur into @empid, @name, @sal;

		while @@FETCH_STATUS = 0
		begin
			if @sal >= 50000
			begin
				set @sal += 5;
			end
			else
			begin
				set @sal += 10;
			end

			update tbl_Employees
			set Salary = @sal
			where EmpID = @empid;

			print @name + ' earns ' + cast(@sal as varchar);

			fetch next from empcur into @empid, @name, @sal;
		end

		close empcur;
		deallocate empcur;
	end
	rollback
	


--STORED PROCEDURES        compilation time is saved, only execution time is needed
--reusable code, access can be controlled

create procedure EmpSalIncrement as
	begin
		declare @empid int;
		declare @name varchar(20);
		declare @sal numeric(20);

		declare empcur cursor for
		select EmpID, FirstName, Salary 
		from tbl_Employees
		where Department = 30;

		open empcur;

		fetch next from empcur into @empid, @name, @sal;

		while @@FETCH_STATUS = 0
		begin
			if @sal >= 50000
			begin
				set @sal += 5;
			end
			else
			begin
				set @sal += 10;
			end

			update tbl_Employees
			set Salary = @sal
			where EmpID = @empid;

			print @name + ' earns ' + cast(@sal as varchar);

			fetch next from empcur into @empid, @name, @sal;
		end

		close empcur;
		deallocate empcur;
	end

--Parameterized

alter procedure EmpSalIncrement @deptid int as
	begin
		declare @empid int;
		declare @name varchar(20);
		declare @sal numeric(20);

		declare empcur cursor for
		select EmpID, FirstName, Salary 
		from tbl_Employees
		where Department = @deptid;

		open empcur;

		fetch next from empcur into @empid, @name, @sal;

		while @@FETCH_STATUS = 0
		begin
			if @sal >= 50000
			begin
				set @sal += 5;
			end
			else
			begin
				set @sal += 10;
			end

			update tbl_Employees
			set Salary = @sal
			where EmpID = @empid;

			print @name + ' earns ' + cast(@sal as varchar);

			fetch next from empcur into @empid, @name, @sal;
		end

		close empcur;
		deallocate empcur;
	end

begin transaction
	execute EmpSalIncrement 20;
	rollback
--execute or exec are same

--output type variables returns values
create proc SampleProc @id int, @name varchar(20) output, @sal numeric(8,2) output as
begin
	select @name = FirstName, @sal = Salary
	from tbl_Employees
	where EmpID = @id;
end

begin
	declare @empname varchar(20);
	declare @salary numeric(8,2);

	execute SampleProc 101, @empname output, @salary out;
	print @empname;
	print @salary;
end
--output or out must be written in procedure call too, to print the values



--STORED FUNCTIONS
--return keyword can be used
--can be used in select/ where / having clause
--can't use exception handling because func must return a value; can't in a catch block

create function TaxAmount(@amount numeric(10,2)) returns numeric(8,2) as
begin
	return @amount * 0.1;
end         --func defination has returns not return

select EmpID, FirstName, Salary, dbo.TaxAmount(Salary) Tax 
from tbl_Employees;



--TRIGGERS
--designed for events like insert, update or login
--executed implicitly
--can be used for DDL, DML or login
--DML triggers 2 types after, instead of

--magic tables
--inserted
--deleted                  on updation both tables are called

create trigger EmpSalCheck on tbl_Employees for update as
begin
	declare @oldsal numeric(8,2);
	declare @newsal numeric(8,2);

	select @oldsal = Salary from deleted;
	select @newsal = Salary from inserted;

	if(@oldsal > @newsal)
	begin
		print 'New salary cannot be less than old salary';
		rollback;
	end
end

update tbl_Employees
set Salary += 1;

create trigger EmpDelCheck on tbl_Employees for delete as
begin
	declare @count int;

	select @count = count(*) from deleted;

	if @count > 1
	begin
		print 'Cannot delete more than one record at a time'
		rollback;
	end
end

--instead of trigger        designed on views only

create view EmpVU as
select e.EmpID, e.FirstName, e.Salary, d.DeptName
from tbl_Employees e join tbl_Departments d 
on e.Department = d.DeptId;

select * from EmpVU;
select * from tbl_Employees;
select * from tbl_Departments;

--here, instead of view the insertion will be done on the main table
create trigger trig_empVUInsert on EmpVU instead of insert as
begin
	declare @empid int;
	declare @name varchar(20);
	declare @sal numeric(8,2);
	declare @deptid int;

	select @empid = EmpID, @name = FirstName, @sal = Salary, @deptid = d.DeptId 
	from tbl_Departments d join inserted
	on d.DeptName = inserted.DeptName

	if @deptid is null
	begin
		print 'Invalid Department';
		rollback;
	end

	insert into tbl_Employees(EmpID, FirstName, Salary, Department) 
	values (@empid, @name, @sal, @deptid);
end

--checking trigger
insert into EmpVU 
values(121, 'ABCD', 30000, 'Sales');

select * from EmpVU;