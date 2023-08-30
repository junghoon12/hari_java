/*
  시퀀스(sequence)
  ==> 순서를 부여할 때 사용하는 문법.
      연속적인 번호를 만들어 주는 기능을 함.
      
  형식)
        create sequence 시퀀스이름
        start with n(시작번호 설정 - 기본적으로 기본값은 1)
        increment by n(증가되는 번호 설정 - 기본적으로 기본값은 1)
        maxvalue n(시퀀스 최대 번호 설정)
        minvalue n(시퀀스 최소 번호 설정)
        cache / nocache(캐쉬 메모리 사용 여부)
        
        1) cache : 시퀀스를 빠르게 제공하기 위하여 미리 캐쉬 메모리에
                   시퀀스를 넣어 두고 준비하고 있다가 시퀀스 작업이
                   필요할 때 사용을 함.
                   drfault 로는 20개씩 시퀀스를 캐쉬 메모리에 보관을 함.
        2) nocache : cache 기능을 사용하지 않겠다는 의미.
*/

-- memo 라는 테이블을 만들어 보자.
create table memo(
    bunho number(5),
    title varchar2(100) not null,
    writer varchar2(50) not null,
    content varchar2(1000) not null,
    regdate date,
    primary key(bunho)  -- 테이블 상에서 제약 조건 설정
);

-- memo 테이블 사용 시 사용할 시퀀스를 만들어 보자.
create sequence memo_seq
start with 1
increment by 1;



-- memo 테이블에 데이터를 저장해 보자.
insert into memo 
    values(memo_seq.nextval, '메모1', '홍길동', '길동이 메모', sysdate);

insert into memo 
    values(memo_seq.nextval, '두번째 메모', '세종대왕', '대왕 메모', sysdate);
    

/*
  join ~ on 키워드
  - 테이블과 테이블을 연결하여 특정한 데이터를 얻고자 할 때 사용함.
  - 두 개 이상의 테이블에 정보가 나뉘어져 있을 때 사용함.
  - 중복해서 데이터가 저장되는 것을 막기 위함.
  - 두 개의 테이블로 나뉘어진 경우에는 데이터의 중복은 발생하지 않지만
    원하는 정보를 얻으려면 여러 번 질의를 해야 하는 불편함이 발생함.
  - 특정 사원이 소속된 부서의 부서명을 알고 싶은 경우에는 emp 테이블과
    dept 테이블을 넘나드는 작업이 생기므로 매우 불편함. 그래서 두 개의
    테이블을 결합해서 원하는 결과를 얻어낼 수 있도록 하는 조인이라는
    기능이 생겨나게 됨.
    
    조인의 종류
    1) Cross Join
    2) Equi Join  -- 가장 많이 사용되는 Join
    3) Self Join
    4) Outer Join
*/

/*
  1) Cross Join
     - 두 개 이상의 테이블이 조인될 때 조건이 없이 테이블의
       결합이 이루어지는 조인.
     - 테이블 상호간에 연결될 수 있는 모든 경우의 수를 산출하여
       나타나는 조인임.
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
-- ==> emp 테이블과 dept 테이블을 조인해야만 원하는 정보를 얻을 수 있음.

select empno, ename, job, e.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno;

-- emp 테이블에서 사원명이 'SCOTT' 인 사원의 부서명을 알고 싶다면??
select ename, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where ename = 'SCOTT';

-- [문제1] 부서명이 'RESEARCH' 인 사원의 사번, 이름,
--        급여, 부서명, 근무위치를 화면에 보여주세요.
select empno, ename, sal, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where dname = 'RESEARCH';

-- [문제2] emp 테이블에서 'NEW YORK'에 근무하는 사원의
--        이름과 급여, 부서번호를 화면에 보여주세요.
select ename, sal, e.deptno
from emp e join dept d
on e.deptno = d.deptno
where loc = 'NEW YORK';

-- [문제3] emp 테이블에서 'ACCOUNTING' 부서 소속 사원의
--        이름과 담당업무, 입사일 그리고 부서번호, 부서명을
--        화면에 보여주세요.
select ename, job, hiredate, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where dname = 'ACCOUNTING';

-- [문제4] emp 테이블에서 담당업무가 'SALESMAN' 인 사원의
--        이름과 담당업무, 부서번호, 부서명, 근무위치를 
--        화면에 보여주세요.
select ename, job, e.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where job = 'SALESMAN';


/*
  3) Self Join
     - 두 개의 테이블 내에서 조인을 해야 자료를 얻을 수 있는데 말 그대로
       자기 자신 테이블과 조인을 맺는 것을 말함.
     - from 절 다음에 테이블 이름을 나란히 두 번 기술할 수 없음.
       따라서 같은 테이블이 하나 더 존재하는 것처럼 사용할 수 있도록
       테이블에 별칭을 붙여서 사용해야 함.
*/

