-- 테이블(Table)
-- 표 형태로 구성된 2차원 구조로, 행과 열로 구성됨
-- 행은 로우(row)나 레코드(record)라고 부르며
-- 열은 컬럼(column) 또는 필드(field)라고 부름
-- 엑셀과 유사한 형태

create database naver_db; -- 데이터베이스 만들기

drop database if exists naver_db; -- 기존에 naver_db가 있다면 삭제
create database naver_db;

-- sql로 테이블 만들기
use naver_db; -- naver_db 데이터베이스를 사용하겠다
drop table if exists member; -- 기존에 member 테이블이 있다면 삭제
create table member
( mem_id		char(3) 	not null primary key, -- 회원 아이디(pk)
  mem_name		varchar(10) not null, -- 이름
  mem_number	tinyint		not null -- 인원수
);
-- null : 기본값. null값을 허용한다
-- not null : null을 허용하지 않는다. 반드시 값을 넣어야 함

insert into member values('TWC', '트와이스', 9);
insert into member values('BLK', '블랙핑크', 4);
insert into member values('WMN', '여자친구', 6);
select * from member;

-- buy 테이블
-- auto_increment 열은 반드시 primary key 또는 unique key 로 지정해야함
drop table if exists buy;
create table buy
( num		int	auto_increment not null primary key, -- 순번(pk)
  mem_id	char(8) not null, -- 아이디(fk)
  prod_name	char(6) not null, -- 제품 이름
  foreign key (mem_id) references member (mem_id)
);

insert into buy (mem_id, prod_name) values ('BLK', '지갑');
insert into buy (mem_id, prod_name) values ('BLK', '맥북프로');
insert into buy (mem_id, prod_name) values ('APN', '아이폰');
-- APN은 아직 회원 테이블에 존재하지 않아서 오류 발생


-- 제약조건
-- 테이블을 만들 때는 테이블의 구조에 필요한 제약조건을 설정해야 함
-- 앞에서 배운 기본키(primary key)와 외래키(foreign key)가 대표적인 제약조건

-- 제약조건의 기본 개념
-- 제약조건(constraint)은 데이터의 무결성을 지키기 위해 제한하는 조건

-- 데이터의 무결성 : 데이터에 결함이 없다는 의미
-- 예) 네이버의 회원 아이디가 중복되면 네이버의 모든 서비스 이용에 혼란이 일어남
-- 위의 예시와 같은 결함이 없는 것을 데이터의 무결성 이라고 표현

-- 예시 상황에서는 데이터의 무결성을 위해 회원 테이블의 아이디를 기본키로 지정할 수 있음
-- 기본키로 설정하면 중복된 아이디를 실수로 입력하려고 해도 입력이 불가능

-- 제약조건의 종류
-- primary key
-- foreign key
-- unique
-- check
-- default 정의
-- null값 허용


-- 기본키
-- 테이블의 많은 데이터 중에 데이터를 구분할 수 있는 식별자
-- 예) 회원 아이디, 학생의 학번, 직원의 사번
-- 기본키의 값은 중복될 수 없으며, null값이 입력될 수 없음

-- 대부분의 테이블은 기본키를 가져야 함
-- 테이블은 기본키를 1개만 가질 수 있음
-- 아이디, 주민등록번호, 이메일 처럼 기본키로 설정할 수 있는 열이 여러 개 인 경우에는
-- 테이블의 특성을 가장 잘 반영하는 열을 선택하는 것이 좋음

-- create table 에서 기본키 제약조건 설정
use naver_db;
drop table if exists buy, member;
create table member
( mem_id		char(8) not null primary key,
  mem_name		varchar(10) not null,
  height		tinyint unsigned null);

desc member;

-- create table의 마지막 행에 primary key 를 추가할 수도 있음
drop table if exists member;
create table member
( mem_id		char(8) not null,
  mem_name		varchar(10) not null,
  height		tinyint unsigned null,
  primary key (mem_id)
);

desc member;

-- alter table에서 기본키 제약조건 설정
-- 이미 만들어진 테이블을 alter table 을 통해 수정하여 기본키를 설정하는 방법
drop table if exists member;
create table member
( mem_id		char(8) not null,
  mem_name		varchar(10) not null,
  height		tinyint unsigned null
);

