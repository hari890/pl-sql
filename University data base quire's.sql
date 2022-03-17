SQL>create table table_name as select * 
  2 from user_name.tablename_as_in_user;

SQL> select *
  2  from deptu;

DEPT_NAME            BUILDING            BUDGET
-------------------- --------------- ----------
Biology              Watson               90000
Comp.Sci.            Taylor              100000
Elec.Eng.            Taylor               85000
Finance              Painter             120000
Music                Packard              80000
Physics              Watson               70000
History              Painter              50000

7 rows selected.

SQL> select *
  2  from courseu;

COURSE_I TITLE                          DEPT_NAME               CREDITS
-------- ------------------------------ -------------------- ----------
BIO-101  Intro.to Biology               Biology                       4
BIO-301  Genetics                       Biology                       4
BIO-399  Computational Biology          Biology                       3
CS-101   Intro.to Computer Science      Comp.Sci.                     4
CS-190   Game Design                    Comp.Sci.                     4
CS-315   Robotics                       Comp.Sci.                     3
CS-319   Image Processing               Comp.Sci.                     3
CS-347   Database System Concepts       Comp.Sci.                     3
EE-181   Intro.to Digital Systems       Elec.Eng.                     3
FIN-201  Investment Banking             Finance                       3
HIS-351  World History                  History                       3
PHY-101  Physical Principles            Physics                       4
MU-199   Music Video Production         Music                         3

13 rows selected.

SQL> select *
  2  from instructoru;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
10101 Srinivasan           Comp.Sci.                 65000
12121 Wu                   Finance                   90000
15151 Mozart               Music                     40000
22222 Einstein             Physics                   95000
32343 El Said              History                   60000
33456 Gold                 Physics                   87000
45565 Katz                 Comp.Sci.                 75000
58583 Califieri            History                   62000
76543 Singh                Finance                   80000
76766 Crick                Biology                   72000
83821 Brandt               Comp.Sci.                 92000
98345 Kim                  Elec.Eng.                 80000

12 rows selected.

SQL> select *
  2  from sectionu;

COURSE_I SEC_ID   SEMEST       YEAR BUILDING        ROOM_NU TIME
-------- -------- ------ ---------- --------------- ------- ----
BIO-101  1        Summer       2009 Painter         514     B
BIO-301  1        Summer       2010 Painter         514     A
CS-101   1        Fall         2009 Packard         101     H
CS-101   1        Spring       2010 Packard         101     F
CS-190   1        Spring       2009 Taylor          3128    E
CS-190   2        Spring       2009 Taylor          3128    A
CS-315   1        Spring       2010 Watson          120     D
CS-319   1        Spring       2010 Watson          100     B
CS-319   2        Spring       2010 Taylor          3128    C
CS-347   1        Fall         2009 Taylor          3128    A
EE-181   2        Spring       2009 Taylor          3128    C
FIN-201  1        Spring       2010 Packard         101     B
HIS-351  1        Spring       2010 Painter         514     C
MU-199   1        Spring       2010 Packard         101     D
PHY-101  1        Fall         2009 Watson          100     A

15 rows selected.

SQL> select *
  2  from teachesu;

ID    COURSE_I SEC_ID   SEMEST       YEAR
----- -------- -------- ------ ----------
10101 CS-101   1        Fall         2009
10101 CS-315   1        Spring       2010
10101 CS-347   1        Fall         2009
12121 FIN-201  1        Spring       2010
15151 MU-199   1        Spring       2010
22222 PHY-101  1        Fall         2009
32343 HIS-351  1        Spring       2010
45565 CS-101   1        Spring       2010
45565 CS-319   1        Spring       2010
76766 BIO-101  1        Summer       2009
76766 BIO-301  1        Summer       2010
83821 CS-190   1        Spring       2009
83821 CS-190   2        Spring       2009
83821 CS-319   2        Spring       2010
98345 EE-181   2        Spring       2009

15 rows selected.

SQL> desc deptu;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 DEPT_NAME                                          VARCHAR2(20)
 BUILDING                                           VARCHAR2(15)
 BUDGET                                             NUMBER(12,2)

