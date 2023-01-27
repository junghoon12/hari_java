/*
   학생 테이블을 만들어 보자.
   
   구성 요소(컬럼 - 속성)
   ==> 학번, 이름, 학과, 연락처, 주소, 등록일(입학일) 등등
   
   테이블을 만드는 형식
   
   create table 테이블이름(
      학번 자료형(크기) {제약조건},
      이름 자료형(크기) {제약조건},
      학과 자료형(크기) {제약조건},
      연락처 자료형(크기) {제약조건},
      주소 자료형(크기) {제약조건},
      등록일 자료형(크기) {제약조건}
   );
*/

create table student(
    hakbun varchar2(10) primary key,
    name varchar2(30) not null,
    major varchar2(40),
    phone varchar2(20) not null,
    addr varchar2(100),
    regdate date not null
);

-- 테이블에 컬럼을 추가하는 방법
-- 형식) alter table 테이블이름 
--             add(추가할 컬럼명 데이터타입(크기) {제약조건});
alter table student add(age number(3));

-- 테이블의 컬럼을 수정하는 방법(컬럼의 전체적인 내용 수정)
-- 형식) alter table 테이블이름
--             modify(컬럼명 데이터타입(크기));
alter table student modify(age varchar2(3));

-- 테이블의 컬럼명을 변경하는 방법
-- 형식) alter table 테이블이름
--             rename column 기존컬럼명 to 변경할 컬럼명;
alter table student rename column name to name1;

-- 테이블의 컬럼을 삭제하는 방법
-- 형식) alter table 테이블이름 drop column 컬럼명;
alter table student drop column age;

/*
   1. DDL(Data Define Language : 데이터 정의 언어)
      - CREATE : 데이터베이스 또는 테이블을 생성하는 명령어.
      - ALTER : 테이블을 수정하는 명령어.
      - DROP : 데이터베이스 또는 테이블을 삭제하는 명령어.
      - TRUNCATE : 테이블을 초기화하는 명령어.
   
   2. DML(Data Manipulation Language : 데이터 조작 언어)
      ==> 데이터베이스에서 가장 많이 사용하는 명령어.
      - SELECT : 데이터를 검색하는 명령어.
      - INSERT : 데이터를 추가하는 명령어.
      - UPDATE : 데이터를 수정하는 명령어.
      - DELETE : 데이터를 삭제하는 명령어.
   
   3. DCL(Data Control Language : 데이터 제어 언어)
      - GRANT : 특정 데이터베이스 사용자에게 작업의 특정 수행 
                권한을 부여하는 명령어.
      - REVOKE : 특정 데이터베이스 사용자에게 작업의 특정 수행
                 권한을 삭제하는 명령어.
      - COMMIT : 트랜잭션 작업을 완료하는 명령어.
      - ROLLBACK : 트랜잭션 작업을 취소하거나 이전 상태로 
                   복구하는 역할을 하는 명령어.
*/

-- student 테이블에 데이터(학생 정보)를 추가해 보자.
-- 형식1) insert into 테이블이름 
--               values(컬럼1 데이터.. 마지막 컬럼 데이터);
insert into student values('2023_001', '홍길동', '경제학과',
        '010-1111-1234', '서울시 중구 남대문로', sysdate);
        
-- 형식2) insert into 테이블이름(not null 제약조건 컬럼들 명시)
--            values(제약 조건 컬럼 수에 해당하는 데이터 기재)
insert into student(hakbun, name1, phone, regdate)
    values('2023_002', '이순신', '010-2222-2345', sysdate);
    
insert into student values('2023_003', '유관순', '회계학과',
        '010-3333-3456', '충청남도 천안시', sysdate);
insert into student(hakbun, name1, phone, regdate)
    values('2023_004', '김유신', '010-4444-4567', sysdate);
insert into student(hakbun, name1, phone, regdate)
    values('2023_005', '김연아', '010-5555-5678', sysdate);
   
-- 데이터베이스에 완전하게 저장하고자 할 때 사용하는 명령어.
commit;

-- student 테이블에 있는 모든 데이터를 삭제하는 방법.
delete from student;

-- 이전 상태로 복원하는 명령어.
rollback;


-- student 테이블에 있는 모든 데이터를 화면에 보여주세요.
-- 형식) select * from 테이블이름
select * from student;

-- 보고 싶은 컬럼만 보이게 하고 싶은 경우
-- 형식) select 컬럼명1, 컬럼명2, 컬럼명3... from 테이블이름
select hakbun, name1, phone from student;

-- emp 테이블에서 empno, ename, job, deptno 컬럼을
-- 화면에 보여주세요.
select empno, ename, job, deptno from emp;

-- [문제1] emp 테이블에서 이름, 입사일, 급여를 
--  화면에 보여주세요.
select ename, hiredate, sal from emp;

