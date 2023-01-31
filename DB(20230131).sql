/*
   시퀀스(sequence)
   ==> 순서를 부여할 때 사용하는 문법.
       연속적인 번호를 만들어 주는 기능을 함.
   
   형식)
        create sequence 시퀀스이름
        start with n (시작번호 설정 - 기본적으로 기본값은 1)
        increment by n (증가번호 설정 - 기본적으로 기본값은 1)
        maxvalue n (시퀀스 최대 번호 설정)
        minvalue n (시퀀스 최소 번호 설정)
        cache / nocache (캐쉬 메모리 사용 여부)
        
        1) cache : 시퀀스를 빠르게 제공하기 위해 미리 캐쉬 메모리에
                   시퀀스를 넣어 두고 준비하고 있다가 시퀀스 작업이
                   필요할 때 사용을 함.
                   default로는 20개의 시퀀스를 캐쉬 메모리에 보관을
                   하게 됨.
        2) nocache : cache 기능을 사용하지 않곘다는 의미.
*/

-- memo 라는 테이블을 만들어 보자.
create table memo(
    bunho number(5),
    title varchar2(100) not null,
    writer varchar2(50) not null,
    cont varchar2(1000) not null,
    regdate date,
    primary key(bunho)  -- 테이블 레벨 상으로 제약조건 설정
);

-- memo 테이블 이용 시 사용할 시퀀스를 만들어 보자.
create sequence memo_seq
start with 1
increment by 1
nocache;

-- memo 테이블에 데이터를 저장해 보자.
insert into memo
    values(memo_seq.nextval, '메모1', '홍길동', 
                '길동이 메모', sysdate);
insert into memo
    values(memo_seq.nextval, '두번째 메모', '이순신', 
                '장군님 메모', sysdate);
insert into memo
    values(memo_seq.nextval, '메모3', '유관순', 
                '유관순 열사 메모', sysdate);

commit;


/*
   제약 조건
   - 테이블에 부적합한 자료가 입력되는 것을 방지하기 위해서
     테이블을 생성할 때 각 컬럼에 대해서 정의하는 여러 가지
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
      - 특정 열에 데이터의 중복 여부와는 상관없이 null 값을
        허용하지 않는 제약 조건.
*/

create table null_test(
    col1 varchar2(10) not null,
    col2 varchar2(10) not null,
    col3 varchar2(10)
);

insert into null_test values('aa', 'aa1', 'aa2');

insert into null_test(col1, col2) values('bb', 'bb1');
            
insert into null_test(col1, col2) values('bb', ''); -- error 발생

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
   3) primary key : not null + unique 제약 조건
      - 테이블에 하나만 존재해야 함.
      - 보통은 주민번호나 emp 테이블의 empno(사원번호) 등이
        primary key의 대표적인 예.
*/

/*
   4) foreign key 제약 조건
      - 다른 테이블의 필드(컬럼)를 참조해서 무결성을 검사하는
        제약 조건.
      - 참조 키 : 부모 테이블의 컬럼을 이야기 함.
      - 외래 키 : 자식 테이블의 컬럼을 이야기 함.
      - 자식 테이블의 컬럼의 값(데이터)이 부모 테이블에 없는 경우
        무결성의 규칙이 깨져 버림.
      - 외래 키가 존재하기 위해서는 우선적으로 부모 테이블이
        먼저 만들어져야 함.
      - 옵션
        * on delete cascade
          ==> 부모 테이블의 데이터 삭제 시 해당 데이터를 참조하고
              있는 자식 테이블의 데이터까지 모두 삭제하는 옵션
        * on delete set null
          ==> 부모 테이블의 데이터 삭제 시 해당 데이터를 참조하고
              있는 자식 테이블의 컬럼 값을 null로 변경하는 옵션.
*/

create table foreign_test(
    bunho number(5) primary key,
    irum varchar2(30) not null,
    job varchar2(100) not null,
    -- dept number(2) references dept(deptno)  -- 컬럼상 외래키 제약조건
    dept number(2),
    constraint dept_fk foreign key(dept)
        references dept(deptno)  -- 테이블상 외래키 제약조건
);

insert into foreign_test values(1111, '홍길동', '영업사원', 30);

insert into foreign_test values(1112, '유관순', '관리사원', 10);

insert into foreign_test values(1113, '김유신', 'IT사원', 50);  -- error 발생

/*
   5) check 제약 조건
      - 열에 저장할 수 있는 값의 범위 또는 패턴을 정의할 때
        사용되는 제약 조건.
*/

create table check_test(
    gender varchar2(6),
    constraint gender_chk
            check(gender in('남자', '여자'))
);

