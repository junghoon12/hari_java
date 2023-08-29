-- [문제1] emp 테이블에서 담당업무가 'CLERK' 인 사원의
--        사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job = 'CLERK';

-- [문제2] emp 테이블에서 1982년 1월 1일 이후에 입사한
--        사원의 사번, 이름, 담당업무, 급여, 입사일자를 
--        화면에 보여주세요.
select empno, ename, job, sal, hiredate
from emp
where hiredate >= '82/01/01';

-- [문제3] emp 테이블에서 급여가 1300 ~ 1500 사이인 사원의
--        이름과 담당업무, 급여, 부서번호를 화면에 보여주세요.
select ename, job, sal, deptno
from emp
-- where sal >= 1300 and sal <= 1500;  -- 1번째 방법
where sal between 1300 and 1500;  -- 2번째 방법

-- [문제4] emp 테이블에서 사번이 7902, 7788, 7566 인 사원의
--        사번, 이름, 담당업무를 화면에 보여주세요.
select empno, ename, job
from emp
-- where empno = 7902 or empno = 7788 or empno = 7566;  -- 1번째 방법
where empno in (7902, 7788, 7566);  -- 2번째 방법

-- [문제5] emp 테이블에서 보너스가 300이거나 500이거나 1400인
--        사원의 모든 정보를 화면에 보여주세요.
select *
from emp
-- where comm = 300 or comm = 500 or comm = 1400;  -- 1번째 방법
where comm in (300, 500, 1400);

-- [문제6] member10 테이블에서 이름이 홍길동이면서 직업이 학생인
--        회원의 모든 정보를 화면에 보여주세요.
select *
from member10
where memname = '홍길동' and job = '학생';

-- [문제7] products 테이블에서 제조사가 '삼성' 또는 '현대' 이면서
--        입고가가 100만원 이하인 상품의 상품명과 입고가, 출고가를
--        화면에 보여주세요.
select products_name, input_price, output_price
from products
where company in('삼성', '현대') and input_price <= 1000000; 

-- [문제8] emp 테이블에서 급여가 1100 이상이고, 담당업무가
--        'MANAGER' 인 사원의 사번, 이름, 담당업무, 급여를
--        화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal >= 1100 and job = 'MANAGER';

/*
  ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  like 키워드 : 검색을 하는 키워드.

  1) where ename like '%S%'
     ==> ename 컬럼에 S자를 포함하는 모든 사원의 이름을 검색.
     
  2) where ename like 'S%'
     ==> ename 컬럼에 첫 글자가 S자로 시작하는 모든 사원의 이름을 검색.
     
  3) where ename like '%S'
     ==> ename 컬럼에 마지막 글자가 S자로 끝나는 모든 사원의 이름을 검색.
  
  4) where ename like '_S%'
     ==> ename 컬럼에 두번째 글자가 S자가 들어가는 모든 사원의 이름을 검색.
*/

-- emp 테이블에서 사원명에 A라는 글자가 포함되어 있는 사원의
-- 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '%A%';

-- [문제1] emp 테이블에서 사원명에 M이라는 글자를 포함하는
--        사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '%M%';

-- [문제2] emp 테이블에서 사원명의 두번째 글자에 'I' 라는
--        글자를 포함하는 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '_I%';

-- [문제3] emp 테이블에서 이름이 'S' 자로 끝나는 사원의
--        사번과 이름, 담당업무, 부서번호를 화면에 보여주세요.
select empno, ename, job, deptno
from emp
where ename like '%S';

-- [문제4] emp 테이블에서 이름의 세번째 글자가 'R' 이
--        들어가 있는 사원의 이름과 담당업무, 급여를 화면에 보여주세요.
select ename, job, sal
from emp
where ename like '__R%';

-- [문제5] emp 테이블에서 이름의 두번째 글자가 'O' 인 사원의
--        모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '_O%';

-- [문제6] emp 테이블에서 입사년도가 82년도인 사원의 사번,
--        이름, 담당업무, 입사일자를 화면에 보여주세요.
select empno, ename, job, hiredate
from emp
where hiredate like '82%';

-- [문제7] member10 테이블에서 성이 '김' 씨인 회원의
--        모든 정보를 화면에 보여주세요.
select *
from member10
where memname like '김%';

-- [문제8] member10 테이블에서 주소에 '서울시' 가 들어가는
--        회원의 이름, 주소, 직업을 화면에 보여주세요.
select memname, addr, job
from member10
where addr like '%서울시%';

