/*
  group by 절
  - 특정 컬럼이나 값을 기준으로 해당 레코드를 묶어서 
    자료를 관리할 때 사용함.
  - 보통은 특정한 컬럼을 기준으로 집계를 구하는데 많이 사용을 함.
  - 또한 그룹함수와 함께 사용하면 효과적으로 활용이 가능함.
*/

select deptno
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

-- [문제] emp 테이블에서 부서별로 그룹을 지어서 부서의
--       급여 합계액과 부서별 인원 수, 부서별 평균 급여,
--       부서별 최대급여액, 부서별 최소급여액을 구하여
--       화면에 보여주세요.
--       단, 급여 합계를 기준으로 내림차순으로 정렬하여
--       화면에 보여주세요.
select deptno, sum(sal), count(*), avg(sal), max(sal), min(sal)
from emp
group by deptno
order by sum(sal) desc;

/*
  having 절
  - group by 절 다음에 나오는 조건절.
  - group by 절의 결과에 조건을 주어서 제한할 때 사용함.
  - group by 절에는 where(조건절) 가 올 수 없음.
*/

-- products 테이블에서 카테고리 별로
-- 상품의 갯수를 화면에 보여주세요.
select category_fk, count(*)
from products
group by category_fk
having count(*) >= 2;


/*
  ★★★★★★★★★★★★★★★★★★★★★
  View
  - 물리적인 테이블에 근거한 논리적인 가상의 테이블을 말함.
  - View 는 실질적으로 데이터를 저장하고 있지 않음.
  - View 를 만들면 데이터베이스에 질의 시 실제 테이블에
    접근하여 데이터를 불러오게 됨.
  - 간단하게 필요한 내용들만 추출해서 사용할 때 많이 사용이 됨.
  - View 는 테이블과 유사하며, 테이블처럼 사용이 가능함.
  - View 는 테이블에 저장하기 위한 물리적인 공간이 필요가 없음.
  - 테이블과 마찬가지로 insert, update, delete 명령이 가능함.
    하지만 주로 데이터를 조회(select)하는 용도로 가장 많이 사용이 됨.
  - View 를 사용하는 이유
    1) 보안 관리를 위해 사용함(중요함)
       ==> 보안 등급에 맞추어 컬럼의 범위를 정해서 조회가
           가능하도록 할 수 있음.
    2) 사용자의 편의성을 제공함.
    
    형식)
            create view view이름
            as
            쿼리문;
*/

-- 1) 보안 관리를 위해 사용함(중요함)
-- 인사부 View
-- 컬럼에 sal(급여), comm(보너스) 컬럼은 제외.
create view emp_insa
as
select empno, ename, job, mgr, hiredate, deptno
from emp;

-- 영업부 View
-- 컬럼에 sal(급여) 컬럼은 제외.
create view emp_sales
as
select empno, ename, job, mgr, hiredate, comm, deptno
from emp;

-- 회계부 View
-- 제외되는 컬름 없음.
create view emp_account
as
select * 
from emp;

insert into emp_account
    values(9000, 'ANGEL', 'SALESMAN', 7698, sysdate, 1300, 300, 30);
    
-- View 를 읽기 전용으로 만들면 데이터가 추가가 안 됨.
-- View 를 읽기 전용으로 만드는 방법
-- ==> View 를 만들 때 쿼리문 마지막에 with read only 문구 추가.

create view emp_view2
as
select * from emp
with read only;

insert into emp_view2
    values(9001, 'LOVE', 'SALESMAN', 7698, sysdate, 1300, 300, 30);

-- create or replace view
-- 같은 이름의 view 가 있는 경우에는 기존에 view를 삭제하고
-- 새로운 view를 만들라는 의미.
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
select * from emp
with read only;

insert into emp_sales
    values(9001, '임정훈', 'SALESMAN', 7694, sysdate, 400, 30);
    
-- 2) 사용자의 편의성을 제공함.
create or replace view emp_salary
as
select empno, ename, (sal * 12 + nvl2(comm, comm, 0)) 연봉
from emp
with read only;

-- [문제1] emp 테이블을 이용하여 부서별로 부서별 급여 합계, 부서별
--        급여 평균을 구한 view 를 만들어 화면에 보여주세요.
--        주의사항) view 를 만들 때 그룹함수 사용시에는 반드시
--                 별칭을 설정해 주어야 함.
create or replace view emp_deptno
as
select deptno, sum(sal) "급여합계", avg(sal) "급여평균"
from emp
group by deptno
with read only;


