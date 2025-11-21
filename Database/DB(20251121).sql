/*
   group by 절
   - 특정 컬럼이나 값을 기준으로 해당 레코드를 묶어서
     자료를 관리할 때 사용함.
   - 보통은 특정한 컬럼을 기준으로 집계를 구하는데 많이 사용이 됨.
   - 또한 그룹 함수와 함께 사용하면 효과적으로 활용이 가능함.
*/

select distinct deptno
from emp;

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
group by deptno;


-- [문제] emp 테이블에서 부서별로 그룹을 지어서 부서의 급여 합계와
--       부서별 인원 수, 부서별 평균 급여, 부서별 최대 급여, 
--       부서별 최소 급여를 구하여 화면에 보여주세요.
--       단, 급여 합계를 기준으로 내림차순으로 정렬하여 보여주세요.
select deptno, sum(sal), count(deptno), avg(sal), max(sal), min(sal)
from emp
group by deptno
order by sum(sal) desc;

/*
   having 절
   - group by 절 다음에 나오는 조건절.
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
    View
    - 물리적인 테이블에 근거한 논리적인 가상의 테이블을 말함.
    - View는 실질적으로 데이터를 저장하고 있지 않음.
    - View를 만들면 데이터베이스에 질의 시 실제 테이블에 접근하여
      데이터를 불러오게 됨.
    - 간단하게 필요한 내용들만 추출해서 사용할 때 많이 사용을 함.
    - View는 테이블과 유사하며, 테이블처럼 사용이 가능함.
    - View는 테이블에 저장하기 위한 물리적인 공간이 필요가 없음.
    - 테이블과 마찬가지로 insert, update, delete 명령이 가능함.
    - 하지만 주로 데이터를 조회(select) 할 때 가장 많이 사용을 함.
    - View를 사용하는 이유
      1) 보안 관리를 위해 사용함(중요)
         ==> 보안 등급에 맞추어 컬럼의 범위를 정해서 조회가
             가능하도록 할 수 있음.
      2) 사용자의 편의성을 제공함.
      
      형식)
            create view 뷰이름
            as
            쿼리문;
*/


-- 1) 보안 관리를 위해서 View를 사용함(중요)
-- 인사부 View
-- 컬럼에 sal(급여), comm(보너스) 컬럼은 제외
create view emp_insa
as
select empno, ename, job, mgr, hiredate, deptno
from emp;


-- 영업부 View
-- 컬럼에 sal(급여) 컬럼은 제외
create view emp_sales
as
select empno, ename, job, mgr, hiredate, comm, deptno
from emp;


-- 회계부 View
-- 모든 컬럼이 적용.
create view emp_account
as
select *
from emp;


-- View에 데이터를 추가해 보자.
insert into emp_insa
    values(9000, 'ANGEL', 'SALESMAN', 7698, sysdate, 30);

-- View를 만들 때 읽기 전용으로 만들면 문제가 해결이 됨.
-- 읽기 전용으로 만드는 방법
-- View를 만들 때 쿼리문 맨 마지막에 with read only 문구 추가.
create view emp_insa1
as
select empno, ename, job, mgr, hiredate, deptno
from emp
with read only;


-- View에 데이터를 추가해 보자.
insert into emp_insa1
    values(9001, 'TIGER', 'SALESMAN', 7698, sysdate, 30);

-- View를 사용하다가 삭제하는 방법
-- 형식) drop view 뷰이름;
drop view emp_insa1;
drop view emp_insa;
drop view emp_sales;
drop view emp_account;

-- create or replace view 뷰이름
-- 같은 이름의 View가 있는 경우에는 기존의 View는 삭제하고
-- 새로운 View를 만들라는 의미.
create or replace view emp_insa
as
select empno, ename, job, mgr, hiredate, deptno
from emp
with read only;

create or replace view emp_insa
as
select empno, ename, job, hiredate, deptno
from emp
with read only;


-- 2) 사용자의 편의성을 제공함.
create or replace view view_salary
as
select empno, ename, (sal * 12 + nvl2(comm, comm, 0)) "연봉"
from emp
with read only;



-- [문제1] 부서별로 부서별 급여합계, 부서별 급여 평균을 구한
--        View를 만들어 화면에 보여주세요.
create or replace view dept_sal
as
select deptno, sum(sal) "급여합계", avg(sal) "급여평균"
from emp
group by deptno
with read only;


-- [문제2] emp 테이블을 이용하여 emp_dept20 이라는 View를
--        만들어 주세요. 단, 부서번호가 20번 부서에 속한
--        사원들의 사번, 이름, 담당업무, 관리자, 부서번호만
--        화면에 보여주세요.
create or replace view emp_dept20
as
select empno, ename, job, mgr, deptno
from emp
where deptno = 20
with read only;

