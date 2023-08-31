/*
  group by ��
  - Ư�� �÷��̳� ���� �������� �ش� ���ڵ带 ��� 
    �ڷḦ ������ �� �����.
  - ������ Ư���� �÷��� �������� ���踦 ���ϴµ� ���� ����� ��.
  - ���� �׷��Լ��� �Բ� ����ϸ� ȿ�������� Ȱ���� ������.
*/

select deptno
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

-- [����] emp ���̺��� �μ����� �׷��� ��� �μ���
--       �޿� �հ�װ� �μ��� �ο� ��, �μ��� ��� �޿�,
--       �μ��� �ִ�޿���, �μ��� �ּұ޿����� ���Ͽ�
--       ȭ�鿡 �����ּ���.
--       ��, �޿� �հ踦 �������� ������������ �����Ͽ�
--       ȭ�鿡 �����ּ���.
select deptno, sum(sal), count(*), avg(sal), max(sal), min(sal)
from emp
group by deptno
order by sum(sal) desc;

/*
  having ��
  - group by �� ������ ������ ������.
  - group by ���� ����� ������ �־ ������ �� �����.
  - group by ������ where(������) �� �� �� ����.
*/

-- products ���̺��� ī�װ� ����
-- ��ǰ�� ������ ȭ�鿡 �����ּ���.
select category_fk, count(*)
from products
group by category_fk
having count(*) >= 2;


/*
  �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
  View
  - �������� ���̺� �ٰ��� ������ ������ ���̺��� ����.
  - View �� ���������� �����͸� �����ϰ� ���� ����.
  - View �� ����� �����ͺ��̽��� ���� �� ���� ���̺�
    �����Ͽ� �����͸� �ҷ����� ��.
  - �����ϰ� �ʿ��� ����鸸 �����ؼ� ����� �� ���� ����� ��.
  - View �� ���̺�� �����ϸ�, ���̺�ó�� ����� ������.
  - View �� ���̺� �����ϱ� ���� �������� ������ �ʿ䰡 ����.
  - ���̺�� ���������� insert, update, delete ����� ������.
    ������ �ַ� �����͸� ��ȸ(select)�ϴ� �뵵�� ���� ���� ����� ��.
  - View �� ����ϴ� ����
    1) ���� ������ ���� �����(�߿���)
       ==> ���� ��޿� ���߾� �÷��� ������ ���ؼ� ��ȸ��
           �����ϵ��� �� �� ����.
    2) ������� ���Ǽ��� ������.
    
    ����)
            create view view�̸�
            as
            ������;
*/

-- 1) ���� ������ ���� �����(�߿���)
-- �λ�� View
-- �÷��� sal(�޿�), comm(���ʽ�) �÷��� ����.
create view emp_insa
as
select empno, ename, job, mgr, hiredate, deptno
from emp;

-- ������ View
-- �÷��� sal(�޿�) �÷��� ����.
create view emp_sales
as
select empno, ename, job, mgr, hiredate, comm, deptno
from emp;

-- ȸ��� View
-- ���ܵǴ� �ø� ����.
create view emp_account
as
select * 
from emp;

insert into emp_account
    values(9000, 'ANGEL', 'SALESMAN', 7698, sysdate, 1300, 300, 30);
    
-- View �� �б� �������� ����� �����Ͱ� �߰��� �� ��.
-- View �� �б� �������� ����� ���
-- ==> View �� ���� �� ������ �������� with read only ���� �߰�.

create view emp_view2
as
select * from emp
with read only;

insert into emp_view2
    values(9001, 'LOVE', 'SALESMAN', 7698, sysdate, 1300, 300, 30);

-- create or replace view
-- ���� �̸��� view �� �ִ� ��쿡�� ������ view�� �����ϰ�
-- ���ο� view�� ������ �ǹ�.
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
    values(9001, '������', 'SALESMAN', 7694, sysdate, 400, 30);
    
