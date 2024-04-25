-- 교안 31p 과제 2

use testdb;


CREATE TABLE EmailLog (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
    sender INT UNSIGNED NOT NULL COMMENT '송신자',
    receiver VARCHAR(1024) COMMENT '수신인',
    subject VARCHAR(1024) COMMENT '제목',
    body TEXT COMMENT '내용',
    PRIMARY KEY (id),
    FOREIGN KEY (sender) REFERENCES Emp(id) ON DELETE CASCADE ON UPDATE CASCADE
);



