/*
   dual 테이블
   - 오라클에서 자체적으로 제공해 주는 테이블.
   - 간단하게 함수를 이용해서 계산, 결과값을 확인할 때 사용하는 테이블.
   - 오직 한 행, 한 컬럼만을 담고 있는 테이블.
   - 사용 용도 : 특정 테이블을 생성할 필요 없이 함수 또는
                계산을 하고자 할 때 사용이 됨.
*/

-- 오라클에서 제공해 주는 함수들
-- 1. 날짜와 관련된 함수들
--    1) sysdate : 현재 시스템의 날짜를 구해 오는 함수.
select sysdate from dual;

--    2) add_months(현재 날짜, 숫자(개월수))
--       : 현재 날짜에서 개월 수를 더해 주는 함수.
select add_months(sysdate, 3) from dual;

--    3) next_day(현재 날짜, '요일')
--       : 다가올 날짜(요일)을 구해 주는 함수.
select next_day(sysdate, '월요일') from dual;

--    4) to_char(날짜, '날짜형식')
--       : 형식에 맞게 문자열로 날짜를 출력해 주는 함수.
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'yyyy-mm-dd') from dual;
select to_char(sysdate, 'mm-dd-yyyy') from dual;

--    5) months_between('마지막날짜', 현재날짜)
--       : 두 날짜 사이의 개월 수를 출력해 주는 함수.
select months_between('23/06/15', sysdate) from dual;

--    6) last_day()
--       : 주어진 날짜가 속한 달의 마지막 날짜를 반환해 주는 함수.
select last_day(sysdate) from dual;

-- 2. 문자와 관련된 함수들
--    1-1) concat('문자열1', '문자열2')
--         : 문자열을 연결(결합)해 주는 함수.
select concat('안녕', '하세요!!!') from dual;

--    1-2) || 연산자 : 문자열을 연결하는 연산자.
select '방가' || '방가' from dual;

--    2) upper() : 소문자를 대문자로 바꾸어 주는 함수.
select upper('happy day') from dual;

--    3) lower() : 대문자를 소문자로 바꾸어 주는 함수.
select lower(upper('happy day')) from dual;

--    4) substr('문자열', x, y)
--       : 문자열을 x부터 y의 길이만큼 추출해 주는 함수.
select substr('ABCDEFG', 3, 2) from dual;  -- CD

--       : x 값이 음수인 경우에는 오른쪽부터 시작이 된다.
select substr('ABCDEFG', -3, 2) from dual; -- EF

--    5) 자릿수를 늘려주는 함수.
--       5-1) lpad('문자열' '전체자릿수' '늘어난 자릿수에 들어갈 문자열')
--            : 왼쪽 자릿수를 늘려주는 함수.
select lpad('ABCDEFG', 15, '*') from dual;

--       5-2) rpad('문자열' '전체자릿수' '늘어난 자릿수에 들어갈 문자열')
--            : 오른쪽 자릿수를 늘려주는 함수.
select rpad('ABCDEFG', 15, '*') from dual;

--    6) 문자를 지워 주는 함수.
--       6-1) ltrim() : 왼쪽 문자를 지워 주는 함수.
select ltrim('ABCDEFGA', 'A') from dual;

--       6-2) rtrim() : 오른쪽 문자를 지워 주는 함수.
select rtrim('ABCDEFGA', 'A') from dual;

--    7) replace() : 문자열을 교체해 주는 함수.
--       형식) replace('원본 문자열', '교체될 문자열', '새로운 문자열');
select replace('Java Program', 'Java', 'JSP') from dual;


-- [문제1] emp 테이블에서 결과가 아래와 같이 나오도록
-- 화면에 보여주세요.
-- 결과) 'SCOTT의 담당업무는 ANALYST 입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(ename, ' 의 담당업무는 '),
concat(job, ' 입니다.')
from emp;

-- [문제2] emp 테이블에서 결과가 아래와 같이 나오도록
-- 화면에 보여주세요.
-- 결과) 'SCOTT의 연봉은 36000입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(ename, ' 의 연봉은 '),
concat(sal * 12, ' 입니다.')
from emp;

-- [문제3] member10 테이블에서 결과가 아래와 같이 나오도록
-- 화면에 보여주세요.
-- 결과) '홍길동 회원의 직업은 학생입니다.'
-- 단, concat() 함수를 이용하세요.
select concat(memname, ' 회원의 직업은 '),
concat(job, ' 입니다.')
from member10;

-- [문제4] emp 테이블에서 사번, 이름, 담당업무를 화면에
-- 보여주세요. 단, 담당업무는 소문자로 변경하여 보여주세요.
select empno, ename, lower(job)
from emp;