alter table member			-- member 테이블을 수정
	add constraint			-- 제약조건을 추가
	primary key (mem_id);	-- mem_id 열에 기본키 제약조건을 설정
	
desc member;

-- 외래키 제약조건
-- 외래키(foreign key) : 두 테이블 사이의 관계를 연결해주고, 그 결과 데이터의 무결성을 보장
-- 외래키가 설정된 열은 다른 테이블의 기본키와 연결됨

-- member 테이블과 buy 테이블이 기본키-외래키 관계
-- 이 경우, 기본키가 있는 member 테이블을 기준 테이블이라고 하며
-- 외래키가 있는 buy 테이블을 참조테이블이라고 함
-- 구매 테이블의 FK는 반드시 회원테이블의 PK로 존재함

-- 예) 네이버쇼핑에서 제품을 구매한 기록이 있는 사람은 네이버쇼핑의 회원이어야 함
-- 외래키를 사용하면 구매한 기록은 있지만 구매한 사람이 누구인지 알 수 없는 상황은 발생하지 않음
-- 따라서 구매 테이블의 모든 데이터는 누가 구매했는지 확실하게 알 수 있는 무결한 데이터가 됨

-- create table 에서 외래키 제약조건 설정
-- 기본 형식 : foreign key(열이름) references 기준테이블(열이름)
-- 구매 테이블의 열(mem_id)이 참조(references)하는 기준 테이블(member)의 열(mem_id)

-- 기준 테이블의 열이 primary key 또는 unique가 아니라면 외래키 관계는 설정되지 않음
drop table if exists buy;
create table buy
( num		int	auto_increment not null primary key,
  mem_id	char(8) not null,
  prod_name	char(6) not null,
  foreign key(mem_id) references member(mem_id)
);

-- alter table에서 외래키 제약조건 설정
drop table if exists buy;
create table buy
( num		int	auto_increment not null primary key,
  mem_id	char(8) not null,
  prod_name	char(6) not null
);
alter table buy					-- buy 테이블을 수정
	add constraint				-- 제약조건을 추가
	foreign key(mem_id)			-- 외래키 제약조건을 buy 테이블의 mem_id에 설정
	references member(mem_id);	-- 참조할 기준 테이블은 member 테이블의 mem_id 열
	
	
-- PK-FK 관계 설정 시 기준 테이블의 열이 변경되는 경우
insert into member values ('BLK', '블랙핑크', 163);
insert into buy (mem_id, prod_name) values ('BLK', '지갑');
insert into buy (mem_id, prod_name) values ('BLK', '맥북');

select m.mem_id, m.mem_name, b.prod_name
from buy b
	inner join member m
	on b.mem_id = m.mem_id;

-- BLK의 아이디를 PINK로 변경
update member set mem_id = 'PINK' where mem_id = 'BLK';
-- 기본키-외래키로 맺어진 후에는 기준 테이블의 열이 변경되지 않음
-- 데이터가 변경되면 참조 테이블의 데이터에 문제가 발생하기 때문

-- 지금은 회원 테이블의 BLK가 물건을 구매한 기록이 구매 테이블에 존재하기 때문에 변경 불가한 것
-- 만약 BLK가 물건을 구매한 적이 없다면(구매 테이블에 데이터가 없다면) 회원 테이블의 BLK는 변경 가능

-- BLK를 삭제
use naver_db;
delete from member where mem_id = 'BLK';

-- 기본키-외래키 관계가 설정되면 기준 테이블의 열은 변경되거나 삭제되지 않음
-- 하지만 기준 테이블의 열 이름이 변경될 때 참조 테이블의 열 이름이 자동으로 함께 변경된다면 더 효율적일 것 임

-- 즉, 회원 테이블의 BLK가 PINK로 변경되면 자동으로 구매 테이블의 BLK도 PINK로 변경되는 것
-- 위와 같은 기능을 위해 on delete cascade와 on update cascade를 사용할 수 있음
-- 기준 테이블의 데이터가 수정되거나 삭제되면 참조 테이블의 데이터도 함께 변경되는 기능

drop table if exists buy;
create table buy
( num		int	auto_increment not null primary key,
  mem_id	char(8) not null,
  prod_name	char(6) not null);

alter table buy
	add constraint
	foreign key(mem_id)
	references member(mem_id)
	on update cascade
	on delete cascade;

desc buy;

