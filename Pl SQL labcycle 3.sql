1. Write a PL/SQL block to do the following:

a) Read a number and print its multiplication table

.sql code:

declare
	n number:=&n;
	i number;
begin
	for i in 1..10
	loop
		dbms_output.put_line(n||' x '||i||' = '||n*i);
	end loop;
end;

output:

SQL> @Z:\DBMS\PlSql\multable.sql;
 10  /
Enter value for n: 5
old   2:        n number:=&n;
new   2:        n number:=5;
5 x 1 = 5
5 x 2 = 10
5 x 3 = 15
5 x 4 = 20
5 x 5 = 25
5 x 6 = 30
5 x 7 = 35
5 x 8 = 40
5 x 9 = 45
5 x 10 = 50

PL/SQL procedure successfully completed.

b) Read a number and check whether it is a palindrome or not

.sql code:

declare
	n number:=&n;
	temp number;
	digit number;
	rev number:=0;
begin
	temp:=n;
	while temp>0 loop
		digit:=mod(temp,10);
		rev:=rev*10+digit;
		temp:=trunc(temp/10);
	end loop;
	if n=rev
	then
		dbms_output.put_line(n||' is a palindrom');
	else
		dbms_output.put_line(n||' is not a palindrom');
	end if;
end;

output:

SQL> @Z:\DBMS\PlSql\palindrom.sql;
 20  /
Enter value for n: 12321
old   2:        n number:=&n;
new   2:        n number:=12321;
12321 is a palindrom

PL/SQL procedure successfully completed.

SQL> /
Enter value for n: 12345
old   2:        n number:=&n;
new   2:        n number:=12345;
12345 is not a palindrom

PL/SQL procedure successfully completed.

c) Read a number n, and print the first n Fibonacci numbers

.sql code:

declare
	n number:=&n;
	n1 number:=0;
	n2 number:=1;
	n3 number;
	i number;
begin
	dbms_output.put_line('The Fibonacci series of '||n||' elements is : ');
	dbms_output.put(n1||'  ');
	dbms_output.put(n2||'  ');
	for i in 2..n
	loop
		n3:=n1+n2;
		dbms_output.put(n3||'  ');
		n1:=n2;
		n2:=n3;
	end loop;
	dbms_output.put_line(' ');
end;

output:

SQL>  @Z:\DBMS\PlSql\fibonacci.sql;
 20  /
Enter value for n: 10
old   2:        n number:=&n;
new   2:        n number:=10;
The Fibonacci series of 10 elements is :
0  1  1  2  3  5  8  13  21  34  55

PL/SQL procedure successfully completed.

2. Write a PL/SQL block which will accept two numbers and find out their LCM and HCF. The output should be stored in a table called DEMO_TAB.

creating table demo_tab:

SQL> create table demo_tab(
  2  num1 number,
  3  num2 number,
  4  gcd number,
  5  lcm number);

Table created.

.sql code:

declare
	a number:=&a;
	b number:=&b;
	gcd number;
	lcm number;
	m number;
	n number;
begin
	m:=a;
	n:=b;
	while m!=n loop
		if m<n then
			n:=n-m;
		else
			m:=m-n;
		end if;
	end loop;
	gcd:=n;
	lcm:=(a*b)/gcd;
	insert into demo_tab values(a,b,gcd,lcm);
	dbms_output.put_line('Gcd = '||gcd||' and Lcm = '||lcm);
end;

output:

SQL> @Z:\DBMS\PlSql\lcm.sql
 23  /
Enter value for a: 3
old   2:        a number:=&a;
new   2:        a number:=3;
Enter value for b: 5
old   3:        b number:=&b;
new   3:        b number:=5;

PL/SQL procedure successfully completed.

SQL> select *
  2  from demo_tab;

      NUM1       NUM2        GCD        LCM
---------- ---------- ---------- ----------
         3          5          1         15

3. Consider the following relation schemas
   
Inventory
Product_ID	Product_name	Quantity

Purchase_Record
Product_ID	Status	Date