-- 2) ������� ���Ǽ��� ������.
create or replace view emp_salary
as
select empno, ename, (sal * 12 + nvl2(comm, comm, 0)) ����
from emp
with read only;

-- [����1] emp ���̺��� �̿��Ͽ� �μ����� �μ��� �޿� �հ�, �μ���
--        �޿� ����� ���� view �� ����� ȭ�鿡 �����ּ���.
--        ���ǻ���) view �� ���� �� �׷��Լ� ���ÿ��� �ݵ��
--                 ��Ī�� ������ �־�� ��.
create or replace view emp_deptno
as
select deptno, sum(sal) "�޿��հ�", avg(sal) "�޿����"
from emp
group by deptno
with read only;


-- [����2] emp ���̺��� �̿��Ͽ� emp_dept20 �̶�� view �� ����� �ּ���.
--        ��, �μ���ȣ�� 20�� �μ��� ���� ������� ���, �̸�, ������,
--        ������, �μ���ȣ�� ȭ�鿡 �����ּ���.
create or replace view emp_dept20
as
select empno, ename, job, mgr, deptno
from emp
where deptno = 20
with read only;

-- [����3] emp ���̺��� �� �μ��� �ִ� �޿��� �ּ� �޿��� �����ִ�
--        view�� �����, sales_view ��� �̸����� ����� ȭ�鿡 �����ּ���.
create or replace view sales_view
as
select deptno, max(sal) "�ִ�޿�", min(sal) "�ּұ޿�"
from emp
group by deptno
with read only;


-- [����4] emp ���̺��� �̿��Ͽ� �������� 'SALESMAN' �� ����� ���,
--        �̸�, ������, �Ի���, �μ���ȣ�� �÷����� �ϴ� view �� 
--        �����, emp_sale �̶�� view �� ����� ȭ�鿡 �����ּ���.
create or replace view emp_sale
as
select empno, ename, job, hiredate, deptno
from emp
where job = 'SALESMAN'
with read only;


/*
  Ʈ�����(Transaction)
  - ������ ó���� �� ������ ����.
  - ����Ŭ���� �߻��ϴ� ���� ���� SQL ��ɹ�����
    �ϳ��� ������ �۾� ������ ó���ϴ� ���� ����.
  - All or Nothing ������� ó����.
  - ��ɾ� ���� ���� ������ ���������� ó���� �Ǹ� �����ϰ�,
    ���� ���� ��ɾ� �߿��� �ϳ��� ����̶� �߸��� �Ǹ�
    ��ü�� ����ϴ� ���� ����. - �߿���
    
  - Ʈ����� ��� ���� : �������� �ϰ����� �����ϸ鼭 
                       �������� �������� �����ϱ� ���� �����.
  - Ʈ����� ��� �� Ʈ������� �����ϱ� ���� ��ɾ�.
    1) commit : ��� �۾��� ���������� ġ���ϰڴٰ� Ȯ���ϴ� ��ɾ�.
                Ʈ�����(insert, update, delete) �۾��� ������
                ���� DB�� �ݿ�.
                ������ �ִ� �����Ϳ� update ������ �߻��� ��.
                ��� ����ڰ� ����� �������� ����� �� �� ����.
    2) rollback : �۾� �߿� ������ �߻����� �� Ʈ����� ó�� ��������
                  �߻��� ���� ������ ����Ͽ� ���� ���·� �ǵ����� ��ɾ�.
                  Ʈ�����(insert, update, delete) �۾��� ������ �����.
                  ������ commit �� �������� ������ ��.
*/

-- 1. dept ���̺��� �����Ͽ� dept_02 ��� ���̺��� ����� ����.
create table dept_02
as
select * from dept;

-- 2. dept_02 ���̺��� 40�� �μ��� ������ ����.
--    ����) delete from ���̺��̸� where �÷���(primary key) = ����(������)
delete from dept_02 where deptno = 40;
-- commit �� �� ����.
commit;

-- 3. dept_02 ���̺��� ��ü �����͸� ������ ����.
delete from dept_02;