-- [문제5] 여러분의 주민등록 번호 중에서 생년월일을 추출하여
-- 화면에 보여주세요.
select substr('881212-1234567', 1, 6)
from dual;

-- [문제6] emp 테이블에서 담당업무에 'A' 라는 글자를
-- '$'로 바꾸어 화면에 보여주세요.
select replace(job, 'A', '$')
from emp;

-- [문제7] member10 테이블에서 직업이 '학생' 인 정보를
-- '대학생'으로 바꾸어 화면에 보여주세요.
select replace(job, '학생', '대학생')
from member10;

--[문제8] member10 테이블에서 주소에 '서울시' 로 된 정보를
-- '서울특별시'로 바꾸어 화면에 보여주세요.
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

--       반올림을 할 때 자릿수를 지정.
--       형식) round([숫자(필수)],  [반올림 위치(선택)]) 
--            음수 값을 지정하면 자연수(정수)쪽으로 한자리씩
--            위로 반올림을 해 줌.
select round(0.1234567, 6) from dual; -- 0.123457

select round(2.3423557, 4) from dual; -- 2.3424

select round(1236.5678, -2) from dual; -- 1200

--    4) trunc() : 소숫점 이하 자릿수를 잘라내는 함수.
--       형식) trunc([숫자(필수)], [버릴위치(선택)])
select trunc(1234.1234567, 0) from dual; -- 1234

select trunc(1234.1234567, 4) from dual; -- 1234.1234

select trunc(1234.1234567, -3) from dual; -- 1000

--    5) ceil() : 무조건 올림을 해 주는 함수.
select ceil(22.8) from dual;  -- 23

select ceil(22.1) from dual;  -- 23

--    6) power() : 제곱을 구해 주는 함수.
select power(4, 3) from dual; -- 64

--    7) mod() : 나머지는 구해 주는 함수.
--       형식) mod([나눗셈될 숫자(필수)], [나눌 숫자(필수)])
select mod(77, 4) from dual;

--    8) sqrt() : 제곱근을 구해 주는 함수.
select sqrt(3) from dual;

select sqrt(16) from dual;



/*
   ★★★★★★★★★★★★★★★★★★★★★★★★★
   서브쿼리
   - 하나의 쿼리문 안에 포함되어 있는 또 하나의 쿼리문을 말함.
   - 쿼리문 안에 또 다른 쿼리문이 존재하는 것을 말함.
   - 서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계임.
   - 여러 번 쿼리를 실행해서 얻을 수 있는 결과를 하나의 중첩된
     쿼리 문장으로 결과를 얻을 수 있게 해 줌.
     
   ※ 주의사항
      - 서브쿼리는 괄호로 묶어서 사용하는 것이 관례임.
      - 서브쿼리 안에서는 order by 절은 사용할 수 없음.
      
   - 사용방법 : 우선은 안쪽에 있는 쿼리문을 실행 후, 그 결과값을
               가지고 바깥쪽 쿼리문을 실행함.
*/

-- emp 테이블에서 이름이 'SCOTT' 인 사원의 급여보다 더 많은
-- 급여를 받는 사원의 사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal > (select sal from emp where ename = 'SCOTT'); 
-- SCOTT 급여는 3000


-- [문제1] emp 테이블에서 평균급여보다 더 적게 받는 사원의
-- 사번, 이름, 담당업무, 급여, 부서번호를 화면에 보여주세요.
select empno, ename, job, sal, deptno
from emp
where sal < (select avg(sal) from emp);  -- 약 2073의 평균 급여

-- [문제2] emp 테이블에서 사번이 7521인 사원과 담당업무가 같고,
-- 사번이 7934인 사원의 급여보다 더 많이 받는 사원의 사번, 이름, 
-- 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job = (select job from emp where empno = 7521)  -- SALESMAN
and
sal > (select sal from emp where empno = 7934);  -- 급여 1300


-- [문제3] emp 테이블에서 담당업무가 'MANAGER' 인 사원의 최소급여보다
-- 적으면서, 담당업무가 'CLERK'은 아닌 사원의 사번, 이름, 담당업무,
-- 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where sal < (select min(sal) from emp where job = 'MANAGER')
and job != 'CLERK';  -- 최소급여 : 2450

-- [문제4] 부서위치가 'DALLAS' 인 사원의 사번, 이름, 부서번호, 
-- 담당업무를 화면에 보여주세요.
select empno, ename, deptno, job
from emp
where deptno = (select deptno from dept where loc = 'DALLAS');

