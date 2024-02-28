/*
  ������(sequence)
  ==> ������ �ο��� �� ����ϴ� ����.
      �������� ��ȣ�� ����� �ִ� ����� ��.
      
  ����)
        create sequence �������̸�
        start with n(���۹�ȣ ���� - �⺻������ �⺻���� 1)
        increment by n(������ȣ ���� - �⺻������ �⺻���� 1)
        [maxvalue n(������ �ִ� ��ȣ ����)]  -- ������ ����
        [minvalue n(������ �ּ� ��ȣ ����)]  -- ������ ����
        cache / nocache(ĳ�� �޸� ��� ����)
        
        1) cache : �������� ������ �����ϱ� ���� �̸� ĳ�� �޸𸮿�
                   �������� �־� �ξ� �غ��ϰ� �ִٰ� ������ �۾���
                   �ʿ��� �� ����� ��.
                   default�δ� 20���� �������� ĳ�� �޸𸮿� ������ �ϰ� ��.
    
        2) nocache : cache ����� ������� �ʴ´ٴ� �ǹ�.
*/


-- memo ��� ���̺��� ����� ����.
create table memo(
    bunho number,
    title varchar2(100) not null,
    writer varchar2(30) not null,
    cont varchar2(1000) not null,
    regdate date,
    primary key(bunho)
);

-- memo ���̺� �̿� �� ����� �������� ����� ����.
create sequence memo_seq
start with 1
increment by 1
cache 20;


-- memo ���̺� �����͸� ������ ����.
insert into memo
    values(memo_seq.nextval, '�޸�1', 'ȫ�浿', '�浿�� �޸𿡿�~~~', sysdate);

insert into memo
    values(memo_seq.nextval, '�ѱ� �޸�', '�������', '������մ� �޸𿡿�~~~', sysdate);
    
insert into memo
    values(memo_seq.nextval, '��������', '������', '���� ���� ����!!!', sysdate);
    
insert into memo
    values(memo_seq.nextval, '�屺�� �޸�', '�̼���', '�̼��� �屺 �޸�', sysdate);
    
insert into memo
    values(memo_seq.nextval, '�޸�5', '�Ż��Ӵ�', '�Ż��Ӵ� �޸𿡿�~~~', sysdate);


commit;


/*
  ��������
  - ���̺� �������� �ڷᰡ �ԷµǴ� ���� �����ϱ� ���ؼ�
    ���̺��� ������ �� �� �÷��� ���Ͽ� �����ϴ� ���� ����
    ��Ģ�� ���� ���� ����.
    
  1) not null
  2) unique
  3) primary key : unique + not null
  4) foreign key
  5) check
*/

/*
  1) not null ���� ����
     - null ���� �Էµ��� ���ϰ� �ϴ� ���� ����.
     - Ư�� ���� �������� �ߺ� ���οʹ� ������� null ����
       ������� �ʴ� ���� ����.
*/

create table null_test(
    col1 varchar2(10) not null,
    col2 varchar2(10) not null,
    col3 varchar2(10)
);

insert into null_test values('aa', 'aa1', 'aa2');

insert into null_test(col1, col2) values('bb', 'bb1');

insert into null_test(col1, col2) values('bb', '');  -- error �߻�.

/*
  2) unique ���� ����
     - ���� ������ �������� �ߺ��� ������� �ʰ��� �� ��
       ����ϴ� ���� ����.
     - null ���� ����� ��.
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
  3) primary key : not null + unique  ���� ����
     - ���̺� �ϳ��� �����ؾ� ��.
     - ������ �ֹι�ȣ�� emp ���̺��� empno(�����ȣ) ����
       primary key�� ��ǥ���� ��.
*/

