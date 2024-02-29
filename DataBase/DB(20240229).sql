-- 서브쿼리 문제
-- [문제1] emp 테이블에서 평균급여보다 더 적게 받는 사원의
-- 사번, 이름, 담당업무, 급여, 부서번호를 화면에 보여주세요.
select empno, ename, job, sal, deptno
from emp
where sal < (select avg(sal) from emp);   -- 평균 급여 : 약 2073
  
-- [문제2] emp 테이블에서 사번이 7521인 사원과 담당업무가 같고,
-- 사번이 7934인 사원의 급여보다 더 많이 받는 사원의 사번, 이름, 
-- 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job = (select job from emp where empno = 7521)   -- 담당업무 : SALESMAN
and
sal > (select sal from emp where empno = 7934);        -- 7934 사원의 급여 : 1300

-- [문제3] emp 테이블에서 담당업무가 'MANAGER' 인 사원의 최소급여보다
-- 적으면서, 담당업무가 'CLERK'은 아닌 사원의 사번, 이름, 담당업무,
-- 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal < (select min(sal) from emp where job = 'MANAGER')  -- MANAGER의 최소 급여 : 2450
and job != 'CLERK';

-- [문제4] 부서위치가 'DALLAS' 인 사원의 사번, 이름, 부서번호, 
-- 담당업무를 화면에 보여주세요.
select empno, ename, deptno, job
from emp
where deptno = (select deptno from dept where loc = 'DALLAS');  -- DALLAS 부서번호 : 20

-- [문제5] member 테이블에 있는 고객의 정보 중 마일리지가 가장 높은
-- 고객의 모든 정보를 화면에 보여주세요.
select *
from member
where mileage = (select max(mileage) from member);   -- 최대 마일리지 : 10,000

-- [문제6] emp 테이블에서 'SMITH' 인 사원보다 더 많은 급여를
-- 받는 사원의 이름과, 급여를 화면에 보여주세요.
select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');    -- SMITH 사원 급여 : 800

-- [문제7] emp 테이블에서 10번 부서 급여의 평균 급여보다 적은 급여를 받는
-- 사원들의 이름, 급여, 부서번호를 화면에 보여주세요.
select ename, sal, deptno
from emp
where sal < (select avg(sal) from emp where deptno = 10);  -- 10번 부서 평균급여 : 약 2916 

-- [문제8] emp 테이블에서 'BLAKE'와 같은 부서에 있는 사원들의
-- 이름과 입사일자, 부서번호를 화면에 보여주되, 'BLAKE' 는 제외하고
-- 화면에 보여주세요.
select ename, hiredate, deptno
from emp
where deptno = (select deptno from emp where ename = 'BLAKE')
and ename != 'BLAKE';                                      -- BLAKE 부서번호 : 30

-- [문제9] emp 테이블에서 평균급여보다 더 많이 받는 사원들의 사번,
-- 이름, 급여를 화면에 보여주되, 급여가 높은데서 낮은 순으로 화면에 
-- 보여주세요.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
order by sal desc;                                        -- EMP 테이블 평균 급여 : 약 2073

-- [문제10] emp 테이블에서 이름에 'T'를 포함하고 있는 사원들과 같은 부서에
-- 근무하고 있는 사원의 사번과 이름, 부서번호를 화면에 보여주세요.
select empno, ename, deptno
from emp
where deptno in(select distinct deptno from emp where ename like '%T%');

-- [문제11] 'SALES' 부서에서 근무하고 있는 사원들의 부서번호,
-- 이름, 담당업무를 화면에 보여주세요.
select deptno, ename, job
from emp
where deptno = (select deptno from dept where dname = 'SALES');  -- SALES 부서명에 해당하는부서번호 : 30

-- [문제12] emp 테이블에서 'KING'에게 보고하는 모든 사원의
-- 이름과 급여, 관리자를 화면에 보여주세요.
select ename, sal, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