-- 4. �� �� ���� 20�� �μ��� ���ؼ��� ������ �ϰ� �;��µ�
--    �߸��ؼ� ��ü�� ������ �� ���, �ٽ� ���� �� �� ����.
rollback;

-- 5. 20�� �μ��� ������ ����.
delete from dept_02 where deptno = 20;

-- 6. �����ͺ��̽��� �����ϰ� ������ ����.
commit;

/*
  savepoint ����
  - Ʈ������� �۰� �����ϴ� ���� ����.
  - ����ڰ� Ʈ����� �߰� �ܰ迡�� ����Ʈ�� �����Ͽ�
    Ʈ����� ���� Ư�� savepoint ���� rollback �� ��
    �ְ� �ϴ� ���� ����.
*/

-- 1. dept ���̺��� �����Ͽ� dept_03 �̶�� ���̺��� ������.
create table dept_03
as
select * from dept;

-- 2. dept_03 ���̺��� 40�� �μ��� ������ �� commit �� ����.
delete from dept_03 where deptno = 40;
commit;

-- 3. dept_03 ���̺��� 30�� �μ��� ������ ����.
delete from dept_03 where deptno = 30;

-- 4. �� �� savepoint sp1�� ������ ����.
savepoint sp1;

-- 5. �μ���ȣ�� 20�� �μ��� ������ ����.
delete from dept_03 where deptno = 20;

-- 6. �� �� savepoint sp2�� ������ ����.
savepoint sp2;

-- 7. ���������� 10�� �μ��� ������ ����.
delete from dept_03 where deptno = 10;

-- 8. �� �� �μ���ȣ�� 20���� �μ��� �����ϱ� �ٷ�
--    ������ �ǵ��� ���� ���� ���
rollback sp1;


/*
  Ư�� ���̺��� �÷��� �����ϴ� ���
  ����)
        update ���̺��̸� set ������ �÷��̸�1 = ������ �÷�����,
                             ������ �÷��̸�2 = ������ �÷�����,
                             ������ �÷��̸�3 = ������ �÷�����
               where �÷���(primary key) = ��;
               
        �� ���ǻ���) ���࿡ where �������� ������ �Ǹ� ���̺� ��ü
                    �����Ͱ� ������ �̷����.
*/

update student set major = '�����а�', addr = '����� �߱� �����'
            where hakbun = '2023_002';
            


/*
  PL/SQL(Procedual Language / SQL)
  - SQL �����δ� ������ ��ưų� ���� �Ұ����� �۾��� �����ϱ� ���ؼ�
    ����Ŭ���� �����ϴ� ���α׷��� �� ����.
  - �Ϲ������� ���α׷��� ������� ��ҵ��� �� ������ ������, �����ͺ��̽�
    ������ ó���ϱ� ���� ����ȭ�� ���.
  - ����, ���� ó��, �ݺ� ó�� �� �پ��� ����� ����� �� ����.

  - �⺻ ����
    1) �����(declare) : ��� ������ ����� �����ϴ� �κ�.
    2) �����(executable ~ begin)
       - ���� ������ ����Ǵ� �κ�.
       - ���(���ǹ�), �ݺ���, �Լ� ���� ���� ������ ����ϴ� �κ�.
    3) ����ó����(exception)
       - ���� ���� ���ܰ� �߻����� �� �ذ��ϱ� ���� ��ɵ��� ����ϴ� �κ�.
       
  - �� �⺻ ���� �߿��� ����ο� ����ó���δ� ������ ����������,
    ����δ� �ݵ�� �����ؾ� ��.
    
  - PL/SQL ��� �� ���ǻ���.
    1) �⺻ ����(declare, begin, exception) Ű���� �ڿ���
       �����ݷ�(;)�� ������ �ʴ´�.
    2) ���� �� �κп��� �����ؾ� �ϴ� ���� ������ �ݵ�� 
       �����ݷ�(;)�� ���δ�.
    3) begin ~ end(�����) �ؿ��� �ݵ�� "/" �� �ٿ� �־�� �Ѵ�.
*/