-- emp 테이블에서 각 사원별 관리자의 이름을 화면에 출력해 보자.
-- 예) CEARK 의 관리자 이름은 KING 입니다.
select e1.ename || ' 의 관리자 이름은 ' || e2.ename || ' 입니다.'
from emp e1 join emp e2
on e1.mgr = e2.empno;

/*
  4) Outer Join
     - 2개 이상의 테이블이 조인이 될 때에는 어느 한 쪽 테이블에는
       해당되는 데이터가 다른쪽 테이블에는 데이터가 존재하지 않는
       경우 그 데이터가 출력이 되지 않는 문제점을 해결하기 위해
       사용되는 조인 기법.
     - 정보가 부족한 테이블의 컬럼 뒤에 '(+)' 기호를 붙여 사용을 함.
*/

select ename, d.deptno, dname
from emp e join dept d
on e.deptno(+) = d.deptno;

select e1.ename, e1.job, e1.mgr
from emp e1 join emp e2
on e1.mgr = e2.empno(+);



/*
  ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  서브 쿼리
  - 하나의 쿼리문 안에 포함되어 있는 또 하나의 쿼리문을 말함.
  - 쿼리문 안에 또 다른 쿼리문이 존재하는 것을 말함.
  - 서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계임.
  - 여러 번 쿼리를 실행해서 얻을 수 있는 결과를 하나의 중첩된
    쿼리 문장으로 결과를 얻을 수 있게 해 줌.
    
  ※ 주의사항
     - 서브쿼리는 괄호로 묶어서 사용하는 것이 관례임.
     - 서브쿼리 안에는 order by 절은 사용할 수 없음.

  - 사용 방법 : 우선은 안 쪽에 있는 쿼리문을 실행 후, 그 결과값을
               가지고 바깥쪽 쿼리문을 실행함.
*/

-- emp 테이블에서 이름이 'SCOTT' 인 사원의 급여보다 더 많은
-- 급여를 받는 사원의 사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal > (select sal from emp where ename = 'SCOTT');


-- [문제1] emp 테이블에서 평균급여보다 더 적게 받는 사원의
-- 사번, 이름, 담당업무, 급여, 부서번호를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal < (select avg(sal) from emp);  -- 평균 급여 : 2073


-- [문제2] emp 테이블에서 사번이 7521인 사원과 담당업무가 같고,
-- 사번이 7934인 사원의 급여보다 더 많이 받는 사원의 사번, 이름, 
-- 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job = (select job from emp where empno = 7521)  -- 담당업무 : SALESMAN
and
sal > (select sal from emp where empno = 7934);  -- 7934사원 급여 : 1300


-- [문제3] emp 테이블에서 담당업무가 'MANAGER' 인 사원의 최소급여보다
-- 적으면서, 담당업무가 'CLERK'은 아닌 사원의 사번, 이름, 담당업무,
-- 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal < (select min(sal) from emp where job = 'MANAGER')  -- 최소급여 : 2450
and
job != 'CLERK';


-- [문제4] 부서위치가 'DALLAS' 인 사원의 사번, 이름, 부서번호, 
-- 담당업무를 화면에 보여주세요.
select empno, ename, deptno, job
from emp
where deptno = (select deptno from dept where loc = 'DALLAS');  -- 20번 부서


