-- 데이터입력(INSERT)
-- INSERT 문의 기본 문법
insert into 테이블 (열1, 열2, 열3......) values (값1, 값2, 값3......);

-- 주의점
-- 테이블 이름 다음에 나오는 열은 생략 가능함
-- 다만, 생략할 시에는 values 다음에 나오는 값들의 순서와 개수는 열의 순서 및 개수와 동일해야함
create table toy_shop (toy_id int, toy_name char(4), age int); -- insert연습용 테이블

select * from toy_shop;

insert into toy_shop values (1, '우디', 25);

-- 아이디와 이름만 입력하고, 나이는 입력하고 싶지 않다면
insert into toy_shop (toy_id, toy_name) values (2, '버즈');

-- 열의 순서를 바꿔서 입력하는 것도 가능함
insert into toy_shop (toy_name, age, toy_id) values ('제시', 20, 3);

drop table toy_shop; -- 테이블 삭제

-- AUTO_INCREMENT
-- 자동으로 증가하는 값 입력
-- INSERT 를 사용할 때 해당 열은 입력하지 않아도 자동으로 증가하는 값이 입력됨

-- 주의점
-- AUTO_INCREMENT 로 지정하는 열은 반드시 PRIMARY KEY로 지정해줘야 함
-- PRIMARY KEY : 각 행을 구분하는 유일한 값

create table toy_shop2(
	toy_id int auto_increment primary key,
	toy_name char(4),
	age int
);

insert into toy_shop2 (toy_name, age) values ('보핍', 25);
insert into toy_shop2 (toy_name, age) values ('슬링키', 22);
insert into toy_shop2 (toy_name, age) values ('렉스', 21);

select * from toy_shop2;

select last_insert_id();

-- AUTO_INCREMENT 로 입력되는 다음 값을 100부터 시작하도록 변경하고 싶다면
alter table toy_shop2 auto_increment = 100;
insert into toy_shop2 (toy_name, age) values ('햄', 35);

-- AUTO_INCREMENT 로 입력되는 값을 1000으로 지정하고, 3씩 증가하도록 설정
truncate table toy_shop2; -- 테이블 초기화
alter table toy_shop2 auto_increment = 1000;
set @@auto_increment_increment = 3;

insert into toy_shop2 (toy_name, age) values ('포테이토', 20);
insert into toy_shop2 (toy_name, age) values ('앤디', 23);
insert into toy_shop2 (toy_name, age) values ('알린', 25);
select * from toy_shop2;

-- 여러 건을 한 번에 입력
insert into toy_shop2 (toy_name, age) values ('아미맨', 92), ('빌리', 77);

-- 다른 테이블의 데이터를 한 번에 입력(INSERT INTO ~ SELECT ~)
insert into 테이블이름 (열이름1, 열이름2......) select ~;

-- 주의점
-- select문의 결과 데이터의 열 개수는 INSERT 할 테이블의 열 개수와 같아야 함

select count(*) from world.city; -- world데이터베이스의 city 테이블의 데이터 개수 조회

desc world.city; -- world.city 테이블 프로퍼티 보기

select * from world.city limit 5;

-- 도시 이름과 인구를 가져와 테이블 구성하기
create table city_popul (city_name char(35), population int);
insert into city_popul (city_name, population)
select name, population from world.city;

select * from city_popul;

-- 데이터 수정(UPDATE)
-- UPDATE 문의 기본 문법
update 테이블이름 set 열1 = 값1, 열2 = 값2... where 조건;

-- city_popul 테이블의 도시 이름 중에서 'Seoul'을 '서울'로 변경하기
select * from city_popul where city_name = 'Seoul';
update city_popul set city_name = '서울' where city_name = 'Seoul';

select * from city_popul where city_name = '서울';

-- 한꺼번에 여러 열 변경하기
-- 도시이름 New York을 뉴욕 으로 바꾸면서 인구는 0으로 수정
update city_popul set city_name = '뉴욕', population = 0 where city_name = 'New York';

select * from city_popul where city_name = '뉴욕';

-- 주의점
-- update문에서 where절은 생략가능하지만, where절을 생략하면 모든 행의 값이 바뀜
-- city_popul테이블의 인구를 10000명 단위로 변경하는 등의 특수한 경우가 아니라면 주의해야함
update city_popul set population = population / 10000;
select * from city_popul limit 5;

-- 데이터 삭제(DELETE)
-- DELETE문의 기본 문법
delete from 테이블이름 where 조건;

-- city_popul 테이블에서 'New'로 시작하는 도시를 삭제하고 싶다면
select * from city_popul where city_name like 'New%';
delete from city_popul where city_name like 'New%';