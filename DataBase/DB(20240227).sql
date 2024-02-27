-- member ��� ���̺��� ����� ����.

create table member(
    memno number primary key,          -- ȸ�� ��ȣ
    memid varchar2(20) not null,       -- ȸ�� ���̵�
    memname varchar2(30) not null,     -- ȸ�� �̸�
    mempwd varchar2(20) not null,      -- ȸ�� ��й�ȣ
    age number,                        -- ȸ�� ����
    mileage number,                    -- ȸ�� ���ϸ���
    job varchar2(30),                  -- ȸ�� ����
    addr varchar2(500),                -- ȸ�� �ּ�
    regdate date not null              -- ȸ�� ������
);


-- member ���̺� ȸ���� ������ ������ ����.
insert into member
    values(1, 'id1', 'ȫ�浿', '1111', 25, 0, '�л�',
            '�λ�� ������', '2013-08-08');

insert into member
    values(2, 'kimkd', '��浿', '2222', 30, 1500, 'ȸ���',
            '����� ������', '2013-09-15');

insert into member
    values(3, 'id3', '������', '3333', 33, 10000, 'ȸ���',
            '�λ�� �߱�', '2013-09-09');
            
insert into member
    values(4, 'kimyh', '�迵��', '4444', 18, 3000, '�л�',
            '��󳲵� �����', '2014-05-23');
            
insert into member
    values(5, 'id5', '�ڸ���', '5555', 45, 5000, '�ֺ�',
            '��⵵ �����ֽ�', '2013-12-01');

insert into member
    values(6, 'id6', '��ö��', '6666', 55, 0, '����',
            '���ֵ� ��������', '2013-01-10');

insert into member
    values(7, 'hong', 'ȫ�浿', '7777', 14, 0, '�л�',
            '���ϵ� ���ֽ�', '2013-12-25');

insert into member
    values(8, 'id8', '�����', '8888', 31, 0, '����',
            '����� ������', '2013-04-22');

insert into member
    values(9, 'id9', '������', '9999', 25, 0, '�л�',
            '������ ������', '2013-10-10');

insert into member
    values(10, 'id10', 'ȫ�浿', '1010', 52, 10000, '����',
            '����� ���ϱ�', '2013-09-15');


-- ī�װ� ���̺��� ����� ����.
create table category(
    cnum number unique,                        -- ī�װ� ��ȣ
    category_code varchar2(8),                 -- ī�װ� �ڵ�
    category_name varchar2(30) not null,       -- ī�װ� �̸�
    primary key(category_code)
);


-- ī�װ� ���̺� �����͸� ������ ����.
insert into category values(1, '00010000', '������ǰ');
insert into category values(2, '00010001', 'TV');
insert into category values(3, '00010002', '��ǻ��');
insert into category values(4, '00010003', '��Ʈ��');
insert into category values(5, '00010004', '������');
insert into category values(6, '00020000', '�Ƿ���ǰ');
insert into category values(7, '00020001', '����');
insert into category values(8, '00020002', '�ӿ�');
insert into category values(9, '00020003', '����');
insert into category values(10, '00030000', '����');
insert into category values(11, '00030001', '��ǻ�͵���');
insert into category values(12, '00030002', '�Ҽ�');


-- ��ǰ ���� ���̺��� ����� ����.
create table products(
    pnum number(11) primary key,                   -- ��ǰ ��ȣ
    category_fk varchar2(8) not null,              -- ī�װ� �ڵ�
    products_name varchar2(50) not null,           -- ��ǰ��
    ep_code_fk varchar2(5) not null,               -- ��ǰ �ڵ�
    input_price number(10) default 0 not null,     -- ��ǰ �԰� ����
    output_price number(10) default 0 not null,    -- ��ǰ ��� ����
    trans_cost number(5) default 0 not null,       -- ��ǰ ��ۺ�
    mileage number(6) default 0 not null,          -- ��ǰ ���ϸ���
    company varchar2(30),                          -- ��ǰ ������
    constraint category_ref foreign key(category_fk) 
        references category(category_code)
);

-- ��ǰ �����͸� ������ ����.
insert into products
   values(1, '00010001', 'S ������ TV', '00001', 5000000, 8000000, 0, 100000, '�Ｚ');
insert into products
   values(2, '00010001', 'L TV', '00002', 1000000, 1500000, 0, 50000, 'LG');