-- [문제2] emp 테이블을 이용하여 emp_dept20 이라는 view 를 만들어 주세요.
--        단, 부서번호가 20번 부서에 속한 사원들의 사번, 이름, 담당업무,
--        관리자, 부서번호만 화면에 보여주세요.
create or replace view emp_dept20
as
select empno, ename, job, mgr, deptno
from emp
where deptno = 20
with read only;

-- [문제3] emp 테이블에서 각 부서별 최대 급여와 최소 급여를 보여주는
--        view를 만들되, sales_view 라는 이름으로 만들어 화면에 보여주세요.
create or replace view sales_view
as
select deptno, max(sal) "최대급여", min(sal) "최소급여"
from emp
group by deptno
with read only;


-- [문제4] emp 테이블을 이용하여 담당업무가 'SALESMAN' 인 사원의 사번,
--        이름, 담당업무, 입사일, 부서번호를 컬럼으로 하는 view 를 
--        만들되, emp_sale 이라는 view 를 만들어 화면에 보여주세요.
create or replace view emp_sale
as
select empno, ename, job, hiredate, deptno
from emp
where job = 'SALESMAN'
with read only;


/*
  트랜잭션(Transaction)
  - 데이터 처리의 한 단위를 말함.
  - 오라클에서 발생하는 여러 개의 SQL 명령문들을
    하나의 논리적인 작업 단위로 처리하는 것을 말함.
  - All or Nothing 방식으로 처리함.
  - 명령어 여러 개의 집합이 정상적으로 처리가 되면 종료하고,
    여러 개의 명령어 중에서 하나의 명령이라도 잘못이 되면
    전체를 취소하는 것을 말함. - 중요함
    
  - 트랜잭션 사용 이유 : 데이터의 일관성을 유지하면서 
                       데이터의 안정성을 보장하기 위해 사용함.
  - 트랜잭션 사용 시 트랜잭션을 제어하기 위한 명령어.
    1) commit : 모든 작업을 정상적으로 치리하겠다고 확정하는 명령어.
                트랜잭션(insert, update, delete) 작업의 내용을
                실제 DB에 반영.
                이전에 있던 데이터에 update 현상이 발생을 함.
                모든 사용자가 변경된 데이터의 결과를 볼 수 있음.
    2) rollback : 작업 중에 문제가 발생했을 때 트랜잭션 처리 과정에서
                  발생한 변경 사항을 취소하여 이전 상태로 되돌리는 명령어.
                  트랜잭션(insert, update, delete) 작업의 내용을 취소함.
                  이전에 commit 한 곳까지만 복구가 됨.
*/

-- 1. dept 테이블을 복사하여 dept_02 라는 테이블을 만들어 보자.
create table dept_02
as
select * from dept;

-- 2. dept_02 테이블에서 40번 부서를 삭제해 보자.
--    형식) delete from 테이블이름 where 컬럼명(primary key) = 내용(데이터)
delete from dept_02 where deptno = 40;
-- commit 을 해 보자.
commit;

-- 3. dept_02 테이블의 전체 데이터를 삭제해 보자.
delete from dept_02;

-- 4. 이 때 만일 20번 부서에 대해서만 삭제를 하고 싶었는데
--    잘못해서 전체가 삭제가 된 경우, 다시 복원 할 수 있음.
rollback;

-- 5. 20번 부서만 삭제를 하자.
delete from dept_02 where deptno = 20;

-- 6. 데이터베이스에 완전하게 저장을 하자.
commit;

/*
  savepoint 개념
  - 트랜잭션을 작게 분할하는 것을 말함.
  - 사용자가 트랜잭션 중간 단계에서 포인트를 지정하여
    트랜잭션 내의 특정 savepoint 까지 rollback 할 수
    있게 하는 것을 말함.
*/

-- 1. dept 테이블을 복사하여 dept_03 이라는 테이블을 만들자.
create table dept_03
as
select * from dept;

-- 2. dept_03 테이블에서 40번 부서를 삭제한 후 commit 해 보자.
delete from dept_03 where deptno = 40;
commit;

-- 3. dept_03 테이블에서 30번 부서를 삭제해 보자.
delete from dept_03 where deptno = 30;

-- 4. 이 때 savepoint sp1을 설정해 보자.
savepoint sp1;

-- 5. 부서번호가 20번 부서를 삭제해 보자.
delete from dept_03 where deptno = 20;

-- 6. 이 때 savepoint sp2을 설정해 보자.
savepoint sp2;

-- 7. 마지막으로 10번 부서를 삭제해 보자.
delete from dept_03 where deptno = 10;

-- 8. 이 때 부서번호가 20번인 부서를 삭제하기 바로
--    전으로 되돌아 가고 싶은 경우
rollback sp1;