-- [문제13] emp 테이블에서 자신의 급여가 평균급여보다 많고, 이름에
-- 'S' 자가 들어가는 사원과 동일한 부서에서 근무하는 모든 사원의 
-- 사번, 이름, 급여, 부서번호를 화면에 보여주세요.
select empno, ename, sal, deptno
from emp
where sal > (select avg(sal) from emp)  -- 평균급여 : 약 2073
and
deptno in(select distinct deptno from emp where ename like '%S%');

-- [문제14] emp 테이블에서 보너스를 받는 사원과 부서번호, 급여가 같은
-- 사원의 이름, 급여, 부서번호를 화면에 보여주세요.
select ename, sal, deptno
from emp
where deptno in(select deptno from emp where comm > 0)  -- 30번 부서
and
sal in(select sal from emp where comm > 0);

-- [문제15] products 테이블에서 상품의 판매가격이 판매가격의
-- 평균보다 큰 상품의 전체 내용을 화면에 보여주세요.
select *
from products
where output_price > (select avg(output_price) from products);  -- 판매가격 평군 : 1,253,800원

-- [문제16] products 테이블에 있는 판매 가격에서 평균 가격 이상의
-- 상품 목록을 구하되, 평균을 구할 때 가격이 가장 큰 금액인 상품을
-- 제외하고 평균을 구하여 화면에 보여주세요.
select *
from products
where output_price >=
(select avg(output_price) from products
where output_price <>
(select max(output_price) from products));  -- 판매 최대 가격 : 8,000,000원

-- [문제17] products 테이블에서 상품명의 이름에 '에어컨' 이라는
-- 단어가 포함된 카테고리에 속하는 상품목록을 화면에 보여주세요.
select *
from products
where category_fk in
(select distinct category_fk from products where products_name like '%에어컨%');

-- [문제18] member 테이블에 있는 고객 정보 중 마일리지가 가장 높은 
-- 금액을 가지는 고객에게 보너스 마일리지 5000점을 더 주어 고객명,
-- 마일리지, 마일리지+5000 점을 화면에 보여주세요.
select memname, mileage, mileage + 5000 "추가된 마일리지"
from member
where mileage = (select max(mileage) from member);  -- 최대 마일리지 : 10,000


/*
  group by 절
  - 특정 컬럼이나 값을 기준으로 해당 레코드를 묶어서 자료를 관리할 때 사용함.
  - 보통은 특정 컬럼을 기준으로 집계를 구하는데 많이 사용이 됨.
  - 또한 그룹함수와 함께 사용하면 효과적으로 활용이 가능함.
*/

select distinct deptno
from emp
order by deptno;


select deptno
from emp
group by deptno;

-- emp 테이블에서 부서별로 해당 부서의
-- 인원을 확인하고 싶은 경우
select deptno, count(*)
from emp
group by deptno;

-- emp 테이블에서 각 부서별로 부서 직원의
-- 급여 합계액을 구하여 화면에 보여주세요.
select deptno, sum(sal)
from emp
group by deptno
order by sum(sal) desc;

-- [문제] emp 테이블에서 부서별로 그룹을 지어서 부서의 급여 합계와
-- 부서별 인원 수, 부서별 평균 급여, 부서별 최대 급여, 부서별 최소 급여를
-- 구하여 화면에 보여주세요.
-- 단, 급여 합계를 기준으로 내림차순으로 정렬하여 화면에 보여주세요.
select deptno, sum(sal), count(*), avg(sal), max(sal), min(sal)
from emp
group by deptno
order by sum(sal) desc;


/*
  having 절
  - group by 절 다음에 오는 조건절.
  - group by 절의 결과에 조건을 주어서 제한할 때 사용함.
  - group by 절 다음에는 where(조건절)이 올 수 없음.
*/

-- products 테이블에서 카테고리 별로
-- 상품의 갯수를 화면에 보여주세요.
select category_fk, count(*)
from products
group by category_fk
having count(*) >= 2;


