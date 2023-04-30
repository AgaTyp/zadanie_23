create table if not exists employees (
    id int primary key AUTO_INCREMENT,
    first_name varchar(30),
    last_name varchar(30),
    date_of_birth date,
    salary decimal(5,2),
    position varchar(40)
);

insert into employees (first_name, last_name, date_of_birth, salary, position) VALUES ('Sebastian', 'Makowski', '1999-07-05', 6500.00, 'młodszy programista');
insert into employees (first_name, last_name, date_of_birth, salary, position) VALUES ('Edyta', 'Sosna', '1994-02-14', 9500.00, 'programista');
insert into employees (first_name, last_name, date_of_birth, salary, position) VALUES ('Michał', 'Masłowski', '1985-05-14', 7500.00, 'analityk systemowy');
insert into employees (first_name, last_name, date_of_birth, salary, position) VALUES ('Oskar', 'Kwiatkowski', '1985-05-14', 6500.00, 'tester');
insert into employees (first_name, last_name, date_of_birth, salary, position) VALUES ('Ewa', 'Orzechowska', '1987-07-20', 9500.00, 'programista');
insert into employees (first_name, last_name, date_of_birth, salary, position) VALUES ('Monika', 'Woda', '1993-03-05', 4500.00, 'tester');
insert into employees (first_name, last_name, date_of_birth, salary, position) VALUES ('Monika', 'Osowska', '1999-07-05', 4500.00, 'młodszy tester');

select * from employees order by last_name;
select * from employees where position='tester';
select * from employees where (current_date - employees.date_of_birth) / 365 >= 30;
update employees set salary=(salary * 1.1) where position = 'programista';

select * from employees where date_of_birth = (select e.date_of_birth from employees e order by e.date_of_birth desc limit 1);

drop table employees;

create table if not exists position (
    id int primary key AUTO_INCREMENT,
    name varchar(40) unique not null,
    description varchar(1000),
    salary decimal(5,2) not null
);

create table if not exists address (
    id int primary key AUTO_INCREMENT,
    street varchar(40) not null,
    block_no_apartment_no varchar(10),
    zip_code varchar(10),
    city varchar(100) not null
);

create table if not exists employees (
    id int primary key AUTO_INCREMENT,
    first_name varchar(30) not null,
    last_name varchar(30) not null,
    position_id int not null,
    address_id int not null,
    constraint fk_position_id foreign key (position_id) references position (id),
    constraint fk_address_id foreign key (address_id) references address (id)
);

insert into position (name, description, salary) values ('młodszy programista', 'młodszy programista java', 6500.00);
insert into position (name, description, salary) values ('programista', 'programista java', 9500.00);
insert into position (name, description, salary) values ('młodszy tester', 'młodszy tester automatyczny', 6800.00);
insert into position (name, description, salary) values ('tester', 'tester automatyczny', 8800.00);

insert into address (street, block_no_apartment_no, zip_code, city) values ('Al. Jerozolimskie', '150/50', '03-765', 'Warszawa');
insert into address (street, block_no_apartment_no, zip_code, city) values ('Marszałkowska', '80/13', '02-675', 'Warszawa');
insert into address (street, block_no_apartment_no, zip_code, city) values ('Grójecka', '70/7', '01-375', 'Warszawa');
insert into address (street, block_no_apartment_no, zip_code, city) values ('Powstańców Śląskich', '125/50', '01-390', 'Warszawa');


-- select * from position;
-- select * from address;
-- select * from employees;

insert into employees (first_name, last_name, position_id, address_id) values ('Sebastian', 'Makowski', 1, 1);
insert into employees (first_name, last_name, position_id, address_id) values ('Zofia', 'Makowska', 2, 1);
insert into employees (first_name, last_name, position_id, address_id) values ('Edyta', 'Sosna', 3, 2);
insert into employees (first_name, last_name, position_id, address_id) values ('Michał', 'Masłowski', 2, 3);
insert into employees (first_name, last_name, position_id, address_id) values ('Ewa', 'Orzechowska', 4, 4);

select e.first_name, e.last_name, p.name, a.street, a.block_no_apartment_no, a.zip_code, a.city from employees e
    join position p on p.id = e.position_id
    join address a on a.id = e.address_id;

select sum(p.salary) from employees e
    join position p on p.id = e.position_id;

select e.first_name, e.last_name, a.street, a.block_no_apartment_no, a.zip_code, a.city from employees e
    join address a on a.id = e.address_id
where a.zip_code = '03-765';