SQL> desc courseu;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 COURSE_ID                                          VARCHAR2(8)
 TITLE                                              VARCHAR2(30)
 DEPT_NAME                                          VARCHAR2(20)
 CREDITS                                            NUMBER(2)

SQL> desc instructoru;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ID                                                 VARCHAR2(5)
 NAME                                      NOT NULL VARCHAR2(20)
 DEPT_NAME                                          VARCHAR2(20)
 SALARY                                             NUMBER(8,2)

SQL> desc sectionu;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 COURSE_ID                                          VARCHAR2(8)
 SEC_ID                                             VARCHAR2(8)
 SEMESTER                                           VARCHAR2(6)
 YEAR                                               NUMBER(4)
 BUILDING                                           VARCHAR2(15)
 ROOM_NUMBER                                        VARCHAR2(7)
 TIME_SLOT_ID                                       VARCHAR2(4)

SQL> desc teachesu;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ID                                                 VARCHAR2(5)
 COURSE_ID                                          VARCHAR2(8)
 SEC_ID                                             VARCHAR2(8)
 SEMESTER                                           VARCHAR2(6)
 YEAR                                               NUMBER(4)

SQL> select table_name,constraint_name,constraint_type
  2  from user_constraints;

TABLE_NAME                     CONSTRAINT_NAME                C
------------------------------ ------------------------------ -
DEPT                           DEPT_PK                        P
DEPT2                          DEPT2_PK                       P
EMPLOYEE                       EMPLOYEE_PK                    P
EMPLOYEE                       EMPLOYEE_FK                    R
INSTRUCTORU                    SYS_C00168118                  C
STUDENT                        STUDENT_PK                     P
STUDENT                        STUDENT_FK                     R

7 rows selected.


Simple Queries:

1. Write a query to retrieve the names of all instructors.

SQL> select name
  2  from instructoru;

NAME
--------------------
Srinivasan
Wu
Mozart
Einstein
El Said
Gold
Katz
Califieri
Singh
Crick
Brandt
Kim

12 rows selected.


2. Write a query to retrieve the department names of all instructors.

SQL> select name,dept_name
  2  from instructoru;

NAME                 DEPT_NAME
-------------------- --------------------
Srinivasan           Comp.Sci.
Wu                   Finance
Mozart               Music
Einstein             Physics
El Said              History
Gold                 Physics
Katz                 Comp.Sci.
Califieri            History
Singh                Finance
Crick                Biology
Brandt               Comp.Sci.
Kim                  Elec.Eng.

12 rows selected.


3. Write a query to retrieve the unique department names of all instructors.

SQL> select distinct dept_name
  2  from instructoru;

DEPT_NAME
--------------------
Biology
Comp.Sci.
Elec.Eng.
Finance
History
Music
Physics

7 rows selected.


4. Write a query to show resulting salaries if each instructor is given a 10 percent raise. 

SQL> select name,salary+(salary*0.1) "10% rise in Sal"
  2  from instructoru;

NAME                     10% rise in Sal
--------------------     ---------------
Srinivasan                         71500
Wu                                 99000
Mozart                             44000
Einstein                          104500
El Said                            66000
Gold                               95700
Katz                               82500
Califieri                          68200
Singh                              88000
Crick                              79200
Brandt                            101200
Kim                                88000

12 rows selected.


5. Write a query to retrieve the names of all instructors in the Computer Science department who have salary more than $70,000.

SQL> select name
  2  from instructoru
  3  where dept_name='Comp.Sci.' and salary>70000;

NAME
--------------------
Katz
Brandt


Queries on multiple relations:

1. Write a query to retrieve the name of all instructors along with their department names and department building name.

SQL> select i.name,i.dept_name,d.building
  2  from instructoru i,deptu d
  3  where i.dept_name=d.dept_name
  4  order by i.id;

NAME                 DEPT_NAME            BUILDING
-------------------- -------------------- ---------------
Srinivasan           Comp.Sci.            Taylor
Wu                   Finance              Painter
Mozart               Music                Packard
Einstein             Physics              Watson
El Said              History              Painter
Gold                 Physics              Watson
Katz                 Comp.Sci.            Taylor
Califieri            History              Painter
Singh                Finance              Painter
Crick                Biology              Watson
Brandt               Comp.Sci.            Taylor
Kim                  Elec.Eng.            Taylor