-- [문제2] emp 테이블에서 사번, 이름, 담당업무, 보너스를
--  화면에 보여주세요.
select empno, ename, job, comm from emp;

-- [문제3] emp 테이블에서 사번, 이름, 급여, 보너스,
--  급여 + 보너스 를 화면에 보여주세요.
select empno, ename, sal, comm, sal+comm from emp;

-- null  값을 가지는 컬럼은 다른 컬럼과 연산을 하게 되면
-- 모두 null 값으로 처리가 되는 문제가 발생.

-- nvl() 함수 : null 값을 특정한 값으로 변경시켜 주는 함수.
--              모든 자료형에 적용이 가능함.
--              nvl() 함수를 사용할 때에는 전환되는 값의
--              자료형을 일치시켜야 함.
-- 형식) nvl(null 값이 들어가 있는 컬럼명, 변경할 값)
select empno, ename, sal, comm, sal + nvl(comm, 0) from emp;

-- nvl2() 함수 : 자바에서의 3항연산자와 비슷한 함수.
-- 형식) nvl2(컬럼명, expr1, expr2)
--        ==> 컬럼명의 값이 null이 아닌 경우 expr1 값을 반환.
--        ==> 컬럼명의 값이 null인 경우 expr2 값을 반환.
select empno, ename, sal, comm, 
                sal + nvl2(comm, comm, 0) from emp;
                
-- as 키워드 : 컬럼의 제목(title)의 이름을 변경하는 키워드.
--            별칭 또는 별명이라고도 함.
--            사용 시에는 컬럼명 바로 뒤에 사용을 함.
--            컬럼명과 별칭 사이에 as 라는 키워드를 넣어주면 됨.
--            보통 별칭은 "" 안에 작성을 함.
--            as 라는 키워드를 생략해도 됨.
select empno, ename, sal, comm,
    sal + nvl2(comm, comm, 0) "SAL + COMM" from emp;
    
-- [문제] emp 테이블에서 사번, 이름, 급여, 급여의 10% 인상액을
-- 화면에 보여주세요.
select empno, ename, sal, sal*1.1 "10% 이상 급여" from emp;

-- emp 테이블에서 각 사원의 담당업무를 화면에 보여주세요.
select job from emp;

-- emp 테이블에서 각 사원의 관리자(mgr)를 화면에 보여주세요.
select mgr from emp;

/*
   distinct 키워드 : 중복을 제거해 주는 명령어(키워드).
   - 주로 하나의 컬럼에서 중복된 값을 제거하고 보여줄 때 사용함.
   - distinct 키워드는 항상 select 키워드 다음에 기술한다.
   - distinct 키워드 뒤에 나오는 컬럼들은 모두 distinct의
     영향을 받는다.
   - distinct 키워드 뒤에 여러 개의 컬럼이 기술이 되면 해당
     컬럼들은 중복이 되지 않게 나타난다.
*/

-- emp 테이블에서 각 사원의 담당업무를 중복이 되지 않게 보여주세요.
select distinct job from emp;

-- emp 테이블에서 각 사원의 관리자를 중복이 되지 않게 보여주세요.
select distinct mgr from emp;

-- [문제] emp 테이블에서 담당업무와 관리자 그리고 부서번호를
-- 화면에 보여주세요.
select distinct job, mgr, deptno from emp;


-- member10 이라는 테이블을 만들어 보자.
create table member10(
    num number(7) primary key,         -- 회원 번호
    memid varchar2(20) not null,       -- 회원 아이디
    memname varchar2(20) not null,     -- 회원 이름
    pwd varchar2(20) not null,         -- 회원 비밀번호
    age number(3),                     -- 회원 나이
    mileage number(5) not null,        -- 회원 마일리지
    job varchar2(30),                  -- 회원 직업
    addr varchar2(200),                -- 회원 주소
    regdate date not null              -- 회원 가입일
);

-- member10 테이블에 고객의 정보를 저장해 보자.
insert into member10
    values(1, 'id1', '홍길동', '1111', 25, 0, '학생',
           '부산시 동래구', '2013-08-08');
insert into member10
    values(2, 'kimkd', '김길동', '2222', 30, 1500, '직장인',
           '서울시 강남구', '2013-09-15');
insert into member10
    values(3, 'id3', '공성현', '3333', 33, 10000, '직장인',
           '부산시 중구', '2013-09-09');
insert into member10
    values(4, 'kimyh', '김영희', '4444', 18, 3000, '학생',
           '경상남도 마산시', '2012-01-01');
insert into member10
    values(5, 'id5', '박말자', '5555', 45, 5000, '주부',
           '경기도 남양주시', '2013-05-23');
insert into member10
    values(6, 'id6', '김철수', '6666', 55, 0, '교수',
           '제주도 서귀포시', '2013-01-10');