/*
  4) foreign key ���� ����
     - �ٸ� ���̺��� �ʵ�(�÷�)�� �����ؼ� ���Ἲ�� �˻��ϴ� ���� ����.
     - ���� Ű : �θ� ���̺��� �÷��� �̾߱� ��.
     - �ܷ� Ű : �ڽ� ���̺��� �÷��� �̾߱� ��.
     - �ڽ� ���̺��� �÷��� ��(������)�� �θ� ���̺� ���� ���
       ���Ἲ�� ��Ģ�� ���� ����.
     - �ܷ� Ű�� �����ϱ� ���ؼ��� �켱������ �θ� ���̺��� ���� ��������� ��.
     - �ɼ�
       * on delete cascade
         ==> �θ� ���̺��� ������ ���� �� �ش� �����͸� �����ϰ� �ִ�
             �ڽ� ���̺��� �����ͱ��� ��� �����ϴ� �ɼ�.
       * on delete set null
         ==> �θ� ���̺��� ������ ���� �� �ش� �����͸� �����ϰ� �ִ�
             �ڽ� ���̺��� �÷��� �ִ� ���� null�� �����Ű�� �ɼ�.
*/


create table foreign_test(
    bunho number primary key,
    irum varchar2(30) not null,
    job varchar2(100) not null,
    -- deptno number references dept(deptno),  -- �÷��� �ܷ�Ű ���� ����
    dept number,
    constraint dept_fk foreign key(dept)
        references dept_test(deptno)
        on delete set null                     -- ���̺� �󿡼� �ܷ�Ű ���� ����
);

drop table foreign_test purge;

insert into foreign_test values(1111, 'ȫ�浿', '�������', 30);

insert into foreign_test values(2222, '������', '�������', 10);

insert into foreign_test values(3333, '�̼���', 'IT���', 50);  -- error �߻�

-- dept ���̺��� 10�� �μ��� ������ ����.
delete from dept_test where deptno = 10;

create table dept_test(
    deptno number,
    dname varchar2(100),
    loc varchar2(100),
    primary key(deptno)
);

insert into dept_test values(10, 'accounting', 'new york');
insert into dept_test values(20, 'research', 'dallas');
insert into dept_test values(30, 'sales', 'chicago');
insert into dept_test values(40, 'operations', 'boston');


/*
  5) check ���� ����
     - ���� ������ �� �ִ� ���� ���� �Ǵ� ������ ������ ��
       ���Ǵ� ���� ����.
*/

create table check_test(
    gender varchar2(6),
    constraint gender_chk check(gender in('��', '��'))
);

insert into check_test values('��');

insert into check_test values('��');

insert into check_test values('����');  -- error �߻�


/*
  join ~ on Ű����
  - ���̺�� ���̺��� �����Ͽ� Ư���� �����͸� ����� �� �� �����.
  - �� �� �̻��� ���̺� ������ �������� ���� �� �����.
  - �ߺ��ؼ� �����Ͱ� ����Ǵ� ���� �����ϱ� ���� ���̺��� ������ ���� ����.
  - �� ���� ���̺�� �������� ��쿡�� �������� �ߺ��� �߻����� ������
    ���ϴ� ������ �������� ���� �� ���Ǹ� �ؾ� �ϴ� �������� �߻���.
  - Ư�� ����� �Ҽӵ� �μ��� �μ����� �˰� ���� ��쿡�� emp ���̺��
    dept ���̺��� �ѳ���� �۾��� ����Ƿ� ����� ������. �׷��� �� ����
    ���̺��� �����ؼ� ���ϴ� ����� �� �� �ֵ��� �ϴ� �����̶��
    ����� ���ܳ��� �Ǿ���.

    ������ ����
    1) Cross Join
    2) Equi Join
    3) Self Join
    4) Outer Join
*/

/*
  1) Cross Join
     - �� �� �̻��� ���̺��� ������ �� �� ������ ���� ���̺��� ������
       �̷������ ������.
     - ���̺� ��ȣ���� ����� �� �ִ� ��� ����� ���� �����Ͽ� ��Ÿ���� ���� �����.
       �׷��� ������ ���̺� ��ü ���� �÷��� ������ ��.
     - ����� ����� �� �ϴ� ���� ����.
*/

select *
from emp, dept;

/*
  2) Equi Join
     - ���� ���� ���Ǵ� ���� ���.
     - ������ ����� �Ǵ� �� ���̺��� ���������� �����ϴ� �÷��� ����
       ��ġ�ϴ� ���� �����Ͽ� ����� �����ϴ� ���.
     - �� ���̺��� ������ �Ϸ��� ��ġ�Ǵ� ���� �÷��� ����ؾ� ��.
*/

