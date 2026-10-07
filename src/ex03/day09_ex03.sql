drop trigger if exists trg_person_insert_audit ON person;
drop trigger if exists trg_person_update_audit ON person;
drop trigger if exists trg_person_delete_audit ON person;

drop function if exists fnc_trg_person_insert_audit();
drop function if exists fnc_trg_person_update_audit();
drop function if exists fnc_trg_person_delete_audit();

truncate table person_audit;

create or replace function fnc_trg_person_audit()
returns trigger as $fnc_trg_person_audit$
begin
	if (tg_op = 'INSERT') then
		insert into person_audit select current_timestamp, 'I', new.*;
		return new;
	elseif (tg_op = 'UPDATE') then
		insert into person_audit select current_timestamp, 'U', old.*;
		return new;
	elseif (tg_op = 'DELETE') then
		insert into person_audit select current_timestamp, 'D', old.*;
		return old;
	end if;
return null;
end;
$fnc_trg_person_audit$ language plpgsql;

create trigger trg_person_audit    
AFTER insert or update or delete on person
FOR EACH row
execute function fnc_trg_person_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk'); 
UPDATE person SET name = 'Bulat' WHERE id = 10; 
UPDATE person SET name = 'Damir' WHERE id = 10; 
DELETE FROM person WHERE id = 10;

SELECT *
FROM person_audit;

