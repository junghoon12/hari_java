-- �������� ����
-- [����1] emp ���̺��� ��ձ޿����� �� ���� �޴� �����
-- ���, �̸�, ������, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select empno, ename, job, sal, deptno
from emp
where sal < (select avg(sal) from emp);   -- ��� �޿� : �� 2073
  
-- [����2] emp ���̺��� ����� 7521�� ����� �������� ����,
-- ����� 7934�� ����� �޿����� �� ���� �޴� ����� ���, �̸�, 
-- ������, �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where job = (select job from emp where empno = 7521)   -- ������ : SALESMAN
and
sal > (select sal from emp where empno = 7934);        -- 7934 ����� �޿� : 1300

-- [����3] emp ���̺��� �������� 'MANAGER' �� ����� �ּұ޿�����
-- �����鼭, �������� 'CLERK'�� �ƴ� ����� ���, �̸�, ������,
-- �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where sal < (select min(sal) from emp where job = 'MANAGER')  -- MANAGER�� �ּ� �޿� : 2450
and job != 'CLERK';

-- [����4] �μ���ġ�� 'DALLAS' �� ����� ���, �̸�, �μ���ȣ, 
-- �������� ȭ�鿡 �����ּ���.
select empno, ename, deptno, job
from emp
where deptno = (select deptno from dept where loc = 'DALLAS');  -- DALLAS �μ���ȣ : 20

-- [����5] member ���̺� �ִ� ���� ���� �� ���ϸ����� ���� ����
-- ���� ��� ������ ȭ�鿡 �����ּ���.
select *
from member
where mileage = (select max(mileage) from member);   -- �ִ� ���ϸ��� : 10,000

-- [����6] emp ���̺��� 'SMITH' �� ������� �� ���� �޿���
-- �޴� ����� �̸���, �޿��� ȭ�鿡 �����ּ���.
select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');    -- SMITH ��� �޿� : 800

-- [����7] emp ���̺��� 10�� �μ� �޿��� ��� �޿����� ���� �޿��� �޴�
-- ������� �̸�, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select ename, sal, deptno
from emp
where sal < (select avg(sal) from emp where deptno = 10);  -- 10�� �μ� ��ձ޿� : �� 2916 

-- [����8] emp ���̺��� 'BLAKE'�� ���� �μ��� �ִ� �������
-- �̸��� �Ի�����, �μ���ȣ�� ȭ�鿡 �����ֵ�, 'BLAKE' �� �����ϰ�
-- ȭ�鿡 �����ּ���.
select ename, hiredate, deptno
from emp
where deptno = (select deptno from emp where ename = 'BLAKE')
and ename != 'BLAKE';                                      -- BLAKE �μ���ȣ : 30

-- [����9] emp ���̺��� ��ձ޿����� �� ���� �޴� ������� ���,
-- �̸�, �޿��� ȭ�鿡 �����ֵ�, �޿��� �������� ���� ������ ȭ�鿡 
-- �����ּ���.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)
order by sal desc;                                        -- EMP ���̺� ��� �޿� : �� 2073

-- [����10] emp ���̺��� �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ���
-- �ٹ��ϰ� �ִ� ����� ����� �̸�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select empno, ename, deptno
from emp
where deptno in(select distinct deptno from emp where ename like '%T%');

-- [����11] 'SALES' �μ����� �ٹ��ϰ� �ִ� ������� �μ���ȣ,
-- �̸�, �������� ȭ�鿡 �����ּ���.
select deptno, ename, job
from emp
where deptno = (select deptno from dept where dname = 'SALES');  -- SALES �μ��� �ش��ϴºμ���ȣ : 30

-- [����12] emp ���̺��� 'KING'���� �����ϴ� ��� �����
-- �̸��� �޿�, �����ڸ� ȭ�鿡 �����ּ���.
select ename, sal, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');

-- [����13] emp ���̺��� �ڽ��� �޿��� ��ձ޿����� ����, �̸���
-- 'S' �ڰ� ���� ����� ������ �μ����� �ٹ��ϴ� ��� ����� 
-- ���, �̸�, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select empno, ename, sal, deptno
from emp
where sal > (select avg(sal) from emp)  -- ��ձ޿� : �� 2073
and
deptno in(select distinct deptno from emp where ename like '%S%');

