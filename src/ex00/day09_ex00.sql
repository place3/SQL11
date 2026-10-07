create table person_audit(
	created timestamp with time zone NOT null default current_timestamp,
	type_event char(1) default 'I' NOT null,
	row_id bigint not null,
	name varchar,
	age integer,
	gender varchar,
	address varchar,
	constraint ch_type_event check (type_event in ('I', 'U', 'D'))
);

create or replace function fnc_trg_person_insert_audit()
returns trigger as $fnc_trg_person_insert_audit$
begin
	insert into person_audit (row_id, name, age, gender, address)
	values (
	new.id,
	new.name,
	new.age,
	new.gender,
	new.address
	);	
	return new;
end
$fnc_trg_person_insert_audit$ language plpgsql;

create trigger trg_person_insert_audit 
AFTER insert on person
FOR EACH row
execute function fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age, gender, address) 
VALUES (11,'Damir', 22, 'male', 'Irkutsk');
SELECT *
FROM person_audit;