-- [문제3] emp 테이블에서 각 부서별 최대급여와 최소급여를
--        보여 주는 View를 만들되, sal_view 라는 이름으로
--        만들어 화면에 보여주세요.
create or replace view sal_view
as
select deptno, max(sal) "최대급여", min(sal) "최소급여"
from emp
group by deptno
with read only;


-- [문제4] 담당업무가 'SALESMAN'인 사원의 사번, 이름, 담당업무,
--        입사일, 부서번호를 컬럼으로 하는 View를 만들되, 
--        view_sale 이라는 View를 만들어 화면에 보여주세요.
create or replace view view_sale
as
select empno, ename, job, hiredate, deptno
from emp
where job = 'SALESMAN'
with read only;


-- update : 데이터를 수정하는 명령어.
-- 형식) update 테이블이름 set 수정할컬럼명1 = 수정할 데이터, 
--             수정할컬럼명2 = 수정할 데이터,.....
--             where 고유한 컬럼명(primary key) = 수정할 컬럼값;

update student set major = '해양학과', age = 37, address = '전라남도 신안군'
    where hakbun = '2025_002';

-- delete : 데이터를 삭제하는 명령어.
-- 형식) delete from 테이블명 where 고유한 컬럼명(primary key) = 삭제할 컬럼값;
delete from emp where empno = 9000;


/*
   트랜잭션(Transaction)?
   - 데이터 처리의 한 단위를 말함.
   - 오라클에서 발생하는 여러 개의 SQL 명령문들을
     하나의 논리적인 작업 단위로 처리하는 것을 말함.
   - All or Nothing 방식으로 처리함.
   - 명령이 여러 개의 집합이 정상적으로 처리가 되면 종료하고,
     여러 개의 명령어 중에서 하나의 명령이라도 잘못이 되면
     전체를 취소하는 것을 말함(중요함).
     
   - 트랜잭션을 사용하는 이유
     데이터의 일관성을 유지하면서 데이터의 안정성을 보장하기 위함.
   - 트랜잭션 사용 시 트랜잭션을 제어하기 위한 명령어.
     1) commit : 모든 작업을 정상적으로 처리하겠다고 하는 명령어.
                 트랜잭션(insert, update, delete) 작업의 내용을
                 실제 DB에 반영.
                 이전에 있던 데이터에 update 현상이 빌생을 함.
                 모든 사용자가 변경된 데이터의 결과를 볼 수 있음.
     2) rollback : 작업 중에 문제가 발생했을 때 트랜잭션 처리 과정에서
                   변경 사항을 취소하여 이전 상태로 되돌리는 명령어.
                   트랜잭션(insert, update, delete) 작업을 내용을
                   취소함. 이전에 commit 한 곳 까지만 복구됨.
*/

-- 1. dept 테이블을 복사하여 dept02 라는 테이블을 만들어 보자.
create table dept02
as
select * from dept;

-- 2. dept02 테이블에서 40번 부서를 삭제한 후 commit을 해 보자.
delete from dept02 where deptno = 40;
commit;

-- 3. dept02 테이블의 전체 데이터를 삭제해 보자.
delete from dept02;

-- 4. dept02 테이블의 20번부서만 삭제하고 싶었는데 전체가 다 삭제되었음.
--    다시 복원을 할 수 있음.
rollback;

-- 5. 이제 20번 부서만 삭제하면 된다.
delete from dept02 where deptno = 20;
commit;


/*
   savepoint
   - 트랜잭션을 작게 분할하는 것을 말함.
   - 사용자가 트랜잭션 중간 단계에서 포인트를 지정하여
     트랜잭션 내의 특정 savepoint까지 roolback 할 수
     있게 하는 것을 말함.
*/

-- 1. dept 테이블을 복사하여 dept_03 이라는 테이블을 만들어 보자.
create table dept_03
as
select * from dept;


-- 2. dept_03 테이블에서 40번 부서를 삭제한 후 commit을 해 보자.
delete from dept_03 where deptno = 40;
commit;


-- 3. dept_03 테이블에서 30번 부서도 삭제를 해 보자.
delete from dept_03 where deptno = 30;

-- 4. 이 때 savepoint를 지정해 보자.
savepoint sp1;


-- 5. dept_03 테이블에서 20번 부서도 삭제를 해 보자.
delete from dept_03 where deptno = 20;

-- 6. 이 때 또 savepoint sp2를 설정해 보자.
savepoint sp2;


-- 7. dept_03 테이블에서 10번 부서도 삭제를 해 보자.
delete from dept_03 where deptno = 10;


-- 8. 부서번호가 20번 부서를 삭제하기 전으로 되돌아가고 싶은 경우
rollback to sp1;




