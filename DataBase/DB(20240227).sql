-- member 라는 테이블을 만들어 보자.

create table member(
    memno number primary key,          -- 회원 번호
    memid varchar2(20) not null,       -- 회원 아이디
    memname varchar2(30) not null,     -- 회원 이름
    mempwd varchar2(20) not null,      -- 회원 비밀번호
    age number,                        -- 회원 나이
    mileage number,                    -- 회원 마일리지
    job varchar2(30),                  -- 회원 직업
    addr varchar2(500),                -- 회원 주소
    regdate date not null              -- 회원 가입일
);


-- member 테이블에 회원의 정보를 저장해 보자.
insert into member
    values(1, 'id1', '홍길동', '1111', 25, 0, '학생',
            '부산시 동래구', '2013-08-08');

insert into member
    values(2, 'kimkd', '김길동', '2222', 30, 1500, '회사원',
            '서울시 강남구', '2013-09-15');

insert into member
    values(3, 'id3', '공성현', '3333', 33, 10000, '회사원',
            '부산시 중구', '2013-09-09');
            
insert into member
    values(4, 'kimyh', '김영희', '4444', 18, 3000, '학생',
            '경상남도 마산시', '2014-05-23');
            
insert into member
    values(5, 'id5', '박말자', '5555', 45, 5000, '주부',
            '경기도 남양주시', '2013-12-01');

insert into member
    values(6, 'id6', '김철수', '6666', 55, 0, '교수',
            '제주도 서귀포시', '2013-01-10');

insert into member
    values(7, 'hong', '홍길동', '7777', 14, 0, '학생',
            '경상북도 경주시', '2013-12-25');

insert into member
    values(8, 'id8', '김상현', '8888', 31, 0, '무직',
            '서울시 마포구', '2013-04-22');

insert into member
    values(9, 'id9', '이지연', '9999', 25, 0, '학생',
            '강원도 강릉시', '2013-10-10');

insert into member
    values(10, 'id10', '홍길동', '1010', 52, 10000, '무직',
            '서울시 강북구', '2013-09-15');


-- 카테고리 테이블을 만들어 보자.
create table category(
    cnum number unique,                        -- 카테고리 번호
    category_code varchar2(8),                 -- 카테고리 코드
    category_name varchar2(30) not null,       -- 카테고리 이름
    primary key(category_code)
);


-- 카테고리 테이블에 데이터를 저장해 보자.
insert into category values(1, '00010000', '전자제품');
insert into category values(2, '00010001', 'TV');
insert into category values(3, '00010002', '컴퓨터');
insert into category values(4, '00010003', '노트북');
insert into category values(5, '00010004', '에어컨');
insert into category values(6, '00020000', '의류제품');
insert into category values(7, '00020001', '남방');
insert into category values(8, '00020002', '속옷');
insert into category values(9, '00020003', '바지');
insert into category values(10, '00030000', '도서');
insert into category values(11, '00030001', '컴퓨터도서');
insert into category values(12, '00030002', '소설');


-- 상품 정보 테이블을 만들어 보자.
create table products(
    pnum number(11) primary key,                   -- 제품 번호
    category_fk varchar2(8) not null,              -- 카테고리 코드
    products_name varchar2(50) not null,           -- 제품명
    ep_code_fk varchar2(5) not null,               -- 제품 코드
    input_price number(10) default 0 not null,     -- 제품 입고 가격
    output_price number(10) default 0 not null,    -- 제품 출고 가격
    trans_cost number(5) default 0 not null,       -- 제품 배송비
    mileage number(6) default 0 not null,          -- 제품 마일리지
    company varchar2(30),                          -- 제품 제조사
    constraint category_ref foreign key(category_fk) 
        references category(category_code)
);

-- 제품 데이터를 저장해 보자.
insert into products
   values(1, '00010001', 'S 벽걸이 TV', '00001', 5000000, 8000000, 0, 100000, '삼성');
insert into products
   values(2, '00010001', 'L TV', '00002', 1000000, 1500000, 0, 50000, 'LG');
insert into products
   values(3, '00010004', 'S 에어컨', '00001', 1000000, 1100000, 5000, 100000, '삼성');
insert into products
   values(4, '00010000', 'C 밥솥', '00003', 200000, 220000, 5500, 0, '쿠쿠');
insert into products
   values(5, '00010004', 'L 에어컨', '00003', 1200000, 1300000, 0, 0, 'LG');
insert into products
   values(6, '00020001', '남성난방', '00002', 100000, 150000, 2500, 0, '');
insert into products
   values(7, '00020001', '여성난방', '00002', 120000, 200000, 0, 0, '');
insert into products
   values(8, '00020002', '사각팬티', '00002', 10000, 20000, 0, 0, '보디가드');
insert into products
   values(9, '00020003', '멜빵바지', '00002', 15000, 18000, 0, 0, '');
