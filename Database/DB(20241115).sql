/*
  시퀀스(sequence)
  ==> - 순서를 부여할 때 사용하는 문법.
      - 연속적인 번호를 만들어 주는 기능을 함.
      
  형식)
        create sequence 시퀀스이름
        start with n(시작번호 설정 - 기본값으로 1)
        increment by n(증감번호 설정 - 기본값으로 1)
        [maxvalue n(시퀀스 최대 번호 설정)] - 생략도 가능
        [minvalue n(시퀀스 최소 번호 설정)] - 생략도 가능
        cache n / nocache(캐쉬 메모리 사용 여부)
        
        1) cache : 시퀀스를 빠르게 제공하기 위하여 미리 캐쉬  
                   메모리에 시퀀스를 넣어 두어 준비하고 있다가
                   시퀀스 작업이 필요할 때 사용을 함.
                   default로는 20개의 시퀀스를 캐쉬 메모리에 보관함.
        
        2) nocache : cache 기능을 사용하지 않는다는 뜻.
*/

-- memo 라는 테이블을 만들어 보자.
create table memo (
    bunho number(5),
    title varchar2(100) not null,
    writer varchar2(30) not null,
    cont varchar2(1000) not null,
    regdate date,
    primary key(bunho)
);

-- memo 테이블을 이용 시 사용할 시퀀스를 만들어 보자.
create sequence memo_seq
start with 1
increment by 1
cache 20;


-- memo 테이블에 데이터를 저장해 보자.
insert into memo 
    values(memo_seq.nextval, '메모1', '홍길동', '길동이 글이에요~~~', sysdate);

insert into memo 
    values(memo_seq.nextval, '한글 메모', '세종대왕', '한글이에요~~~', sysdate);

insert into memo 
    values(memo_seq.nextval, '독립선언문', '유관순', '대한독립만세!!!', sysdate);
    
insert into memo 
    values(memo_seq.nextval, '장군님 메모', '이순신', '이순신 장군 메모', sysdate);
    
insert into memo 
    values(memo_seq.nextval, '메모5', '신사임당', '신사임당 메모글이에요~~~', sysdate);
    
commit;

/*
  제약조건
  - 테이블에 부적합한 자료가 입력되는 것을 방지하기 위해서
    테이블을 생성할 때 각 컬럼에 대하여 정의하는 여러 가지
    규칙을 정한 것을 말함.
    
  1) not null
  2) unique
  3) primary key : unique + not null
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

insert into null_test(col1, col2) values('bb', '');  -- error 발생.


/*
  2) unique 제약 조건
     - 열에 저장할 데이터의 중복을 허용하지 않고자 할 때
       사용하는 제약 조건.
     - null 값은 허용을 함.
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
    values('', 'aa1', 'bbb1', 'bbbb1'); -- error 발생

/*
  3) primary-key : unique + not null 제약 조건
     - 테이블에 하나만 존재해야 함.
     - 보통은 주민번호나 emp 테이블의 empno(사번) 등이
       primary key의 대표적인 예
*/

/*
  4) foreign key 제약 조건
     - 다른 테이블의 필드(컬럼)를 참조해서 무결성을
       검사하는 제약 조건.
     - 참조 키 : 부모 테이블의 컬럼을 이야기 함.
     - 외래 키 : 자식 테이블의 컬럼을 이야기 함.
     - 자식 테이블의 컬럼의 값(데이터)이 부모 테이블에
       없는 경우 무결성의 규칙이 깨져 버림.
     - 외래 키가 존재하기 위해서는 우선적으로 부모 
       테이블이 먼저 만들어져야 함.
     - 옵션 
        * on delete cascade
          ==> 부모 테이블의 데이터 삭제 시 해당 데이터를
              참조하고 있는 자식 테이블의 데이터까지
              삭제하는 옵션.
        * on delete set null
          ==> 부모 테이블의 데이터 삭제 시 해당 데이터를
              참조하고 있는 자식 테이블의 컬럼에 있는 
              값(데이터)을 null로 변경시키는 옵션.
*/
create table dept_test(
    deptno number,
    dname varchar2(100),
    loc varchar2(100),
    primary key(deptno)
);

insert into dept_test values(10, 'accounting', 'newyork');
insert into dept_test values(20, 'research', 'dallas');
insert into dept_test values(30, 'sales', 'chicago');
insert into dept_test values(40, 'operations', 'boston');