-- [문제9] products 테이블에서 제품명에 '에어컨' 을 포함하는
--        제품의 제품명, 입고가, 출고가, 제조사를 화면에 보여주세요.
select products_name, input_price, output_price, company
from products
where products_name like '%에어컨%';


/*
  ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  order by 절
  - 자료를 정렬하여 나타낼 때 사용하는 명령문.
  - order by 절을 사용할 때는 반드시 select 구문의 맨 마지막에 위치해야 함.
    * asc : 오름차순 정렬
    * desc : 내림차순 정렬
  - 기본적으로 order by 절을 사용 시에는 오름차순 정렬이 default임.
  - 오름차순 정렬인 경우에는 asc 문장을 생략해도 됨.
*/

-- member10 테이블에서 이름을 기준으로 오름차순 정렬하여 모든 정보를
-- 화면에 보여주세요.
-- 단, 이름이 같은 경우에는 나이를 기준으로 내림차순 정렬.
select *
from member10
order by memname asc, age desc;

-- [문제1] emp 테이블에서 부서번호를 기준으로 오름차순 정렬을 하고,
--        부서번호가 같은 경우 급여를 기준으로 내림차순으로 정렬을
--        하여 화면에 보여주세요.
select *
from emp
order by deptno asc, sal desc;

-- [문제2] products 테이블에서 판매가격을 기준으로 내림차순으로
--        정렬하여 모든 정보를 화면에 보여주세요.
select *
from products
order by output_price desc;

-- [문제3] products 테이블에서 배송비를 기준으로 내림차순으로
--        정렬하세요. 단, 배송비가 같은 경우 마일리지를 기준으로
--        내림차순으로 정렬하여 모든 정보를 화면에 보여주세요.
select *
from products
order by trans_cost desc, mileage desc;

-- [문제4] emp 테이블에서 입사일자가 오래된 사원부터 최근에 입사한
--        사원을 기준으로 정렬을 하되, 사원명, 입사일자를 화면에 
--        보여주세요.
select ename, hiredate
from emp
order by hiredate asc;

-- [문제5] emp 테이블에서 급여를 기준으로 내림차순으로 정렬을 하여
--        사원번호, 사원명, 담당업무, 급여 정보를 화면에 보여주세요.
select empno, ename, job, sal
from emp
order by sal desc;

-- [문제6] emp 테이블에서 급여가 1100 이상인 사원들의 정보를 보여주되,
--        입사일자가 빠른 순으로 정렬하여 화면에 보여주세요.
select *
from emp
where sal >= 1100
order by hiredate asc;

-- [문제7] emp 테이블에서 부서번호를 기준으로 오름차순 정렬을 하여 
--        보여주고, 부서번호가 같은 경우 담당업무를 오름차순으로 정렬하세요.
--        만약, 담당업무가 같다고 하면 급여가 많은데서 적은 순으로
--        정렬을 하여 모든 정보를 화면에 보여주세요.
select *
from emp
order by deptno asc, job asc, sal desc;


/*
  not 키워드 : 부정
  - 쿼리문 작성 시 부정은 일단 긍정의 쿼리문을 작성을 하자.
  - 그런 다음에 부정의 의미인 not을 붙여주면 됨.
*/

-- emp 테이블에서 담당업무가 'MANAGER', 'CLERK',
-- 'ANALYST' 가 아닌 사원의 사번, 이름, 담당업무, 급여를
-- 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job not in ('MANAGER', 'CLERK', 'ANALYST');

-- [문제1] emp 테이블에서 이름에 'S' 자가 들어가지 않는
--        사원의 이름과 담당업무를 화면에 보여주세요.
select ename, job
from emp
where ename not like '%S%';

-- [문제2] emp 테이블에서 부서번호가 10번 부서가 아닌
--        사원의 이름, 담당업무, 부서번호를 화면에 보여주세요.
select ename, job, deptno
from emp
-- where deptno != 10;  -- 첫번째 방법
where deptno <> 10;     -- 두번째 방법

-- [문제3] member10 테이블에서 주소가 '서울시' 가 아닌
--        회원의 모든 정보를 화면에 보여주세요.
select *
from member10
where addr not like '%서울시%';

-- [문제4] products 테이블에서 출고가가 100만원 미만이 아닌
--        제품의 제품명과 출고가를 화면에 보여주세요.
select products_name, output_price
from products
where not output_price < 1000000;

-- [문제5] emp 테이블에서 보너스가 null 이 아닌 사원의
--        모든 정보를 화면에 보여주세요.
select *
from emp
where comm is not null;

