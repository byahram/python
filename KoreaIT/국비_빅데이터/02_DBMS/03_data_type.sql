-- MYSQL의 데이터 형식
-- 데이터 형식은 크게 숫자형, 문자형, 날짜형이 있음
-- 실제로 저장될 데이터의 형태가 다양하기 때문에 이를 효율적으로 저장하기 위해
-- 위의 데이터 형식에서 세부적으로 다시 여러 데이터 형식으로 나뉨
-- 예) 사람의 이름을 저장하기 위해 100글자를 저장할 칸을 준비하는 것은 비효율적임

-- 정수형
-- TINYINT (숫자 범위 : -128 ~ 127)
-- SMALLINT (숫자 범위 : -32768 ~ 32767)
-- INT (숫자 범위 : 약 -21억 ~ 21억)
-- BIGINT (숫자 범위 : 약 -900경 ~ 900경)

create table tbl_type (
	tinyint_col tinyint,
	smallint_col smallint,
	int_col int,
	bigint_col bigint
);

-- 각 열의 최댓값까지는 이상 없이 입력 가능
insert into tbl_type values (127, 32767, 2147483647, 9000000000000000000);
select * from tbl_type;

-- 최댓값에 0을 더 붙여서 입력해보기
insert into tbl_type values (1270, 327670, 21474836470, 90000000000000000000);
-- Out of range 에러는 입력값의 범위를 벗어났다는 뜻

-- 문자형
-- 문자형은 글자를 저장하기 위해 사용
-- 입력할 최대 글자의 개수를 지정해야 함
-- CHAR(개수)
-- VARCHAR(개수)

-- CHAR는 Character의 약자로, 고정길이 문자형이라고 부름
-- 자릿수가 고정됨
-- 예) CHAR(10) 에 "가나다" 3글자만 저장해도 10글자를 모두 확보한 후에
-- 앞의 3자리만 사용하고 뒤의 7자리는 낭비하게 됨 

-- VARCHAR 는 가변길이 문자형으로, "가나다" 3글자를 저장하면 3자리만 사용함(Variable Character)

-- VARCHAR가 CHAR보다 공간을 더 효율적으로 사용할 수 있지만 MySQL의 처리 속도는 CHAR가 더 빠름
-- 예) 거주 지역 컬럼에 데이터가 서울/경기/부산 과 같이 모두 2글자로 지정한 경우에는
-- CHAR(2)로 설정하는 것이 더 좋음
-- 반면에 가수 이름은 글자 수가 다양하기 때문에 VARCHAR로 설정하는 것이 더 좋음


-- 위에서 배운 내용을 바탕으로 member 테이블 생성 코드를 다시 작성한다면
create table member -- 회원 테이블
( mem_id		CHAR(8) not null primary key, -- 사용자 아이디(PK)
  mem_name		VARCHAR(10) not null, -- 이름
  mem_number	tinyint not null, -- 인원수
  addr			char(2) not null, -- 지역(경기, 서울, 경남 식으로 2글자만 입력)
  phone1		char(3), -- 연락처의 국번(02, 031, 055 등)
  phone2		char(8), -- 연락처의 나머지 전화번호(하이픈 제외)
  height		tinyint unsigned, -- 평균 키
  debut_date	date -- 데뷔 일자
);

-- 전화번호는 숫자로서의 의미가 없기 때문에 문자열로 지정
-- 숫자로서의 의미를 가지기 위해서는
-- 더하기/빼기 등의 연산에 의미가 있거나
-- 크다/작다 또는 순서에 의미가 있어야함

-- 대량의 데이터 형식
-- CHAR는 최대 255까지, VARCHAR는 최대 16383자 까지 지정이 가능
-- 즉, 더 큰 값을 가지는 데이터는 저장할 수 없음
-- TEXT (최대 65535 자)
-- LONGTEXT (약 42억 자, 소설이나 영화 대본 등의 대량의 내용을 저장할 때 사용)
-- BLOB (Binary Long Object의 약자. 이미지, 동영상 등의 이진 데이터를 저장할 때 사용)
-- LONGBLOB (LONGTEXT 및 LONGBLOB은 최대 4GB까지 입력 가능)

-- 실수형
-- 소수점이 있는 숫자를 저장할 때 사용
-- FLOAT (소수점 아래 7자리까지 표현)
-- DOUBLE (소수점 아래 15자리까지 표현)

-- 날짜형
-- 날짜 및 시간을 저장할 때 사용
-- DATE (날짜만 저장. YYYY-MM-DD) 형식으로 사용
-- TIME (시간만 저장. HH:MM:SS) 형식으로 사용
-- DATETIME (날짜 및 시간을 저장. YYYY-MM-DD HH:MM:SS) 형식으로 사용

-- 데이터 형 변환
-- 문자형 데이터를 정수형 데이터로 바꾸거나, 정수형 데이터를 문자형으로 바꾸는 등 데이터의 형식을 변환하는 것을
-- 데이터 형 변환(type conversion) 이라고 함

-- 형 변환에는 직접 함수를 사용해서 변환하는 명시적 변환(explicit conversion)과
-- 별도의 지시 없이 자연스럽게 변환되는 암시적 변환(implicit conversion)이 있음

-- 함수를 이용한 명시적 변환
-- 데이터 형식을 변환하는 함수는 CAST(), CONVERT()

-- 사용 형식
cast (값 as 데이터형식(길이))
convert (값, 데이터형식(길이))

-- 사용 예
select avg(price) "평균 가격" from buy; -- 실수형 데이터

-- 위의 평균 가격을 정수형으로 표현하고 싶다면
select cast(avg(price) as signed) "평균 가격" from buy;
select convert(avg(price), signed) "평균 가격" from buy;

-- 문자열 데이터를 날짜형으로 변경
select cast('2025$01$23' as date);

-- 결과를 원하는 형태로 표현하고 싶을 때
select num
, concat(cast(price as char), 'X', cast(amount as char), '=') '가격X수량'
, price * amount '구매액'
from buy;

-- 암시적 변환
-- CAST()나 CONVERT() 함수를 사용하지 않고 자연스럽게 데이터 형태가 변환되는 것
select '100' + '200';
-- 문자는 덧셈이 불가하기 때문에 자동으로 숫자 100과 숫자 200으로 변환해서 덧셈을 수행

-- 만약에 문자 '100'과 문자 '200'을 연결한 '100200'을 만들려면 concat() 을 사용해야함
select concat('100', '200');

-- 숫자와 문자를 concat() 함수로 연결한다면
select concat(100, '200');

-- 숫자 100과 문자 '200'을 더하면
select 100 + '200';