-- PL/SQL���� ȭ�鿡 ����� �ϱ� ���ؼ��� PL/SQL�� ��±����
-- Ȱ��ȭ ���� �־�� �Ѵ�.
set serveroutput on;

-- ȭ�鿡 �ؽ�Ʈ�� ����� ����.
begin
    dbms_output.put_line('Hello PL/SQL!!!');
end;
/

-- �����(declare) ������ ������ �����ϴ� ���
-- 1) ��Į�� �ڷ���
--    ����) ������ �ڷ���(ũ��)
--          ��) num number(5); name varchar2(20);
declare
    v_empno number(4);
    v_ename varchar2(20) := 'ADAMS';
begin
    v_empno := 7788;
    
    dbms_output.put_line('v_empno >>> ' || v_empno);
    dbms_output.put_line('v_ename >>> ' || v_ename);
end;
/

-- 2) ���۷��� �ڷ���
--    ���̺� ���ǵ� �÷��� �ڷ����� ũ�⸦ ��� �ľ��ϰ� �ִٸ�
--    ������ ��������, ��κ��� �׷��� ���ϱ� ������ ����Ŭ������
--    ���۷���(reference) ������ ������ ��.
--    ����) ������ ���̺��.�÷���%type;
--         ��) num emp.empno%type;

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

-- 3) rowtype �ڷ���
--    ���̺��� ��� �÷��� �Ѳ����� �����ϱ� ���� ������ �����ϴ� ���.
--    ����) e_row emp%rowtype;

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
  ���� ���(���ǹ�)
  - Ư�� ���ǽ��� ���� ��Ȳ�� ���� ������ ������ �޸��ϴ�
    ����� ��ɾ ����.
    
  1. if ���ǹ�
     1) if ~ then
        - Ư�� ������ �����ϴ� ��쿡�� �۾��� ����.
        - ����) 
                if ���ǽ� then
                    ���ǽ��� ���� ��� ���� ����;
                end if
     2) if ~ then ~ else
        - Ư�� ���ǽ��� �����ϴ� ���� �ݴ��� ��쿡
          ���� ������ �۾��� ����.
        - ����)
                if ���ǽ� then
                    ���ǽ��� ���� ��� ���� ����;
                else
                    ���ǽ��� ������ ��� ���� ����;
                end if
     3) if ~ then ~ elsif
        - ���� ���� ���ǿ� ���� ���� ������ �۾��� ����.
        - ����)
                if ���ǽ�1 then
                    ���ǽ�1�� ���� ��� ���� ����;
                elsif ���ǽ�2 then 
                    ���ǽ�1�� �����̰�, ���ǽ�2�� ���� ��� ���� ����;
                elsif ���ǽ�3 then
                    ���ǽ�1, ���ǽ�2�� �����̰�, ���ǽ�3�� ���� ��� ���� ����;
                else 
                    ���ǽ�1, ���ǽ�2, ���ǽ�3 ��ΰ� ������ ��� ���� ����;
                end if
*/

-- 1) if ~ then
declare
    e_number number(3) := 77;
begin
    if e_number >= 10 then
        dbms_output.put_line(e_number || ' �� 10���� ū ���Դϴ�.');
    end if;
end;
/

-- 2) if ~ then ~ else
-- [����] ������ ��� �ִ� ���� Ȧ������, ¦������
--       �Ǻ��Ͽ� ȭ�鿡 ����� ������.
declare
    e_num number(3) := 87;
begin
    if mod(e_num, 2) = 1 then
        dbms_output.put_line(e_num || ' ��(��) Ȧ���Դϴ�.');
    else
        dbms_output.put_line(e_num || ' ��(��) ¦���Դϴ�.');
    end if;
end;
/

-- 3) if ~ then ~ elsif
declare
    e_avg number(5,2) := 89.12;
