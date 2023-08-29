-- [����1] emp ���̺��� �������� 'CLERK' �� �����
--        ���, �̸�, ������, �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where job = 'CLERK';

-- [����2] emp ���̺��� 1982�� 1�� 1�� ���Ŀ� �Ի���
--        ����� ���, �̸�, ������, �޿�, �Ի����ڸ� 
--        ȭ�鿡 �����ּ���.
select empno, ename, job, sal, hiredate
from emp
where hiredate >= '82/01/01';

-- [����3] emp ���̺��� �޿��� 1300 ~ 1500 ������ �����
--        �̸��� ������, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select ename, job, sal, deptno
from emp
-- where sal >= 1300 and sal <= 1500;  -- 1��° ���
where sal between 1300 and 1500;  -- 2��° ���

-- [����4] emp ���̺��� ����� 7902, 7788, 7566 �� �����
--        ���, �̸�, �������� ȭ�鿡 �����ּ���.
select empno, ename, job
from emp
-- where empno = 7902 or empno = 7788 or empno = 7566;  -- 1��° ���
where empno in (7902, 7788, 7566);  -- 2��° ���

-- [����5] emp ���̺��� ���ʽ��� 300�̰ų� 500�̰ų� 1400��
--        ����� ��� ������ ȭ�鿡 �����ּ���.
select *
from emp
-- where comm = 300 or comm = 500 or comm = 1400;  -- 1��° ���
where comm in (300, 500, 1400);

-- [����6] member10 ���̺��� �̸��� ȫ�浿�̸鼭 ������ �л���
--        ȸ���� ��� ������ ȭ�鿡 �����ּ���.
select *
from member10
where memname = 'ȫ�浿' and job = '�л�';

-- [����7] products ���̺��� �����簡 '�Ｚ' �Ǵ� '����' �̸鼭
--        �԰��� 100���� ������ ��ǰ�� ��ǰ��� �԰�, �����
--        ȭ�鿡 �����ּ���.
select products_name, input_price, output_price
from products
where company in('�Ｚ', '����') and input_price <= 1000000; 

-- [����8] emp ���̺��� �޿��� 1100 �̻��̰�, ��������
--        'MANAGER' �� ����� ���, �̸�, ������, �޿���
--        ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where sal >= 1100 and job = 'MANAGER';

/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  like Ű���� : �˻��� �ϴ� Ű����.

  1) where ename like '%S%'
     ==> ename �÷��� S�ڸ� �����ϴ� ��� ����� �̸��� �˻�.
     
  2) where ename like 'S%'
     ==> ename �÷��� ù ���ڰ� S�ڷ� �����ϴ� ��� ����� �̸��� �˻�.
     
  3) where ename like '%S'
     ==> ename �÷��� ������ ���ڰ� S�ڷ� ������ ��� ����� �̸��� �˻�.
  
  4) where ename like '_S%'
     ==> ename �÷��� �ι�° ���ڰ� S�ڰ� ���� ��� ����� �̸��� �˻�.
*/

-- emp ���̺��� ����� A��� ���ڰ� ���ԵǾ� �ִ� �����
-- ��� ������ ȭ�鿡 �����ּ���.
select *
from emp
where ename like '%A%';

-- [����1] emp ���̺��� ����� M�̶�� ���ڸ� �����ϴ�
--        ����� ��� ������ ȭ�鿡 �����ּ���.
select *
from emp
where ename like '%M%';

-- [����2] emp ���̺��� ������� �ι�° ���ڿ� 'I' ���
--        ���ڸ� �����ϴ� ����� ��� ������ ȭ�鿡 �����ּ���.
select *
from emp
where ename like '_I%';

-- [����3] emp ���̺��� �̸��� 'S' �ڷ� ������ �����
--        ����� �̸�, ������, �μ���ȣ�� ȭ�鿡 �����ּ���.
select empno, ename, job, deptno
from emp
where ename like '%S';

-- [����4] emp ���̺��� �̸��� ����° ���ڰ� 'R' ��
--        �� �ִ� ����� �̸��� ������, �޿��� ȭ�鿡 �����ּ���.
select ename, job, sal
from emp
where ename like '__R%';

