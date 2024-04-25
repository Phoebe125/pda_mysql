use testdb;

alter table Dept add column captin int unsigned null comment '부서장';

select * from Dept;

alter table Dept add constraint fk_captin_Emp 
foreign key (captin)
references Emp(id)
on delete set null
on update cascade;

select * from Dept;