Write a PL/SQL block to read the quantity of a product from inventory and if it is > 0 reduce the quantity by 1 and record the status of purchase of that product as ‘PURCHASED’. 
Otherwise record the status of purchase of that product as ‘OUT OF STOCK’. While recording the status of a purchase, record the date of transaction.

creating table inventory:

SQL> create table inventory(
  2  product_id number,
  3  product_name varchar(20),
  4  quantity number);

Table created.

.sql code to insert rows into inventory table:

insert into inventory values(101,'Car',10);
insert into inventory values(102,'Bike',1);
insert into inventory values(103,'Scooty',-10);
insert into inventory values(104,'Lorry',5);
insert into inventory values(105,'Bus',-1);

output:

SQL> @Z:\DBMS\PlSql\inventory.sql;

1 row created.

1 row created.

1 row created.

1 row created.

1 row created.

displaying inventory table:

SQL> select *
  2  from inventory;

PRODUCT_ID PRODUCT_NAME           QUANTITY
---------- -------------------- ----------
       101 Car                          10
       102 Bike                          1
       103 Scooty                      -10
       104 Lorry                         5
       105 Bus                          -1

creating purchase_record table:

SQL> create table purchase_record(
  2  purchase_id number,
  3  status varchar(20),
  4  date_of_purc date);

Table created.

.sql code:

declare
	qty inventory.quantity%type;
	pid inventory.product_id%type:=&pid;
begin
	select quantity into qty
	from inventory
	where product_id=pid;
	if qty>0
	then
		update inventory set quantity=quantity-1
		where product_id=pid;
		insert into purchase_record values(pid,'PURCHASED',sysdate);
	else
		insert into purchase_record values(pid,'OUT OF STOCK',sysdate);
	end if;
end;

output:

SQL>  @Z:\DBMS\PlSql\purchaserec.sql;
 17  /
Enter value for pid: 103
old   3:        pid inventory.product_id%type:=&pid;
new   3:        pid inventory.product_id%type:=103;

PL/SQL procedure successfully completed.

SQL> /
Enter value for pid: 102
old   3:        pid inventory.product_id%type:=&pid;
new   3:        pid inventory.product_id%type:=102;

PL/SQL procedure successfully completed.

SQL> /
Enter value for pid: 101
old   3:        pid inventory.product_id%type:=&pid;
new   3:        pid inventory.product_id%type:=101;

PL/SQL procedure successfully completed.

SQL> /
Enter value for pid: 104
old   3:        pid inventory.product_id%type:=&pid;
new   3:        pid inventory.product_id%type:=104;

PL/SQL procedure successfully completed.

SQL> /
Enter value for pid: 105
old   3:        pid inventory.product_id%type:=&pid;
new   3:        pid inventory.product_id%type:=105;

PL/SQL procedure successfully completed.

SQL> select *
  2  from purchase_record;

PURCHASE_ID STATUS               DATE_OF_P
----------- -------------------- ---------
        103 OUT OF STOCK         07-MAR-22
        102 PURCHASED            07-MAR-22
        101 PURCHASED            07-MAR-22
        104 PURCHASED            07-MAR-22
        105 OUT OF STOCK         07-MAR-22

SQL> select *
  2  from inventory;

PRODUCT_ID PRODUCT_NAME           QUANTITY
---------- -------------------- ----------
       101 Car                           9
       102 Bike                          0
       103 Scooty                      -10
       104 Lorry                         4
       105 Bus                          -1

4. Consider the following relation schemas

Emp
empid	name	salary	dno

Del_History
dno	Rows_deleted	date

Write a PL/SQL block to delete records of all employees who belong to a particular department and then record the dno,
no of rows deleted and date on which deletion occurred in the Del_History table. 

creating table emp:

SQL> create table emp(
  2  empid number,
  3  name varchar(20),
  4  salary number,
  5  dno number);

Table created.

.sql code to insert rows into emp table:

insert into emp values(10101,'Smith',65000,3);
insert into emp values(20202,'Scott',70000,3);
insert into emp values(30303,'Steve',90000,2);
insert into emp values(40404,'Tony',85000,1);
insert into emp values(50505,'Peter',100000,1);