insert into member10
    values(7, 'hong', '홍길동', '7777', 14, 0, '학생',
           '경상북도 경주시', '2012-12-25');
insert into member10
    values(8, 'id8', '김상현', '8888', 31, 0, '무직',
           '서울시 마포구', '2013-04-18');
insert into member10
    values(9, 'id9', '이지연', '9999', 25, 0, '학생',
           '강원도 강릉시', '2013-02-06');
insert into member10
    values(10, 'id10', '홍길동', '1010', 52, 10000, '주부',
           '서울시 강북구', '2013-09-15');


-- 카테고리 테이블을 만들어 보자.
create table category(
    cnum number(5),                        -- 카테고리 번호
    category_code varchar2(8) not null,    -- 카테고리 코드
    category_name varchar2(30) not null,   -- 카테고리 이름
    primary key(cnum)
);

-- 카테고리 테이블에 데이터를 저장해 보자.
insert into category 
            values(1, '00010000', '전자제품');
insert into category 
            values(2, '00010001', 'TV');
insert into category 
            values(3, '00010002', '컴퓨터');
insert into category 
            values(4, '00010003', 'MP3');
insert into category 
            values(5, '00010004', '에어컨');
insert into category 
            values(6, '00020000', '의류');
insert into category 
            values(7, '00020001', '남방');
insert into category 
            values(8, '00020002', '속옷');
insert into category 
            values(9, '00020003', '바지');
insert into category 
            values(10, '00030000', '도서');
insert into category 
            values(11, '00030001', '컴퓨터도서');
insert into category 
            values(12, '00030002', '소설');
            

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
    company varchar2(30)                           -- 제품 제조사
);

-- 제품 데이터를 저장해 보자.
insert into products
   values(1, '00010001', 'S 벽걸이 TV', '00001', 5000000, 8000000, 0, 100000, '삼성');
insert into products
   values(2, '00010001', 'D TV', '00002', 300000, 400000, 0, 50000, '대우');
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
   
commit;

-- [문제1] member10 테이블에서 회원의 이름과 나이, 직업을
-- 화면에 보여주세요.
select memname, age, job from member10;

-- [문제2] products 테이블에서 제품명, 입고가 , 출고가,
-- 제조사를 화면에 보여주세요.
select products_name, input_price, output_price,
    company from products;
    
    
-- 예) KING 사원의 연봉은 60000 입니다.
-- || : 연결 연산자.
select ename || ' 사원의 연봉은 ' || sal * 12 || ' 입니다.'
    "사원의 연봉" from emp;
    
-- [문제] member10 테이블의 내용을 아래와 같이 출력해 보자.
-- 예) 홍길동 회원의 직업은 학생이고, 마일리지는 0 입니다.
select memname || ' 회원의 직업은 ' || job || 
'이고, 마일리지는 ' || mileage || ' 입니다.'
from member10;


-- 테이블을 삭제하는 방법
-- 형식) drop table 테이블이름 purge;



/*
   ★★★★★★★★★★★★★★★★★★★★★★★★★★★
   where 조건절
   
   - 모든 데이터를 가져 오는 것이 아니라 사용자가 원하는 데이터만
     조회할 경우에 사용됨.
   - where 조건절은 자료를 필터링 할 때 사용되는 키워드.
   - where 조건절은 from 테이블 이름 뒤에 기술해야 함.
   형식) select 컬럼명1, 컬럼명2,... 컬럼명n 
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

-- [문제2] emp 테이블에서 1982년 1월 1일 이후에 입사한
-- 사원의 시번, 이름, 담당업무, 급여, 입사일자를 화면에
-- 보여주세요.

-- [문제3] emp 테이블에서 급여가 1300 ~ 1500 사이인 사원의
-- 이름과 담당업무, 굽여, 부서번호를 화면에 보여주세요.

-- [문제4] emp 테이블에서 사번이 7902, 7788, 7566 인 사원의
-- 사번, 이름, 담당업무를 화면에 보여주세요.

-- [문제5] emp 테이블에서 보너스가 300이거나 500이거나
-- 1400인 사원의 모든 정보를 화면에 보여주세요.

-- [문제6] member10 테이블에서 이름이 홍길동이면서 직업이
-- 학생인 회원의 모든 정보를 화며에 보여주세요..

-- [문제7] products 테이블에서 제조사가 '삼성' 또는 '현대'
-- 이면서 입고가가 100만원 이하인 상품의 상품명과 입고가,
-- 출고가를 화면에 보여주세요.

-- [문제8] emp 테이블에서 급여가 1100 이상이고, 담당업무가
-- 'MANAGER' 인 사원의 사번, 이름, 담당업무, 급여를 화면에
-- 보여주세요..


select * from emp;