/*
  PL/SQL(Procedual Language / SQL)
  - SQL 만으로는 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해서
    오라클에서 제공하는 프로그래밍 언어를 말함.
  - 일반적으로 프로그래밍 언어적인 요소들을 다 가지고 있으며, 데이터베이스
    업무를 처리하기 위한 최적화된 언어.
  - 변수, 조건 처리, 반복 처리 등 다양한 기능을 사용할 수 있음.
  - PL/SQL은 애플리케이션 서버 쪽에서 실행되는 것이 아니라, 데이터베이스
    엔진 쪽에서 수행이 됨. 따라서 데이터와 가장 가까운 곳에 위치하고
    있으므로 애플리케이션 서버로 데이터를 주고 받는데 따르는 네트워크
    트래픽이 최소화 된다는 장점이 있음.
  - 오라클 업무 시스템에서 데이터 처리 로직 구현
    1) 정기 배치 작업(Batch Job)
    2) 복잡한 계산 처리
    3) 대량 데이터 업데이트 / 정리
    4) 조건에 따른 데이터 자동 처리
    
  - 기본 구조
    1) 선언부(declare) : 모든 변수나 상수를 선언하는 부분.
    2) 실행부(executable - begin)
       - 실제 로직이 실행되는 부분.
       - 제어문(조건문), 반복문, 함수 정의 등의 로직을 기술하는 부분.
    3) 예외처리부(exception)
       - 실행 도중 예외가 발생 시 해결하기 위한 명령들을 기술하는 부분.
       
    ※ 위 기본 구조 중에서 선언부와 예외처리부는 생략이 가능하지만,
       실행부는 반드시 존재해야 함.
       
  - PL/SQL 사용 시 주의사항.
    1) 기본 구조(declare, begin, exception) 키워드 뒤에는 세미콜론(;)을
       붙이지 않는다.
    2) 블럭의 각 부분에서 실행해야 하는 문장 끝에는 반드시 세미콜론(;)을 붙인다.
    3) begin ~ end(실행부) 밑에는 반드시 "/" 를 붙여 주어야 한다.
*/

-- 화면에 출력 기능을 활성화 시켜주어야 한다.
set serveroutput on;

-- "Hello PL/SQL" 이라는 문장을 PL/SQL을 이용하여 화면에 출력해 보자.
begin
    -- 화면(콘솔)에 문장을 출력하는 명령문.
   dbms_output.put_line('Hello PL/SQL');
end;
/


-- 선언부(declare) 영역에 변수를 선언하는 방법
-- 1) 스칼라 자료형
--    형식) 변수명 자료형(크기)
--         예) num number; or name varchar2(30);

declare
    v_empno number(4) := 7788;
    v_ename varchar2(30);
begin
    v_ename := 'ADAMS';
    
    dbms_output.put_line('v_empno >>> ' || v_empno);
    dbms_output.put_line('v_ename >>> ' || v_ename);
end;
/

-- 2) 레퍼런스 자료형
-- 테이블에 정의된 컬럼의 자료형과 크기를 모두 파악하고 있다면
-- 문제가 없겠지만, 대부분은 그렇지 못하기 때문에 오라클에서는
-- 레퍼런스(reference) 변수를 제공해 줌.
-- 형식) 변수명 테이블명.컬럼%type;
-- 예) num emp.empno%type;

declare
    e_empno emp.empno%type;
    e_ename emp.ename%type;
begin
    e_empno := 9002;
    e_ename := 'SEJONG';
    
    dbms_output.put_line('e_empno >>> ' || e_empno);
    dbms_output.put_line('e_ename >>> ' || e_ename);

end;
/


-- 3) rowType 자료형
-- 테이블의 모든 컬럼을 한꺼번에 저장하기 위한 변수로 선언하는 방법.
-- 형식) e_row emp%rowType;

declare
    emp_row emp%rowType;
begin
    
    select * into emp_row
    from emp
    where empno = 7698;
    
    dbms_output.put_line(emp_row.empno || ' ' || emp_row.ename
        || ' ' || emp_row.job || ' ' || emp_row.mgr || ' ' ||
        emp_row.hiredate || ' ' || emp_row.sal || ' ' ||
        emp_row.comm || ' ' || emp_row.deptno);
end;
/

-- dept 테이블을 rowType으로 하여 30번 부서에 해당하는 내역을
-- 화면에 보여주세요.

declare
    dept_row dept%rowType;
begin

    select * into dept_row
    from dept
    where deptno = 30;
    
    dbms_output.put_line(dept_row.deptno || ' ' || 
            dept_row.dname || ' ' || dept_row.loc);
end;
/