insert into products
   values(10, '00030001', '무따기 시리즈', '00001', 25000, 30000, 2000, 0, '길벗');


-- [문제1] member 테이블에서 회원의 이름과 나이, 직업을 화면에 보여주세요.
select memname, age, job from member;

-- [문제2] products 테이블에서 제품명, 입고가, 출고가, 제조사를 화면에 보여주세요.
select products_name, input_price, output_price, company from products; 


-- KING 사원의 연봉은 60000 입니다.
-- || : 오라클에서 연결 연산자.
select ename || ' 사원의 연봉은 ' || sal * 12 || ' 입니다.' 
        as "직원의 연봉" from emp;
        
-- [문제] member 테이블의 내용을 아래와 같이 화면에 출력해 보세요.
-- 예시) 홍길동 회원의 직업은 학생이고, 마일리지는 0 마일리지 입니다.
select memname || ' 회원의 직업은 ' || job || ' 이고, 마일리지는 ' 
    || mileage || ' 마일리지 입니다.' from member;

-- 테이블을 삭제하는 방법
-- 형식) drop table 테이블이름 purge;


/*
  ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  where 조건절
  
  - 모든 데이터를 가져 조회하는 것이 아니라 사용자가 원하는 데이터만
    조회할 경우에 사용함.
  - where 조건절은 자료를 필터링 할 때 사용되는 키워드.
  - where 조건절은 from 테이블 이름 뒤에 기술해야 함.
  
  형식) select 컬럼명1, 컬럼명2, 멀럼명3,......
            from 테이블이름 where 조건식;
            
  조건식에 들어가는 내용
  1) = : 조건이 같은지 여부 확인.
  2) < : 조건이 작은지 여부 확인.
  3) <= : 조건이 작거나 같은지 여부 확인.
  4) > : 조건이 큰지 여부 확인.
  5) >= : 조건이 크거나 같은지 여부 확인.
  6) != : 조건이 같지 않은지 여부 확인.
  7) <> : 조건이 같지 않은지 여부 확인. ==> != 과 같은 의미.
  8) between A and B : A와 B 사이에 있는지 여부 확인.
  9) in(list) : list 값 중에 어느 하나와 일치하는지 여부 확인.
  10) not between A and B : A와 B 사이에 있지 않은지 여부 확인.
      ==> A, B 값을 포함하지 않음.
  11) not in(list) : list 값과 일치하지 않는지 여부 확인.
*/

-- emp 테이블에서 담당업무가 'MANAGER' 인 사원의
-- 모든 정보를 화면에 보여주세요.
select * from emp
where job = 'MANAGER';

-- emp 테이블에서 담당업무가 'SALESMAN' 인 사원의
-- 모든 정보를 화면에 보여주세요.
select * from emp
where job = 'SALESMAN';


-- [문제1] emp 테이블에서 담당업무가 'CLERK' 인 사원의
-- 사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job = 'CLERK';

-- [문제2] emp 테이블에서 1982년 1월 1일 이후에 입사한
-- 사원의 사번, 이름, 담당업무, 급여, 입사일자를 화면에 보여주세요.
select empno, ename, job, sal, hiredate
from emp
where hiredate >= '82/01/01';

-- [문제3] emp 테이블에서 급여가 1300 ~ 1500 사이인 사원의
-- 이름과 담당업무, 급여, 부서번호를 화면에 보여주세요.
select ename, job, sal, deptno
from emp
-- where sal >= 1300 and sal <= 1500; (O)
where sal between 1300 and 1500;

-- [문제4] emp 테이블에서 사번이 7902, 7788, 7566 인 사원의
-- 사번, 이름, 담당업무를 화면에 보여주세요.
select empno, ename, job
from emp
-- where empno = 7902 or empno = 7788 or empno = 7566; (O)
where empno in (7902, 7788, 7566);

--[문제5] emp 테이블에서 보너스가 300이거나 500이거나
-- 1400인 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
-- where comm = 300 or comm = 500 or comm = 1400; (O)
where comm in (300, 500, 1400);

-- [문제6] member 테이블에서 이름이 홍길동이면서 직업이
-- 학생인 회원의 모든 정보를 화면에 보여주세요.
select *
from member
where memname = '홍길동' and job = '학생';

-- [문제7] products 테이블에서 제조사가 '삼성' 또는 '현대'
-- 이면서 입고가가 100만원 이하인 상품의 상품명과 입고가 그리고
-- 출고가를 화면에 보여주세요.
select products_name, input_price, output_price
from products
where company in ('삼성', '현대') and input_price <= 1000000;

-- [문제8] emp 테이블에서 급여가 1100 이상이고, 담당업무가
-- 'MANAGER' 인 사원의 사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal >= 1100 and job = 'MANAGER';