create table foreign_test(
    bunho number primary key,
    irum varchar2(30) not null,
    job varchar2(100) not null,
    -- deptno number(2) references dept(deptno) -- 컬럼상에서 외래키 제약 조건
    deptno number,
    constraint dept_fk foreign key(deptno)
        references dept_test(deptno)
        on delete set null  -- 테이블 상에서 외래키 제약 조건
);

drop table foreign_test purge;

insert into foreign_test values(1111, '홍길동', '영업사원', 30);

insert into foreign_test values(2222, '유관순', '관리사원', 10);

insert into foreign_test values(3333, '이순신', 'IT사원', 50);  -- error 발생

-- dept 테이블에서 10번 부서번호를 삭제해 보자.
delete from dept_test where deptno = 10;


/*
  5) check 제약 조건
     - 열에 저장할 수 있는 값의 범위 또는 패턴을 
       정의할 때 사용되는 제약 조건.
*/

create table check_test(
    gender varchar2(10),
    constraint gender_chk check(gender in('남', '여'))
);

insert into check_test values('남');

insert into check_test values('여');

insert into check_test values('여자');  -- error 발생


/*
  join ~ on 키워드
  - 테이블과 테이블을 연결하여 특정한 데이터를 얻고자 할 때 사용함.
  - 두 개 이상의 테이블에 정보가 나뉘어져 있을 때 사용함.
  - 중복해서 데이터가 저장되는 것을 방지하기 위해서 테이블을 나누어 놓은 것임.
  - 두 개의 테이블로 나누어진 경우에는 데이터의 중복은 발생하지 않지만
    원하는 정보를 얻으려면 여러 번 질의를 해야 하는 불편함이 생김.
  - 예를 든다면 특정 사원이 소속된 부서의 부서명을 알고 싶은 경우에는
    emp 테이블과 dept 테이블을 넘나드는 작업이 생기므로 상당히 불편함.
    그래서 두 개의 테이블을 결합해서 원하는 결과를 얻어낼 수 있도록 하는
    조인이라는 기능이 생겨나게 되었음.
    
    조인의 종류
    1) Cross Join
    2) Equi Join
    3) Self Join
    4) Outer Join
*/

/*
  1) Cross Join
     - 두 개 이상의 테이블이 조인이 될 때 조건이 없이 테이블의
       결합이 이루어지는 조인 방법.
     - 테이블 상호 간에 연결될 수 있는 모든 경우의 수를 산출하여 
       나타내는 조인 방법임. 그렇기 때문에 테이블 전체 행의 
       컬럼이 조인이 됨.
     - 현재는 사용을 안 하는 조인 종류임.
*/

select *
from emp, dept;

/*
  2) Equi Join
     - 가장 많이 사용하는 조인 방법.
     - 조인의 대상이 되는 두 테이블에서 공통적으로 존재하는
       컬럼의 값이 일치하는 행을 연결하여 결과를 생성하는 방법.
     - 두 테이블의 조인을 하려면 일치되는 공통 컬럼을 사용해야 함.
*/

-- emp 테이블에서 사원의 사번, 이름, 담당업무, 부서번호 및
-- 부서명, 부서위치를 화면에 보여주세요.
-- ==> emp 테이블과 dept 테이블을 조인시켜 주어야 함.
select empno, ename, job, e.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno;

-- emp 테이블에서 사원명이 'SCOTT' 인 사원의
-- 부서명을 알고 싶은 경우.
select ename, e.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where ename = 'SCOTT';

-- [문제1] 부서명이 'REAEARCH' 인 사원의
-- 사번, 이름, 급여, 부서명, 근무위치를 화면에 보여주세요.
select empno, ename, sal, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where dname = 'RESEARCH';

-- [문제2] emp 테이블에서 'NEW YORk' 에 근무하는 사원의
-- 이름과 급여, 부서번호를 화면에 보여주세요.
select ename, sal, d.deptno
from emp e join dept d
on e.deptno = d.deptno
where loc = 'NEW YORK';


-- [문제3] emp 테이블에서 'ACCOUNTING' 부서 소속 사원의
-- 이름과 담당업무, 입사일 그리고 부서번호, 부서명을 
-- 화면에 보여주세요.
select ename, job, hiredate, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where dname = 'ACCOUNTING';

-- [문제4] emp 테이블에서 담당업무가 'SALESMAN' 인 사원의
-- 이름과 담당업무, 부서번호, 부서명, 근무위치를 화면에 보여주세요.
select ename, job, e.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where job = 'SALESMAN';


