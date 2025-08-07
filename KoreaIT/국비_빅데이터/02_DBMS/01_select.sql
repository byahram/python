-- 데이터 조회(SELECT 문)

use market_db; -- use문. 사용할 데이터베이스를 지정

-- DML(Data Manipulation Language, 데이터 조작어)
-- 정의된 데이터베이스에 입력된 레코드를 조회, 수정, 삭제 하는 등의 역할을 하는 언어

-- DML의 종류
-- SELECT : 데이터를 조회
-- INSERT : 데이터를 삽입
-- UPDATE : 데이터를 수정
-- DELETE : 데이터를 삭제 

-- SELECT문의 기본 형식
select (열 이름)
from (테이블 이름)
where (조건식)
group by (열 이름)
having (조건식)
order by (열 이름)
limit 숫자;

-- SELECT 문은 키워드에 의해 구분되어 여러 개의 절 로 구성됨

-- SELECT ~ FROM ~
select * from member;
-- select : 테이블에서 데이터를 가져올 때 사용하는 예약어

-- * : asterisk. 일반적으로 "모든 것"을 의미함.
-- 위 예시에서는 열 이름이 들어갈 자리에 사용되어 "모든 열"을 뜻함.

-- from : 데이터를 가져올 테이블을 지정
-- member : 조회할 테이블 이름

-- 입력이 끝나면 명령의 마지막을 나타내는 세미콜론을 넣음
-- > member 테이블에서 모든 열의 내용을 가져와라

-- select 와 * 그리고 from 과 테이블명 사이에는 스페이스를 넣어 구분
-- 모든 명령어를 붙여서 입력하면 에러가 발생할 수 있음

-- 값이 없는 데이터는 NULL로 표시됨(아무 것도 저장되지 않은 상태)

select * from market_db.member; -- 원칙적으로는 데이터베이스.테이블 의 형식으로 표현해야 함

-- 필요한 열만 가져오기
select mem_name from member;

-- 여러 열을 가져오고 싶으면 콤마로 연결
-- 기존 테이블의 열 순서는 관계없이 보고싶은 순서대로 열을 나열
-- 동일한 열을 중복해서 지정해도 무관
select addr, debut_date, mem_name, addr from member;

-- 열 이름에 별칭 지정
-- 열 이름 다음에 지정하고 싶은 별칭 입력
-- 별칭에 공백이 포함되어 있다면 따옴표로 묶음
select addr 주소, debut_date "데뷔 일자", mem_name from member;

-- select문에서 사칙연산을 사용하는 경우,
-- 계산식이 열 이름에 나타나 열 이름이 너무 길고 알아보기 힘들어지는 경우 별칭을 주로 사용
select mem_id, prod_name, price * amount "총 구매액"
from buy;

-- select ~ from ~ where ~
-- 특정 조건만 조회하기
-- 부하 문제 때문에 실무에서는 보통 where 를 함께 사용하거나 limit를 사용함

-- 조건식의 구조
-- (열 이름) (연산자) (값)

-- 동등비교(=)
-- = 연산자를 기준으로 좌변과 우변의 항목을 비교하고, 서로 같은 값이면 TRUE, 같지 않으면 FALSE 를 반환
select * from member where mem_name = '블랙핑크';
-- 문자열 데이터를 비교할 때는 따옴표로 감싸 표기

select * from member where mem_number = 4;

-- 부등비교(!=, <>)
-- 연산자의 좌변과 우변의 값이 다를 경우 TRUE, 같을 경우 FALSE
select * from member where mem_number != 4;
select * from member where mem_number <> 4;

-- 관계 연산자, 논리 연산자
-- 숫자로 표현된 데이터라면 범위를 지정할 수 있음
select mem_id, mem_name, height from member where height <= 162;

-- where절에서 사칙연산을 사용하는 것도 가능
select mem_id, prod_name, price * amount "총 구매액"
from buy
where price * amount >= 800;

select * from buy;
-- 이 때 select 절에서 지정한 별명은 where절 안에서 사용할 수 없음

-- 논리 연산자를 이용하여 여러 조건을 만족하도록 할 수도 있음
select mem_name, height, mem_number
from member
where height >= 165 and mem_number > 6;

select mem_name, height, mem_number
from member
where height >= 165 or mem_number > 6;

-- 특정 범위에 있는 값을 구하는 경우
select mem_name, height
from member
where height >= 163 and height <= 165;

select mem_name, height
from member
where height between 163 and 165;

-- IN
select mem_name, addr
from member 
where addr = '경기' or addr = '전남' or addr = '경남';

select mem_name, addr
from member
where addr in ('경기', '전남', '경남');

