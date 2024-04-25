-- 교안 28p 과제 1

use testdb;

select * from Emp;

alter table Emp drop column auth;
alter table Emp add column auth tinyint not null 
  default 9 comment '권한(0:sys, 1:super, …, 9:guest)' after dept;
  
