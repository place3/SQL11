drop function if exists fnc_persons_male();
drop function if exists fnc_persons_female();

create or replace function fnc_persons(pgender varchar default 'female')
returns setof person as $$
	select * from person where gender = pgender;
$$ language sql;

select *
from fnc_persons(pgender := 'male');

select *
from fnc_persons();