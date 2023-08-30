/*
  ������(sequence)
  ==> ������ �ο��� �� ����ϴ� ����.
      �������� ��ȣ�� ����� �ִ� ����� ��.
      
  ����)
        create sequence �������̸�
        start with n(���۹�ȣ ���� - �⺻������ �⺻���� 1)
        increment by n(�����Ǵ� ��ȣ ���� - �⺻������ �⺻���� 1)
        maxvalue n(������ �ִ� ��ȣ ����)
        minvalue n(������ �ּ� ��ȣ ����)
        cache / nocache(ĳ�� �޸� ��� ����)
        
        1) cache : �������� ������ �����ϱ� ���Ͽ� �̸� ĳ�� �޸𸮿�
                   �������� �־� �ΰ� �غ��ϰ� �ִٰ� ������ �۾���
                   �ʿ��� �� ����� ��.
                   drfault �δ� 20���� �������� ĳ�� �޸𸮿� ������ ��.
        2) nocache : cache ����� ������� �ʰڴٴ� �ǹ�.
*/

-- memo ��� ���̺��� ����� ����.
create table memo(
    bunho number(5),
    title varchar2(100) not null,
    writer varchar2(50) not null,
    content varchar2(1000) not null,
    regdate date,
    primary key(bunho)  -- ���̺� �󿡼� ���� ���� ����
);

-- memo ���̺� ��� �� ����� �������� ����� ����.
create sequence memo_seq
start with 1
increment by 1;



-- memo ���̺� �����͸� ������ ����.
insert into memo 
    values(memo_seq.nextval, '�޸�1', 'ȫ�浿', '�浿�� �޸�', sysdate);

insert into memo 
    values(memo_seq.nextval, '�ι�° �޸�', '�������', '��� �޸�', sysdate);
    

/*
  join ~ on Ű����
  - ���̺�� ���̺��� �����Ͽ� Ư���� �����͸� ����� �� �� �����.
  - �� �� �̻��� ���̺� ������ �������� ���� �� �����.
  - �ߺ��ؼ� �����Ͱ� ����Ǵ� ���� ���� ����.
  - �� ���� ���̺�� �������� ��쿡�� �������� �ߺ��� �߻����� ������
    ���ϴ� ������ �������� ���� �� ���Ǹ� �ؾ� �ϴ� �������� �߻���.
  - Ư�� ����� �Ҽӵ� �μ��� �μ����� �˰� ���� ��쿡�� emp ���̺��
    dept ���̺��� �ѳ���� �۾��� ����Ƿ� �ſ� ������. �׷��� �� ����
    ���̺��� �����ؼ� ���ϴ� ����� �� �� �ֵ��� �ϴ� �����̶��
    ����� ���ܳ��� ��.
    
    ������ ����
    1) Cross Join
    2) Equi Join  -- ���� ���� ���Ǵ� Join
    3) Self Join
    4) Outer Join
*/

/*
  1) Cross Join
     - �� �� �̻��� ���̺��� ���ε� �� ������ ���� ���̺���
       ������ �̷������ ����.
     - ���̺� ��ȣ���� ����� �� �ִ� ��� ����� ���� �����Ͽ�
       ��Ÿ���� ������.
       �׷��� ������ ���̺� ��ü ���� �÷��� ������ ��. 
     - ����� ����� �� �ϴ� ������.
*/

select *
from emp, dept;


/*
  2) Equi Join
     - ���� ���� ���Ǵ� ���� ���.
     - ������ ����� �Ǵ� �� ���̺��� ���������� �����ϴ� �÷���
       ���� ��ġ�Ǵ� ���� �����Ͽ� ����� �����ϴ� ���.
     - �� ���̺��� ������ �Ϸ��� ��ġ�Ǵ� ���� �÷��� ����ؾ� ��.
*/

-- emp ���̺��� ����� ���, �̸�, ������, �μ���ȣ ��
-- �μ���, �ٹ���ġ�� ȭ�鿡 �����ּ���.
-- ==> emp ���̺�� dept ���̺��� �����ؾ߸� ���ϴ� ������ ���� �� ����.

select empno, ename, job, e.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno;

-- emp ���̺��� ������� 'SCOTT' �� ����� �μ����� �˰� �ʹٸ�??
select ename, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where ename = 'SCOTT';

-- [����1] �μ����� 'RESEARCH' �� ����� ���, �̸�,
--        �޿�, �μ���, �ٹ���ġ�� ȭ�鿡 �����ּ���.
select empno, ename, sal, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where dname = 'RESEARCH';