output:

SQL> @Z:\DBMS\PlSql\emp.sql;

1 row created.

1 row created.

1 row created.

1 row created.

1 row created.

displaying emp table:

SQL> select *
  2  from emp;

     EMPID NAME                     SALARY        DNO
---------- -------------------- ---------- ----------
     10101 Smith                     65000          3
     20202 Scott                     70000          3
     30303 Steve                     90000          2
     40404 Tony                      85000          1
     50505 Peter                    100000          1

creating table del_history:

SQL> create table del_history(
  2  dno number,
  3  rows_deleted number,
  4  date_of_del date);

Table created.

.sql code:

declare
	d emp.dno%type:=&d;
	cnt number;
	cursor c is select (dno) from emp where dno=d;
begin
	open c;
	delete from emp where dno=d;
	if sql%found
	then
		cnt:=sql%rowcount;
		insert into del_history values (d,cnt,sysdate);
	else
		dbms_output.put_line('No data exist in emp table with entered dno');
	end if;
end;

output:

SQL>  @Z:\DBMS\PlSql\delrec.sql;
 16  /
Enter value for d: 3
old   2:        d emp.dno%type:=&d;
new   2:        d emp.dno%type:=3;

PL/SQL procedure successfully completed.

SQL> select *
  2  from emp;

     EMPID NAME                     SALARY        DNO
---------- -------------------- ---------- ----------
     30303 Steve                     90000          2
     40404 Tony                      85000          1
     50505 Peter                    100000          1

SQL> select *
  2  from del_history;

       DNO ROWS_DELETED DATE_OF_D
---------- ------------ ---------
         3            2 07-MAR-22

5. Write a PL/SQL block to display all the records of a table using explicit cursor.

Consider the following relation schemas

Bank_Main
Acc_no	Name	Address	Acc_type	Curr_balance

Bank_Trans
Acc_no	Tr_type	Tr_date	Tr_amt	Upd_flag

Where acc_type is S – savings C- current 
Tr_type is D – deposit W – withdrawal 

Write a PL/SQL block to update master table’s (i.e., Bank_Main) curr_balance field with transaction details from transaction file (i.e., Bank_Trans) 
and also change the status of the Upd_flag field of transaction table to ‘Y’ once the updation is complete.

creating bank_main and bank_trans tables:

SQL> create table bank_main(
  2  acc_no number,
  3  name varchar(20),
  4  address varchar(20),
  5  acc_type varchar(20),
  6  curr_balance number);

Table created.

SQL> create table bank_trans(
  2  acc_no number,
  3  tr_type char,
  4  tr_date date,
  5  tr_amt number,
  6  upd_flag char);

Table created.

.sql codes to insert rows into bank_main and bank_trans tables:

insert into bank_main values(10101,'Smith','Guntur','Savings',65000);
insert into bank_main values(20202,'Scott','Vijayawada','Current',70000);
insert into bank_main values(30303,'Steve','Newyork','Savings',90000);
insert into bank_main values(40404,'Tony','Newyork','Savings',85000);
insert into bank_main values(50505,'Peter','Queens','Current',100000);
insert into bank_trans values(10101,'W','10-OCT-21',5000,'Y');
insert into bank_trans values(30303,'D','05-MAR-22',10000,'N');
insert into bank_trans values(40404,'W','10-SEP-21',15000,'N');
insert into bank_trans values(50505,'D','19-NOV-20',7000,'Y');

output:

SQL>  @Z:\DBMS\PlSql\bank.sql;

1 row created.

1 row created.

1 row created.

1 row created.

1 row created.

1 row created.

1 row created.

1 row created.

1 row created.

SQL> select *
  2  from bank_main;

    ACC_NO NAME                 ADDRESS              ACC_TYPE             CURR_BALANCE
---------- -------------------- -------------------- -------------------- ------------
     10101 Smith                Guntur               Savings                     65000
     20202 Scott                Vijayawada           Current                     70000
     30303 Steve                Newyork              Savings                     90000
     40404 Tony                 Newyork              Savings                     85000
     50505 Peter                Queens               Current                    100000