-- [����5] emp ���̺��� �̸��� �ι�° ���ڰ� 'O' �� �����
--        ��� ������ ȭ�鿡 �����ּ���.
select *
from emp
where ename like '_O%';

-- [����6] emp ���̺��� �Ի�⵵�� 82�⵵�� ����� ���,
--        �̸�, ������, �Ի����ڸ� ȭ�鿡 �����ּ���.
select empno, ename, job, hiredate
from emp
where hiredate like '82%';

-- [����7] member10 ���̺��� ���� '��' ���� ȸ����
--        ��� ������ ȭ�鿡 �����ּ���.
select *
from member10
where memname like '��%';

-- [����8] member10 ���̺��� �ּҿ� '�����' �� ����
--        ȸ���� �̸�, �ּ�, ������ ȭ�鿡 �����ּ���.
select memname, addr, job
from member10
where addr like '%�����%';

-- [����9] products ���̺��� ��ǰ�� '������' �� �����ϴ�
--        ��ǰ�� ��ǰ��, �԰�, ���, �����縦 ȭ�鿡 �����ּ���.
select products_name, input_price, output_price, company
from products
where products_name like '%������%';


/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  order by ��
  - �ڷḦ �����Ͽ� ��Ÿ�� �� ����ϴ� ��ɹ�.
  - order by ���� ����� ���� �ݵ�� select ������ �� �������� ��ġ�ؾ� ��.
    * asc : �������� ����
    * desc : �������� ����
  - �⺻������ order by ���� ��� �ÿ��� �������� ������ default��.
  - �������� ������ ��쿡�� asc ������ �����ص� ��.
*/

-- member10 ���̺��� �̸��� �������� �������� �����Ͽ� ��� ������
-- ȭ�鿡 �����ּ���.
-- ��, �̸��� ���� ��쿡�� ���̸� �������� �������� ����.
select *
from member10
order by memname asc, age desc;

-- [����1] emp ���̺��� �μ���ȣ�� �������� �������� ������ �ϰ�,
--        �μ���ȣ�� ���� ��� �޿��� �������� ������������ ������
--        �Ͽ� ȭ�鿡 �����ּ���.
select *
from emp
order by deptno asc, sal desc;

-- [����2] products ���̺��� �ǸŰ����� �������� ������������
--        �����Ͽ� ��� ������ ȭ�鿡 �����ּ���.
select *
from products
order by output_price desc;

-- [����3] products ���̺��� ��ۺ� �������� ������������
--        �����ϼ���. ��, ��ۺ� ���� ��� ���ϸ����� ��������
--        ������������ �����Ͽ� ��� ������ ȭ�鿡 �����ּ���.
select *
from products
order by trans_cost desc, mileage desc;

-- [����4] emp ���̺��� �Ի����ڰ� ������ ������� �ֱٿ� �Ի���
--        ����� �������� ������ �ϵ�, �����, �Ի����ڸ� ȭ�鿡 
--        �����ּ���.
select ename, hiredate
from emp
order by hiredate asc;

-- [����5] emp ���̺��� �޿��� �������� ������������ ������ �Ͽ�
--        �����ȣ, �����, ������, �޿� ������ ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
order by sal desc;

-- [����6] emp ���̺��� �޿��� 1100 �̻��� ������� ������ �����ֵ�,
--        �Ի����ڰ� ���� ������ �����Ͽ� ȭ�鿡 �����ּ���.
select *
from emp
where sal >= 1100
order by hiredate asc;

-- [����7] emp ���̺��� �μ���ȣ�� �������� �������� ������ �Ͽ� 
--        �����ְ�, �μ���ȣ�� ���� ��� �������� ������������ �����ϼ���.
--        ����, �������� ���ٰ� �ϸ� �޿��� �������� ���� ������
--        ������ �Ͽ� ��� ������ ȭ�鿡 �����ּ���.
select *
from emp
order by deptno asc, job asc, sal desc;


/*
  not Ű���� : ����
  - ������ �ۼ� �� ������ �ϴ� ������ �������� �ۼ��� ����.
  - �׷� ������ ������ �ǹ��� not�� �ٿ��ָ� ��.
*/

