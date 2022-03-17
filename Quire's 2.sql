1. Find all employees who earn a salary greater than the average salary of their departments.

SQL> select empno,ename
  2  from employee e
  3  where sal > (select avg(sal)
  4  from employee
  5  where e.deptno=deptno);

     EMPNO ENAME
---------- --------------------
      7499 Allen
      7566 Jones
      7698 Blake
      7788 Scott
      7839 King
      7902 Ford

6 rows selected.


2. Write a query to sort names of employees in department 10 & 20 in alphabetical order

SQL> select ename,deptno
  2  from employee e
  3  where deptno in (10,20)
  4  order by deptno,ename;

ENAME                    DEPTNO
-------------------- ----------
Clark                        10
King                         10
Miller                       10
Adams                        20
Ford                         20
Jones                        20
Scott                        20
Smith                        20

8 rows selected.


3. Write a query to display all job types.

SQL> select job
  2  from employee
  3  group by job;

JOB
------------
Analyst
Clerk
Manager
President
Salesman


4. Calculate the number of employees and average salary of each department.

SQL> select deptno,count(ename),avg(sal)
  2  from employee
  3  group by deptno;

    DEPTNO COUNT(ENAME)   AVG(SAL)
---------- ------------ ----------
        10            3 2916.66667
        20            5       2175
        30            6 1566.66667


5. Write a query to find the name of the manager and number of sub-ordinates.

SQL> select m.ename,count(*) "No of Subordinates"
  2  from employee e,employee m
  3  where e.mgr=m.empno
  4  group by m.ename;

ENAME                No of Subordinates
-------------------- -------------------
Blake                                 5
Clark                                 1
Ford                                  1
Jones                                 2
King                                  3
Scott                                 1

6 rows selected.


6. Write a query to find out the manager having Maximum number of sub-ordinates.

SQL> select m.ename,count(*) "No of Subordinates"
  2  from employee e,employee m
  3  where e.mgr=m.empno
  4  group by m.ename
  5  having count(*) in (select max(count(*))
  6  from employee e,employee m
  7  where e.mgr=m.empno
  8  group by m.ename);

ENAME                 No of Subordinates 
-------------------- -------------------
Blake                                 5


7. Display the average, monthly salary bill for each job type within department.

SQL> select deptno,job,avg(sal)
  2  from employee
  3  group by deptno,job
  4  order by deptno;

    DEPTNO JOB            AVG(SAL)
---------- ------------ ----------
        10 Clerk              1300
        10 Manager            2450
        10 President          5000
        20 Analyst            3000
        20 Clerk               950
        20 Manager            2975
        30 Clerk               950
        30 Manager            2850
        30 Salesman           1400

9 rows selected.


8. Find all employees whose dept is not in dept table.

SQL> select empno,ename
  2  from employee
  3  where deptno not in (select deptno
  4  from dept2);

no rows selected


9(a). Write a query to find out the employees who have joined before their managers.

SQL> select e.ename
  2  from employee e,employee m
  3  where e.mgr=m.empno and e.hiredate<m.hiredate;

ENAME
--------------------
Ward
Allen
Clark
Blake
Jones
Smith

6 rows selected.


9(b). Write a query to find out the year, where most people join in the company display the year and No. of Employees.

SQL> select to_char(hiredate,'YYYY'),count(ename) "No of Emp"
  2  from employee
  3  group by to_char(hiredate,'YYYY')
  4  having count(ename) in (select max(count(ename))
  5  from employee
  6  group by to_char(hiredate,'YYYY'));

TO_C No of Emp
---- ---------
1981        10


10(a). List the department names of each employee.

SQL> select e.ename,d.dname
  2  from employee e,dept2 d
  3  where e.deptno=d.deptno;

ENAME                DNAME
-------------------- ------------
Smith                Research
Allen                Sales
Ward                 Sales
Jones                Research
Martin               Sales
Blake                Sales
Clark                Accounting
Scott                Research
King                 Accounting
Turner               Sales
Adams                Research
James                Sales
Ford                 Research
Miller               Accounting

14 rows selected.


10(b). Find all employees who earn lowest salary in each department.

SQL> select deptno,ename,sal
  2  from employee
  3  where sal in (select min(sal)
  4  from employee
  5  group by deptno)
  6  order by deptno;

    DEPTNO ENAME                       SAL
---------- -------------------- ----------
        10 Miller                     1300
        20 Smith                       800
        30 James                       950


11(a). Display all employees who earn more than the lowest salary of department 30.

SQL> select ename,sal
  2  from employee
  3  where sal>(select min(sal)
  4  from employee
  5  where deptno=30);

ENAME                       SAL
-------------------- ----------
Allen                      1600
Ward                       1250
Jones                      2975
Martin                     1250
Blake                      2850
Clark                      2450
Scott                      3000
King                       5000
Turner                     1500
Adams                      1100
Ford                       3000
Miller                     1300

12 rows selected.


11(b). Display all departments, which have the average salary more than average salary of department.

SQL> select deptno,avg(sal)
  2  from employee e
  3  group by deptno
  4  having avg(sal) > (Select avg(sal)
  5  from employee
  6  where deptno=e.deptno);

no rows selected


12. Write a query which will return the DAY of the week. (i.e. MONDAY), for any date entered in the format: DD.MM.YY.