/*
  3) Self Join
     - 하나의 테이블 내에서 조인을 해야 데이터를 얻어낼 수
       있는데 말 그대로 자기 자신과 조인을 맺는 것을 말함.
     - from 절 다음에 테이블 이름을 나란히 두 번 기술할 수 없음.
       따라서 같은 테이블이 하나 더 존재하는 것처럼 사용할 수
       있도록 테이블에 별칭을 붙여서 사용해야 함.
*/

-- emp 테이블에서 각 사원별 관리자의 이름을 화면에 출력해 보자.
-- 예) CLARK 의 관리자의 이름은 KING 입니다.
select e1.ename || ' 의 관리자 이름은 ' || e2.ename || ' 입니다.'
from emp e1 join emp e2
on e1.mgr = e2.empno;

-- [문제] emp 테이블에서 매니저가 'KING' 인 사원들의
-- 이름과 담당업무를 화면에 보여주세요.
select e1.ename, e1.job
from emp e1 join emp e2
on e1.mgr = e2.empno
where e2.ename = 'KING';


/*
  4) Outer Join
     - 2개 이상의 테이블이 조인이 될 때 어느 한 쪽 테이블에는
       해당되는 데이터가 다른쪽 테이블에는 데이터가 존재하지
       않는 경우 그 데이터가 출력이 되지 않는 문제점을 해결하기
       위해 사용되는 조인 기법임
     - 정보가 부족한 테이블의 컬럼 뒤에 '(+)' 기호를 붙여 사용을 함.
*/

select ename, d.deptno, dname
from emp e join dept d
on e.deptno(+) = d.deptno;

select e1.ename, e1.job, e1.mgr
from emp e1 join emp e2
on e1.mgr = e2.empno(+);


/*
  dual 테이블
  - 오라클에서 자체적으로 제공해 주는 테이블.
  - 간단하게 함수를 이용해서 계산, 결과값을 확인할 때 사용하는 테이블.
  - 오직 한 행, 한 컬럼만을 담고 있는 테이블.
  - 사용 용도 : 특정 테이블을 생성할 필요 없이 함수 또는
               계산을 하고자 할 때 사용이 됨.
*/

-- 오라클에서 제공해 주는 함수들
-- 1. 날짜와 관련된 함수들.
--    1) sysdate : 현재 시스템의 날짜를 구해 오는 키워드.
select sysdate from dual;

--    2) add_months(현재날짜, 숫자(개월수))
--       ==> 현재 날짜에서 개월 수를 더한 날짜를 알려 주는 함수.
select add_months(sysdate, 3) from dual;

--    3) next_day(현재날짜, '요일')
--       ==> 다가올 날짜(요일)를 구해 주는 함수.
select next_day(sysdate, '토요일') from dual;

--    4) to_char(날짜, '날짜형식')
--       ==> 형식에 맞게 문자열로 날짜를 출력해 주는 함수.
select to_char(sysdate, 'yyyy/mm/dd') from dual;

select to_char(sysdate, 'yyyy-mm-dd') from dual;

select to_char(sysdate, 'mm-dd-yyyy') from dual;

--    5) months_between('마지말날짜', 현재날짜)
--       ==> 두 날짜 사이의 개월 수를 출력해 주는 함수.
select months_between('25/04/17', sysdate) from dual;

--    6) last_day('날짜')
--       ==> 주어진 날짜가 속한 달의 마지막 날짜를 구해 주는 함수.
select last_day(sysdate) from dual;


-- 2. 문자와 관련된 함수들.
--    1) concat('문자열1', '문자열2')
--       ==> 두 문자열을 결합해 주는 함수.
select concat('안뇽', '하세요??') from dual;

--    2) || 연산자 : 문자열을 겹합하는 연산자.
select '방가' || '방가' from dual;

--    3) upper() : 소문자를 대문자로 바꾸어 주는 함수.
select upper('happy day') from dual;

--    4) lower() : 대문자를 소문자로 바꾸어 주는 함수.
select lower(upper('happy day')) from dual;

--    5) substr('문자열', n, n1)
--       ==> 문자열을 n부터 n1의 길이만큼 추출해 주는 함수.
select substr('ABCDEFG', 3, 2) from dual; -- CD
--       ==> n 값이 음수인 경우에는 오른쪽(뒤쪽)에서부터 시작이 됨.
select substr('ABCDEFG', -3, 2) from dual; -- EF

--    6) 자릿수를 늘려 주는 함수
--    6-1) lpad('문자열', 전체자릿수, '늘어난 자릿수에 들어갈 문자열')
select lpad('ABCDEFG', 15, '*') from dual;