/*
  ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
  View
  - 물리적인 테이블에 근거한 논리적인 가상의 테이블을 말함.
  - View 는 실질적으로 데이터를 저장하고 있지 않음.
  - View를 만들면 데이터베이스에 질의 시 실제 테이블에 접근하여
    데이터를 불러오게 됨.
  - 간단하게 필요한 내용들만 추출해서 사용할 때 많이 사용을 함.
  - View 는 테이블과 유사하며, 테이블처럼 사용이 가능함.
  - View 는 테이블에 저장하기 위한 물리적인 공간이 필요가 없음.
  - 테이블과 마찬가지로 insert, update, delete 명령이 가능함.
  - 하지만 주로 데이터를 조회(select) 할 때 가장 많이 사용이 됨.
  - View 를 사용하는 이유
    1) 보안 관리를 위해 사용함(중요).
       ==> 보안 등급에 맞추어 컬럼의 범위를 정해서 조회가 
           가능하도록 할 수 있음.
    2) 사용자의 편의성을 제공함.

    형식)
            create view 뷰이름
            as
            쿼리문;
*/


-- 보안 관리를 위해서 사용함(중요)
-- 인사부 View
-- 컬럼에 sal(급여), comm(보너스) 컬럼은 제외
create view emp_insa
as
select empno, ename, job, mgr, hiredate, deptno
from emp;

select * from emp_insa;

-- 영업부 View
-- 컬럼에 sal(급여) 컬럼은 제외
create view emp_sales
as
select empno, ename, job, mgr, hiredate, comm, deptno
from emp;

select * from emp_sales;

-- 회계부 View
-- 모든 컬럼이 적용.
create view emp_account
as
select * from emp;

select * from emp_account;

insert into emp_account
    values(9000, 'ANGEL', 'SALESMAN', 7698, sysdate, 1300, 100, 30);

-- View 를 읽기 전용으로 만들면 데이터가 추가가 안 됨.
-- 읽기 전용으로 만드는 방법.
-- ==> View 를 만들 때 쿼리문 맨 마지막에 with read only 문구 추가.

create view emp_view1
as
select * from emp
with read only;

insert into emp_view1
    values(9001, '임정훈', 'SALESMAN', 7698, sysdate, 1500, 200, 30);

-- create or replace view
-- 같은 이름의 view가 있는 경우에는 기존의 View는 삭제하고
-- 새로운 View를 만들라는 의미.
create or replace view emp_insa
as
select empno, ename, job, mgr, hiredate, deptno
from emp
with read only;

create or replace view emp_sales
as
select empno, ename, job, mgr, hiredate, comm, deptno
from emp
with read only;

create or replace view emp_account
as
select *
from emp
with read only;

-- 2) 사용자의 편의성을 제공함.
create or replace view emp_salary
as
select empno, ename, (sal * 12 + nvl2(comm, comm, 0)) "연봉"
from emp
with read only;

select * from emp_salary;



-- [문제1] 부서별로 부서별 급여 합계, 부서별 급여 평균을 
-- 구한 view를 만들어 화면에 보여주세요.
-- 주의사항) view를 만들 때 그룹함수 사용시에는 반드시
--          별칭을 설정해 주어야 함.
create or replace view emp_sal
as
select deptno, sum(sal) "급여합계", avg(sal) "급여평균"
from emp
group by deptno
with read only;

select * from emp_sal;


-- [문제2] emp 테이블을 이용하여 emp_dept20 이라는 
-- view를 만들어 주세요. 단, 부서번호가 20번 부서에 속한
-- 사원들의 사번, 이름, 담당업무, 관리자, 부서번호만 
-- 화면에 보여주시기 바랍니다.
create or replace view emp_dept20
as
select empno, ename, job, mgr, deptno
from emp
where deptno = 20
with read only;

select * from emp_dept20;


-- [문제3] emp 테이블에서 각 부서별 최대급여와 최소급여를
-- 보여주는 view를 만들되, sal_view라는 이름으로 만들어
-- 화면에 보여주세요.
create or replace view sal_view
as
select deptno, max(sal) "최대급여", min(sal) "최소급여"
from emp
group by deptno
with read only;

select * from sal_view;