insert into products
   values(3, '00010004', 'S ������', '00001', 1000000, 1100000, 5000, 100000, '�Ｚ');
insert into products
   values(4, '00010000', 'C ���', '00003', 200000, 220000, 5500, 0, '����');
insert into products
   values(5, '00010004', 'L ������', '00003', 1200000, 1300000, 0, 0, 'LG');
insert into products
   values(6, '00020001', '��������', '00002', 100000, 150000, 2500, 0, '');
insert into products
   values(7, '00020001', '��������', '00002', 120000, 200000, 0, 0, '');
insert into products
   values(8, '00020002', '�簢��Ƽ', '00002', 10000, 20000, 0, 0, '���𰡵�');
insert into products
   values(9, '00020003', '�ủ����', '00002', 15000, 18000, 0, 0, '');
insert into products
   values(10, '00030001', '������ �ø���', '00001', 25000, 30000, 2000, 0, '���');


-- [����1] member ���̺��� ȸ���� �̸��� ����, ������ ȭ�鿡 �����ּ���.
select memname, age, job from member;

-- [����2] products ���̺��� ��ǰ��, �԰�, ���, �����縦 ȭ�鿡 �����ּ���.
select products_name, input_price, output_price, company from products; 


-- KING ����� ������ 60000 �Դϴ�.
-- || : ����Ŭ���� ���� ������.
select ename || ' ����� ������ ' || sal * 12 || ' �Դϴ�.' 
        as "������ ����" from emp;
        
-- [����] member ���̺��� ������ �Ʒ��� ���� ȭ�鿡 ����� ������.
-- ����) ȫ�浿 ȸ���� ������ �л��̰�, ���ϸ����� 0 ���ϸ��� �Դϴ�.
select memname || ' ȸ���� ������ ' || job || ' �̰�, ���ϸ����� ' 
    || mileage || ' ���ϸ��� �Դϴ�.' from member;

-- ���̺��� �����ϴ� ���
-- ����) drop table ���̺��̸� purge;


/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  where ������
  
  - ��� �����͸� ���� ��ȸ�ϴ� ���� �ƴ϶� ����ڰ� ���ϴ� �����͸�
    ��ȸ�� ��쿡 �����.
  - where �������� �ڷḦ ���͸� �� �� ���Ǵ� Ű����.
  - where �������� from ���̺� �̸� �ڿ� ����ؾ� ��.
  
  ����) select �÷���1, �÷���2, �ַ���3,......
            from ���̺��̸� where ���ǽ�;
            
  ���ǽĿ� ���� ����
  1) = : ������ ������ ���� Ȯ��.
  2) < : ������ ������ ���� Ȯ��.
  3) <= : ������ �۰ų� ������ ���� Ȯ��.
  4) > : ������ ū�� ���� Ȯ��.
  5) >= : ������ ũ�ų� ������ ���� Ȯ��.
  6) != : ������ ���� ������ ���� Ȯ��.
  7) <> : ������ ���� ������ ���� Ȯ��. ==> != �� ���� �ǹ�.
  8) between A and B : A�� B ���̿� �ִ��� ���� Ȯ��.
  9) in(list) : list �� �߿� ��� �ϳ��� ��ġ�ϴ��� ���� Ȯ��.
  10) not between A and B : A�� B ���̿� ���� ������ ���� Ȯ��.
      ==> A, B ���� �������� ����.
  11) not in(list) : list ���� ��ġ���� �ʴ��� ���� Ȯ��.
*/

-- emp ���̺��� �������� 'MANAGER' �� �����
-- ��� ������ ȭ�鿡 �����ּ���.
select * from emp
where job = 'MANAGER';

-- emp ���̺��� �������� 'SALESMAN' �� �����
-- ��� ������ ȭ�鿡 �����ּ���.
select * from emp
where job = 'SALESMAN';


-- [����1] emp ���̺��� �������� 'CLERK' �� �����
-- ���, �̸�, ������, �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where job = 'CLERK';

-- [����2] emp ���̺��� 1982�� 1�� 1�� ���Ŀ� �Ի���
-- ����� ���, �̸�, ������, �޿�, �Ի����ڸ� ȭ�鿡 �����ּ���.
select empno, ename, job, sal, hiredate
from emp
where hiredate >= '82/01/01';