12 rows selected.


2. Write a query to retrieve name of the instructors and course id that he/she teaches the courses.

SQL> select i.name,t.course_id
  2  from instructoru i,teachesu t
  3  where i.id=t.id;

NAME                 COURSE_I
-------------------- --------
Srinivasan           CS-101
Srinivasan           CS-315
Srinivasan           CS-347
Wu                   FIN-201
Mozart               MU-199
Einstein             PHY-101
El Said              HIS-351
Katz                 CS-101
Katz                 CS-319
Crick                BIO-101
Crick                BIO-301
Brandt               CS-190
Brandt               CS-190
Brandt               CS-319
Kim                  EE-181

15 rows selected.


3. Write a query to retrieve name of the instructors and courses who taught Biology department courses.

SQL> select name,dept_name
  2  from instructoru
  3  where dept_name='Biology';

NAME                 DEPT_NAME
-------------------- --------------------
Crick                Biology


4. Write a query to retrieve the names of instructors, and title of the courses that they teach.

SQL> select i.name,c.title
  2  from instructoru i,courseu c,teachesu t
  3  where i.id=t.id and t.course_id=c.course_id;

NAME                 TITLE
-------------------- ------------------------------
Srinivasan           Intro.to Computer Science
Srinivasan           Robotics
Srinivasan           Database System Concepts
Wu                   Investment Banking
Mozart               Music Video Production
Einstein             Physical Principles
El Said              World History
Katz                 Intro.to Computer Science
Katz                 Image Processing
Crick                Intro.to Biology
Crick                Genetics
Brandt               Game Design
Brandt               Image Processing
Brandt               Game Design
Kim                  Intro.to Digital Systems

15 rows selected.


5. Write a query to retrieve the names of all instructors whose salary is greater than at least one instructor in the Biology department.

SQL> select name,salary
  2  from instructoru
  3  where salary>any(select salary
  4  from instructoru
  5  where dept_name='Biology');

NAME                     SALARY
-------------------- ----------
Wu                        90000
Einstein                  95000
Gold                      87000
Katz                      75000
Singh                     80000
Brandt                    92000
Kim                       80000

7 rows selected.


6. Write a query to retrieve names of all departments whose building name includes 'Watson'.

SQL> select dept_name
  2  from deptu
  3  where building in ('Watson');

DEPT_NAME
--------------------
Biology
Physics


7. Write a query to retrieve the names of the Physics department instructors in ascending order.

SQL> select name
  2  from instructoru
  3  where dept_name='Physics'
  4  order by name;

NAME
--------------------
Einstein
Gold


8. Write a query to retrieve the name and salary of instructors order by salary in descending order and 
   if more than one instructor have the same salary, order by names in ascending order.

SQL> select name,salary
  2  from instructoru
  3  order by salary desc,name;

NAME                     SALARY
-------------------- ----------
Einstein                  95000
Brandt                    92000
Wu                        90000
Gold                      87000
Kim                       80000
Singh                     80000
Katz                      75000
Crick                     72000
Srinivasan                65000
Califieri                 62000
El Said                   60000
Mozart                    40000

12 rows selected.


9. Write a query to retrieve the names of instructors whose salary amounts in the range $90,000 and $100,000.

SQL> select name,salary
  2  from instructoru
  3  where salary between 90000 and 100000;

NAME                     SALARY
-------------------- ----------
Wu                        90000
Einstein                  95000
Brandt                    92000


10. Write a query to retrieve all the courses taught in the Fall 2009 semester.

SQL> select c.title
  2  from courseu c,sectionu s
  3  where c.course_id=s.course_id and s.semester='Fall' and s.year=2009;

TITLE
------------------------------
Intro.to Computer Science
Database System Concepts
Physical Principles


11. Write a query to retrieve all the courses taught in the Spring 2010 semester.

SQL> select c.title
  2  from courseu c,sectionu s
  3  where c.course_id=s.course_id and s.semester='Spring' and s.year=2010;

TITLE
------------------------------
Intro.to Computer Science
Robotics
Image Processing
Image Processing
Investment Banking
World History
Music Video Production

7 rows selected.
