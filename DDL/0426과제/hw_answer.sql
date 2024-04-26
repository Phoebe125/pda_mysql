-- 4/26 과제 해설 
alter table Emp add column auth tinyint(1) default 9;

-- hw2
use testdb;
create table EmailLog(
	id int unsigned not null auto_increment primary key,
    sender int unsigned not null comment '발신자',
    receiver varchar(1024) not null comment '수신자',
    subject varchar(255) not null comment '제목', 
    body text null comment '내용',
    foreign key fk_EmailLog_sender_Emp (sender)
		references Emp(id) on update cascade on delete cascade
) ENGINE = MyIsam; -- InnoDB: Lock 이 걸려버려서 비효율적

-- 트랜잭션 지원이나 데이터 무결성이 중요하다면 InnoDB 엔진이 더 좋음
alter table EmailLog engine = MyISAM;

desc EmailLog;
show index from EmailLog;
analyze table EmailLog;
show table status;


-- hw3 
use schooldb;
select * from Student;
desc Student;

create table Prof (
	id smallint unsigned not null auto_increment primary key,
    name varchar(31) not null comment '교수명',
    likecnt int unsigned not null default 0 comment '좋아요 수'
);

create table Subject (
	id tinyint unsigned not null auto_increment,
    name varchar(31) not null comment '과목명',
    prof smallint unsigned null comment '담당선생님',
    foreign key fk_Subject_prof (prof) references Prof(id)
		on update cascade
        on delete set null
);

create table Enroll (
	id int unsigned not null auto_increment primary key,
	createdate timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
    updatedate timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '등록일시',
    subject tinyint unsigned not null comment '신청과목 ID',
    student int unsigned not null comment '신청학생',
    foreign key fk_Enroll_subject (subject) references Subject(id)
		on update cascade on delete cascade,
	foreign key fk_Enroll_student (student) references Student(id)
		on update cascade on delete cascade
);

-- alter
alter table Enroll add column createdate timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시' after id;
alter table Enroll add column updatedate timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '등록일시' after createdate;
select * from Enroll;

-- data 넣기 [insert에서 이어서 배움]
insert into Prof (name) select '교수' from testdb.Emp where id <= 6;
select * from Prof;
update Prof set name = concat(name, id);
update Prof set likecnt = floor(rand() * 100);

-- Unique 조건 추가
ALTER TABLE Enroll ADD CONSTRAINT unique_subject_student UNIQUE (subject, student);
ALTER TABLE Enroll ADD UNIQUE INDEX unique_subject_student (subject DESC, student ASC) VISIBLE; 