-- [����14] emp ���̺��� ���ʽ��� �޴� ����� �μ���ȣ, �޿��� ����
-- ����� �̸�, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select ename, sal, deptno
from emp
where deptno in(select deptno from emp where comm > 0)  -- 30�� �μ�
and
sal in(select sal from emp where comm > 0);

-- [����15] products ���̺��� ��ǰ�� �ǸŰ����� �ǸŰ�����
-- ��պ��� ū ��ǰ�� ��ü ������ ȭ�鿡 �����ּ���.
select *
from products
where output_price > (select avg(output_price) from products);  -- �ǸŰ��� �� : 1,253,800��

-- [����16] products ���̺� �ִ� �Ǹ� ���ݿ��� ��� ���� �̻���
-- ��ǰ ����� ���ϵ�, ����� ���� �� ������ ���� ū �ݾ��� ��ǰ��
-- �����ϰ� ����� ���Ͽ� ȭ�鿡 �����ּ���.
select *
from products
where output_price >=
(select avg(output_price) from products
where output_price <>
(select max(output_price) from products));  -- �Ǹ� �ִ� ���� : 8,000,000��

-- [����17] products ���̺��� ��ǰ���� �̸��� '������' �̶��
-- �ܾ ���Ե� ī�װ��� ���ϴ� ��ǰ����� ȭ�鿡 �����ּ���.
select *
from products
where category_fk in
(select distinct category_fk from products where products_name like '%������%');

-- [����18] member ���̺� �ִ� �� ���� �� ���ϸ����� ���� ���� 
-- �ݾ��� ������ ������ ���ʽ� ���ϸ��� 5000���� �� �־� ����,
-- ���ϸ���, ���ϸ���+5000 ���� ȭ�鿡 �����ּ���.
select memname, mileage, mileage + 5000 "�߰��� ���ϸ���"
from member
where mileage = (select max(mileage) from member);  -- �ִ� ���ϸ��� : 10,000


/*
  group by ��
  - Ư�� �÷��̳� ���� �������� �ش� ���ڵ带 ��� �ڷḦ ������ �� �����.
  - ������ Ư�� �÷��� �������� ���踦 ���ϴµ� ���� ����� ��.
  - ���� �׷��Լ��� �Բ� ����ϸ� ȿ�������� Ȱ���� ������.
*/

select distinct deptno
from emp
order by deptno;


select deptno
from emp
group by deptno;

-- emp ���̺��� �μ����� �ش� �μ���
-- �ο��� Ȯ���ϰ� ���� ���
select deptno, count(*)
from emp
group by deptno;

-- emp ���̺��� �� �μ����� �μ� ������
-- �޿� �հ���� ���Ͽ� ȭ�鿡 �����ּ���.
select deptno, sum(sal)
from emp
group by deptno
order by sum(sal) desc;

-- [����] emp ���̺��� �μ����� �׷��� ��� �μ��� �޿� �հ��
-- �μ��� �ο� ��, �μ��� ��� �޿�, �μ��� �ִ� �޿�, �μ��� �ּ� �޿���
-- ���Ͽ� ȭ�鿡 �����ּ���.
-- ��, �޿� �հ踦 �������� ������������ �����Ͽ� ȭ�鿡 �����ּ���.
select deptno, sum(sal), count(*), avg(sal), max(sal), min(sal)
from emp
group by deptno
order by sum(sal) desc;


/*
  having ��
  - group by �� ������ ���� ������.
  - group by ���� ����� ������ �־ ������ �� �����.
  - group by �� �������� where(������)�� �� �� ����.
*/

-- products ���̺��� ī�װ� ����
-- ��ǰ�� ������ ȭ�鿡 �����ּ���.
select category_fk, count(*)
from products
group by category_fk
having count(*) >= 2;


