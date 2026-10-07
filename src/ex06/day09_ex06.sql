create or replace function fnc_person_visits_and_eats_on_date(
	pperson varchar default 'Dmitriy',
	pprice bigint default 500,
	pdate date default '2022-01-08')
returns table (name varchar) as $$
begin
	return query
	select distinct pi.name from pizzeria pi
	join menu m on pi.id = m.pizzeria_id
	join person_order po on m.id = po.menu_id
	join person p on p.id = po.person_id
	where p.name = pperson
 	  and m.price < pprice
  	  and po.order_date = pdate;
end;
$$ language plpgsql;


select *  
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *  
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');