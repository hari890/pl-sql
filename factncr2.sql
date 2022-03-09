Declare
	n number := &n;
	r number := &r;
	ncr number;
begin
	ncr:= fact(n)/(fact(n-r)*fact(r));
	dbms_output.put_line('the ncr value is :'||ncr);
end;
/