--    6-2) rpad('문자열', 전체자릿수, '늘어난 자릿수에 들어갈 문자열')
select rpad('ABCDEFG', 15, '*') from dual;

--    7) 문자를 지워 주는 함수.
--    7-1) ltrim() : 왼쪽 문자를 지워주는 함수.
select ltrim('ABCDEFG', 'A') from dual;

--    7-2) rtrim() : 오른쪽 문자를 지워 주는 함수.
select rtrim('ABCDEFGA', 'A') from dual;

--    8) replace() : 문자열을 교체해 주는 함수.
--       형식) replace('원본 문자열', '교체될 문자열', '새로운 문자열')
select replace('Java Program' , 'Java', 'Python') from dual;


-- [문제1] emp 테이블에서 결과가 아래와 같이 나오도록
-- 화면에 보여주세요.
-- 예시) 'SCOTT 의 담당업무는 ANALYST 입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(concat(ename, ' 의 담당업무는 '),
concat(job, ' 입니다.'))
from emp;

-- [문제2] emp 테이블에서 결과가 아래와 같이 나오도록
-- 화면에 보여주세요.
-- 예시) 'SCOTT 의 연봉은 36000 입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(concat(ename, ' 의 연봉은 '),
concat(sal * 12, ' 입니다.'))
from emp;


-- [문제3] member10 테이블에서 결과가 아래와 같이 
-- 나오도록 화면에 보여주세요.
-- 예시) '홍길동 회원의 직업은 학생입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(concat(memname, ' 회원의 직업은 '),
concat(job, ' 입니다.'))
from member10;

-- [문제4] emp 테이블에서 사번, 이름, 담당업무를 화면에
-- 보여주세요.
-- 단, 담당업무는 소문자로 변경하여 화면에 보여주세요.
select empno, ename, lower(job)
from emp;

-- [문제5] 여러분의 주민등록 번호 중에서 생년월일을 추출하여
-- 화면에 보여주세요.
select substr('881201-1234567', 1, 6)
from dual;

-- [문제6] emp 테이블에서 담당업무에 'A' 라는 글자를
-- '$' 로 바꾸어 화면에 보여주세요.
select replace(job, 'A', '$') 
from emp;

-- [문제7] member10 테이블에서 직업이 '학생' 인 정보를
-- '대학생' 으로 바꾸어 화면에 보여주세요.
select replace(job, '학생', '대학생') 
from member10;


-- [문제8] member10 테이블에서 주소에 '서울시' 로 된 정보를
-- '서울특별시' 로 바꾸어 화면에 보여주세요.
select replace(addr, '서울시', '서울특별시') 
from member10;


-- 3. 숫자와 관련된 함수들.
--    1) abs(정수) : 절대값을 구해 주는 함수.
select abs(23) from dual;

select abs(-23) from dual;

--    2) sign(정수) : 양수(1), 음수(-1),0(0)을 반환해 주는 함수.
select sign(0) from dual;

select sign(13), sign(-27), sign(0) from dual;

--    3) round(실수) : 반올림을 해 주는 함수.
select round(1234.5678) from dual;  -- 1235

--       반올림을 할 때 자릿수를 지정.
--       형식) round([숫자(필수)], [반올림위치(선택)])
--            ==> 반올림 위치에 음수 값을 지정하면 정수쪽으로
--                한자리씩 위로 반올림을 해 줌.
select round(0.1234567, 6) from dual;  -- 0.123457

select round(2.3423557, 4) from dual;  -- 2.3424

select round(1265.5678, -2) from dual; -- 1300

--    4) trunc() : 소숫점 이하 지릿수를 잘라내는 함수.
--       형식) trunc([숫자(필수), [버릴위치(선택)])
select trunc(1234.1234567, 0) from dual;  -- 1234

select trunc(1234.1234567, 4) from dual;  -- 1234.1234

select trunc(1234.1234567, -3) from dual; -- 1000


--    5) ceil() : 무조건 올림을 해 주는 함수.
select ceil(22.8) from dual;   -- 23

select ceil(22.1) from dual;   -- 23

--    6) power() : 제곱을 해 주는 함수.
select power(4, 3) from dual;  -- 64

--    7) mod() : 나머지를 구해 주는 함수.
select mod(77, 4) from dual;

--    8) sqrt() : 제곱근을 구해 주는 함수.
select sqrt(3) from dual;

select sqrt(16) from dual;