/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  View
  - �������� ���̺� �ٰ��� ������ ������ ���̺��� ����.
  - View �� ���������� �����͸� �����ϰ� ���� ����.
  - View�� ����� �����ͺ��̽��� ���� �� ���� ���̺� �����Ͽ�
    �����͸� �ҷ����� ��.
  - �����ϰ� �ʿ��� ����鸸 �����ؼ� ����� �� ���� ����� ��.
  - View �� ���̺�� �����ϸ�, ���̺�ó�� ����� ������.
  - View �� ���̺� �����ϱ� ���� �������� ������ �ʿ䰡 ����.
  - ���̺�� ���������� insert, update, delete ����� ������.
  - ������ �ַ� �����͸� ��ȸ(select) �� �� ���� ���� ����� ��.
  - View �� ����ϴ� ����
    1) ���� ������ ���� �����(�߿�).
       ==> ���� ��޿� ���߾� �÷��� ������ ���ؼ� ��ȸ�� 
           �����ϵ��� �� �� ����.
    2) ������� ���Ǽ��� ������.

    ����)
            create view ���̸�
            as
            ������;
*/


-- ���� ������ ���ؼ� �����(�߿�)
-- �λ�� View
-- �÷��� sal(�޿�), comm(���ʽ�) �÷��� ����
create view emp_insa
as
select empno, ename, job, mgr, hiredate, deptno
from emp;

select * from emp_insa;

-- ������ View
-- �÷��� sal(�޿�) �÷��� ����
create view emp_sales
as
select empno, ename, job, mgr, hiredate, comm, deptno
from emp;

select * from emp_sales;

-- ȸ��� View
-- ��� �÷��� ����.
create view emp_account
as
select * from emp;

select * from emp_account;

insert into emp_account
    values(9000, 'ANGEL', 'SALESMAN', 7698, sysdate, 1300, 100, 30);

-- View �� �б� �������� ����� �����Ͱ� �߰��� �� ��.
-- �б� �������� ����� ���.
-- ==> View �� ���� �� ������ �� �������� with read only ���� �߰�.

create view emp_view1
as
select * from emp
with read only;

insert into emp_view1
    values(9001, '������', 'SALESMAN', 7698, sysdate, 1500, 200, 30);

-- create or replace view
-- ���� �̸��� view�� �ִ� ��쿡�� ������ View�� �����ϰ�
-- ���ο� View�� ������ �ǹ�.
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

-- 2) ������� ���Ǽ��� ������.
create or replace view emp_salary
as
select empno, ename, (sal * 12 + nvl2(comm, comm, 0)) "����"
from emp
with read only;

select * from emp_salary;



-- [����1] �μ����� �μ��� �޿� �հ�, �μ��� �޿� ����� 
-- ���� view�� ����� ȭ�鿡 �����ּ���.
-- ���ǻ���) view�� ���� �� �׷��Լ� ���ÿ��� �ݵ��
--          ��Ī�� ������ �־�� ��.
create or replace view emp_sal
as
select deptno, sum(sal) "�޿��հ�", avg(sal) "�޿����"
from emp
group by deptno
with read only;

select * from emp_sal;


-- [����2] emp ���̺��� �̿��Ͽ� emp_dept20 �̶�� 
-- view�� ����� �ּ���. ��, �μ���ȣ�� 20�� �μ��� ����
-- ������� ���, �̸�, ������, ������, �μ���ȣ�� 
-- ȭ�鿡 �����ֽñ� �ٶ��ϴ�.
create or replace view emp_dept20
as
select empno, ename, job, mgr, deptno
from emp
where deptno = 20
with read only;

select * from emp_dept20;


-- [����3] emp ���̺��� �� �μ��� �ִ�޿��� �ּұ޿���
-- �����ִ� view�� �����, sal_view��� �̸����� �����
-- ȭ�鿡 �����ּ���.
create or replace view sal_view
as
select deptno, max(sal) "�ִ�޿�", min(sal) "�ּұ޿�"
from emp
group by deptno
with read only;

select * from sal_view;


-- [����4] �������� 'SALESMAN' �� ����� ���, �̸�,
-- ������, �Ի���, �μ���ȣ�� �÷����� �ϴ� view�� 
-- �����, emp_sale �̶�� view�� ����� ȭ�鿡 �����ּ���.
create or replace view emp_sale
as
select empno, ename, job, hiredate, deptno
from emp
where job = 'SALESMAN'
with read only;