-- [문제5] member10 테이블에 있는 고객의 정보 중 마일리지가 가장 높은
-- 고객의 모든 정보를 화면에 보여주세요.
select *
from member10
where mileage = 
(select max(mileage) from member10);  -- 최대 마일리지 : 10,000


-- [문제6] emp 테이블에서 'SMITH' 인 사원보다 더 많은 급여를
-- 받는 사원의 이름과, 급여를 화면에 보여주세요.
select ename, sal
from emp
where sal >
(select sal from emp where ename = 'SMITH');  -- 급여 : 800


-- [문제7] emp 테이블에서 10번 부서 급여의 평균 급여보다 적은 급여를 받는
-- 사원들의 이름, 급여, 부서번호를 화면에 보여주세요.
select ename, sal, deptno
from emp
where sal < 
(select avg(sal) from emp where deptno = 10); -- 부서 평균 : 2916


-- [문제8] emp 테이블에서 'BLAKE'와 같은 부서에 있는 사원들의
-- 이름과 입사일자, 부서번호를 화면에 보여주되, 'BLAKE' 는 제외하고
-- 화면에 보여주세요.
select ename, hiredate, deptno
from emp
where deptno = 
(select deptno from emp where ename = 'BLAKE')
and ename != 'BLAKE';  -- 30번 부서

-- [문제9] emp 테이블에서 평균급여보다 더 많이 받는 사원들의 사번,
-- 이름, 급여를 화면에 보여주되, 급여가 높은데서 낮은 순으로 화면에 
-- 보여주세요.
select empno, ename, sal
from emp
where sal >
(select avg(sal) from emp)
order by sal desc;  -- 급여 평균 : 2073


-- [문제10] emp 테이블에서 이름에 'T'를 포함하고 있는 사원들과 같은 부서에
-- 근무하고 있는 사원의 사번과 이름, 부서번호를 화면에 보여주세요.
select empno, ename, deptno
from emp
where deptno in
(select distinct deptno from emp where ename like '%T%');


-- [문제11] 'SALES' 부서에서 근무하고 있는 사원들의 부서번호,
-- 이름, 담당업무를 화면에 보여주세요.
select deptno, ename, job
from emp
where deptno = 
(select deptno from dept where dname = 'SALES');

-- [문제12] emp 테이블에서 'KING'에게 보고하는 모든 사원의
-- 이름과 급여, 관리자를 화면에 보여주세요.
select ename, sal, mgr
from emp
where mgr = 
(select empno from emp where ename = 'KING');


-- [문제13] emp 테이블에서 자신의 급여가 평균급여보다 많고, 이름에
-- 'S' 자가 들어가는 사원과 동일한 부서에서 근무하는 모든 사원의 
-- 사번, 이름, 급여, 부서번호를 화면에 보여주세요.
select empno, ename, sal, deptno
from emp
where sal > (select avg(sal) from emp)  -- 평균 급여 : 2073
and 
deptno in
(select deptno from emp where ename like '%S%');

-- 문제풀이 생략
-- [문제14] emp 테이블에서 보너스를 받는 사원과 부서번호, 급여가 같은
-- 사원의 이름, 급여, 부서번호를 화면에 보여주세요.



-- [문제15] products 테이블에서 상품의 판매가격이 판매가격의
-- 평균보다 큰 상품의 전체 내용을 화면에 보여주세요.
select *
from products
where output_price >
(select avg(output_price) from products); -- 판매가격 평균 : 1,143,800원


-- [문제16] products 테이블에 있는 판매 가격에서 평균 가격 이상의
-- 상품 목록을 구하되, 평균을 구할 때 가격이 가장 큰 금액인 상품을
-- 제외하고 평균을 구하여 화면에 보여주세요.
select *
from products
where output_price >
(select avg(output_price) from products     -- 판매가격 평균 : 1,143,800원
where output_price <>
(select max(output_price) from products));  -- 최대가격 : 8000000

-- [문제17] products 테이블에서 상품명의 이름에 '에어컨' 이라는
-- 단어가 포함된 카테고리에 속하는 상품목록을 화면에 보여주세요.
select *
from products
where category_fk = 
(select distinct category_fk from products
where products_name like '%에어컨%');

-- [문제18] member10 테이블에 있는 고객 정보 중 마일리지가 가장 높은 
-- 금액을 가지는 고객에게 보너스 마일리지 5000점을 더 주어 고객명,
-- 마일리지, 마일리지+5000 점을 화면에 보여주세요.
select memname, mileage, mileage + 5000 "추가된 마일리지"
from member10
where mileage = 
(select max(mileage) from member10);  -- 최대 마일리지 : 10,000


select * from emp;
select * from products;
