1. Write a PL/SQL stored function to calculate ncr using fact (m) function that returns factorial of m.

fact function:

create or replace function fact(n number)
return number as
i number;
f number:=1;
begin
	for i in 1..n
	loop
		f:=f*i;
	end loop;
	return f;
end;

output:

SQL> @Z:\Dbms\PlSql\fact.sql;
 12  /

Function created.

ncr function:

create or replace function ncr(n number,r number)
return
number as
res number;
begin
	res:=fact(n)/(fact(n-r)*fact(r));
	return res;
end;	

output:

SQL> @Z:\Dbms\PlSql\ncr.sql;
Input truncated to 5 characters
  9  /

Function created.

.sql for main:

declare
	n number:=&n;
	r number:=&r;
	res number;
begin
	res:=ncr(n,r);
	dbms_output.put_line('ncr = '||res);
end;

output:

SQL> @Z:\Dbms\PlSql\comb.sql;
  9  /
Enter value for n: 4
old   2:        n number:=&n;
new   2:        n number:=4;
Enter value for r: 2
old   3:        r number:=&r;
new   3:        r number:=2;
ncr = 6

PL/SQL procedure successfully completed.

2. Write a PL/SQL block that updates salary of an employee in employee table by using incr function which takes employee number as argument, calculates increment and returns increment based on the following criteria.
   If salary <= 3000 – increment = 30% of salary
   If salary > 3000 and <= 6000– increment = 20% of salary
   Else increment = 10% of salary. 

creating table emp2:

SQL> create table emp2 as select * from y20cb42.employee;

Table created.

incr function:

create or replace function incr(eid number)
return number as
s number;
inc number;
begin
	select sal into s
	from emp2
	where empno=eid;
	if s>0 and s<=3000
	then
		inc:=s*30/100;
	elsif s>3000 and s<=6000
	then
		inc:=s*20/100;
	else
		inc:=s*10/100;
	end if;
	return inc;
end;

output:

SQL> @Z:\DBMS\PlSql\incrfun.sql;
 20  /

Function created.

.sql for main:

declare
	eid emp2.empno%type:=&eid;
	inc number;
begin
	inc:=incr(eid);
	dbms_output.put_line('Salary of employee '||eid||' should be incremented by '||inc);
end;

output:

SQL>  @Z:\Dbms\PlSql\incrfunmain.sql;
  8  /
Enter value for eid: 7844
old   2:        eid emp2.empno%type:=&eid;
new   2:        eid emp2.empno%type:=7844;
Salary of employee 7844 should be incremented by 450

PL/SQL procedure successfully completed.

3. Write a stored procedure, raise_salary which accepts an employee number. It uses incr function of previous program to get the
   salary increase amount and uses employee number to select the current salary from employee table. If employee number is not 
   found or if the current salary is null, it should raise an exception. Otherwise, updates the salary.

raisesal procedure:

create or replace procedure raise_sal(eid number) as
s number;
inc number;
null_sal exception;
begin
	select sal into s from emp2
	where empno=eid;
	if s is Null
	then
		raise null_sal;
	else
		inc:=incr(eid);
		update emp2 set sal=sal+inc
		where empno=eid;
		dbms_output.put_line('Salary of employee '||eid||' is incremented by '||inc);
	end if;
exception
	when no_data_found then
		dbms_output.put_line('There is no employee with employee id '||eid);
	when null_sal then
		dbms_output.put_line('Salary is null and cannot be incremented');
end;

output:

SQL> @Z:\Dbms\PlSql\raisesal.sql;
 23  /

Procedure created.

.sql for main:

declare
	eid emp2.empno%type:=&eid;
begin
	empproced(eid);
end;

output:

SQL> @Z:\Dbms\PlSql\incrprocedmain.sql;
  6  /
Enter value for eid: 7499
old   2:        eid emp2.empno%type:=&eid;
new   2:        eid emp2.empno%type:=7499;
Salary of employee 7499 should be incremented by 480

PL/SQL procedure successfully completed.

SQL> select *
  2  from emp2
  3  where empno=7499;

     EMPNO ENAME                JOB                 MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- ------------ ---------- --------- ---------- ---------- ----------
      7499 Allen                Salesman           7698 20-FEB-81       2080        300         30

SQL> @Z:\Dbms\PlSql\incrprocedmain.sql;
  6  /
Enter value for eid: 5432
old   2:        eid emp2.empno%type:=&eid;
new   2:        eid emp2.empno%type:=5432;
There is no employee with employee id 5432

PL/SQL procedure successfully completed.


