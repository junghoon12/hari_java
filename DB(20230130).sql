-- [문제1] emp 테이블에서 담당업무가 'CLERK' 인 사원의
-- 사번, 이름, 담당업무, 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job = 'CLERK';

-- [문제2] emp 테이블에서 1982년 1월 1일 이후에 입사한
-- 사원의 사번, 이름, 담당업무, 급여, 입사일자를 화면에
-- 보여주세요.
select empno, ename, job, sal, hiredate
from emp
where hiredate >= '82/01/01';

-- [문제3] emp 테이블에서 급여가 1300 ~ 1500 사이인 사원의
-- 이름과 담당업무, 급여, 부서번호를 화면에 보여주세요.
select ename, job, sal, deptno
from emp
-- where sal >= 1300 and sal <=1500;
where sal between 1300 and 1500;

-- [문제4] emp 테이블에서 사번이 7902, 7788, 7566 인 사원의
-- 사번, 이름, 담당업무를 화면에 보여주세요.
select empno, ename, job
from emp
-- where empno = 7902 or empno = 7788 or empno = 7566;
where empno in(7902, 7788, 7566);

-- [문제5] emp 테이블에서 보너스가 300이거나 500이거나
-- 1400인 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
-- where comm = 300 or comm = 500 or comm = 1400;
where comm in (300, 500, 1400);

-- [문제6] member10 테이블에서 이름이 홍길동이면서 직업이
-- 학생인 회원의 모든 정보를 화면에 보여주세요..
select *
from member10
where memname = '홍길동' and job = '학생';

-- [문제7] products 테이블에서 제조사가 '삼성' 또는 '현대'
-- 이면서 입고가가 100만원 이하인 상품의 상품명과 입고가,
-- 출고가를 화면에 보여주세요.
select products_name, input_price, output_price
from products
where company in ('삼성', '현대') and input_price <= 1000000;

-- [문제8] emp 테이블에서 급여가 1100 이상이고, 담당업무가
-- 'MANAGER' 인 사원의 사번, 이름, 담당업무, 급여를 화면에
-- 보여주세요..
select empno, ename, job, sal
from emp
where sal >= 1100 and job = 'MANAGER';



-- ★★★★★★★★★★★★★★★
-- like 키워드 : 검색을 하는 키워드

-- 1) where ename like '%S%'
--    ==> ename 컬럼에 S자를 포함하는 사원의 이름을 검색.

-- 2) where ename like 'S%'
--    ==> ename 컬럼에 첫글자가 S자로 시작하는 사원의 이름을 검색.

-- 3) where ename like '%S'
--    ==> ename 컬럼에 마지막 글자가 S자로 끝나는 사원의 이름을 검색.

-- 4) where ename like '_S%'
--    ==> ename 컬럼에 두번째 글자가 S자가 들어가는 사원의 이름을 검색.

-- emp 테이블에서 사원명에 A라는 글자를 포함하는 사원의
-- 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '%A%';

-- [문제1] emp 테이블에서 사원명에 M이라는 글자를 포함하는
-- 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '%M%';

-- [문제2] emp 테이블에서 사원명의 두번째 글자에 'I'라는
-- 글자를 포함하는 사원의 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '_I%';

-- [문제3] emp 테이블에서 이름이 'S'자로 끝나는 사원의
-- 사번과 이름, 담당업무, 부서번호를 화면에 보여주세요.
select empno, ename, job, deptno
from emp
where ename like '%S';

-- [문제4] emp 테이블에서 이름의 세번째 글자가 'R'이
-- 들어가는 사원의 이름과 담당업무, 급여를 화면에 보여주세요.
select ename, job, sal
from emp
where ename like '__R%';

-- [문제5] emp 테이블에서 이름의 두번째 글자가 'O'인 사원의
-- 모든 정보를 화면에 보여주세요.
select *
from emp
where ename like '_O%';

-- [문제6] emp 테이블에서 입사년도가 82년도인 사원의 사번,
-- 이름, 담당업무, 입사일자를 화면에 보여주세요.
select empno, ename, job, hiredate
from emp
where hiredate like '82%';

-- [문제7] member10 테이블에서 성이 '김' 씨인 회원의
-- 모든 정보를 화면에 보여주세요.
select *
from member10
where memname like '김%';

-- [문제8] member10 테이블에서 주소에 '서울시' 가 들어가는 
-- 회원의 이름, 주소, 직업을 화면에 보여주세요.
select memname, addr, job
from member10
where addr like '%서울시%';

-- [문제9] products 테이블에서 제품명에 '에어컨'을 포함하는
-- 제품의 제품명, 입고가, 출고가, 제조사를 화면에 보여주세요.
select products_name, input_price, output_price, company
from products
where products_name like '%에어컨%';



/*
  ★★★★★★★★★★★★★★★
  order by 절
  - 자료를 정렬하여 나타낼 때 사용하는 명령문.
  - order by 절을 사용할 때는 select 구문의 맨 마지막에
    위치해야 함. 
  - asc : 오름차순 정렬
  - desc : 내림차순 정렬
  - 기본적으로 order by 절을 사용 시에는 오름차순 정렬이 default임.
  - 오름차순 정렬인 경우에는 asc를 생략해도 됨.
*/

-- member10 테이블에서 이름을 기준으로 오름차순으로 정렬하여 모든 
-- 정보를 화면에 보여주세요.
-- 단, 이름이 같은 경우에는 나이를 기준으로 내림차순 정렬
select *
from member10
order by memname, age desc;