/*
  조건 제어문(조건문)
  - 특정 조건식을 통해 상황에 따라 실행할 내용을 달리하는 
    방식의 명령문을 말함.

  1. if 조건문
     1) if ~ then 조건문
        - 특정 조건을 만족하는 경우에만 작업을 수행.
        - 형식)
                if 조건식 then
                    조건식이 참인 경우 실행 문장;
                end if;
        
     2) if ~ then ~ else 조건문
        - 특정 조건을 만족하는 경우와 만족하지 않는 경우
          각자 지정한 작업을 수행.
        - 형식) 
                if 조건식 then
                    조건식이 참인 경우 실행 문장;
                else
                    조건식이 거짓인 경우 실행 문장;
                end if;
     
     3) if ~ then ~ elsif 조건문
        - 여러 가지 조건에 따라 각자 지정한 작업을 수행.
        - 형식)
                if 조건식1 then
                    조건식1이 참인 경우 실행 문장;
                elsif 조건식2 then
                    조건식1이 거짓이고, 조건식2가 참인 경우 실행 문장;
                elsif 조건식3 then
                    조건식1, 조건식2가 거짓이고, 조건식3이 참인 경우 실행 문장;
                else
                    조건식1, 조건식2, 조건식3 모두가 거짓인 경우 실행 문장;
                end if;
*/

-- 1) if ~ then 조건식

declare
    e_number number := 77;
begin

    if e_number >= 50 then
        dbms_output.put_line(e_number || ' 은(는) 50보다 큰 수입니다.');
    end if;
    
end;
/

-- 키보드로 데이터를 입력 받는 방법
declare
    e_num number;
begin

    e_num := '&num';   -- 키보드로 데이터를 입력 받는 방법
    
    dbms_output.put_line('입력 받은 데이터 >>> ' || e_num);
end;
/

-- 2) if ~ then ~ else 조건문

declare
    su number;
begin
    su := '&su';
    
    if su >= 50 then
        dbms_output.put_line(su || ' 은(는) 50 이상의 숫자입니다.');
    else
        dbms_output.put_line(su || ' 은(는) 50 이하의 숫자입니다.');
    end if;
end;
/

-- [문제] 키보드로 입력 받은 수가 홀수인지 짝수인지 판별해 보세요.
declare
    e_num number;
begin

    e_num := '&num';
    
    if mod(e_num, 2) = 1 then
        dbms_output.put_line(e_num || ' 은(는) 홀수입니다.');
    else
        dbms_output.put_line(e_num || ' 은(는) 짝수입니다.');
    end if;
    
end;
/

-- 3) if ~ then ~ elsif 조건문

declare
    e_avg number := 88.12;
begin
    
    if e_avg >= 90 then
        dbms_output.put_line('A학점입니다.');
    elsif e_avg >= 80 then
        dbms_output.put_line('B학점입니다.');
    elsif e_avg >= 70 then
        dbms_output.put_line('C학점입니다.');
    elsif e_avg >= 60 then
        dbms_output.put_line('D학점입니다.');
    else
        dbms_output.put_line('F학점입니다.');
    end if;
    
end;
/

/*
  반복 제어문
  - 특정 작업을 반복하여 수행하고자 할 때 사용하는 제어문.
  - 반복 제어문의 종류
    1) 기본 loop
       - 가장 기본적인 반복문.
    2) while loop
       - 특정 조건의 결과를 통해서 반복을 수행하는 반복문.
    3) for loop
       - 반복 횟수를 정하여 반복을 수행하는 반복문.
  - 반복문의 반복적인 수행을 종료시키는 명령어.
    1) exit
       - 수행 중인 반복을 종료시키는 명령어.
    2) exit ~ then
       - 반복 종료를 위한 조건식을 지정하고 만족하면
         반복을 종료시키는 명령어.
    3) continue
       - 수행 중인 반복의 현재 주기를 건너 뛰는 명령어.
    4) continue ~ when
       - 특정 조건식을 지정하고 조건식을 만족하면 반복 주기를
         건너 뛰는 명령어.
*/

-- 1) 기본 loop 반복문

declare

    su number := 1;
begin

    loop
    
        dbms_output.put_line('su >>> ' || su);
        su := su + 1;
        
        if su > 10 then
            exit;
        end if;
        
    end loop;
    
end;
/

-- 2) while loop 반복문
declare

    su number := 1;
    
    e_sum number := 0;  -- 합을 누적시킬 변수
    
begin

    dbms_output.put_line('*** 1 ~ 100 까지의 합 ***');

    while su <= 100 loop
        e_sum := e_sum + su;
        su := su + 1;
    end loop;
    
    dbms_output.put_line('총합 >>> ' || e_sum);

end;
/

-- 3) for loop 반복문

declare
    tot number := 0;
begin

    dbms_output.put_line('*** for loop 를 이용한 1 ~ 100 까지의 합 ***');    

    for su in 1 .. 100 loop
        tot := tot + su;
    end loop;
    
    dbms_output.put_line('1 ~ 100 까지의 합 >>> ' || tot);
    
end;
/