/*
  ★★★★★★★★★★★★★★★★
  
  - 사용자 계정을 만드는 방법
    create user 사용자명 identified by 비밀번호;

  - 만들어진 사용자 계정을 사용하기 위한 명령어.
    grant connect, resource to 사용자명;
    
  - role : 사용자에게 보다 효율적으로 권한을 부여할 수 있도록
           여러 개의 권한을 묶어 놓은 것을 말함.
    * connect role
      ==> 오라클에 접속할 수 있는 세션 생성 및 사용자가
          데이터베이스에 접속이 가능하도록 하기 위해서
          가장 기본적인 시스템 권한 8가지를 묶어 놓은 것을 말함.
          
    * resource role
      ==> 사용자가 테이블을 생성할 수 있도록 하기 위해서
          시스템 권한을 묶어 놓은 것을 말함.
          또한 insert, update, delete 구문을 사용할 수
          있는 권한을 묶어 놓은 것을 말함.
*/

create user zzang identified by 1234;

/*
  그룹함수
  ==> 여러 행 또는 테이블 전체에 대해 함수가 적용되어
      하나의 결과값을 가져오는 함수.

  1) avg() : 평균값을 구하는 함수.
  2) count() : 행(레코드)의 갯수를 구하는 함수.
               ==> null 값은 무시하고 행의 갯수를 구함.
  3) max() : 최대값을 구하는 함수.
  4) min() : 최소값을 구하는 함수.
  5) sum() : 총 합을 구하는 함수.
*/

-- emp 테이블에서 사번을 가지고 있는 모든 사원의 수를 화면에 보여주세요.
select count(*) 
from emp;

-- [문제1] emp 테이블에서 관리자(mgr)의 수를 화면에 보여주세요.
select count(distinct mgr)
from emp;

-- [문제2] emp 테이블에서 보너스를 가진 사원의 수를 화면에 보여주세요.
select count(comm)
from emp;

-- [문제3] emp 테이블에서 모든 SALESMAN의 급여 평균과 급여 최고액,
--   급여 최소액, 급여 합계액을 구하여 화면에 보여주세요.
select avg(sal), max(sal), min(sal), sum(sal)
from emp
where job = 'SALESMAN';

-- [문제4] emp 테이블에서 등록되어 있는 사원의 총 수, 보너스가 null 이
--        아닌 사원의 수, 보너스의 평균, 등록되어 있는 부서의 수를 
--        화면에 보여주세요.
select count(*), count(comm), avg(comm), count(distinct deptno)
from emp;


/*
  dual 테이블
  - 오라클에서 자체적으로 제공해 주는 테이블.
  - 간단하게 함수를 이용해서 계산, 결과값을 확인할 때 사용하는 테이블.
  - 오직 한 행, 한 컬럼 만을 담고 있는 테이블.
  - 사용 용도 : 특정 테이블을 생성할 필요 없이 함수 또는 계산을
               하고자 할 때 사용이 됨.
*/

-- 오라클에서 제공해 주는 함수들
-- 1. 날짜와 관련된 함수들
--    1) sysdate : 현재 시스템의 날짜를 구해 옴.
select sysdate from dual;

--    2) add_months(현재 날짜, 숫자(개월 수))
--       : 현재 날짜에서 개월 수를 더해 주는 함수.
select add_months(sysdate, 3) from dual;

--    3) next_day(현재 날짜, '요일')
--       : 다가올 날짜(요일)를 구해 주는 함수.
select next_day(sysdate, '월요일') from dual;

--    4) to_char(날짜, '날짜형식')
--       : 형식에 맞게 문자열로 날짜를 출력해 주는 함수.
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'yyyy-mm-dd') from dual;
select to_char(sysdate, 'mm-dd-yyyy') from dual;

--    5) months_between('마지막 날짜', 현재 날짜)
--       : 두 날짜 사이의 개월 수를 출력해 주는 함수.
select months_between('23/12/16', sysdate) from dual;

--    6) last_day()
--       : 주어진 날짜가 속한 달의 마지막 날짜를 반환해 주는 함수.
select last_day(sysdate) from dual;


-- 2. 문자와 관련된 함수들
--    1) concat('문자열1', '문자열2')
--       : 문자열을 연결(결합)해 주는 함수.
select concat('안녕', '하세요!!!') from dual;

--    2) upper()
--       : 소문자를 대문자로 바꾸어 주는 함수.
select upper('happy day') from dual;

--    3) lower()
--       : 대문자를 소문자로 바꾸어 주는 함수.
select lower(upper('happy day!!!')) from dual;

