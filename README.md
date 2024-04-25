## 신한투자증권 프로디지털 아카데미 DB 실습

### Table 생성
```sql
CREATE TABLE [IF NOT EXISTS] Student (
	id int unsigned not null auto_increment COMMENT '학번',
	name varchar(31) not null COMMENT '학생명',
	createdate timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
     updatedate timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '등록일시',
	graduatedt varchar(10) DEFAULT NULL COMMENT '졸업일',
	auth tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '0:sys, 1:super, ...9:guest',
	…,
	PRIMARY KEY (id),
	FOREIGN KEY <key-name>(col3)
       REFERENCES Tbl1(id) ON [DELETE|UPDATE] [CASCADE | SET NULL | NO ACTION | SET DEFAULT]
  	UNIQUE KEY unique_stu_id_name (createdate, name)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
desc Student;
```

### Datetime VS Timestamp
- Datetime is constant variable(8B)  '2024-12-03 15:33:45.9'  
- Timestamp is snapshot fot UTC time (4B)   Y38 Problem  
  - (TIMESTAMP range : '1970-01-01 00:00:01'UTC ~ '2038-01-19 03:14:07'UTC)  
- 시간과 관련된 sql
- `select now(), sysdate(), curdate(), curtime();`
- `select year(now()), month(now()), day(now()), hour(now()), minute(now()), second(now());`
- `set time_zone = 'Asia/Seoul';  (same as KST)`
- `set global time_zone = 'UTC';    -- root authority`