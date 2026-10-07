create or replace function fnc_trg_person_update_audit ()
returns trigger as $fnc_trg_person_update_audit$
begin
	insert into person_audit (type_event, row_id, name, age, gender, address)
	values (
	'U',
	old.id,
	old.name,
	old.age,
	old.gender,
	old.address
	);	
	return new;
end
$fnc_trg_person_update_audit$ language plpgsql;

create trigger trg_person_update_audit  
AFTER update on person
FOR EACH row
execute function fnc_trg_person_update_audit();

UPDATE person SET name = 'Bulat' WHERE id = 10; 
UPDATE person SET name = 'Damir' WHERE id = 10;

SELECT *
FROM person_audit
WHERE row_id = 10
ORDER BY created;