-- emp ���̺��� ����� ���, �̸�, ������, �μ���ȣ ��
-- �μ���, �μ���ġ�� ȭ�鿡 �����ּ���.
-- ==> emp ���̺�� dept ���̺��� ���ν��� �־�� ��.

select empno, ename, job, d.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno;

-- emp ���̺��� ������� 'SCOTT' ����� �μ����� �˰� �ʹٸ�???
select ename, e.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where ename = 'SCOTT';


-- [����1] �μ����� 'RESEARCH' �� �����
-- ���, �̸�, �޿�, �μ���, �ٹ���ġ�� ȭ�鿡 �����ּ���.
select empno, ename, sal, d.deptno, loc
from emp e join dept d
on e.deptno = d.deptno
where dname = 'RESEARCH';


-- [����2] emp ���̺��� 'NEW YORK'�� �ٹ��ϴ� �����
-- �̸��� �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.
select ename, sal, e.deptno
from emp e join dept d
on e.deptno = d.deptno
where loc = 'NEW YORK';


-- [����3] emp ���̺��� 'ACCOUNTING' �μ� �Ҽ� �����
-- �̸��� ������, �Ի��� �׸��� �μ���ȣ, �μ�����
-- ȭ�鿡 �����ּ���.
select ename, job, hiredate, d.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where dname = 'ACCOUNTING';


--[����4] emp ���̺��� �������� 'SALESMAN' �� �����
-- �̸��� ������, �μ���ȣ, �μ���, �ٹ���ġ�� ȭ�鿡 �����ּ���.
select ename, job, d.deptno, dname, loc
from emp e join dept d
on e.deptno = d.deptno
where job = 'SALESMAN';


/*
  3) Self Join
     - �ϳ��� ���̺� ������ ������ �ؾ� �����͸� ��� �� �� �ִµ� �� �״��
       �ڱ� �ڽŰ� ������ �δ� ���� ����.
     - from �� ������ ���̺� �̸��� ������ �� �� ����� �� �� ����.
       ���� ���� ���̺��� �ϳ� �� �����ϴ� ��ó�� ����� �� �ֵ���
       ���̺� ��Ī�� �ٿ��� ����ؾ� ��.
*/

-- emp ���̺��� �� ����� �������� �̸��� ȭ�鿡 ����� ����.
-- ��) CLARK�� ������ �̸��� KING �Դϴ�.
select e1.ename || ' �� ������ �̸��� ' || e2.ename || ' �Դϴ�.'
from emp e1 join emp e2
on e1.mgr = e2.empno;

-- emp ���̺��� �Ŵ����� 'KING' �� �������
-- �̸��� �������� ȭ�鿡 �����ּ���.
select e1.ename, e1.job
from emp e1 join emp e2
on e1.mgr = e2.empno
where e2.ename = 'KING';


/*
  4) Outer Join
     - 2�� �̻��� ���̺��� ������ �� �� ��� �� �� ���̺���
       �ش�Ǵ� �����Ͱ� �ٸ��� ���̺��� �����Ͱ� ��������
       �ʴ� ��� �� �����Ͱ� ����� ���� �ʴ� �������� �ذ��ϱ�
       ���� ���Ǵ� ���� �����.
     - ������ ������ ���̺��� �÷� �ڿ� '(+)' ��ȣ�� �ٿ� ����� ��.
*/

select ename, d.deptno, dname
from emp e join dept d
on e.deptno(+) = d.deptno;

select e1.ename, e1.job, e1.mgr
from emp e1 join emp e2
on e1.mgr = e2.empno(+);


/*
  dual ���̺�
  - ����Ŭ���� ��ü������ ������ �ִ� ���̺�.
  - �����ϰ� �Լ��� �̿��ؼ� ���, ������� Ȯ���� �� ����ϴ� ���̺�.
  - ���� �� ��, �� �÷����� ��� �ִ� ���̺�.
  - ��� �뵵 : Ư�� ���̺��� ������ �ʿ� ���� �Լ� �Ǵ�
               ����� �ϰ��� �� �� ����� ��.
*/

-- ����Ŭ���� ������ �ִ� �Լ���
-- 1. ��¥�� ���õ� �Լ���
--    1) sysdate : ���� �ý����� ��¥�� ���� ���� Ű����.
select sysdate from dual;