--    4) substr('문자열', x, y)
--       : 문자열을 x부터 y의 길이만큼 추출해 주는 함수.
select substr('ABCDEFG', 3, 2) from dual;    -- CD

--       x의 값이 음수인 경우에는 오른쪽부터 시작이 된다.
select substr('ABCDEFG', -3, 2) from dual;   -- EF

--    5) 자릿수를 늘려 주는 함수.
--       5-1) lpad('문자열', '전체자릿수' '늘어난 자릿수에 들어갈 문자열')
--            ==> 왼쪽 자릿수를 늘려 주는 함수.
select lpad('ABCDEFG', 15, '*') from dual;

--       5-2) rpad('문자열', '전체자릿수' '늘어난 자릿수에 들어갈 문자열')
--            ==> 오른쪽 자릿수를 늘려 주는 함수.
select rpad('ABCDEFG', 15, '*') from dual;

--    6) 문자를 지워 주는 함수.
--       6-1) ltrim('문자열', '삭제할 문자');
--            : 왼쪽 문자를 삭제하는 함수.
select ltrim('ABCDEFGA', 'A') from dual;

--       6-2) rtrim('문자열', '삭제할 문자');
--            : 오른쪽 문자를 삭제하는 함수.
select  rtrim('ABCDEFGA', 'A') from dual;

--    7) replace()
--       : 문자열을 교체해 주는 함수.
--         형식) replace('원본 문자열', '교체될 문자열', '새로운 문자열');
select replace('JAVA Program', 'JAVA', 'Spring') from dual;


-- [문제1] emp 테이블에서 결과가 아래와 같이 나오도록
--        화면에 보여주세요.
--        결과) 'SCOTT의 담당업무는 ANALYST 입니다.'
--        (단, concat() 함수를 이용하세요)
select concat(concat(ename, '의 담당업무는 '), 
        concat(job, ' 입니다.'))
from emp;

-- [문제2] emp 테이블에서 결과가 아래와 같이 나오도록
--        화면에 보여주세요.
--        결과) 'SCOTT의 연봉은 36000 입니다'
--        (단, concat() 함수를 이용하세요)
select concat(concat(ename, '의 연봉은 '), 
        concat(sal * 12, ' 입니다.'))
from emp;

-- [문제3] member10 테이블에서 결과가 아래와 같이 나오도록
--        화면에 보여주세요.
--        결과) '홍길동 회원의 직업은 학생입니다.'
--        (단, concat() 함수를 이용하세요)
select concat(concat(memname, '의 직업은 '), 
        concat(job, ' 입니다.'))
from member10;

-- [문제4] emp 테이블에서 사번, 이름, 담당업무를 화면에 보여주세요.
--        단, 담당업무는 소문자로 변경하여 보여주세요.
select empno, ename, lower(job)
from emp;

-- [문제5] 여러 분의 주민등록 번호 중에서 생년월일을 추출하여
--        화면에 보여 주세요.
select substr('881212-1234567', 1, 6)
from dual;

-- [문제6] emp 테이블에서 담당업무에 'A' 라는 글자를 '$' 로 바꾸어
--        화면에 보여 주세요.
select replace(job, 'A', '$') 
from emp;

-- [문제7] member10 테이블에서 직업이 '학생'인 정보를 '대학생'으로 바꾸어
--        화면에 보여 주세요.
select replace(job, '학생', '대학생')
from member10;

-- [문제8] member10 테이블에서 주소에 '서울시' 로 된 정보를 '서울특별시'
--        로 바꾸어 화면에 보여 주세요.
select replace(addr, '서울시', '서울특별시')
from member10;


-- 3. 숫자와 관련된 함수들
--    1) abs(정수) : 절대값을 구해 주는 함수.
select abs(23) from dual;
select abs(-23) from dual;

--    2) sign(정수) : 양수(1), 음수(-1), 0을 반환해 주는 함수.
select sign(15) from dual;
select sign(15), sign(-15), sign(0) from dual;

--    3) round(실수) : 반올림을 해 주는 함수.
select round(1234.5678) from dual;  -- 1235

--       반올림을 할 때 자릿수를 지정
--       형식) round([숫자(필수)], [반올림 위치(선택)])
--            ==> 음수 값을 지정하면 자연수(정수)쪽으로 한자리씩
--                위로 반올림을 해 준다.
select round(0.1234567, 6) from dual;  -- 0.123457

select round(2.3423557, 4) from dual;  -- 2.3424

select round(1236.5678, -2) from dual;  -- 1200