-- 문자열 패턴 검색(LIKE)
-- = 연산자로 비교하면 값이 완전히 동일한지를 비교
-- 하지만 특정 문자열이 포함되어 있는지를 검색하고 싶다면 패턴 검색을 활용
select * from member where mem_name like '우%';
-- '%' 는 임의의 문자열을 뜻하며, 빈 문자열에도 매치함

-- 글자 수 매치
select * from member where mem_name like '__핑크';

-- NULL값 검색(IS NULL)
select * from member where phone1 = null;
-- '=' 연산자로는 null을 검색할 수 없음
-- null 값을 검색할 때는 IS NULL 연산자를 활용
select * from member where phone1 is null;

-- NULL이 아닌 행을 검색하고 싶다면 IS NOT NULL을 사용
select * from member where phone1 is not null;

-- NULL값의 연산
-- SQL에서 NULL은 0으로 처리되지 않기 때문에 NULL을 사용한 연산은 항상 NULL이 됨
select null+1, 1 + 2 * null, 1 / null;

-- 연산자의 우선순위
-- MYSQL에서는 AND가 OR보다 우선순위가 더 높음
select *
from member
where mem_number = 8 or mem_number = 4 and addr = '경남' or addr = '서울';

-- 위의 코드는 아래와 같음
select *
from member
where mem_number = 8 or (mem_number = 4 and addr = '경남') or addr = '서울';

-- 일반적으로 or 조건식은 괄호로 묶어 지정하는 경우가 많음
select *
from member
where (mem_number = 8 or mem_number = 4) and (addr = '경남' or addr = '서울');

-- 연습문제
-- 1. buy 테이블에서 amount가 4 이상인 모든 열 데이터 조회하기
select * from buy where amount >= 4;

-- 2. buy 테이블에서 prod_name 이 지갑 또는 청바지 에 해당하는 모든 열 데이터 조회하기
select * from buy where prod_name in ('지갑', '청바지');

-- 정렬(ORDER BY)
-- 결과가 출력되는 순서를 조절
-- ORDER BY를 지정하지 않으면 데이터베이스 내부에 저장된 순서로 반환
select mem_id, mem_name, debut_date from member order by debut_date;

-- ASC : 오름차순
-- DESC : 내림차순
-- 정렬옵션을 생략하면 ASC로 받아들임

select mem_id, mem_name, debut_date from member order by debut_date desc;

-- height가 164이상인 회원들을 키의 내림차순으로 조회할 때
select mem_id, mem_name, debut_date, height
from member
where height >= 164
order by height desc;

-- 문자열 자료형의 데이터 대소관계는 사전식 순서에 의해 결정
select mem_id, mem_name
from member
order by mem_name asc;

-- SQL에서는 명령어의 순서가 정해져 있어서 순서를 바꿀 수 없음
-- 순서를 바꿔서 사용하면 에러 발생
select mem_id, mem_name, debut_date, height
from member
order by height desc
where height >= 164;

-- 정렬 기준을 여러 열로 지정하기
-- 데이터양이 많을 경우 하나의 열만으로는 행을 특정짓기 어려운 때가 많음
-- ORDER BY 로 정렬할 때 같은 값을 가진 행의 순서는 데이터베이스 서버의 상황에 따라 어떤 행을 반환할지 결정하여
-- 일정하지 않음
select mem_id, mem_name, debut_date, height
from member
where height >= 164
order by height desc, debut_date asc;

-- NULL 값의 정렬 순서
-- NULL은 대소비교를 할 수 없어서 각 DBMS마다 기준이 다르지만, 일반적으로 가장 작은 값 또는 가장 큰 값으로 처리
-- MYSQL에서는 가장 작은 값으로 취급
select mem_id, mem_name, phone1, phone2
from member
order by phone1 asc;

-- ORDER BY 에서는 SELECT 절에서 지정한 별명을 사용할 수 있음
select mem_id, prod_name, price * amount 총구매액
from buy
order by 총구매액 desc;

-- 출력 개수 제한(LIMIT)
-- LIMIT 는 표준SQL이 아니라 MYSQL과 PostgreSQL 에서 사용할 수 있는 문법
-- SQL Server 에서는 LIMIT과 비슷한 TOP 명령어를 사용
-- ORACLE에서는 ROWNUM을 WHERE 절에서 사용해 출력 개수를 제한
select * from member limit 3;

-- 데뷔 일자가 가장 빠른 3건만 조회
select * from member order by debut_date asc limit 3;

-- 오프셋 지정
-- OFFSET 을 통한 시작 위치 지정 가능. 기본값은 0
select * from member order by debut_date asc limit 3 offset 2;

-- offset 키워드를 생략하고 숫자를 나열하여 오프셋을 지정할 수 있음
-- 이 경우에는 limit (시작 위치), (데이터 개수)
select * from member order by debut_date asc limit 2, 3;

-- 중복 제거
select addr from member;
select distinct addr from member order by addr asc;