-- emp ���̺��� �������� 'MANAGER', 'CLERK',
-- 'ANALYST' �� �ƴ� ����� ���, �̸�, ������, �޿���
-- ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where job not in ('MANAGER', 'CLERK', 'ANALYST');

-- [����1] emp ���̺��� �̸��� 'S' �ڰ� ���� �ʴ�
--        ����� �̸��� �������� ȭ�鿡 �����ּ���.
select ename, job
from emp
where ename not like '%S%';

-- [����2] emp ���̺��� �μ���ȣ�� 10�� �μ��� �ƴ�
--        ����� �̸�, ������, �μ���ȣ�� ȭ�鿡 �����ּ���.
select ename, job, deptno
from emp
-- where deptno != 10;  -- ù��° ���
where deptno <> 10;     -- �ι�° ���

-- [����3] member10 ���̺��� �ּҰ� '�����' �� �ƴ�
--        ȸ���� ��� ������ ȭ�鿡 �����ּ���.
select *
from member10
where addr not like '%�����%';

-- [����4] products ���̺��� ����� 100���� �̸��� �ƴ�
--        ��ǰ�� ��ǰ��� ����� ȭ�鿡 �����ּ���.
select products_name, output_price
from products
where not output_price < 1000000;

-- [����5] emp ���̺��� ���ʽ��� null �� �ƴ� �����
--        ��� ������ ȭ�鿡 �����ּ���.
select *
from emp
where comm is not null;

/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  
  - ����� ������ ����� ���
    create user ����ڸ� identified by ��й�ȣ;

  - ������� ����� ������ ����ϱ� ���� ��ɾ�.
    grant connect, resource to ����ڸ�;
    
  - role : ����ڿ��� ���� ȿ�������� ������ �ο��� �� �ֵ���
           ���� ���� ������ ���� ���� ���� ����.
    * connect role
      ==> ����Ŭ�� ������ �� �ִ� ���� ���� �� ����ڰ�
          �����ͺ��̽��� ������ �����ϵ��� �ϱ� ���ؼ�
          ���� �⺻���� �ý��� ���� 8������ ���� ���� ���� ����.
          
    * resource role
      ==> ����ڰ� ���̺��� ������ �� �ֵ��� �ϱ� ���ؼ�
          �ý��� ������ ���� ���� ���� ����.
          ���� insert, update, delete ������ ����� ��
          �ִ� ������ ���� ���� ���� ����.
*/

create user zzang identified by 1234;

/*
  �׷��Լ�
  ==> ���� �� �Ǵ� ���̺� ��ü�� ���� �Լ��� ����Ǿ�
      �ϳ��� ������� �������� �Լ�.

  1) avg() : ��հ��� ���ϴ� �Լ�.
  2) count() : ��(���ڵ�)�� ������ ���ϴ� �Լ�.
               ==> null ���� �����ϰ� ���� ������ ����.
  3) max() : �ִ밪�� ���ϴ� �Լ�.
  4) min() : �ּҰ��� ���ϴ� �Լ�.
  5) sum() : �� ���� ���ϴ� �Լ�.
*/

-- emp ���̺��� ����� ������ �ִ� ��� ����� ���� ȭ�鿡 �����ּ���.
select count(*) 
from emp;

-- [����1] emp ���̺��� ������(mgr)�� ���� ȭ�鿡 �����ּ���.
select count(distinct mgr)
from emp;

-- [����2] emp ���̺��� ���ʽ��� ���� ����� ���� ȭ�鿡 �����ּ���.
select count(comm)
from emp;

-- [����3] emp ���̺��� ��� SALESMAN�� �޿� ��հ� �޿� �ְ��,
--   �޿� �ּҾ�, �޿� �հ���� ���Ͽ� ȭ�鿡 �����ּ���.
select avg(sal), max(sal), min(sal), sum(sal)
from emp
where job = 'SALESMAN';