-- [문제5] member10 테이블에 있는 고객의 정보 중 마일리지가 가장 높은
-- 고객의 모든 정보를 화면에 보여주세요.
select *
from member10
where mileage = (select max(mileage) from member10);  -- 마일리지 최대값 : 10000 마일리지


-- [문제6] emp 테이블에서 'SMITH' 인 사원보다 더 많은 급여를
-- 받는 사원의 이름과, 급여를 화면에 보여주세요.
select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');  -- SMITH 사원 급여 : 800


-- [문제7] emp 테이블에서 10번 부서 급여의 평균 급여보다 적은 급여를 받는
-- 사원들의 이름, 급여, 부서번호를 화면에 보여주세요.
select ename, sal, deptno
from emp
where sal < (select avg(sal) from emp where deptno = 10);  -- 10번 부서 평균 급여 : 약 2916


-- [문제8] emp 테이블에서 'BLAKE'와 같은 부서에 있는 사원들의
-- 이름과 입사일자, 부서번호를 화면에 보여주되, 'BLAKE' 는 제외하고
-- 화면에 보여주세요.
select ename, hiredate, deptno
from emp
where deptno = (select deptno from emp where ename = 'BLAKE') -- BLAKE 부서 : 30
and ename <> 'BLAKE';

-- [문제9] emp 테이블에서 평균급여보다 더 많이 받는 사원들의 사번,
-- 이름, 급여를 화면에 보여주되, 급여가 높은데서 낮은 순으로 화면에 
-- 보여주세요.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)  -- 평균 급여 : 2073
order by sal desc;

-- [문제10] emp 테이블에서 이름에 'T'를 포함하고 있는 사원들과 같은 부서에
-- 근무하고 있는 사원의 사번과 이름, 부서번호를 화면에 보여주세요.
select empno, ename, deptno
from emp
where deptno in (select distinct deptno from emp where ename like '%T%');

-- [문제11] 'SALES' 부서에서 근무하고 있는 사원들의 부서번호,
-- 이름, 담당업무를 화면에 보여주세요.
select deptno, ename, job
from emp
where deptno = (select deptno from dept where dname = 'SALES');  -- 30번 부서


-- [문제12] emp 테이블에서 'KING'에게 보고하는 모든 사원의
-- 이름과 급여, 관리자를 화면에 보여주세요.
select ename, sal, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');  -- KING 사원 사번 : 7839


-- [문제13] emp 테이블에서 자신의 급여가 평균급여보다 많고, 이름에
-- 'S' 자가 들어가는 사원과 동일한 부서에서 근무하는 모든 사원의 
-- 사번, 이름, 급여, 부서번호를 화면에 보여주세요.
select empno, ename, sal, deptno
from emp
where sal > (select avg(sal) from emp)  -- 평균급여 : 2073
and
deptno in (select distinct deptno from emp where ename like '%S%');


-- [문제14] products 테이블에서 상품의 판매가격이 판매가격의
-- 평균보다 큰 상품의 전체 내용을 화면에 보여주세요.
select *
from products
where output_price > (select avg(output_price) from products);  -- 판매가격 평균 : 1,143,800원


-- [문제15] products 테이블에 있는 판매 가격에서 평균 가격 이상의
-- 상품 목록을 구하되, 평균을 구할 때 가격이 가장 큰 금액인 상품을
-- 제외하고 평균을 구하여 화면에 보여주세요.
select *
from products
where output_price > 
(select avg(output_price) from products
   where output_price <>
(select max(output_price) from products));


-- [문제16] products 테이블에서 상품명의 이름에 '에어컨' 이라는
-- 단어가 포함된 카테고리에 속하는 상품목록을 화면에 보여주세요.
select *
from products
where category_fk = 
(select distinct category_fk from products 
where products_name like '%에어컨%'); 


-- [문제17] member10 테이블에 있는 고객 정보 중 마일리지가 가장 높은 
-- 금액을 가지는 고객에게 보너스 마일리지 5000점을 더 주어 고객명,
-- 마일리지, 마일리지+5000 점을 화면에 보여주세요.
select memname, mileage, mileage + 5000 "추가된 마일리지"
from member10
where mileage = (select max(mileage) from member10);  -- 최대 마일리지 : 10,000