select * from emp_sale;

-- View �� ���� �� �÷��� ����� ���� ���
-- ������ �� �� ���� �� �Ǵ� ������ �ָ� ��.
create or replace view emp_view2
as
select * from emp
where deptno = 1
with read only;

select * from emp_view2;


/*
  Ʈ�����(Transaction)?
  - ������ ó���� �� ������ ����.
  - ����Ŭ���� �߻��ϴ� ���� ���� SQL ��ɹ�����
    �ϳ��� ������ �۾� ������ ó���ϴ� ���� ����.
  - All or Nothing ������� ó����.
  - ����� ���� ���� ������ ���������� ó���� �Ǹ� �����ϰ�,
    ���� ���� ��ɾ� �߿��� �ϳ��� ����̶� �߸��� �Ǹ�
    ��ü�� ����ϴ� ���� ����. (�߿�)
    
  - Ʈ����� ��� ���� : �������� �ϰ����� �����ϸ鼭
                       �������� �������� �����ϱ� ���� �����.
  - Ʈ����� ��� �� Ʈ������� �����ϱ� ���� ��ɾ�.
    1) commit : ��� �۾��� ���������� ó���ρٴٰ� Ȯ���ϴ� ��ɾ�.
                Ʈ�����(insert, update, delete) �۾��� ������
                ���� DB�� �ݿ�.
                ������ �ִ� �����Ϳ� update ������ �߻��� ��.
                ��� ����ڰ� ����� �������� ����� �� �� ����.
    2) rollback : �۾� �߿� ������ �߻����� �� Ʈ����� ó�� ��������
                  ���� ������ ����Ͽ� ���� ���·� �ǵ����� ��ɾ�.
                  Ʈ�����(insert, update, delete) �۾��� ������ �����.
                  ������ commit �� �������� ������ ��. 
*/

create table dept
as
select * from dept_02;

-- 1. dept ���̺��� �����Ͽ� dept_02 ��� ���̺��� ����� ����.
create table dept_02
as
select * from dept;

select * from dept_02;

-- 2. dept_02 ���̺��� 40�� �μ��� ������ �Ŀ� commit�� �� ����.
delete from dept_02 where deptno = 40;
commit;

-- 3. dept_02 ���̺��� ��ü �����͸� ������ ����.
delete from dept_02;

-- 4. �� �� ���� 20�� �μ��� ���ؼ��� ������ �Ϸ��� �ߴµ�
-- �߸��ؼ� ��ü�� ������ �� ���, �ٽ� ������ �� �� �ִ�.
rollback;

-- 5. 20�� �μ��� �����ϸ� �ȴ�.
delete from dept_02 where deptno = 20;

-- 6. �����ͺ��̽��� �Ϻ��ϰ� ������ ����.
commit;


/*
  savepoint
  - Ʈ������� �۰� �����ϴ� ���� ����.
  - ����ڰ� Ʈ����� �߰� �ܰ迡�� ����Ʈ�� �����Ͽ�
    Ʈ����� ���� Ư�� savepoint���� rollback �� ��
    �ְ� �ϴ� ���� ����.
*/

-- 1. dept ���̺��� �����Ͽ� dept_03 �̶�� ���̺��� ������.
create table dept_03
as
select * from dept;

-- 2. dept_03 ���̺��� 40�� �μ��� ������ �� commit�� �� ����.
delete from dept_03 where deptno = 40;
commit;

-- 3. dept_03 ���̺��� 30�� �μ��� ������ ����.
delete from dept_03 where deptno = 30;

-- 4. �� �� savepoint sp1 �� ������ ����.
savepoint sp1;

-- 5. dept_03 ���̺��� 20�� �μ��� ������ ����.
delete from dept_03 where deptno = 20;

-- 6. �� �� savepoint sp2 �� ������ ����.
savepoint sp2;

-- 7. dept_03 ���̺��� 10�� �μ��� ������ ����.
delete from dept_03 where deptno = 10;

-- 8. �μ���ȣ�� 20���� �μ��� �����ϱ� �ٷ� ������ 
-- �ǵ��ư��� ���� ���.
rollback to sp1;

select * from dept_03;