-- [����4] emp ���̺��� ��ϵǾ� �ִ� ����� �� ��, ���ʽ��� null ��
--        �ƴ� ����� ��, ���ʽ��� ���, ��ϵǾ� �ִ� �μ��� ���� 
--        ȭ�鿡 �����ּ���.
select count(*), count(comm), avg(comm), count(distinct deptno)
from emp;


/*
  dual ���̺�
  - ����Ŭ���� ��ü������ ������ �ִ� ���̺�.
  - �����ϰ� �Լ��� �̿��ؼ� ���, ������� Ȯ���� �� ����ϴ� ���̺�.
  - ���� �� ��, �� �÷� ���� ��� �ִ� ���̺�.
  - ��� �뵵 : Ư�� ���̺��� ������ �ʿ� ���� �Լ� �Ǵ� �����
               �ϰ��� �� �� ����� ��.
*/

-- ����Ŭ���� ������ �ִ� �Լ���
-- 1. ��¥�� ���õ� �Լ���
--    1) sysdate : ���� �ý����� ��¥�� ���� ��.
select sysdate from dual;

--    2) add_months(���� ��¥, ����(���� ��))
--       : ���� ��¥���� ���� ���� ���� �ִ� �Լ�.
select add_months(sysdate, 3) from dual;

--    3) next_day(���� ��¥, '����')
--       : �ٰ��� ��¥(����)�� ���� �ִ� �Լ�.
select next_day(sysdate, '������') from dual;

--    4) to_char(��¥, '��¥����')
--       : ���Ŀ� �°� ���ڿ��� ��¥�� ����� �ִ� �Լ�.
select to_char(sysdate, 'yyyy/mm/dd') from dual;
select to_char(sysdate, 'yyyy-mm-dd') from dual;
select to_char(sysdate, 'mm-dd-yyyy') from dual;

--    5) months_between('������ ��¥', ���� ��¥)
--       : �� ��¥ ������ ���� ���� ����� �ִ� �Լ�.
select months_between('23/12/16', sysdate) from dual;

--    6) last_day()
--       : �־��� ��¥�� ���� ���� ������ ��¥�� ��ȯ�� �ִ� �Լ�.
select last_day(sysdate) from dual;


-- 2. ���ڿ� ���õ� �Լ���
--    1) concat('���ڿ�1', '���ڿ�2')
--       : ���ڿ��� ����(����)�� �ִ� �Լ�.
select concat('�ȳ�', '�ϼ���!!!') from dual;

--    2) upper()
--       : �ҹ��ڸ� �빮�ڷ� �ٲپ� �ִ� �Լ�.
select upper('happy day') from dual;

--    3) lower()
--       : �빮�ڸ� �ҹ��ڷ� �ٲپ� �ִ� �Լ�.
select lower(upper('happy day!!!')) from dual;

--    4) substr('���ڿ�', x, y)
--       : ���ڿ��� x���� y�� ���̸�ŭ ������ �ִ� �Լ�.
select substr('ABCDEFG', 3, 2) from dual;    -- CD

--       x�� ���� ������ ��쿡�� �����ʺ��� ������ �ȴ�.
select substr('ABCDEFG', -3, 2) from dual;   -- EF

--    5) �ڸ����� �÷� �ִ� �Լ�.
--       5-1) lpad('���ڿ�', '��ü�ڸ���' '�þ �ڸ����� �� ���ڿ�')
--            ==> ���� �ڸ����� �÷� �ִ� �Լ�.
select lpad('ABCDEFG', 15, '*') from dual;

--       5-2) rpad('���ڿ�', '��ü�ڸ���' '�þ �ڸ����� �� ���ڿ�')
--            ==> ������ �ڸ����� �÷� �ִ� �Լ�.
select rpad('ABCDEFG', 15, '*') from dual;

--    6) ���ڸ� ���� �ִ� �Լ�.
--       6-1) ltrim('���ڿ�', '������ ����');
--            : ���� ���ڸ� �����ϴ� �Լ�.
select ltrim('ABCDEFGA', 'A') from dual;

--       6-2) rtrim('���ڿ�', '������ ����');
--            : ������ ���ڸ� �����ϴ� �Լ�.
select  rtrim('ABCDEFGA', 'A') from dual;

