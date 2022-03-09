create or replace function ncr(n number,r number)
return number as ncr1 number;
begin
	ncr1:= fact(n)/(fact(r)*fact(n-r));
	return ncr1;
end;