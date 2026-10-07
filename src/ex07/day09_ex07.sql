create or replace function func_minimum(arr numeric[])
returns numeric as $$
declare
	minimum numeric;
	i integer;
begin
	if array_length(arr, 1) is null 
	then return null;
	end if;
	minimum := arr[1];
	for i in 1..array_length(arr, 1) loop
		if arr[i] < minimum 
		then minimum := arr[i];
		end if;
	end loop;
return minimum;
end
$$ language plpgsql;

SELECT func_minimum(ARRAY[5, 2, 9, -3, 7, 0]);