--    7) replace()
--       : ���ڿ��� ��ü�� �ִ� �Լ�.
--         ����) replace('���� ���ڿ�', '��ü�� ���ڿ�', '���ο� ���ڿ�');
select replace('JAVA Program', 'JAVA', 'Spring') from dual;


-- [����1] emp ���̺��� ����� �Ʒ��� ���� ��������
--        ȭ�鿡 �����ּ���.
--        ���) 'SCOTT�� �������� ANALYST �Դϴ�.'
--        (��, concat() �Լ��� �̿��ϼ���)
select concat(concat(ename, '�� �������� '), 
        concat(job, ' �Դϴ�.'))
from emp;

-- [����2] emp ���̺��� ����� �Ʒ��� ���� ��������
--        ȭ�鿡 �����ּ���.
--        ���) 'SCOTT�� ������ 36000 �Դϴ�'
--        (��, concat() �Լ��� �̿��ϼ���)
select concat(concat(ename, '�� ������ '), 
        concat(sal * 12, ' �Դϴ�.'))
from emp;

-- [����3] member10 ���̺��� ����� �Ʒ��� ���� ��������
--        ȭ�鿡 �����ּ���.
--        ���) 'ȫ�浿 ȸ���� ������ �л��Դϴ�.'
--        (��, concat() �Լ��� �̿��ϼ���)
select concat(concat(memname, '�� ������ '), 
        concat(job, ' �Դϴ�.'))
from member10;

-- [����4] emp ���̺��� ���, �̸�, �������� ȭ�鿡 �����ּ���.
--        ��, �������� �ҹ��ڷ� �����Ͽ� �����ּ���.
select empno, ename, lower(job)
from emp;

-- [����5] ���� ���� �ֹε�� ��ȣ �߿��� ��������� �����Ͽ�
--        ȭ�鿡 ���� �ּ���.
select substr('881212-1234567', 1, 6)
from dual;

-- [����6] emp ���̺��� �������� 'A' ��� ���ڸ� '$' �� �ٲپ�
--        ȭ�鿡 ���� �ּ���.
select replace(job, 'A', '$') 
from emp;

-- [����7] member10 ���̺��� ������ '�л�'�� ������ '���л�'���� �ٲپ�
--        ȭ�鿡 ���� �ּ���.
select replace(job, '�л�', '���л�')
from member10;

-- [����8] member10 ���̺��� �ּҿ� '�����' �� �� ������ '����Ư����'
--        �� �ٲپ� ȭ�鿡 ���� �ּ���.
select replace(addr, '�����', '����Ư����')
from member10;


-- 3. ���ڿ� ���õ� �Լ���
--    1) abs(����) : ���밪�� ���� �ִ� �Լ�.
select abs(23) from dual;
select abs(-23) from dual;

--    2) sign(����) : ���(1), ����(-1), 0�� ��ȯ�� �ִ� �Լ�.
select sign(15) from dual;
select sign(15), sign(-15), sign(0) from dual;

--    3) round(�Ǽ�) : �ݿø��� �� �ִ� �Լ�.
select round(1234.5678) from dual;  -- 1235

--       �ݿø��� �� �� �ڸ����� ����
--       ����) round([����(�ʼ�)], [�ݿø� ��ġ(����)])
--            ==> ���� ���� �����ϸ� �ڿ���(����)������ ���ڸ���
--                ���� �ݿø��� �� �ش�.
select round(0.1234567, 6) from dual;  -- 0.123457

select round(2.3423557, 4) from dual;  -- 2.3424

select round(1236.5678, -2) from dual;  -- 1200

--    4) trunc() : �Ҽ��� ���� �ڸ����� �߶󳻴� �Լ�.
--       ����) trunc([����(�ʼ�)], [������ġ(����)])
select trunc(1234.1234567, 0) from dual;  -- 1234

select trunc(1234.1234567, 4) from dual;  -- 1234.1234

select trunc(1234.1234567, -2) from dual;  -- 1200

--    5) ceil() : ������ �ø��� �� �ִ� �Լ�.
select ceil(22.8) from dual;  -- 23

select ceil(22.1) from dual;  -- 23