/*
  특정 테이블의 컬럼을 수정하는 방법
  형식)
        update 테이블이름 set 수정할 컬럼이름1 = 수정할 컬럼내용,
                             수정할 컬럼이름2 = 수정할 컬럼내용,
                             수정할 컬럼이름3 = 수정할 컬럼내용
               where 컬럼명(primary key) = 값;
               
        ※ 주의사항) 만약에 where 조건절이 누락이 되면 테이블 전체
                    데이터가 수정이 이루어짐.
*/

update student set major = '국문학과', addr = '서울시 중구 태평로'
            where hakbun = '2023_002';
            


/*
  PL/SQL(Procedual Language / SQL)
  - SQL 만으로는 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해서
    오라클에서 제공하는 프로그래밍 언어를 말함.
  - 일반적으로 프로그래밍 언어적인 요소들을 다 가지고 있으며, 데이터베이스
    업무를 처리하기 위한 최적화된 언어.
  - 변수, 조건 처리, 반복 처리 등 다양한 기능을 사용할 수 있음.

  - 기본 구조
    1) 선언부(declare) : 모든 변수나 상수를 선언하는 부분.
    2) 실행부(executable ~ begin)
       - 실제 로직이 실행되는 부분.
       - 제어문(조건문), 반복문, 함수 정의 등의 로직을 기술하는 부분.
    3) 예외처리부(exception)
       - 실행 도중 예외가 발생했을 시 해결하기 위한 명령들을 기술하는 부분.
       
  - 위 기본 구조 중에서 선언부와 예외처리부는 생략이 가능하지만,
    실행부는 반드시 존재해야 함.
    
  - PL/SQL 사용 시 주의사항.
    1) 기본 구조(declare, begin, exception) 키워드 뒤에는
       세미콜론(;)을 붙이지 않는다.
    2) 블럭의 각 부분에서 실행해야 하는 문장 끝에는 반드시 
       세미콜론(;)을 붙인다.
    3) begin ~ end(실행부) 밑에는 반드시 "/" 를 붙여 주어야 한다.
*/

-- PL/SQL에서 화면에 출력을 하기 위해서는 PL/SQL의 출력기능을
-- 활성화 시켜 주어야 한다.
set serveroutput on;

-- 화면에 텍스트를 출력해 보자.
begin
    dbms_output.put_line('Hello PL/SQL!!!');
end;
/

-- 선언부(declare) 영역에 변수를 선언하는 방법
-- 1) 스칼라 자료형
--    형식) 변수명 자료형(크기)
--          예) num number(5); name varchar2(20);
declare
    v_empno number(4);
    v_ename varchar2(20) := 'ADAMS';
begin
    v_empno := 7788;
    
    dbms_output.put_line('v_empno >>> ' || v_empno);
    dbms_output.put_line('v_ename >>> ' || v_ename);
end;
/

-- 2) 레퍼런스 자료형
--    테이블에 정의된 컬럼의 자료형과 크기를 모두 파악하고 있다면
--    문제가 없겠지만, 대부분은 그렇지 못하기 때문에 오라클에서는
--    레퍼런스(reference) 변수를 제공을 함.
--    형식) 변수명 테이블명.컬럼명%type;
--         예) num emp.empno%type;

declare
    e_empno emp.empno%type;
    e_ename emp.ename%type;
begin
    e_empno := 7900;
    e_ename := 'SCOTT';
    
    dbms_output.put_line('e_empno >>> ' || e_empno);
    dbms_output.put_line('e_ename >>> ' || e_ename);
end;
/

-- 3) rowtype 자료형
--    테이블의 모든 컬럼을 한꺼번에 저장하기 위한 변수로 선언하는 방법.
--    형식) e_row emp%rowtype;

declare
    emp_row emp%rowtype;
begin
    select * into emp_row
    from emp
    where empno = 7698;
    
    dbms_output.put_line(emp_row.empno || ' ' || emp_row.ename 
                    || ' ' || emp_row.job || ' ' || emp_row.mgr 
                    || ' ' || emp_row.hiredate || ' ' || emp_row.sal
                    || ' ' || emp_row.comm || ' ' || emp_row.deptno);
end;
/

/*
  조건 제어문(조건문)
  - 특정 조건식을 통해 상황에 따라 실행할 내용을 달리하는
    방식의 명령어를 말함.
    
  1. if 조건문
     1) if ~ then
        - 특정 조건을 만족하는 경우에만 작업을 수행.
        - 형식) 
                if 조건식 then
                    조건식이 참인 경우 실행 문장;
                end if
     2) if ~ then ~ else
        - 특정 조건식의 만족하는 경우와 반대의 경우에
          각자 지정한 작업을 수행.
        - 형식)
                if 조건식 then
                    조건식이 참인 경우 실행 문장;
                else
                    조건식이 거짓인 경우 실행 문장;
                end if
     3) if ~ then ~ elsif
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
                end if
*/