insert into buy (mem_id, prod_name) values ('BLK', '지갑');
insert into buy (mem_id, prod_name) values ('BLK', '맥북');
select * from buy;

select m.mem_id, m.mem_name, b.prod_name
from buy b
	inner join member m
	on b.mem_id = m.mem_id;

-- member 테이블의 BLK를 PINK로 변경
update member set mem_id = 'PINK' where mem_id = 'BLK';

-- PINK를 기준 테이블에서 삭제
delete from member where mem_id = 'PINK';
-- 구매 테이블을 확인하면 PINK의 데이터가 함께 삭제되었음 


-- 기타 제약 조건

-- 고유키 제약조건
-- 고유키(unique) 제약조건 : 중복되지 않는 유일한 값을 입력해야 하는 조건.
-- 기본키 제약조건과 거의 비슷하지만, 고유키 제약조건은 NULL값을 허용한다는 것이 차이점

-- null값은 여러 개가 입력되어도 상관없음
-- 또 다른 차이점은 기본키는 테이블에 1개만 설정할 수 있지만 고유키는 여러 개를 설정할 수 있음
-- 예) 회원 테이블에 email 주소가 있다면 중복되지 않으므로 고유키로 설정할 수 있음
drop table if exists buy, member;
create table member
( mem_id		char(8) not null primary key,
  mem_name		varchar(10) not null,
  height		tinyint	unsigned null,
  email			char(30) null unique);

-- 중복된 데이터 입력
insert into member values ('BLK', '블랙핑크', 163, 'pink@gmail.com');
insert into member values ('TWC', '트와이스', 167, null);
insert into member values ('APN', '에이핑크', 164, 'pink@gmail.com');
-- 이메일이 중복되기 때문에 오류 발생

-- 체크 제약 조건
-- 체크(check) 제약조건 : 입력되는 데이터를 점검하는 기능
-- 예) height 에 마이너스 값이 입력되지 않도록 하거나, 연락처의 국번에 02, 031, 041, 055 중 하나만
-- 입력되도록 하는 것

-- height는 반드시 100 이상의 값만 입력되도록 체크 제약조건을 설정하는 예시
drop table if exists member;
create table member
( mem_id		char(8) not null primary key,
  mem_name		varchar(10) not null,
  height		tinyint unsigned null check (height >= 100),
  phone1		char(3) null);
-- 열 정의 뒤에 check (조건) 을 추가하면 됨

-- 데이터 입력
insert into member values ('BLK', '블랙핑크', 163, null);
insert into member values ('TWC', '트와이스', 99, null);

-- 테이블을 만든 후에 alter table 로 체크 제약조건을 추가하는 것도 가능
alter table member
	add constraint
	check (phone1 in ('02', '031', '032', '054', '055', '061'));

-- 데이터 입력
insert into member values ('TWC', '트와이스', 167, '02');
insert into member values ('OMY', '오마이걸', 167, '010');

-- 기본값 정의
-- 기본값(default) 정의 : 값을 입력하지 않았을 때 자동으로 입력될 값을 미리 지정하는 방법
-- 예) height를 입력하지 않고 기본적으로 160이라고 입력되도록 하고 싶은 경우
drop table if exists member;
create table member
( mem_id		char(8) not null primary key,
  mem_name		varchar(10) not null,
  height		tinyint	unsigned null default 160,
  phone1		char(3) null);

-- alter table로 default 를 지정하기 위해서는 alter column을 사용
-- 예) 연락처의 국번을 입력하지 않으면 자동으로 '02'가 입력되도록 하려는 경우
alter table member
	alter column phone1 set default '02';

-- 기본값이 설정된 열에 기본값을 입력하려면 default 라고 입력
insert into member values ('RED', '레드벨벳', 161, '054');
insert into member values ('SPC', '우주소녀', default, default);
select * from member;

insert into member (mem_id, mem_name) values ('OMY', '오마이걸');

-- NULL 값 허용
-- NULL 값을 허용하려면 생략하거나 NULL을 입력하고, 허용하지 않으려면 NOT NULL을 입력
-- PRIMARY KEY 가 설정된 열에는 NULL 값이 있을 수 없으므로 생략하면 자동으로 NOT NULL로 인식함
-- NULL 은 '아무것도 없다' 라는 의미이므로 공백('')이나 0과는 다름