-- [����2] emp ���̺��� 'NEW YORK'�� �ٹ��ϴ� �����
--        �̸��� �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select ename, sal, e.deptno
from emp e join dept d
on e.deptno = d.deptno
where loc = 'NEW YORK';

-- [����3] emp ���̺��� 'ACCOUNTING' �μ� �Ҽ� �����
--        �̸��� ������, �Ի��� �׸��� �μ���ȣ, �μ�����
--        ȭ�鿡 �����ּ���.
select ename, job, hiredate, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where dname = 'ACCOUNTING';

-- [����4] emp ���̺��� �������� 'SALESMAN' �� �����
--        �̸��� ������, �μ���ȣ, �μ���, �ٹ���ġ�� 
--        ȭ�鿡 �����ּ���.
select ename, job, e.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where job = 'SALESMAN';


/*
  3) Self Join
     - �� ���� ���̺� ������ ������ �ؾ� �ڷḦ ���� �� �ִµ� �� �״��
       �ڱ� �ڽ� ���̺�� ������ �δ� ���� ����.
     - from �� ������ ���̺� �̸��� ������ �� �� ����� �� ����.
       ���� ���� ���̺��� �ϳ� �� �����ϴ� ��ó�� ����� �� �ֵ���
       ���̺� ��Ī�� �ٿ��� ����ؾ� ��.
*/

-- emp ���̺��� �� ����� �������� �̸��� ȭ�鿡 ����� ����.
-- ��) CEARK �� ������ �̸��� KING �Դϴ�.
select e1.ename || ' �� ������ �̸��� ' || e2.ename || ' �Դϴ�.'
from emp e1 join emp e2
on e1.mgr = e2.empno;

/*
  4) Outer Join
     - 2�� �̻��� ���̺��� ������ �� ������ ��� �� �� ���̺���
       �ش�Ǵ� �����Ͱ� �ٸ��� ���̺��� �����Ͱ� �������� �ʴ�
       ��� �� �����Ͱ� ����� ���� �ʴ� �������� �ذ��ϱ� ����
       ���Ǵ� ���� ���.
     - ������ ������ ���̺��� �÷� �ڿ� '(+)' ��ȣ�� �ٿ� ����� ��.
*/

select ename, d.deptno, dname
from emp e join dept d
on e.deptno(+) = d.deptno;

select e1.ename, e1.job, e1.mgr
from emp e1 join emp e2
on e1.mgr = e2.empno(+);



/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  ���� ����
  - �ϳ��� ������ �ȿ� ���ԵǾ� �ִ� �� �ϳ��� �������� ����.
  - ������ �ȿ� �� �ٸ� �������� �����ϴ� ���� ����.
  - ���������� ���������� ���������� �����ϴ� �������� ������.
  - ���� �� ������ �����ؼ� ���� �� �ִ� ����� �ϳ��� ��ø��
    ���� �������� ����� ���� �� �ְ� �� ��.
    
  �� ���ǻ���
     - ���������� ��ȣ�� ��� ����ϴ� ���� ������.
     - �������� �ȿ��� order by ���� ����� �� ����.

  - ��� ��� : �켱�� �� �ʿ� �ִ� �������� ���� ��, �� �������
               ������ �ٱ��� �������� ������.
*/

-- emp ���̺��� �̸��� 'SCOTT' �� ����� �޿����� �� ����
-- �޿��� �޴� ����� ���, �̸�, ������, �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where sal > (select sal from emp where ename = 'SCOTT');


-- [����1] emp ���̺��� ��ձ޿����� �� ���� �޴� �����
-- ���, �̸�, ������, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where sal < (select avg(sal) from emp);  -- ��� �޿� : 2073


-- [����2] emp ���̺��� ����� 7521�� ����� �������� ����,
-- ����� 7934�� ����� �޿����� �� ���� �޴� ����� ���, �̸�, 
-- ������, �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where job = (select job from emp where empno = 7521)  -- ������ : SALESMAN
and
sal > (select sal from emp where empno = 7934);  -- 7934��� �޿� : 1300


-- [����3] emp ���̺��� �������� 'MANAGER' �� ����� �ּұ޿�����
-- �����鼭, �������� 'CLERK'�� �ƴ� ����� ���, �̸�, ������,
-- �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where sal < (select min(sal) from emp where job = 'MANAGER')  -- �ּұ޿� : 2450
and
job != 'CLERK';


-- [����4] �μ���ġ�� 'DALLAS' �� ����� ���, �̸�, �μ���ȣ, 
-- �������� ȭ�鿡 �����ּ���.
select empno, ename, deptno, job
from emp
where deptno = (select deptno from dept where loc = 'DALLAS');  -- 20�� �μ�


-- [����5] member10 ���̺� �ִ� ���� ���� �� ���ϸ����� ���� ����
-- ���� ��� ������ ȭ�鿡 �����ּ���.
select *
from member10
where mileage = (select max(mileage) from member10);  -- ���ϸ��� �ִ밪 : 10000 ���ϸ���


-- [����6] emp ���̺��� 'SMITH' �� ������� �� ���� �޿���
-- �޴� ����� �̸���, �޿��� ȭ�鿡 �����ּ���.
select ename, sal
from emp
where sal > (select sal from emp where ename = 'SMITH');  -- SMITH ��� �޿� : 800


-- [����7] emp ���̺��� 10�� �μ� �޿��� ��� �޿����� ���� �޿��� �޴�
-- ������� �̸�, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select ename, sal, deptno
from emp
where sal < (select avg(sal) from emp where deptno = 10);  -- 10�� �μ� ��� �޿� : �� 2916


-- [����8] emp ���̺��� 'BLAKE'�� ���� �μ��� �ִ� �������
-- �̸��� �Ի�����, �μ���ȣ�� ȭ�鿡 �����ֵ�, 'BLAKE' �� �����ϰ�
-- ȭ�鿡 �����ּ���.
select ename, hiredate, deptno
from emp
where deptno = (select deptno from emp where ename = 'BLAKE') -- BLAKE �μ� : 30
and ename <> 'BLAKE';

-- [����9] emp ���̺��� ��ձ޿����� �� ���� �޴� ������� ���,
-- �̸�, �޿��� ȭ�鿡 �����ֵ�, �޿��� �������� ���� ������ ȭ�鿡 
-- �����ּ���.
select empno, ename, sal
from emp
where sal > (select avg(sal) from emp)  -- ��� �޿� : 2073
order by sal desc;

-- [����10] emp ���̺��� �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ���
-- �ٹ��ϰ� �ִ� ����� ����� �̸�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select empno, ename, deptno
from emp
where deptno in (select distinct deptno from emp where ename like '%T%');

-- [����11] 'SALES' �μ����� �ٹ��ϰ� �ִ� ������� �μ���ȣ,
-- �̸�, �������� ȭ�鿡 �����ּ���.
select deptno, ename, job
from emp
where deptno = (select deptno from dept where dname = 'SALES');  -- 30�� �μ�


-- [����12] emp ���̺��� 'KING'���� �����ϴ� ��� �����
-- �̸��� �޿�, �����ڸ� ȭ�鿡 �����ּ���.
select ename, sal, mgr
from emp
where mgr = (select empno from emp where ename = 'KING');  -- KING ��� ��� : 7839


-- [����13] emp ���̺��� �ڽ��� �޿��� ��ձ޿����� ����, �̸���
-- 'S' �ڰ� ���� ����� ������ �μ����� �ٹ��ϴ� ��� ����� 
-- ���, �̸�, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select empno, ename, sal, deptno
from emp
where sal > (select avg(sal) from emp)  -- ��ձ޿� : 2073
and
deptno in (select distinct deptno from emp where ename like '%S%');


-- [����14] products ���̺��� ��ǰ�� �ǸŰ����� �ǸŰ�����
-- ��պ��� ū ��ǰ�� ��ü ������ ȭ�鿡 �����ּ���.
select *
from products
where output_price > (select avg(output_price) from products);  -- �ǸŰ��� ��� : 1,143,800��


-- [����15] products ���̺� �ִ� �Ǹ� ���ݿ��� ��� ���� �̻���
-- ��ǰ ����� ���ϵ�, ����� ���� �� ������ ���� ū �ݾ��� ��ǰ��
-- �����ϰ� ����� ���Ͽ� ȭ�鿡 �����ּ���.
select *
from products
where output_price > 
(select avg(output_price) from products
   where output_price <>
(select max(output_price) from products));


-- [����16] products ���̺��� ��ǰ���� �̸��� '������' �̶��
-- �ܾ ���Ե� ī�װ��� ���ϴ� ��ǰ����� ȭ�鿡 �����ּ���.
select *
from products
where category_fk = 
(select distinct category_fk from products 
where products_name like '%������%'); 


-- [����17] member10 ���̺� �ִ� �� ���� �� ���ϸ����� ���� ���� 
-- �ݾ��� ������ ������ ���ʽ� ���ϸ��� 5000���� �� �־� ����,
-- ���ϸ���, ���ϸ���+5000 ���� ȭ�鿡 �����ּ���.
select memname, mileage, mileage + 5000 "�߰��� ���ϸ���"
from member10
where mileage = (select max(mileage) from member10);  -- �ִ� ���ϸ��� : 10,000