-- 1) if ~ then
declare
    e_number number(3) := 77;
begin
    if e_number >= 10 then
        dbms_output.put_line(e_number || ' 는 10보다 큰 수입니다.');
    end if;
end;
/

-- 2) if ~ then ~ else
-- [문제] 변수에 들어 있는 값이 홀수인지, 짝수인지
--       판별하여 화면에 출력해 보세요.
declare
    e_num number(3) := 87;
begin
    if mod(e_num, 2) = 1 then
        dbms_output.put_line(e_num || ' 은(는) 홀수입니다.');
    else
        dbms_output.put_line(e_num || ' 은(는) 짝수입니다.');
    end if;
end;
/

-- 3) if ~ then ~ elsif
declare
    e_avg number(5,2) := 89.12;
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

-- 키보드로 데이터를 입력 받는 방법
declare
    e_num number(3);
begin

    e_num := '&num';
    
    dbms_output.put_line('입력받은 수 >>> ' || e_num);

end;
/

/*
  2. case 조건문
     형식)
            case 비교기준
                when 값1 then
                    값1 일때 수행할 명령문;
                when 값2 then
                    값2 일때 수행할 명령문;
                when 값3 then
                    값3 일때 수행할 명령문;
                else
                    값1, 값2, 값3이 아닌 다른 값일 경우 수행할 명령어;
                end case;
*/

declare
    e_score number(3);
begin
    e_score := '&score';
    
    case trunc(e_score / 10)
        when 10 then
            dbms_output.put_line('A학점입니다.');
        when 9 then
            dbms_output.put_line('A학점입니다.');
        when 8 then
            dbms_output.put_line('B학점입니다.');
        when 7 then
            dbms_output.put_line('C학점입니다.');
        when 6 then
            dbms_output.put_line('D학점입니다.');
        else
            dbms_output.put_line('F학점입니다.');
    end case;
end;
/

/*
  반복 제어문
  - 특정 작업을 반복하여 수행하고자 할 때 사용하는 문장.
  - 반복 제어문의 종류
    1) 기본 loop
       - 가장 기본적인 반복문.
    2) while loop
       - 특정 조건의 결과를 통해서 반복을 수행하는 반복문.
    3) for loop
       - 반복 횟수를 정하여 반복을 수행하는 반복문.
  - 반복문의 반복적인 수행을 종료시키는 명령어.
    1) exit
       - 수행중인 반복을 종료시키는 명령어.
    2) exit ~ when
       - 반복 종료를 위한 조건식을 지정하고 만족하면 반복을
         종료시키는 명령어.
    3) continue
       - 수행 중인 반복의 현재 주기를 건너 뛰는 명령어.
    4) continue ~ when
       - 특정 조건식을 지정하고 조건식을 만족하면 반복 주기를
         건너 뛰는 명령어.
*/

-- 기본 loop
declare
    e_num number(3) := 1;
begin
    loop
        if(e_num > 100) then
            exit;
        end if;
        dbms_output.put_line('e_num >>> ' || e_num);
        e_num := e_num + 1;
    end loop;
end;
/

-- while loop
declare
    e_num number(3) := 1;
    e_sum number(6) := 0;
    
begin
    dbms_output.put_line('*** 1 ~ 100 까지의 합 ***');
    
    while e_num <= 100 loop
        e_sum :=  e_sum + e_num;
        e_num := e_num + 1;
    end loop;
    
    dbms_output.put_line('총 합 >>> ' || e_sum);
end;
/

-- for loop
declare
    e_tot number(5) := 0;
begin
    dbms_output.put_line('*** for문을 이용한 1 ~ 100 까지의 합 ***');
    
    for e_num in 1 .. 100 loop
        e_tot := e_tot + e_num; 
    end loop;
    
    dbms_output.put_line('총 합 >>> ' || e_tot);
end;
/

-- 키보드로 입력받은 수까지의 합을 구해 보자.
declare
    e_tot number(5) := 0;
    e_su number(3);
begin
    dbms_output.put_line('*** for문을 이용한 1 ~ 100 까지의 합 ***');
    
    e_su := '&su';
    
    for e_num in 1 .. e_su loop
        e_tot := e_tot + e_num; 
    end loop;
    
    dbms_output.put_line('총 합 >>> ' || e_tot);
end;
/