--    6) power() : ������ ���� �ִ� �Լ�.
select power(4, 3) from dual;  -- 64

--    7) mod() : �������� ���� �ִ� �Լ�.
--       ����) mod([�������� ����(�ʼ�)], [���� ����(�ʼ�)])
select mod(77, 4) from dual;

--    8) sqrt() : �������� ���� �ִ� �Լ�.
select sqrt(16) from dual;


/*
  ���� ����
  - ���̺� �������� �ڷᰡ �ԷµǴ� ���� �����ϱ� ���ؼ�
    ���̺��� ������ �� �� �÷��� ���ؼ� �����ϴ� ���� ����
    ��Ģ�� ���� ���� ����.
    
  1) not null
  2) unique
  3) primary key : not null + unique
  4) foreign key
  5) check
*/

/*
  1) not null ���� ����
     - null ���� �Էµ��� ���ϰ� �ϴ� ���� ����.
     - Ư�� ���� �������� �ߺ� ���οʹ� ��� ���� 
       null ���� ������� �ʴ� ���� ����.
*/

create table null_test(
    col1 varchar2(10) not null,
    col2 varchar2(10) not null,
    col3 varchar2(10)
);

insert into null_test values('aa', 'aa1', 'aa2');

insert into null_test(col1, col2) values('bb', 'bb1');

insert into null_test(col1, col2) values('bb', '');  -- error �߻�

/*
  2) unique ���� ����
     - ���� ������ �������� �ߺ��� ������� �ʰ��� �� �� 
       ����ϴ� ���� ����.
     - null ���� �����.
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
    values('bb', 'aa1', 'bbb1', 'bbbb1');  -- error �߻�

/*
  3) primary key ���� ����
     - unique + not null ���� ����
     - ���̺� �ϳ��� �����ؾ� ��.
     - ������ �ֹι�ȣ�� emp ���̺��� empno(�����ȣ) ����
       primary key�� ��ǥ���� ��
*/

/*
  4) foreign key ���� ����
     - �ٸ� ���̺��� �ʵ�(�÷�)�� �����ؼ� ���Ἲ�� �˻��ϴ� ���� ����.
     - ���� Ű : �θ� ���̺��� �÷��� �̾߱� ��.
     - �ܷ� Ű : �ڽ� ���̺��� �÷��� �̾߱� ��.
     - �ڽ� ���̺��� �÷��� ��(������)�� �θ� ���̺� ���� ���
       ���Ἲ ��Ģ�� ���� ����.
     - �ܷ� Ű�� �����ϱ� ���ؼ��� �켱������ �θ� ���̺��� ����
       ��������� ��.
     - �ɼ�
       * on delete cascade
         ==> �θ� ���̺��� ������ ���� �� �ش� �����͸� �����ϰ�
             �ִ� �ڽ� ���̺��� �����ͱ��� �����ϴ� �ɼ�
       * on detete set null
         ==> �θ� ���̺��� ������ ���� �� �ش� �����͸� �����ϰ�
             �ִ� �ڽ� ���̺��� �÷� ���� null�� �����ϴ� �ɼ�
*/

create table foreign_test(
    bunho number(5),
    name1 varchar2(30) not null,
    job varchar2(100) not null,
    -- deptno number(2) references dept(deptno) -- �÷��� �ܷ�Ű ���� ����
    deptno number(2),
    primary key(bunho),
    constraint dept_fk foreign key(deptno)
        references dept(deptno)                 -- ���̺� �� �ܷ�Ű ���� ����
);

insert into foreign_test values(1111, 'ȫ�浿', '�������', 30);

insert into foreign_test values(2222, '������', '�������', 10);

insert into foreign_test values(3333, '������', 'IT���', 50);   -- error �߻�


/*
  5) check ���� ����
     - ���� ������ �� �ִ� ���� ���� �Ǵ� ������ ������ ��
       ���Ǵ� ���� ����.
*/

create table check_test(
    gender varchar2(6),
    constraint gender_chk check(gender in('����', '����'))
);

insert into check_test values('����');

insert into check_test values('����');

insert into check_test values('��');  -- error �߻�



select * from emp;