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

<hr>

### Index

[Clustered vs NonClustered (index 개념)](https://gwang920.github.io/database/clusterednonclustered/)

[데이터베이스 인덱스 (2) - 클러스터형 인덱스와 비클러스터형 인덱스](https://hudi.blog/db-clustered-and-non-clustered-index/)

![클러스터 인덱스 vs 비클러스터 인덱스](./docs/Untitled%20(20).png)

1. Cluster Index  
    - prime, 최우선으로 설정  
    - 항상 순서를 유지함  
    - insert, update 작업에 대해 부하가 많다.  
    - insert, update 작업이 많은 경우 pk를 만들지 않음 ⇒ unique key 만듦  
    - Cluster index 효율성을 위해 id가 생김  
    - ORM을 위해 id 생성  
    - 정보를 json 형태로 뒤에 붙여줌  
2. Non-Cluster Index  

### PAGE = 일종의 BUFFER  

- BUFFER를 만들어서 streaming 해야한다  
- 데이터든 index든 page 단위로  
- flush: Buffer를 비운다, 지금 당장 적용해야하는 경우에 flush 실행해야 한다.

### INSERT 팁들…

- insert 여러개할때, for문으로 돌리지 말고
- [{}, {}] 이런식으로 array를 넣어서
- 데이터베이스 단에서 for문이 돌아가도록 설정

### prepared statement

- 데이터베이스에 쿼리 cache 올라가져 있음
- 컴파일 되면, AST 가 되어 있음
- 다음에 또 요청이 오면, parsing하는 time을 갖지 않고 cache에 있는거 실행하면 되니까 보다 빠르게 실행할 수 있다.
- prepared statement이다 == Query Cache에 있다 == parsing 되어져 있다
- SQL Injection 공격에 안전해 진다.
- Prepared statement은 데이터베이스에서 쿼리를 실행하기 전에 미리 준비된 구조를 가지고 있는 SQL 문장입니다. 이를 통해 SQL 인젝션과 같은 보안 문제를 방지하고 성능을 향상시킬 수 있습니다.
- 일반적으로 SQL 문장은 사용자로부터 입력된 데이터를 포함하고 있습니다. 그러나 이는 보안 상의 위험을 초래할 수 있습니다. 예를 들어, 사용자로부터 입력받은 데이터가 악의적인 SQL 코드일 경우, 이를 실행하면 데이터베이스가 손상될 수 있습니다. 이를 방지하기 위해 prepared statement를 사용합니다.
- Prepared statement를 사용하면 SQL 쿼리가 데이터가 삽입될 위치를 placeholder(자리표시자)로 대체합니다. 이후 데이터가 삽입될 때, 데이터베이스는 쿼리를 새로 컴파일할 필요 없이 즉시 실행할 수 있습니다. 이로써 성능이 향상되며, SQL 인젝션과 같은 보안 문제를 방지할 수 있습니다.

### Truncate와 Drop의 차이

1. **Truncate**
- Truncate는 테이블의 모든 행을 삭제합니다. 즉, 테이블의 데이터를 완전히 지웁니다.
- 그러나 Truncate는 테이블의 구조를 변경하지 않습니다. 즉, 테이블의 기본 틀(schema)은 그대로 유지됩니다.
- 또한, Truncate는 롤백이 불가능합니다. 즉, 한 번 실행되면 복구할 수 없습니다.
- Truncate는 대규모 데이터를 삭제할 때 Drop보다 훨씬 빠릅니다. 그러나 테이블에 관계가 있는 외래 키(Foreign Key) 제약 조건이 있으면 Truncate를 사용할 수 없습니다.

1. **Drop**
- Drop은 테이블 자체를 삭제합니다. 즉, 테이블의 데이터와 구조 모두를 제거합니다.
- 따라서 Drop을 사용하면 테이블의 모든 데이터와 테이블 스키마가 사라지므로 매우 주의해야 합니다.
- Drop은 테이블을 완전히 제거하므로 데이터베이스에서 해당 테이블의 모든 관련 정보가 사라집니다.
- Drop은 롤백이 가능합니다. 즉, 트랜잭션 내에서 실행한 후 롤백하면 테이블을 다시 복원할 수 있습니다.

간단히 말하자면, Truncate는 테이블의 데이터만 삭제하고 구조를 유지하며, Drop은 테이블의 데이터와 구조를 모두 삭제합니다. Drop을 사용할 때에는 테이블이 정말로 삭제되길 원하는지 신중히 고려해야 합니다.

### Trigger

- AOP: Aspect(관점)의 분리를 통해 모듈화하는 기법을 제공
- 형 변환 (utf8 → Application에서 사용하는 형)으로 변환해주는 역할을 제공하기도 함
- Trigger를 남발하지 마세욥…!
- Trigger가 숨겨져 있는 경우가 많아서 데이터가 꼬이는 경우가 있음, 최종 관리자 권한


### 기타 json function
![json function](./docs/화면%20캡처%202024-04-29%20143510.png)