-- [문제1] emp 테이블에서 부서번호를 기준으로 오름차순
-- 정렬을 하고, 부서번호가 같은 경우 급여를 기준으로
-- 내림차순으로 정렬을 하여 화면에 보여주세요.
select *
from emp
order by deptno, sal desc;


-- [문제2] products 테이블에서 판매가격을 기준으로 
-- 내림차순으로 정렬하여 모든 정보를 화면에 보여주세요.
select *
from products
order by output_price desc;

-- [문제3] products 테이블에서 배송비를 기준으로 
-- 내림차순으로 정렬하세요. 단, 배송비가 같은 경우 
-- 마일리지를 기준으로 내림차순으로 정렬하여 모든 정보를
-- 화면에 보여주세요.
select *
from products
order by trans_cost desc, mileage desc;

-- [문제4] emp 테이블에서 입사일자가 오래된 사원부터
-- 최근에 입사한 사원을 기준으로 정렬을 하되, 사원명,
-- 입사일자를 화면에 보여주세요.
select ename, hiredate
from emp
order by hiredate asc;

-- [문제5] emp 테이블에서 급여를 기준으로 내림차순으로 
-- 정렬을 하여 모든 정보를 화면에 보여주세요.
select * 
from emp
order by sal desc;

-- [문제6] emp 테이블에서 급여가 1100 이상인 사원들의
-- 정보를 보여주되, 입사일자가 빠른 순으로 정렬하여
-- 화면에 보여주세요.
select *
from emp
where sal >= 1100
order by hiredate asc;

-- [문제7] emp 테이블에서 부서번호를 기준으로 오름차순
-- 정렬하여 나타내고, 부서번호가 같은 경우 담당업무를
-- 오름차순으로 정렬하세요. 만약 담당업무가 같다고 하면,
-- 급여가 많은데서 적은 순으로 정렬하여 모든 정보를
-- 화면에 보여주세요.
select *
from emp
order by deptno asc, job asc, sal desc;


-- not 키워드 : 부정
-- 쿼리문 작성시 부정은 일단 긍정의 쿼리문을 작성 후에
-- 부정의 의미인 not을 붙여주면 됨.

-- emp 테이블에서 담당업무가 'MANAGER', 'CLERK',
-- 'ANALYST' 가 아닌 사원의 사번, 이름, 담당업무,
-- 급여를 화면에 보여주세요.
select empno, ename, job, sal
from emp
where job not in ('MANAGER', 'CLERK', 'ANALYST');

-- [문제1] emp 테이블에서 이름에 'S'자가 들어가지 않는
-- 사원의 이름과 담당업무를 화면에 보여주세요.
select ename, job
from emp
where ename not like '%S%';

-- [문제2] emp 테이블에서 부서번호가 10번 부서가 아닌
-- 사원의 이름, 담당업무, 부서번호를 화면에 보여주세요.
select ename, job, deptno
from emp
-- where not deptno = 10;
-- where deptno != 10;
where deptno <> 10;

-- [문제3] member10 테이블에서 주소가 '서울시' 가 아닌
-- 회원의 모든 정보를 화면에 보여주세요.
select *
from member10
where addr not like '%서울시%';

-- [문제4] products 테이블에서 출고가가 100만원 미만이
-- 아닌 제품의 제품명과 출고가를 화면에 보여주세요.
select products_name, output_price
from products
where not output_price < 1000000;

-- [문제5] emp 테이블에서 보너스가 null 이 아닌 사원의
-- 모든 정보를 화면에 보여주세요.
select *
from emp
where comm is not null;


/*
  ★★★★★★★★★★★★★★★★★★★★★
  
  - 사용자 계정을 만드는 방법
  - create user user명 identified by 비밀번호;
  
  - 만들어진 계정을 사용하기 위한 명령어.
  - grant connect, resource to user명;
  
  - role : 사용자에게 보다 효율적으로 권한을 부여할 수
           있도록 여러 개의 권한을 묶어 놓은 것을 말함.
           
  - connect role
    ==> 오라클에 접속할 수 있는 세션 생성 및
        사용자가 데이터베이스에 접속이 가능하도록
        하기 위해서 가장 기본적인 시스템 권한
        8가지를 묶어 놓은 것을 말함.
  
  - resource role
    ==> 사용자가 테이블을 생성할 수 있도록 하기 위해서
        시스템 권한을 묶어 놓을 것을 말함.
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
-- 화면에 보여주세요.
select count(*) from emp;

-- [문제1] emp 테이블에서 관리자(mgr)의 수를
-- 화면에 보여주세요.
select count(distinct mgr) 
from emp;

-- [문제2] emp 테이블에서 보너스를 가진 사원의 수를
-- 화면에 보여주세요.
select count(comm)
from emp;

-- [문제3] emp 테이블에서 모든 SALESMAN의 급여 평균과
-- 급여 최고액, 급여 최소액, 급여 합계액을 화면에 보여주세요.
select avg(sal), max(sal), min(sal), sum(sal)
from emp
where job = 'SALESMAN';

-- [문제4] emp 테이블에서 등록되어 있는 사원의 총 수,
-- 보너스가 null이 아닌 사원 수, 보너스의 평균, 등록되어
-- 있는 부서의 수를 화면에 보여주세요.
select count(*), count(comm), avg(comm), count(distinct deptno)
from emp;





select * from emp;