begin
    if e_avg >= 90 then
        dbms_output.put_line('A�����Դϴ�.');
    elsif e_avg >= 80 then
        dbms_output.put_line('B�����Դϴ�.');
    elsif e_avg >= 70 then
        dbms_output.put_line('C�����Դϴ�.');
    elsif e_avg >= 60 then
        dbms_output.put_line('D�����Դϴ�.');
    else
        dbms_output.put_line('F�����Դϴ�.');
    end if;
end;
/

-- Ű����� �����͸� �Է� �޴� ���
declare
    e_num number(3);
begin

    e_num := '&num';
    
    dbms_output.put_line('�Է¹��� �� >>> ' || e_num);

end;
/

/*
  2. case ���ǹ�
     ����)
            case �񱳱���
                when ��1 then
                    ��1 �϶� ������ ��ɹ�;
                when ��2 then
                    ��2 �϶� ������ ��ɹ�;
                when ��3 then
                    ��3 �϶� ������ ��ɹ�;
                else
                    ��1, ��2, ��3�� �ƴ� �ٸ� ���� ��� ������ ��ɾ�;
                end case;
*/

declare
    e_score number(3);
begin
    e_score := '&score';
    
    case trunc(e_score / 10)
        when 10 then
            dbms_output.put_line('A�����Դϴ�.');
        when 9 then
            dbms_output.put_line('A�����Դϴ�.');
        when 8 then
            dbms_output.put_line('B�����Դϴ�.');
        when 7 then
            dbms_output.put_line('C�����Դϴ�.');
        when 6 then
            dbms_output.put_line('D�����Դϴ�.');
        else
            dbms_output.put_line('F�����Դϴ�.');
    end case;
end;
/

/*
  �ݺ� ���
  - Ư�� �۾��� �ݺ��Ͽ� �����ϰ��� �� �� ����ϴ� ����.
  - �ݺ� ����� ����
    1) �⺻ loop
       - ���� �⺻���� �ݺ���.
    2) while loop
       - Ư�� ������ ����� ���ؼ� �ݺ��� �����ϴ� �ݺ���.
    3) for loop
       - �ݺ� Ƚ���� ���Ͽ� �ݺ��� �����ϴ� �ݺ���.
  - �ݺ����� �ݺ����� ������ �����Ű�� ��ɾ�.
    1) exit
       - �������� �ݺ��� �����Ű�� ��ɾ�.
    2) exit ~ when
       - �ݺ� ���Ḧ ���� ���ǽ��� �����ϰ� �����ϸ� �ݺ���
         �����Ű�� ��ɾ�.
    3) continue
       - ���� ���� �ݺ��� ���� �ֱ⸦ �ǳ� �ٴ� ��ɾ�.
    4) continue ~ when
       - Ư�� ���ǽ��� �����ϰ� ���ǽ��� �����ϸ� �ݺ� �ֱ⸦
         �ǳ� �ٴ� ��ɾ�.
*/

-- �⺻ loop
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
    dbms_output.put_line('*** 1 ~ 100 ������ �� ***');
    
    while e_num <= 100 loop
        e_sum :=  e_sum + e_num;
        e_num := e_num + 1;
    end loop;
    
    dbms_output.put_line('�� �� >>> ' || e_sum);
end;
/

-- for loop
declare
    e_tot number(5) := 0;
begin
    dbms_output.put_line('*** for���� �̿��� 1 ~ 100 ������ �� ***');
    
    for e_num in 1 .. 100 loop
        e_tot := e_tot + e_num; 
    end loop;
    
    dbms_output.put_line('�� �� >>> ' || e_tot);
end;
/

-- Ű����� �Է¹��� �������� ���� ���� ����.
declare
    e_tot number(5) := 0;
    e_su number(3);
begin
    dbms_output.put_line('*** for���� �̿��� 1 ~ 100 ������ �� ***');
    
    e_su := '&su';
    
    for e_num in 1 .. e_su loop
        e_tot := e_tot + e_num; 
    end loop;
    
    dbms_output.put_line('�� �� >>> ' || e_tot);
end;
/






