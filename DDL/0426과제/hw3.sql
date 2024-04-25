-- 교안 32p 과제 3

use schooldb;

create table Prof(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    name varchar(31) NOT NULL COMMENT '이름',
	likecnt int default 0 COMMENT '좋아요 개수',
    PRIMARY KEY (id)
);

select * from Prof;

create table Subject (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    name varchar(32) NOT NULL COMMENT '과목명',
    prof INT UNSIGNED COMMENT '담당 교수 id',
    PRIMARY KEY (id),
    FOREIGN KEY (prof) REFERENCES Prof(id) ON DELETE SET NULL ON UPDATE CASCADE
);

select * from Subject;

create table Enroll (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    subject INT UNSIGNED COMMENT '과목명',
	student INT UNSIGNED COMMENT '학생 id',
    PRIMARY KEY (id),
    FOREIGN KEY (student) REFERENCES Student(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (subject) REFERENCES Subject(id) ON DELETE CASCADE ON UPDATE CASCADE
);

select * from Enroll;

-- 1. Prof 
show index from Prof;

-- 2. Subject
show index from Subject;

-- 3. Enroll
show index from Enroll;

-- 4. Student
show index from Student;