create or replace function fnc_trg_person_delete_audit ()
returns trigger as $fnc_trg_person_delete_audit$
begin
	insert into person_audit (type_event, row_id, name, age, gender, address)
	values (
	'D',
	old.id,
	old.name,
	old.age,
	old.gender,
	old.address
	);	
	return old;
end
$fnc_trg_person_delete_audit$ language plpgsql;

create trigger trg_person_delete_audit   
AFTER DELETE on person
FOR EACH row
execute function fnc_trg_person_delete_audit();

DELETE FROM person WHERE id = 10;

SELECT *
FROM person_audit;