SQL> select *
  2  from bank_trans;

    ACC_NO T TR_DATE       TR_AMT U
---------- - --------- ---------- -
     10101 W 10-OCT-21       5000 Y
     30303 D 05-MAR-22      10000 N
     40404 W 10-SEP-21      15000 N
     50505 D 19-NOV-20       7000 Y

.sql code:

declare
	acc bank_trans.acc_no%type;
	ttype bank_trans.tr_type%type;
	tamt bank_trans.tr_amt%type;
	cursor bank is select acc_no,tr_type,tr_amt from bank_trans
	where upd_flag='N';
begin
	open bank;
	loop
		fetch bank into acc,ttype,tamt;
		exit when bank%notfound;
		if ttype='D'
		then
			update bank_main set curr_balance=curr_balance+tamt
			where acc_no=acc;
			update bank_trans set upd_flag='Y'
			where acc_no=acc;
		elsif ttype='W'
		then
			update bank_main set curr_balance=curr_balance-tamt
			where acc_no=acc;
			update bank_trans set upd_flag='Y'
			where acc_no=acc;
		end if;
	end loop;
end;

output:

SQL> @Z:\DBMS\PlSql\banktrans.sql;
 27  /

PL/SQL procedure successfully completed.

SQL> select *
  2  from bank_main;

    ACC_NO NAME                 ADDRESS              ACC_TYPE             CURR_BALANCE
---------- -------------------- -------------------- -------------------- ------------
     10101 Smith                Guntur               Savings                     65000
     20202 Scott                Vijayawada           Current                     70000
     30303 Steve                Newyork              Savings                    100000
     40404 Tony                 Newyork              Savings                     70000
     50505 Peter                Queens               Current                    100000

SQL> select *
  2  from bank_trans;

    ACC_NO T TR_DATE       TR_AMT U
---------- - --------- ---------- -
     10101 W 10-OCT-21       5000 Y
     30303 D 05-MAR-22      10000 Y
     40404 W 10-SEP-21      15000 Y
     50505 D 19-NOV-20       7000 Y

6. Write a PL/SQL block to handle the following built-in exceptions
   no_data_found
   too_many_rows
   zero_divide  

.sql code:

declare
	nam emp.name%type;
	eno emp.empid%type;
	m number:=1;
	n number:=0;
begin
	begin
		select name into nam
		from emp
		where dno=4;
	exception
		when NO_DATA_FOUND then
		dbms_output.put_line('There is no data in emp table with dno = 4');
	end;
	begin
		select empid into eno
		from emp;
	exception
		when TOO_MANY_ROWS then
		dbms_output.put_line('SELECT statement retrieved multiple rows, so try to use cursor');
	end;
	begin
		dbms_output.put_line(m/n);
	exception
		when ZERO_DIVIDE then
		dbms_output.put_line('Division is not possible with denominator = 0');
	end;
end;

output:

SQL>  @Z:\DBMS\PlSql\inbuiltexc.sql;
 29  /
There is no data in emp table with dno = 4
SELECT statement retrieved multiple rows, so try to use cursor
Division is not possible with denominator = 0

PL/SQL procedure successfully completed.

7. Write a PL/SQL block to check whether the quantity of any product in Inventory table of problem 3 is < 0. If so, 
   using an exception display relevant message and update quantity to 0.

declare
pid inventory.product_id%type ;
invalid_qty exception;
begin
	select product_id into pid from inventory where quantity<0;
	if sql%found
	then 
		raise invalid_qty;
	end if;
exception
	when no_data_found then
		dbms_output.put_line('NO DATA FOUND');
	when too_many_rows then 
		dbms_output.put_line('more than one row selected where only 1 is expected');
	when invalid_qty then 
		dbms_output.put_line('INVALID QUANTITY');
		update inventory set quantity=0 where product_id=pid;
end;

output:

SQL> @Z:\Dbms\PlSql\userdefexc2.sql;
 19  /
more than one row selected where only 1 is expected

PL/SQL procedure successfully completed.
