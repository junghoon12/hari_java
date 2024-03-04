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

-- 화면에 출력 기능을 활성화를 시켜 주어야 한다.
set serveroutput on;

-- "Hello PL/SQL" 이라는 문장을 PL/SQL을 이용하여 화면에 출력해 보자.

begin
-- 화면(콘솔)에 문장을 출력하는 명령문
   dbms_output.put_line('Hello PL/SQL');
end;
/


-- 선언부(declare) 영역에 변수를 선언하는 방법
-- 1) 스칼라 자료형
--    형식) 변수명 자료형(크기)
--          예) num number;  name varchar2(30);

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
    e_empno := 7900;
    e_ename := 'SCOTT';
    
    dbms_output.put_line('e_empno >>> ' || e_empno);
    dbms_output.put_line('e_ename >>> ' || e_ename);
end;
/

-- 3) rowtype 자료형
-- 테이블의 모든 컬럼을 한꺼번에 저장하기 위한 변수로 선언하는 방법.
-- 형식) e_row emp%rowtype;

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

-- [문제] dept 테이블을 rowtype으로 하여 30번 부서에 해당하는 내역을
-- 화면에 보여주세요.

declare
    dept_row dept%rowtype;
begin
    select * into dept_row
    from dept
    where deptno = 30;
    
    dbms_output.put_line('DEPTNO >>> ' || dept_row.deptno);
    dbms_output.put_line('DNAME >>> ' || dept_row.dname);
    dbms_output.put_line('LOC >>> ' || dept_row.loc);
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

-- 1) if ~ then
declare
    e_number number := 77;
begin
    if e_number >= 50 then
        dbms_output.put_line(e_number || ' 은(는) 50보다 큰 수입니다.');
    end if;
end;
/

-- 2) if ~ then ~ else
-- [문제] 변수에 들어 있는 값이 홀수인지, 짝수인지 판별하여
--       화면에 출력해 보세요.

declare
    e_num number := 86;
begin
    
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

-- 키보드로 데이터를 입력 받는 방법
declare
    e_num number;
begin

    e_num := '&num';
    
    dbms_output.put_line('입력 받은 데이터 >>> ' || e_num);
end;
/

/*
  2. case 조건문
     형식)
            case 비교기준
                when 값1 then
                    값1 일 때 수행할 문장;
                when 값2 then
                    값2 일 때 수행할 문장;
                when 값3 then
                    값3 일 때 수행할 문장;
                else
                    값1, 값2, 값3 이 아닌 다른 값일 경우 수행할 문장;
            end case;
*/

-- [문제] 키보드로 점수를 입력받아서 학점을 화면에 출력해 보세요.

declare
    e_score number;
begin

    e_score := '&score';
    
    case trunc(e_score / 10)
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

-- 기본 loop 반복을 사용해 보자.
declare
    e_num number := 1;
begin

    loop
        dbms_output.put_line('e_num >>> ' || e_num);
        e_num := e_num + 1;
        
        if(e_num > 10) then
            exit;
        end if;
    end loop;
end;
/

-- while loop
declare
    e_su number := 1;
    e_sum number := 0;  -- 합을 누적시키는 변수
begin

    dbms_output.put_line('*** 1 ~ 100  까지의 합 ***');
    
    while e_su <= 100 loop
        e_sum := e_sum + e_su;
        e_su := e_su + 1;
    end loop;

    dbms_output.put_line('총 합 >>> ' || e_sum);
end;
/

-- for loop 예제
declare
    e_tot number := 0;
begin
    
    dbms_output.put_line('*** for loop 문을 이용한 1 ~ 100 까지의 합 ***');
    
    for e_num in 1 .. 100 loop
        e_tot := e_tot + e_num;
    end loop;
    
    dbms_output.put_line('총 합 >>> ' || e_tot);
end;
/


select * from member order by memno desc;

select max(memno) from member;