/*
  ★★★★★★★★★★★★★★★★★★★★
  like 키워드 : 검색을 하는 키워드.
  
  1) where ename like '%S%'
     ==> ename 컬럼에 S자를 포함하는 사원의 이름을 검색.
     
  2) where ename like 'S%'
     ==> ename 컬럼에 첫글자가 S자로 시작하는 사원의 이름을 검색.
     
  3) where ename like '%S'
     ==> ename 컬럼에 마지막 글자가 S자로 끝나는 사원의 이름을 검색.
     
  4) where ename like '_S%'
     ==> ename 컬럼에 두번째 글자가 S자를 포함하는 사원의 이름을 검색.
*/

-- emp 테이블에서 사원명에 'A' 라는 글자를 포함하는 사원의
-- 모든 정보를 보여주세요.
select * 
from emp
where ename like '%A%';


-- [문제1] emp 테이블에서 사원명에 'M' 이라는 글자를 포함하는
-- 사원의 모든 정보를 화면에 보여주세요.
select * 
from emp
where ename like '%M%';

-- [문제2] emp 테이블에서 사원명의 두번째 글자에 'I' 이라는 
-- 글자를 포함하는 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '_I%';

-- [문제3] emp 테이블에서 사원명에 이름이 'S' 라는 글자로 끝나는
-- 사원의 사번과 이름, 담당업무, 부서번호를 화면에 보여주세요.
select empno, ename, job, deptno
from emp
where ename like '%S';

-- [문제4] emp 테이블에서 사원명에 세번째 글자가 'R' 이라는 
-- 글자를 포함하는 사원의 이름과 담당업무, 급여를 화면에 보여주세요.
select ename, job, sal
from emp
where ename like '__R%';

-- [문제5] emp 테이블에서 사원명에 두번째 글자가 'O' 라는 
-- 글자를 포함하는 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '_O%';

-- [문제6] emp 테이블에서 입사년도가 82년도인 사원의 
-- 사번, 이름, 담당업무, 입사일자를 화면에 보여주세요.
select empno, ename, job, hiredate
from emp
where hiredate like '82%';

-- [문제7] member 테이블에서 성이 '김'씨 성을 가지는 
-- 회원의 모든 정보를 화면에 보여주세요.
select *
from member
where memname like '김%';

-- [문제8] member 테이블에서 주소에 '서울시' 가 들어가는 
-- 회원의 이름, 주소, 직업을 화면에 보여주세요.
select memname, addr, job
from member
where addr like '서울시%';

-- [문제9] products 테이블에서 제품명에 '에어컨' 을 
-- 포함하는 제품의 제품명, 입고가, 출고가, 제조사를
-- 화면에 보여주세요.
select products_name, input_price, output_price, company
from products
where products_name like '%에어컨%';


/*
  ★★★★★★★★★★★★★★★★★★★★
  order by 절
  
  - 자료를 정렬하여 나타낼 때 사용하는 명령어.
  - order by 절을 사용할 때는 select 구문의 맨 마지막에 위치해야 함.
  - asc : 오름차순 정렬
  - desc : 내림차순 정렬
  - 기본적으로 order by 절을 사용 시에는 오름차순 정렬이 default임.
  - 오름차순 정렬인 경우에는 asc를 생략해도 됨.
*/

-- member 테이블에서 이름을 기준으로 오름차순으로 정렬을 하여 
-- 모든 정보를 화면에 보여주세요.
-- 단, 이름이 같은 경우에는 나이를 기준으로 내림차순 정렬하세요.
select *
from member
order by memname, age desc;


-- [문제1] emp 테이블에서 부서번호를 기준으로 오름차순 정렬을 하고,
-- 부서번호가 같은 경우 급여를 기준으로 내림차순으로 정렬을 하여
-- 화면에 보여주세요.
-- 단, 급여가 같은 경우 사원번호를 기준으로 오름차순 정렬
select *
from emp
order by deptno, sal desc, empno;

--[문제2] products 테이블에서 판매가격을 기준으로 내림차순으로
-- 정렬을 하여 모든 정보를 화면에 보여주세요.
select *
from products
order by output_price desc;

-- [문제3] products 테이블에서 배송비를 기준으로 내림차순으로
-- 정렬하세요. 단, 배송비가 같은 경우 마일리지를 기준으로
-- 내림차순으로 정렬하여 모든 정보를 화면에 보여주세요.
select * 
from products
order by trans_cost desc, mileage desc;

-- [문제4] emp 테이블에서 입사일자가 오래된 사원부터 최근에 
-- 입사한 사원을 기준으로 정렬하되, 사원명, 입사일자를
-- 화면에 보여주세요.
select ename, hiredate
from emp
order by hiredate;

-- [문제5] emp 테이블에서 급여를 기준으로 내림차순으로 정렬을
-- 하여 모든 정보를 화면에 보여주세요.
select *
from emp
order by sal desc;

