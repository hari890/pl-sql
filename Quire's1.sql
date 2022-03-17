1. Display the department names in the lower case but the initial must be in uppercase. 

SQL> select initcap(dname) "Dept Names"
  2  from dept2;

Dept Names
------------
Accounting
Research
Sales
Operations


2. Determine the ‘ename’, ‘job’, ‘sal’ rename the title as Job-sal the output must be Job-Sal as SMITH[CLERKRS.2000]

SQL> select ename||'['||job||'.'||sal||']' "Job-Sal"
  2  from employee;

Job-Sal
---------------------------------------------------------------------------
Smith[Clerk       .800]
Allen[Salesman    .1600]
Ward[Salesman    .1250]
Jones[Manager     .2975]
Martin[Salesman    .1250]
Blake[Manager     .2850]
Clark[Manager     .2450]
Scott[Analyst     .3000]
King[President   .5000]
Turner[Salesman    .1500]
Adams[Clerk       .1100]
James[Clerk       .950]
Ford[Analyst     .3000]
Miller[Clerk       .1300]

14 rows selected.


3. Count the number of times S occurs in department names.

SQL> select count(length(upper(dname))-length(replace(upper(dname),'S'))) "Occurence of S and s in Dnames"
  2  from dept2;

Occurence of S and s in Dnames
------------------------------
                             4


4. Write a query to display the department name which does not contains any employees.

SQL> select deptno
  2  from dept2
  3  where deptno not in (select deptno
  4  from employee);

    DEPTNO
----------
        40


5. Write a query to display all employee details where employee was joined during the years 1980 to 1990 and in the 2nd week of a month

SQL> select *
  2  from employee
  3  where to_char(hiredate,'w')=2 and to_char(hiredate,'yyyy') between 1980 and 1990;

     EMPNO ENAME                JOB                 MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- ------------ ---------- --------- ---------- ---------- ----------
      7782 Clark                Manager            7839 09-JUN-81       2450                    10
      7844 Turner               Salesman           7698 08-SEP-81       1500          0         30


6. Write an SQL statement to convert the current date to new date picture 

SQL> select to_char(sysdate,'DAY DD YYYY HH12')||':'||to_char(sysdate,'MI')||'.'||to_char(sysdate,'SS AM') "Current Sys Details"
  2  from dual;

Current Sys Details
--------------------------------------------------------
WEDNESDAY 26 2022 01:03.07 PM


7. Write a query to display details of all employees who joined on last Monday of a month and whose experience is more than 20 months.

SQL> select *
  2  from employee
  3  where months_between(sysdate,hiredate)>20 and to_char(hiredate,'dy')='mon' and to_char(last_day(hiredate),'dy') not in ('sun');

     EMPNO ENAME                JOB                 MGR HIREDATE         SAL       COMM     DEPTNO
---------- -------------------- ------------ ---------- --------- ---------- ---------- ----------
      7654 Martin               Salesman           7698 28-SEP-81       1250       1400         30


8. Write a query to calculate the service of employees rounded to years.

SQL> select ename,round((months_between(sysdate,hiredate))/12) "Years of Service"
  2  from employee;

ENAME                Years of Service
-------------------- ----------------
Smith                              41
Allen                              41
Ward                               41
Jones                              41
Martin                             40
Blake                              41
Clark                              41
Scott                              35
King                               40
Turner                             40
Adams                              35
James                              40
Ford                               40
Miller                             40

14 rows selected.


9. Write a query that will display all different job types.

SQL> select distinct job
  2  from employee;

JOB
------------
Salesman
Clerk
President
Manager
Analyst


10. Write a query that will display list of employees and their salary and the comments as follows.
    If the salary is more than 1500 then display “above target”
    If the salary is equal to 1500 then display “on the target”
    If the salary is less than 1500 then display “below the target”

SQL> select ename,sal,case
  2  when sal>1500 then 'Above target'
  3  when sal<1500 then 'Below target'
  4  else 'On the target'
  5  end "Comments"
  6  from employee;

ENAME                       SAL Comments
-------------------- ---------- -------------
Smith                       800 Below target
Allen                      1600 Above target
Ward                       1250 Below target
Jones                      2975 Above target
Martin                     1250 Below target
Blake                      2850 Above target
Clark                      2450 Above target
Scott                      3000 Above target
King                       5000 Above target
Turner                     1500 On the target
Adams                      1100 Below target
James                       950 Below target
Ford                       3000 Above target
Miller                     1300 Below target

14 rows selected.


11. Display all employee names, employee number, department names & salary grades for all employees who are working in department 30.


SQL> select e.ename,e.empno,d.dname,s.grade
  2  from employee e,dept2 d,salgrade s
  3  where e.deptno=30 and d.deptno=30 and (e.sal between s.losal and s.hisal);

ENAME                     EMPNO DNAME             GRADE
-------------------- ---------- ------------ ----------
Allen                      7499 Sales                 3
Ward                       7521 Sales                 2
Martin                     7654 Sales                 2
Blake                      7698 Sales                 4
Turner                     7844 Sales                 3
James                      7900 Sales                 1

6 rows selected.


12. Display the time of day.

SQL> select to_char(sysdate,'HH12')||':'||to_char(sysdate,'MI')||':'||to_char(sysdate,'SS AM') "Time"
  2  from dual;

Time
-----------
08:29:01 PM