--    2) add_months(���� ��¥, ����(������))
--       ==> ���� ��¥���� ���� ���� ���� �ִ� �Լ�.
select add_months(sysdate, 3) from dual;

--    3) next_day(���� ��¥, '����')
--       ==> �ٰ��� ��¥(����)�� ���� �ִ� �Լ�.
select next_day(sysdate, '������') from dual;

--    4) to_char(��¥, '��¥����')
--       ==> ���Ŀ� �°� ���ڿ��� ��¥�� ����� �ִ� �Լ�.
select to_char(sysdate, 'yyyy/mm/dd') from dual;

select to_char(sysdate, 'yyyy-mm-dd') from dual;

select to_char(sysdate, 'mm/dd/yyyy') from dual;

--    5) months_between('��������¥', ���糯¥)
--       ==> �� ��¥ ������ ���� ���� ����� �ִ� �Լ�.
select months_between('24/07/31', sysdate) from dual;

--    6) last_day()
--       ==> �־��� ��¥�� ���� ���� ������ ��¥�� ��ȯ�� �ִ� �Լ�.
select last_day(sysdate) from dual;

-- 2. ���ڿ� ���õ� �Լ���
--    1-1) concat('���ڿ�1', '���ڿ�2')
--         ==> �� ���ڿ��� ����(����)�� �ִ� �Լ�.
select concat('�ȴ�' , '�ϼ���!!!') from dual;

--    1-2) || ������ : ���ڿ��� �����ϴ� ������.
select '�氡' || '�氡' from dual;

--    2) upper() : �ҹ��ڸ� �빮�ڷ� �ٲپ� �ִ� �Լ�.
select upper('happy day') from dual;

--    3) lower() : �빮�ڸ� �ҹ��ڷ� �ٲپ� �ִ� �Լ�.
select lower(upper('happy day')) from dual;

--    4) substr('���ڿ�', x, y)
--       ==> ���ڿ��� x���� y�� ���̸�ŭ ������ �ִ� �Լ�.
select substr('ABCDEFG', 3,2) from dual; -- CD

--       ==> x ���� ������ ��쿡�� ������(����)�������� ������ ��.
select substr('ABCDEFG', -3, 2) from dual; -- EF

--    5) �ڸ����� �÷��ִ� �Լ�.
--     5-1) lpad('���ڿ�', '��ü�ڸ���', '�þ �ڸ����� �� ���ڿ�')
select lpad('ABCDEFG', 15, '*') from dual;

--     5-2) rpad('���ڿ�', '��ü�ڸ���', '�þ �ڸ����� �� ���ڿ�')
select rpad('ABCDEFG', 15, '*') from dual;

--    6) ���ڸ� ���� �ִ� �Լ�.
--     6-1) ltrim() : ���� ���ڸ� �����ִ� �Լ�.
select ltrim('ABCDEFGA', 'A') from dual;

--     6-2) rtrim() : ������ ���ڸ� �����ִ� �Լ�.
select rtrim('ABCDEFGA', 'A') from dual;

--    7) replace() : ���ڿ��� ��ü�� �ִ� �Լ�.
--       ����) replace('���� ���ڿ�', '��ü�� ���ڿ�', '���ο� ���ڿ�')
select replace('Java Program', 'Java', 'Python') from dual;


-- [����1] emp ���̺��� ����� �Ʒ��� ���� ��������
-- ȭ�鿡 �����ּ���.
-- ���) 'SCOTT�� �������� ANALYST �Դϴ�.'
-- ��, concat() �Լ��� �̿��ϼ���.
select concat(ename, ' �� �������� '), 
concat(job, ' �Դϴ�.')
from emp;

-- [����2] emp ���̺��� ����� �Ʒ��� ���� ��������
-- ȭ�鿡 �����ּ���.
-- ���) 'SCOTT�� ������ 36000�Դϴ�.'
-- ��, concat() �Լ��� �̿��ϼ���.
select concat(ename, ' �� ������ '),
concat(sal * 12, ' �Դϴ�.')
from emp;


