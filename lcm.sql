declare
     a number:=&a;
     b number:=&b;
     lcm number;
     gcd number;
     lcm number;
     gcd number;
 begin
         while a<>b loop
                            if a<b then
                            b:=b-a;
                             else
                             a:=a-b;
                             end if;
         end loop;
         gcd:=b;
          lcm:=(a1*b1)/b;
          insert into demo_tab1 values(a1,b1,gcd,lcm);
           dbms_output.put_line(gcd||' '||lcm);