-- [문제6] emp 테이블에서 급여가 1100 이상인 사원들의 정보를
-- 보여주되, 입사일자가 빠른 순으로 정렬하여 화면에 보여주세요.
select *
from emp
where sal >= 1100
order by hiredate;

-- [문제7] emp 테이블에서 부서번호를 기준으로 오름차순 정렬하여
-- 나타내고, 부서번호가 같은 경우 담당업무를 기준으로 오름차순하여
-- 정렬하세요. 만약 담당업무가 같다고 하면, 급여가 많은데서 적은
-- 순으로 정렬하여 모든 정보를 화면에 보여주세요.
select *
from emp
order by deptno, job, sal desc;


/*
  not 키워드 : 부정
  - 부정을 처리하는 경우에는 일단은 긍정의 쿼리문을 작성 후에
    부정의 의미인 not을 붙여주면 됨.
*/

-- emp 테이블에서 담당업무가 'MANAGER', 'CLERK', 'ANALYST' 가
-- 아닌 사원의 사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job not in ('MANAGER', 'CLERK', 'ANALYST');


-- [문제1] emp 테이블에서 이름에 'S' 자가 들어가지 않는
-- 사원의 이름과 담당업무를 화면에 보여주세요.
select ename, job
from emp
where ename not like '%S%';

-- [문제2] emp 테이블에서 부서번호가 10번 부서가 아닌 사원의
-- 이름, 담당업무, 부서번호를 화면에 보여주세요.
select ename, job, deptno
from emp
-- where not deptno = 10; (O)
-- where deptno != 10; (O)
where deptno <> 10;

-- [문제3] member 테이블에서 주소가 '서울시' 가 아닌 회원의
-- 모든 정보를 화면에 보여주세요.
select *
from member
where addr not like '%서울시%';

-- [문제4] products 테이블에서 출고가가 100만원 미만이 아닌
-- 제품의 제품명과 출고가를 화면에 보여주세요.
select products_name, output_Price
from products
where not output_price < 1000000;

-- [문제5] emp 테이블에서 보너스가 null이 아닌 사원의 
-- 모든 정보를 화면에 보여주세요.
select *
from emp
where comm is not null;


/*
  ★★★★★★★★★★★★★★★★★★★
  
  - 사용자 계정을 만드는 방법
  - create user 사용자계정명 identified by 비밀번호;
  
  - 만들어진 계정을 사용하기 위해 권한을 설정.
  - grant connect, resource to 사용자계정명;

  - role : 사용자에게 보다 효율적으로 권한을 부여할 수 있도록 
           여러 개의 권한을 묶어 놓은 것을 말함.

  - connect role
    ==> 오라클에 접속할 수 있는 세션 설정 및 사용자가
        데이터베이스에 접속이 가능하도록 하기 위해서 가장
        기본적인 시스템 권한을 묶어 놓은 것을 말함.
        
  - resource role
    ==> 사용자가 테이블을 생성할 수 있도록 하기 위해서
        시스템 권한을 묶어 놓은 것을 말함.
        또한 insert, update, delete 구문을 사용할 수
        있는 권한을 묶어 놓은 것을 말함.
*/

/*
  그룹함수
  ==> 여러 행 또는 테이블 전체에 대하여 함수가 적용되어
      하나의 결과값을 가져오는 함수.
      
  1) avg() : 평균값을 구하는 함수.
  2) count() : 행(레코드)의 갯수를 구하는 함수.
               ==> null 값은 무시하고 행의 갯수를 구함.
  3) max() : 최대값을 구하는 함수.
  4) min() : 최소값을 구하는 함수.
  5) sum() : 총 합을 구하는 함수.
*/

-- emp 테이블에서 사번을 가지고 있는 모든 사원의 수를
-- 구하여 화면에 보여주세요.
select count(empno) 
from emp;

-- [문제1] emp 테이블에서 관리자(mgr)의 수를
-- 구하여 화면에 보여주세요.
select count(distinct mgr)
from emp;

--[문제2] emp 테이블에서 보너스를 가진 사원의 수를
-- 구하여 화면에 보여주세요.
select count(comm)
from emp;

--[문제3] emp 테이블에서 모든 'SALESMAN' 의 급여 평균과
-- 급여 최고액, 급여 최저액, 급여 합계액을 구하여
-- 화면에 보여주세요.
select avg(sal), max(sal), min(sal), sum(sal)
from emp
where job = 'SALESMAN';

--[문제4] emp 테이블에서 등록되어 있는 사원의 총 수,
-- 보너스가 null 이 아닌 사원 수, 보너스의 평균, 등록되어
-- 있는 부서의 수를 구하여 화면에 보여주세요.
select count(*), count(comm), avg(comm), count(distinct deptno)
from emp;








select * from emp;








commit;