-- [����3] member ���̺��� ����� �Ʒ��� ���� ��������
-- ȭ�鿡 �����ּ���.
-- ���) 'ȫ�浿 ȸ���� ������ �л��Դϴ�.'
-- ��, concat() �Լ��� �̿��ϼ���.
select concat(memname, ' ȸ���� ������ '),
concat(job, ' �Դϴ�.')
from member;


-- [����4] emp ���̺��� ���, �̸�, �������� ȭ�鿡
-- �����ּ���. ��, �������� �ҹ��ڷ� �����Ͽ� �����ּ���.
select empno, ename, lower(job)
from emp;


-- [����5] �������� �ֹε�� ��ȣ �߿��� ��������� �����Ͽ�
-- ȭ�鿡 �����ּ���.
select substr('881212-1234567', 1, 6)
from dual;

-- [����6] emp ���̺��� �������� 'A' ��� ���ڸ�
-- '$'�� �ٲپ� ȭ�鿡 �����ּ���.
select replace(job, 'A', '$') 
from emp;


-- [����7] member ���̺��� ������ '�л�' �� ������
-- '���л�'���� �ٲپ� ȭ�鿡 �����ּ���.
select replace(job, '�л�', '���л�')
from member;


--[����8] member ���̺��� �ּҿ� '�����' �� �� ������
-- '����Ư����'�� �ٲپ� ȭ�鿡 �����ּ���.
select replace(addr, '�����', '����Ư����')
from member;


-- 3. ���ڿ� ���õ� �Լ���
--  1) abs(����) : ���밪�� ���� �ִ� �Լ�.
select abs(23) from dual;

select abs(-23) from dual;

--  2) sign(����) : ���(1), ����(-1), 0�� ��ȯ�� �ִ� �Լ�.
select sign(0) from dual;

select sign(13), sign(-13), sign(0) from dual;

--  3) round(�Ǽ�) : �ݿø��� �� �ִ� �Լ�.
select round(1234.5678) from dual;  -- 1235

--     �ݿø��� �� �� �ڸ����� ����.
--     ����) round([����(�ʼ�)], [�ݿø� ��ġ(����)]
--          ==> ���� ���� �����ϸ� �ڿ���(����)������ ���ڸ���
--              ���� �ݿø��� �� ��.
select round(0.1234567, 6) from dual;  -- 0.123457

select round(2.3423557, 4) from dual;  -- 2.3424

select round(1256.5678, -2) from dual; -- 1300

--  4) trunc() : �Ҽ��� ���� �ڸ����� �߶󳻴� �Լ�.
--     ����) trunc([����(�ʼ�)], [������ġ(����)])
select trunc(1234.1234567, 0) from dual;  -- 1234

select trunc(1234.1234567, 4) from dual;  -- 1234.1234

select trunc(1234.1234567, -3) from dual; -- 1000

--  5) ceil() : ������ �ø��� �� �ִ� �Լ�.
select ceil(22.8) from dual;  -- 23

select ceil(22.1) from dual;  -- 23


--  6) power() : ������ �� �ִ� �Լ�.
select power(4, 3) from dual; -- 64

--  7) mod() : �������� ���� �ִ� �Լ�.
--     ����) mod([�������� ����(�ʼ�)], [���� ����(�ʼ�)])
select mod(77, 4) from dual;

--  8) sqrt() : �������� ���� �ִ� �Լ�.
select sqrt(3) from dual;

select sqrt(16) from dual;



/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  ��������
  - �ϳ��� ������ �ȿ� ���ԵǾ� �ִ� �� �ϳ��� �������� ����.
  - ������ �ȿ� �� �ٸ� �������� �����ϴ� ���� ����.
  - ���������� ���������� ���������� �����ϴ� �������� ������.
  - ���� �� ������ �����ؼ� ���� �� �ִ� ����� �ϳ��� ��ø��
    ���� �������� ����� ���� �� �ְ� ��.
    
  �� ���ǻ���
     - ���������� ��ȣ�� ��� ����ϴ� ���� ������.
     - �������� �ȿ����� order by���� ����� �� ����.
     
  - ������ : �켱�� ���ʿ� �ִ� �������� ���� ��, �� ������� ������
              �ٱ��� �������� ������.
*/

