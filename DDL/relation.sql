use schooldb;

alter table Student add constraint fk_Student_Major_id 
foreign key (major) references Major(id) 
on update cascade
on delete restrict;

