create or replace function fnc_fibonacci(pstop integer default 10)
returns table(num integer) as $$
declare
	a integer := 0;
	b integer := 1;
	c integer;
begin
	loop
		if a >= pstop then 
			exit;
		end if;
	num := a;
	return next;
	c := a + b;
    a := b;
    b := c;
	end loop;
	return;
end;
$$ language plpgsql;

SELECT * FROM fnc_fibonacci(100);