-- [����3] emp ���̺��� �޿��� 1300 ~ 1500 ������ �����
-- �̸��� ������, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select ename, job, sal, deptno
from emp
-- where sal >= 1300 and sal <= 1500; (O)
where sal between 1300 and 1500;

-- [����4] emp ���̺��� ����� 7902, 7788, 7566 �� �����
-- ���, �̸�, �������� ȭ�鿡 �����ּ���.
select empno, ename, job
from emp
-- where empno = 7902 or empno = 7788 or empno = 7566; (O)
where empno in (7902, 7788, 7566);

--[����5] emp ���̺��� ���ʽ��� 300�̰ų� 500�̰ų�
-- 1400�� ����� ��� ������ ȭ�鿡 �����ּ���.
select *
from emp
-- where comm = 300 or comm = 500 or comm = 1400; (O)
where comm in (300, 500, 1400);

-- [����6] member ���̺��� �̸��� ȫ�浿�̸鼭 ������
-- �л��� ȸ���� ��� ������ ȭ�鿡 �����ּ���.
select *
from member
where memname = 'ȫ�浿' and job = '�л�';

-- [����7] products ���̺��� �����簡 '�Ｚ' �Ǵ� '����'
-- �̸鼭 �԰��� 100���� ������ ��ǰ�� ��ǰ��� �԰� �׸���
-- ����� ȭ�鿡 �����ּ���.
select products_name, input_price, output_price
from products
where company in ('�Ｚ', '����') and input_price <= 1000000;

-- [����8] emp ���̺��� �޿��� 1100 �̻��̰�, ��������
-- 'MANAGER' �� ����� ���, �̸�, ������, �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where sal >= 1100 and job = 'MANAGER';


/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  like Ű���� : �˻��� �ϴ� Ű����.
  
  1) where ename like '%S%'
     ==> ename �÷��� S�ڸ� �����ϴ� ����� �̸��� �˻�.
     
  2) where ename like 'S%'
     ==> ename �÷��� ù���ڰ� S�ڷ� �����ϴ� ����� �̸��� �˻�.
     
  3) where ename like '%S'
     ==> ename �÷��� ������ ���ڰ� S�ڷ� ������ ����� �̸��� �˻�.
     
  4) where ename like '_S%'
     ==> ename �÷��� �ι�° ���ڰ� S�ڸ� �����ϴ� ����� �̸��� �˻�.
*/

-- emp ���̺��� ����� 'A' ��� ���ڸ� �����ϴ� �����
-- ��� ������ �����ּ���.
select * 
from emp
where ename like '%A%';


-- [����1] emp ���̺��� ����� 'M' �̶�� ���ڸ� �����ϴ�
-- ����� ��� ������ ȭ�鿡 �����ּ���.

-- [����2] emp ���̺��� ������� �ι�° ���ڿ� 'I' �̶�� 
-- ���ڸ� �����ϴ� ����� ��� ������ ȭ�鿡 �����ּ���.

-- [����3] emp ���̺��� ����� �̸��� 'S' ��� ���ڷ� ������
-- ����� ����� �̸�, ������, �μ���ȣ�� ȭ�鿡 �����ּ���.

-- [����4] emp ���̺��� ����� ����° ���ڰ� 'R' �̶�� 
-- ���ڸ� �����ϴ� ����� �̸��� ������, �޿��� ȭ�鿡 �����ּ���.

-- [����5] emp ���̺��� ����� �ι�° ���ڰ� 'O' ��� 
-- ���ڸ� �����ϴ� ����� ��� ������ ȭ�鿡 �����ּ���.

-- [����6] emp ���̺��� �Ի�⵵�� 82�⵵�� ����� 
-- ���, �̸�, ������, �Ի����ڸ� ȭ�鿡 �����ּ���.

-- [����7] member ���̺��� ���� '��'�� ���� ������ 
-- ȸ���� ��� ������ ȭ�鿡 �����ּ���.

-- [����8] member ���̺��� �ּҿ� '�����' �� ���� 
-- ȸ���� �̸�, �ּ�, ������ ȭ�鿡 �����ּ���.

-- [����9] products ���̺��� ��ǰ�� '������' �� 
-- �����ϴ� ��ǰ�� ��ǰ��, �԰�, ���, �����縦
-- ȭ�鿡 �����ּ���.












select * from emp;








commit;