--    4) trunc() : 소숫점 이하 자릿수를 잘라내는 함수.
--       형식) trunc([숫자(필수)], [버릴위치(선택)])
select trunc(1234.1234567, 0) from dual;  -- 1234

select trunc(1234.1234567, 4) from dual;  -- 1234.1234

select trunc(1234.1234567, -2) from dual;  -- 1200

--    5) ceil() : 무조건 올림을 해 주는 함수.
select ceil(22.8) from dual;  -- 23

select ceil(22.1) from dual;  -- 23

--    6) power() : 제곱을 구해 주는 함수.
select power(4, 3) from dual;  -- 64

--    7) mod() : 나머지를 구해 주는 함수.
--       형식) mod([나눗셈될 숫자(필수)], [나눌 문자(필수)])
select mod(77, 4) from dual;

--    8) sqrt() : 제곱근을 구해 주는 함수.
select sqrt(16) from dual;


/*
  제약 조건
  - 테이블에 부적합한 자료가 입력되는 것을 방지하기 위해서
    테이블을 생성할 때 각 컬럼에 대해서 정의하는 여러 가지
    규칙을 정한 것을 말함.
    
  1) not null
  2) unique
  3) primary key : not null + unique
  4) foreign key
  5) check
*/

/*
  1) not null 제약 조건
     - null 값이 입력되지 못하게 하는 제약 조건.
     - 특정 열에 데이터의 중복 여부와는 상관 없이 
       null 값을 허용하지 않는 제약 조건.
*/

create table null_test(
    col1 varchar2(10) not null,
    col2 varchar2(10) not null,
    col3 varchar2(10)
);

insert into null_test values('aa', 'aa1', 'aa2');

insert into null_test(col1, col2) values('bb', 'bb1');

insert into null_test(col1, col2) values('bb', '');  -- error 발생

/*
  2) unique 제약 조건
     - 열에 저장할 데이터의 중복을 허용하지 않고자 할 때 
       사용하는 제약 조건.
     - null 값은 허용함.
*/

create table unique_test(
    col1 varchar2(10) unique,
    col2 varchar2(10) unique,
    col3 varchar2(10) not null,
    col4 varchar2(10) not null
);

insert into unique_test
    values('aa', 'aa1', 'aaa1', 'aaaa1');
    
insert into unique_test
    values('bb', 'aa1', 'bbb1', 'bbbb1');  -- error 발생

/*
  3) primary key 제약 조건
     - unique + not null 제약 조건
     - 테이블에 하나만 존재해야 함.
     - 보통은 주민번호나 emp 테이블의 empno(사원번호) 등이
       primary key의 대표적인 예
*/

/*
  4) foreign key 제약 조건
     - 다른 테이블의 필드(컬럼)를 참조해서 무결성을 검사하는 제약 조건.
     - 참조 키 : 부모 테이블의 컬럼을 이야기 함.
     - 외래 키 : 자식 테이블의 컬럼을 이야기 함.
     - 자식 테이블의 컬럼의 값(데이터)이 부모 테이블에 없는 경우
       무결성 규칙이 깨져 버림.
     - 외래 키가 존재하기 위해서는 우선적으로 부모 테이블이 먼저
       만들어져야 함.
     - 옵션
       * on delete cascade
         ==> 부모 테이블의 데이터 삭제 시 해당 데이터를 참조하고
             있는 자식 테이블의 데이터까지 삭제하는 옵션
       * on detete set null
         ==> 부모 테이블의 데이터 삭제 시 해당 데이터를 참조하고
             있는 자식 테이블의 컬럼 값을 null로 변경하는 옵션
*/

create table foreign_test(
    bunho number(5),
    name1 varchar2(30) not null,
    job varchar2(100) not null,
    -- deptno number(2) references dept(deptno) -- 컬럼상 외래키 제약 조건
    deptno number(2),
    primary key(bunho),
    constraint dept_fk foreign key(deptno)
        references dept(deptno)                 -- 테이블 상 외래키 제약 조건
);

insert into foreign_test values(1111, '홍길동', '영업사원', 30);

insert into foreign_test values(2222, '유관순', '관리사원', 10);

insert into foreign_test values(3333, '김유신', 'IT사원', 50);   -- error 발생


/*
  5) check 제약 조건
     - 열에 저장할 수 있는 값의 범위 또는 패턴을 정의할 때
       사용되는 제약 조건.
*/

create table check_test(
    gender varchar2(6),
    constraint gender_chk check(gender in('남자', '여자'))
);

insert into check_test values('남자');

insert into check_test values('여자');

insert into check_test values('남');  -- error 발생



select * from emp;