insert into check_test values('여자');

insert into check_test values('남자');

insert into check_test values('여성');  -- error 발생


/*
   join ~ on 키워드
   - 테이블과 테이블을 연결하여 특정한 데이터를 얻고자 할 때 사용함.
   - 두 개 이상의 테이블에 정보가 나뉘어져 있을 때 사용함.
   - 중복해서 데이터가 저장되는 것을 막기 위함.
   - 두 개의 테이블로 나뉘어진 경우에는 데이터의 중복은 발생하지 않지만
     원하는 정보를 얻으려면 여러 번 질의를 해야 하는 불편함이 발생됨.
   - 특정 사원이 소속된 부서의 부서명을 알고 싶은 경우에는 emp 테이블과
     dept 테이블을 넘나드는 작업이 생기므로 상당히 불편함. 그래서 두 개의
     테이블을 결합해서 원하는 결과를 얻어낼 수 있도록 하는 조인이라는
     기능이 생겨나게 되었음.
     
     조인의 종류
     1) Cross Join
     2) Equi Join  -- 가장 많이 사용되는 join
     3) Self Join
     4) Outer Join
*/

/*
   1) Cross Join
      - 두 개 이상의 테이블이 조인될 때 조건이 없이 테이블의 결합이
        이루어지는 조인.
      - 테이블 상호간에 연결될 수 있는 모든 경우의 수를 산출하여
        나타내는 조인임.
        그렇기 때문에 테이블 전체 행의 컬럼이 조인이 됨.
      - 현재는 사용을 안 하는 조인임.
*/

select *
from emp, dept;


/*
   2) Equi Join
      - 가장 많이 사용되는 조인 방법.
      - 조인의 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의
        값이 일치되는 행을 연결하여 결과를 생성하는 방법.
      - 두 테이블이 조인을 하려면 일치되는 공통 컬럼을 사용해야 함.
*/

-- emp 테이블에서 사원의 사번, 이름, 담당업무, 부서번호 및
-- 부서명, 근무위치를 화면에 보여주세요.
-- ==> emp 테이블과 dept 테이블을 조인시켜 주어야 함.
select empno, ename, job, d.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno;


-- emp 테이블에서 사원명이 'SCOTT' 인 사원의 부서명을 알고 싶다면?
select ename, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where ename = 'SCOTT';

-- [문제1] 부서명이 'RESEARCH' 인 사원의
-- 사번, 이름, 급여, 부서명, 근무위치를 화면에 보여주세요.
select empno, ename, sal, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where dname = 'RESEARCH';

-- [문제2] emp 테이블에서 'NEW YORK' 에 근무하는 사원의
-- 이름과 급여, 부서번호를 화면에 보여주세요.
select ename, sal, d.deptno
from emp e join dept d
on e.deptno = d.deptno
where loc = 'NEW YORK';

-- [문제3] emp 테이블에서 'ACCOUNTING' 부서 소속 사원의
-- 이름과 담당업무, 입사일 그리고 부서번호, 부서명을
-- 화면에 보여주세요.
select ename, job, hiredate, e.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where dname = 'ACCOUNTING';

-- [문제4] emp 테이블에서 담당업무가 'SALESMAN' 인 사원의
-- 이름과, 담당업무, 부서번호, 부서명, 근무위치를 화면에
-- 보여주세요.
select ename, job, d.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where job = 'SALESMAN';


/*
   3) Self Join
      - 하나의 테이블 내에서 조인을 해야 자료를 얻을 수 있는데 말 그대로
        자기 자신 테이블과 조인을 맺는 것을 말함.
      - from 절 다음에 테이블 이름을 나란히 두 번 기술을 할 수 없음.
        따라서 같은 테이블이 하나 더 존재하는 것처럼 사용할 수 있도록
        테이블에 별칭을 붙여서 사용해야 함.
*/

-- emp 테이블에서 각 사원별 관리자의 이름을 화면에 출력해 보자.
-- 예) CLERK 의 관리자 이름은 KING 입니다.
select e1.ename || '의 관리자 이름은 ' || e2.ename || ' 입니다.'
from emp e1 join emp e2
on e1.mgr = e2.empno;

-- emp 테이블에서 매니저가 'KING' 인 사원들의
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
        위해 사용되는 조인 기법.
      - 정보가 부족한 테이블의 컬럼 뒤에 '(+)' 기호를 붙여 사용을 함.
*/

select ename, d.deptno, dname
from emp e join dept d
on e.deptno(+) = d.deptno;

select e1.ename, e1.job, e1.mgr
from emp e1 join emp e2
on e1.mgr = e2.empno(+);