-- emp ���̺��� �̸��� 'SCOTT' �� ����� �޿����� �� ����
-- �޿��� �޴� ����� ���, �̸�, ������, �޿��� ȭ�鿡 �����ּ���.
select empno, ename, job, sal
from emp
where sal > (select sal from emp where ename = 'SCOTT');  -- SCOTT�� �޿� : 3000



-- �������� ����
-- [����1] emp ���̺��� ��ձ޿����� �� ���� �޴� �����
-- ���, �̸�, ������, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.


-- [����2] emp ���̺��� ����� 7521�� ����� �������� ����,
-- ����� 7934�� ����� �޿����� �� ���� �޴� ����� ���, �̸�, 
-- ������, �޿��� ȭ�鿡 �����ּ���.


-- [����3] emp ���̺��� �������� 'MANAGER' �� ����� �ּұ޿�����
-- �����鼭, �������� 'CLERK'�� �ƴ� ����� ���, �̸�, ������,
-- �޿��� ȭ�鿡 �����ּ���.


-- [����4] �μ���ġ�� 'DALLAS' �� ����� ���, �̸�, �μ���ȣ, 
-- �������� ȭ�鿡 �����ּ���.


-- [����5] member ���̺� �ִ� ���� ���� �� ���ϸ����� ���� ����
-- ���� ��� ������ ȭ�鿡 �����ּ���.


-- [����6] emp ���̺��� 'SMITH' �� ������� �� ���� �޿���
-- �޴� ����� �̸���, �޿��� ȭ�鿡 �����ּ���.


-- [����7] emp ���̺��� 10�� �μ� �޿��� ��� �޿����� ���� �޿��� �޴�
-- ������� �̸�, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.


-- [����8] emp ���̺��� 'BLAKE'�� ���� �μ��� �ִ� �������
-- �̸��� �Ի�����, �μ���ȣ�� ȭ�鿡 �����ֵ�, 'BLAKE' �� �����ϰ�
-- ȭ�鿡 �����ּ���.


-- [����9] emp ���̺��� ��ձ޿����� �� ���� �޴� ������� ���,
-- �̸�, �޿��� ȭ�鿡 �����ֵ�, �޿��� �������� ���� ������ ȭ�鿡 
-- �����ּ���.


-- [����10] emp ���̺��� �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ���
-- �ٹ��ϰ� �ִ� ����� ����� �̸�, �μ���ȣ�� ȭ�鿡 �����ּ���.


-- [����11] 'SALES' �μ����� �ٹ��ϰ� �ִ� ������� �μ���ȣ,
-- �̸�, �������� ȭ�鿡 �����ּ���.


-- [����12] emp ���̺��� 'KING'���� �����ϴ� ��� �����
-- �̸��� �޿�, �����ڸ� ȭ�鿡 �����ּ���.


-- [����13] emp ���̺��� �ڽ��� �޿��� ��ձ޿����� ����, �̸���
-- 'S' �ڰ� ���� ����� ������ �μ����� �ٹ��ϴ� ��� ����� 
-- ���, �̸�, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.


-- [����14] emp ���̺��� ���ʽ��� �޴� ����� �μ���ȣ, �޿��� ����
-- ����� �̸�, �޿�, �μ���ȣ�� ȭ�鿡 �����ּ���.


-- [����15] products ���̺��� ��ǰ�� �ǸŰ����� �ǸŰ�����
-- ��պ��� ū ��ǰ�� ��ü ������ ȭ�鿡 �����ּ���.


-- [����16] products ���̺� �ִ� �Ǹ� ���ݿ��� ��� ���� �̻���
-- ��ǰ ����� ���ϵ�, ����� ���� �� ������ ���� ū �ݾ��� ��ǰ��
-- �����ϰ� ����� ���Ͽ� ȭ�鿡 �����ּ���.


-- [����17] products ���̺��� ��ǰ���� �̸��� '������' �̶��
-- �ܾ ���Ե� ī�װ��� ���ϴ� ��ǰ����� ȭ�鿡 �����ּ���.


-- [����18] member ���̺� �ִ� �� ���� �� ���ϸ����� ���� ���� 
-- �ݾ��� ������ ������ ���ʽ� ���ϸ��� 5000���� �� �־� ����,
-- ���ϸ���, ���ϸ���+5000 ���� ȭ�鿡 �����ּ���.

select * from emp;









