4. Consider the following table

ITEM
prod_ id  name  mat_used  weight

Write a procedure which will check for the existence of prod_id from the table ITEM. This procedure must have two 
arguments, one of which will receive a value, which is a matching pattern for prod_id of the ITEM table, and 
another which will return a value indicating whether a match has been found or not.

creating item table:

SQL> create table item(
  2  prod_id number,
  3  name varchar(20),
  4  mat_used varchar(20),
  5  weight number);

Table created.

.sql for rows of item table:

insert into item values(101,'Black panther','Vibranium',70);
insert into item values(102,'Iron man','Iron',90);
insert into item values(103,'Ant man','Ants',60);
insert into item values(104,'Vision','Mind stone',80);
insert into item values(105,'Cap','Vibranium',100);

output:

SQL>  @Z:\Dbms\PlSql\item.sql;

1 row created.

1 row created.

1 row created.

1 row created.

1 row created.

procedure:

create or replace procedure itemproced(pid in number,m out char) as
prid item.prod_id%type;
begin
	select prod_id into prid
	from item 
	where prod_id=pid;
	m:='found';
exception
	when no_data_found then
		m:='not found';
end;

output:

SQL> @Z:\Dbms\PlSql\itemproced.sql;
 12  /

Procedure created.

main:

declare 
	pid number:=&pid;
	m char(12);
begin
	itemproced(pid,m);
	dbms_output.put_line('The product with entered pid is '||m);
end;

output:

SQL>  @Z:\Dbms\PlSql\itemmain.sql;
  8  /
Enter value for pid: 101
old   2:        pid number:=&pid;
new   2:        pid number:=101;
The product with entered pid is found

PL/SQL procedure successfully completed.

SQL> /
Enter value for pid: 106
old   2:        pid number:=&pid;
new   2:        pid number:=106;
The product with entered pid is not found

PL/SQL procedure successfully completed.

5.	Consider the following tables

PERSINFO
EMPNO	NAME	AGE

AUDITPERSINFO
EMPNO	NAME	AGE	OPERATION	ODATE
 
PERSINFO is the table for which the auditing must be performed and AUDITPERSINFO is the table 
which keeps track of the records deleted or modified. Create a database trigger audit_trial. 
This trigger is forced when an UPDATE or a DELETE is performed on the table PERSINFO. 
It first checks for the operation being performed on the table. Then depending on the operation, 
a variable (that corresponds to operation) is assigned the value ‘UPDATE’ or ‘DELETE’ and 
then inserts the updated/deleted record into AUDITPERSINFO.

creating tables:

SQL> create table persinfo(
  2  empno number,
  3  name varchar(20),
  4  age number);

Table created.

SQL> create table auditpersinfo(
  2  empno number,
  3  name varchar(20),
  4  age number,
  5  operation varchar(20),
  6  odate date);

Table created.

.sql for rows of persinfo:

insert into persinfo values(101,'Peter',19);
insert into persinfo values(102,'Steve',70);
insert into persinfo values(103,'Tony',35);
insert into persinfo values(104,'Thor',34);

output:

SQL>  @Z:\Dbms\PlSql\persinfo.sql;

1 row created.

1 row created.

1 row created.

1 row created.

trigger:

create or replace trigger audit_trial
after update or delete on persinfo for each row
declare
	eno    number;
	ename  varchar2(12);
	eage   number;
	op     varchar2(12);
begin
	if updating then op:='update';
	elsif deleting then op:='delete';
	end if;
	eno:=:old.empno;
	ename:=:old.name;
	eage:=:old.age;
	insert into auditpersinfo
	values(eno,ename,eage,op,sysdate);
end;

output:

SQL> @Z:\Dbms\PlSql\trigger.sql;
 18  /

Trigger created.

operations:

SQL> delete from persinfo where empno=104;

1 row deleted.

SQL> select *
  2  from auditpersinfo;

     EMPNO NAME                        AGE OPERATION            ODATE
---------- -------------------- ---------- -------------------- ---------
       104 Thor                         34 delete               10-MAR-22

SQL> update persinfo set age=30 where empno=103;

1 row updated.

SQL> select *
  2  from auditpersinfo;

     EMPNO NAME                        AGE OPERATION            ODATE
---------- -------------------- ---------- -------------------- ---------
       104 Thor                         34 delete               10-MAR-22
       103 Tony                         35 update               10-MAR-22

SQL> select *
  2  from persinfo;

     EMPNO NAME                        AGE
---------- -------------------- ----------
       101 Peter                        19
       102 Steve                        70
       103 Tony                         30