-- 집계 함수
-- 집계 함수는 인수로 집합을 지정하면 결괏값을 반환

-- 집계함수의 종류
-- COUNT() : 데이터 개수 세기
-- SUM() : 합계
-- AVG() : 평균
-- MIN() : 최솟값
-- MAX() : 최댓값

select count(*) from member;

-- 연락처가 있는 회원 수만 알고 싶은 경우
select count(phone1) "연락처가 있는 회원" from member;
select * from member;

-- 집계함수에서의 DISTINCT
-- 집계함수의 인수에 DISTINCT를 사용하면 집합에서 중복을 제거한 뒤 집계함수를 적용
select count(addr), count(distinct addr) from member;

-- group by
-- 그룹으로 묶어주는 역할

select mem_id, amount from buy order by mem_id;

-- 각 회원이 구매한 물품의 총 개수를 알고싶은 경우
select mem_id, sum(amount) from buy group by mem_id;

-- 각 회원이 구매한 금액의 총합을 알고 싶은 경우
select mem_id "회원 아이디", sum(price * amount) "총 구매 금액"
from buy
group by mem_id;

-- 한 거래당 구매하는 물품 수 평균
select avg(amount) "평균 구매 개수" from buy;

-- 각 회원이 한 거래 당 구매하는 물품 수 평균
select mem_id, avg(amount) "평균 구매 개수"
from buy
group by mem_id;

-- having
select mem_id "회원 아이디", sum(price * amount) "총 구매 금액"
from buy
group by mem_id;

select * from buy;

-- 위 데이터에서 총 구매액이 1000이상인 회원에게만 사은품을 증정하려고 한다면
select mem_id "회원 아이디", sum(price * amount) "총 구매 금액"
from buy
where sum(price * amount) >= 1000
group by mem_id;
-- 집계함수는 where절에서 사용할 수 없음

select mem_id "회원 아이디", sum(price * amount) "총 구매 금액"
from buy
group by mem_id
having sum(price * amount) >= 1000;

-- 위 데이터에서 총 구매액이 큰 사용자부터 나타내려면
select mem_id "회원 아이디", sum(price * amount) "총 구매 금액"
from buy
group by mem_id
having sum(price * amount) >= 1000
order by sum(price * amount) desc;

-- MYSQL의 SELECT 문법 작성 순서
-- SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY

-- MYSQL의 SELECT 문법 실행 순서
-- FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY


-- 1. 동물 보호소에 들어온 모든 동물의 id와 이름(name)과 보호시작일(datetime)을
-- animal_id의 내림차순으로 조회하는 sql문을 작성하기
select animal_id, name, datetime
from aac_intakes
order by animal_id desc;

-- 2. 동물 보호소에 들어온 동물 중 intake_condition이 sick 인 동물의 데이터를
-- animal_id의 오름차순으로 조회하기
-- 조회할 열 : animal_id, intake_condition, name
select animal_id, intake_condition, name
from aac_intakes
where intake_condition = 'sick'
order by animal_id asc;

-- 3. 동물 보호소에 들어온 동물 중 intake_condition이 Aged가 아닌 동물들의 정보를
-- animal_id의 오름차순으로 조회하기
-- 조회할 열 : animal_id, intake_condition, name
select animal_id, intake_condition, name
from aac_intakes
where intake_condition != 'Aged'
order by animal_id asc;

-- 4. 동물 보호소에 들어온 모든 동물의 데이터를 이름의 내림차순으로 조회하는 sql문 작성하기
-- 이름이 같은 동물 중에서는 최근에 보호를 시작한 동물을 먼저 보여주기
-- 조회할 열 : animal_id, datetime, name
select animal_id, datetime, name
from aac_intakes
order by name desc, datetime desc;

-- 5. 동물 보호소에 가장 먼저 들어온 동물의 데이터 조회하기
-- 조회할 열 : name, datetime
select name, datetime
from aac_intakes
order by datetime asc
limit 1;

-- 6. 동물 보호소에 들어온 동물의 이름이 총 몇 종류 있는지 조회하기
-- 이때, 이름이 ''인 경우는 집계하지 않음
select count(distinct name)
from aac_intakes
where name != '';

-- 7. 동물 보호소에 들어온 동물 종(animal_type) 별로 각각 몇 마리인지 조회하기
-- 이때, animal_type의 오름차순으로 정렬하기
-- 조회할 열 : animal_type, 마리수(cnt)
select animal_type, count(*) cnt
from aac_intakes
group by animal_type
order by animal_type asc;

-- 8. 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하기
-- 이때, 이름이 ''인 동물은 집계에서 제외하며, 이름의 오름차순으로 조회하기
-- 조회할 열 : name, 횟수(cnt)
select name, count(*) cnt
from aac_intakes
where name != '' and name not like '*%'
group by name
having cnt >= 2
order by name asc;