-- [문제4] 담당업무가 'SALESMAN' 인 사원의 사번, 이름,
-- 담당업무, 입사일, 부서번호를 컬럼으로 하는 view를 
-- 만들되, emp_sale 이라는 view를 만들어 화면에 보여주세요.
create or replace view emp_sale
as
select empno, ename, job, hiredate, deptno
from emp
where job = 'SALESMAN'
with read only;

select * from emp_sale;

-- View 를 만들 때 컬럼만 만들고 싶은 경우
-- 조건을 줄 때 말도 안 되는 조건을 주면 됨.
create or replace view emp_view2
as
select * from emp
where deptno = 1
with read only;

select * from emp_view2;


/*
  트랜잭션(Transaction)?
  - 데이터 처리의 한 단위를 말함.
  - 오라클에서 발생하는 여러 개의 SQL 명령문들을
    하나의 논리적인 작업 단위로 처리하는 것을 말함.
  - All or Nothing 방식으로 처리함.
  - 명령이 여러 개의 집합이 정상적으로 처리가 되면 종료하고,
    여러 개의 명령어 중에서 하나의 명령이라도 잘못이 되면
    전체를 취소하는 것을 말함. (중요)
    
  - 트랜잭션 사용 이유 : 데이터의 일관성을 유지하면서
                       데이터의 안정성을 보장하기 위해 사용함.
  - 트랜잭션 사용 시 트랜잭션을 제어하기 위한 명령어.
    1) commit : 모든 작업을 정상적으로 처리하곘다고 확정하는 명령어.
                트랜잭션(insert, update, delete) 작업의 내용을
                실제 DB에 반영.
                이전에 있던 데이터에 update 현상이 발생을 함.
                모든 사용자가 변경된 데이터의 결과를 볼 수 있음.
    2) rollback : 작업 중에 문제가 발생했을 때 트랜잭션 처리 과정에서
                  변경 사항을 취소하여 이전 상태로 되돌리는 명령어.
                  트랜잭션(insert, update, delete) 작업의 내용을 취소함.
                  이전에 commit 한 곳까지만 복구가 됨. 
*/

create table dept
as
select * from dept_02;

-- 1. dept 테이블을 복사하여 dept_02 라는 테이블을 만들어 보자.
create table dept_02
as
select * from dept;

select * from dept_02;

-- 2. dept_02 테이블에서 40번 부서를 삭제한 후에 commit을 해 보자.
delete from dept_02 where deptno = 40;
commit;

-- 3. dept_02 테이블의 전체 데이터를 삭제해 보자.
delete from dept_02;

-- 4. 이 때 만약 20번 부서에 대해서만 삭제를 하려고 했는데
-- 잘못해서 전체가 삭제가 된 경우, 다시 복원을 할 수 있다.
rollback;

-- 5. 20번 부서를 삭제하면 된다.
delete from dept_02 where deptno = 20;

-- 6. 데이터베이스에 완벽하게 저장을 하자.
commit;


/*
  savepoint
  - 트랜잭션을 작게 분할하는 것을 말함.
  - 사용자가 트랜잭션 중간 단계에서 포인트를 지정하여
    트랜잭션 내의 특정 savepoint까지 rollback 할 수
    있게 하는 것을 말함.
*/

-- 1. dept 테이블을 복사하여 dept_03 이라는 테이블을 만들자.
create table dept_03
as
select * from dept;

-- 2. dept_03 테이블에서 40번 부서를 삭제한 후 commit을 해 보자.
delete from dept_03 where deptno = 40;
commit;

-- 3. dept_03 테이블에서 30번 부서를 삭제해 보자.
delete from dept_03 where deptno = 30;

-- 4. 이 때 savepoint sp1 을 설정해 보자.
savepoint sp1;

-- 5. dept_03 테이블에서 20번 부서를 삭제해 보자.
delete from dept_03 where deptno = 20;

-- 6. 이 때 savepoint sp2 을 설정해 보자.
savepoint sp2;

-- 7. dept_03 테이블에서 10번 부서를 삭제해 보자.
delete from dept_03 where deptno = 10;

-- 8. 부서번호가 20번인 부서를 삭제하기 바로 전으로 
-- 되돌아가고 싶은 경우.
rollback to sp1;

select * from dept_03;





