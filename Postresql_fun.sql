create or replace function get_cust1(integer) returns text as
$$
declare
custno alias for $1;
cust customer%rowtype ;
begin
select into cust * from customer where customer_id=custno;
return cust.fname ||''|| cust.lname;
end;
$$ language 'plpgsql';


create or replace function get_cust_id(text,text) returns integer as
$$
declare
first_name alias for $1;
last_name alias for $2;
cust_id customer.customer_id%type;
begin
select into cust_id customer_id from customer where first_name=fname and last_name=lname;
if not found then
return -1;
else
return cust_id;
end if;
end;
$$ language 'plpgsql';


create or replace function datareturn(integer) returns text as
$$
declare
mya alias for $1;
mya1 myint.a%type;
pnt text;
begin
select into mya1 a from myint where a=mya ;
if (mya1=0)
then
pnt:='zero';
elsif (mya1>0)
then
pnt:='positive';
else
pnt:='negative';
end if;
return pnt;
end;
$$ language 'plpgsql';


create or replace function dtr(integer) returns text as
$$
declare
mya alias for $1;
mya1 myint.a%type;
msg text;
beginm
select into mya1 a from myint where a=mya ;
case
when mya1 between 0 and 100 then
msg:='value is between zero and 100';
when mya1 between -1 and -100 then
msg:='value is between -1 and -100';
else
msg:='NULL';
end case;
return msg;
end;
$$ language 'plpgsql';

create or replace function mycom(integer) returns integer as
$$
declare
sum integer;
a alias for $1;
begin
sum:=0;
loop
sum:=sum+a;
a=a-1;
exit when a=0 ;
end loop;
return sum;
end;
$$ language 'plpgsql';

create or replace function myfact(integer) returns integer as
$$
declare
sum integer;
a alias for $1;
begin
sum:=1;
loop
sum:=sum*a;
a=a-1;
exit when a=0 ;
end loop;
return sum;
end;
$$ language 'plpgsql';


create or replace function myfibo(integer) returns text as
$$
declare
list text;
msg text;
n1 integer;
n2 integer;
n3 integer;
a alias for $1;
begin
msg:=' ';
n1:=0;
n2:=1;
list= n1 || msg;
loop
list= list || n2 || msg;
n3=n1+n2;
n1=n2;
n2=n3;
a=a-1;
exit when a=1 ;
end loop;
return list;
end;
$$ language 'plpgsql';


create or replace function myprime(integer) returns text as
$$
declare
msg text;
i integer;
n alias for $1;
begin
i:=2;
while (i!=n) loop

if (n%i=0)
then 
msg:= 'not prime';
exit when msg='not prime';
else
i=i+1;
msg:='prime';
end if;

end loop;
return msg;
end;
$$ language 'plpgsql';

create or replace function prime_numbers(integer) returns text as
$$
declare
list text;
space text;
i integer;
j integer;
n alias for $1;
begin
space=' ';
i:=2;
j:=2;
list= 1 || space || 2 ||space;
while (i!=n) loop

while (j!=i) loop
exit when (i%j=0);
list=list || i || space;
j=j+1;
end loop;

i=i+1;
end loop;
return list;
end;
$$ language 'plpgsql';

create or replace function My_Fib2(fib_for integer)
returns
setof integer as
$$
declare
retval integer := 0;
nxtval integer := 1;
tmpval integer;
begin
for num in 1..fib_for LOOP
return next retval;
tmpval := retval;
retval := nxtval;
nxtval := tmpval + nxtval;
end loop;
end;
$$ language plpgsql;

create or replace function My_Fib3(fib_for integer)
returns
integer AS
$$
begin
if fib_for < 2 then
return fib_for;
end if;
return My_fib3(fib_for-2)+My_fib(fib_for-1);
end;
$$ language plpgsql;

create or replace function My_Fib3(fib_for integer)
returns
integer AS
$$
begin
if fib_for < 2 then
return fib_for;
end if;
return My_Fib3(fib_for-2) + My_Fib3(fib_for-1);
end;
$$ language plpgsql;

create table mytab(firstname char(10),lastname char(10));
insert into mytab(firstname,lastname) values ('supriya','shahane');
begin 
update mytab set firstname = 'shital' where lastname = 'shahane';
x := x+1;
y := x/0;
exception
when division_by_zero then
raise notice 'caught division by zero';
return x;
end;

create function My_sum (text,text) returns text as
$$
select $1 || ' ' || $2
$$ language sql;

create operator +(
procedure = My_sum,
leftarg = text,
rightarg = text
);

create or replace function My_Power(integer,integer)
returns
integer as
$$
declare
num alias for $1;
raiseto alias for $2;
index1 integer;
product integer:= 1;
begin
for index1 in 1..raiseto loop
product :=product*num;
end loop;
return product;
end;
$$ language plpgsql;

create operator^(
procedure = My_Power,
leftarg = integer,
rightarg = integer);

create table emp (name text,salary numeric);
create function double_salary(emp)returns numeric as
$$
select $1.salary*2 as salary;
$$ language sql;
select name,double_salary(row(name,salary*1.1))as dream from emp;

create table sqr (number integer,square numeric);
create function sqr_number(sqr) returns numeric as
$$
select $1.number^2 as square;
$$ language sql;
select number,sqr_number(row(number,squqre*1.1))as square1 from sqr;

create function myappend(anyarray,anyelement) returns
anyarray as
$$
select $1 || $2;
$$ language sql;

 variadiac -function take undefined no. of i\p parameter

create function Mymin(variadic numeric[]) returns numeric 
as $$
select min($1[i]) from genrate_subscripts($1,1) g(i);
$$ languege 'sql';

create function MyCombine(variadic text[]) returns text as
$$
select array_to_string($1,'');
$$ language 'sql';

create or replace function myConcate (text,anyelement) returns text as
$$
select concat(',',$1) $$ language 'sql';
create aggregate str_myAgg(anyelement) (sfunc = myConcate,stype = text);
CREATE FUNCTION
CREATE AGGREGATE

create or replace function myConcate (anyelement) returns text as
$$
select concat($1,',') $$ language 'sql';
create aggregate str_myAgg(anyelement) (sfunc = myConcate,stype = text);
CREATE FUNCTION
CREATE AGGREGATE













