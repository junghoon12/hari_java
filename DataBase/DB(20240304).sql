/*
  PL/SQL(Procedual Language / SQL)
  - SQL �����δ� ������ ��ưų� ���� �Ұ����� �۾��� �����ϱ� ���ؼ�
    ����Ŭ���� �����ϴ� ���α׷��� �� ����.
  - �Ϲ������� ���α׷��� ������� ��ҵ��� �� ������ ������, �����ͺ��̽�
    ������ ó���ϱ� ���� ����ȭ�� ���.
  - ����, ���� ó��, �ݺ� ó�� �� �پ��� ����� ����� �� ����.
  - PL/SQL�� ���ø����̼� ���� �ʿ��� ����Ǵ� ���� �ƴ϶�, �����ͺ��̽�
    ���� �ʿ��� ������ ��. ���� �����Ϳ� ���� ����� ���� ��ġ�ϰ�
    �����Ƿ� ���ø����̼� ������ �����͸� �ְ� �޴µ� ������ ��Ʈ��ũ
    Ʈ������ �ּ�ȭ �ȴٴ� ������ ����.
    
  - �⺻ ����
    1) �����(declare) : ��� ������ ����� �����ϴ� �κ�.
    2) �����(executable - begin)
       - ���� ������ ����Ǵ� �κ�.
       - ���(���ǹ�), �ݺ���, �Լ� ���� ���� ������ ����ϴ� �κ�.
    3) ����ó����(exception)
       - ���� ���� ���ܰ� �߻� �� �ذ��ϱ� ���� ��ɵ��� ����ϴ� �κ�.
       
    �� �� �⺻ ���� �߿��� ����ο� ����ó���δ� ������ ����������,
       ����δ� �ݵ�� �����ؾ� ��.
       
  - PL/SQL ��� �� ���ǻ���.
    1) �⺻ ����(declare, begin, exception) Ű���� �ڿ��� �����ݷ�(;)��
       ������ �ʴ´�.
    2) ���� �� �κп��� �����ؾ� �ϴ� ���� ������ �ݵ�� �����ݷ�(;)�� ���δ�.
    3) begin ~ end(�����) �ؿ��� �ݵ�� "/" �� �ٿ� �־�� �Ѵ�.
*/

-- ȭ�鿡 ��� ����� Ȱ��ȭ�� ���� �־�� �Ѵ�.
set serveroutput on;

-- "Hello PL/SQL" �̶�� ������ PL/SQL�� �̿��Ͽ� ȭ�鿡 ����� ����.

begin
-- ȭ��(�ܼ�)�� ������ ����ϴ� ��ɹ�
   dbms_output.put_line('Hello PL/SQL');
end;
/


-- �����(declare) ������ ������ �����ϴ� ���
-- 1) ��Į�� �ڷ���
--    ����) ������ �ڷ���(ũ��)
--          ��) num number;  name varchar2(30);

declare
    v_empno number(4) := 7788;
    v_ename varchar2(30);
begin
    v_ename := 'ADAMS';
    
    dbms_output.put_line('v_empno >>> ' || v_empno);
    dbms_output.put_line('v_ename >>> ' || v_ename);
    
end;
/


-- 2) ���۷��� �ڷ���
-- ���̺� ���ǵ� �÷��� �ڷ����� ũ�⸦ ��� �ľ��ϰ� �ִٸ�
-- ������ ��������, ��κ��� �׷��� ���ϱ� ������ ����Ŭ������
-- ���۷���(reference) ������ ������ ��.
-- ����) ������ ���̺��.�÷�%type;
-- ��) num emp.empno%type;

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
-- ���̺��� ��� �÷��� �Ѳ����� �����ϱ� ���� ������ �����ϴ� ���.
-- ����) e_row emp%rowtype;

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

-- [����] dept ���̺��� rowtype���� �Ͽ� 30�� �μ��� �ش��ϴ� ������
-- ȭ�鿡 �����ּ���.

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
  ���� ���(���ǹ�)
  - Ư�� ���ǽ��� ���� ��Ȳ�� ���� ������ ������ �޸��ϴ� 
    ����� ��ɹ��� ����.

  1. if ���ǹ�
     1) if ~ then ���ǹ�
        - Ư�� ������ �����ϴ� ��쿡�� �۾��� ����.
        - ����)
                if ���ǽ� then
                    ���ǽ��� ���� ��� ���� ����;
                end if;
        
     2) if ~ then ~ else ���ǹ�
        - Ư�� ������ �����ϴ� ���� �������� �ʴ� ���
          ���� ������ �۾��� ����.
        - ����) 
                if ���ǽ� then
                    ���ǽ��� ���� ��� ���� ����;
                else
                    ���ǽ��� ������ ��� ���� ����;
                end if;
     
     3) if ~ then ~ elsif ���ǹ�
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
                end if;
*/

-- 1) if ~ then
declare
    e_number number := 77;
begin
    if e_number >= 50 then
        dbms_output.put_line(e_number || ' ��(��) 50���� ū ���Դϴ�.');
    end if;
end;
/

-- 2) if ~ then ~ else
-- [����] ������ ��� �ִ� ���� Ȧ������, ¦������ �Ǻ��Ͽ�
--       ȭ�鿡 ����� ������.

declare
    e_num number := 86;
begin
    
    if mod(e_num, 2) = 1 then
        dbms_output.put_line(e_num || ' ��(��) Ȧ���Դϴ�.');
    else 
        dbms_output.put_line(e_num || ' ��(��) ¦���Դϴ�.');
    end if;
end;
/

-- 3) if ~ then ~ elsif ���ǹ�
declare
    e_avg number := 88.12;
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
    e_num number;
begin

    e_num := '&num';
    
    dbms_output.put_line('�Է� ���� ������ >>> ' || e_num);
end;
/

/*
  2. case ���ǹ�
     ����)
            case �񱳱���
                when ��1 then
                    ��1 �� �� ������ ����;
                when ��2 then
                    ��2 �� �� ������ ����;
                when ��3 then
                    ��3 �� �� ������ ����;
                else
                    ��1, ��2, ��3 �� �ƴ� �ٸ� ���� ��� ������ ����;
            end case;
*/

-- [����] Ű����� ������ �Է¹޾Ƽ� ������ ȭ�鿡 ����� ������.

declare
    e_score number;
begin

    e_score := '&score';
    
    case trunc(e_score / 10)
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
  - Ư�� �۾��� �ݺ��Ͽ� �����ϰ��� �� �� ����ϴ� ���.
  - �ݺ� ����� ����
    1) �⺻ loop
       - ���� �⺻���� �ݺ���.
    2) while loop
       - Ư�� ������ ����� ���ؼ� �ݺ��� �����ϴ� �ݺ���.
    3) for loop
       - �ݺ� Ƚ���� ���Ͽ� �ݺ��� �����ϴ� �ݺ���.
  - �ݺ����� �ݺ����� ������ �����Ű�� ��ɾ�.
    1) exit
       - ���� ���� �ݺ��� �����Ű�� ��ɾ�.
    2) exit ~ then
       - �ݺ� ���Ḧ ���� ���ǽ��� �����ϰ� �����ϸ�
         �ݺ��� �����Ű�� ��ɾ�.
    3) continue
       - ���� ���� �ݺ��� ���� �ֱ⸦ �ǳ� �ٴ� ��ɾ�.
    4) continue ~ when
       - Ư�� ���ǽ��� �����ϰ� ���ǽ��� �����ϸ� �ݺ� �ֱ⸦
         �ǳ� �ٴ� ��ɾ�.
*/

-- �⺻ loop �ݺ��� ����� ����.
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
    e_sum number := 0;  -- ���� ������Ű�� ����
begin

    dbms_output.put_line('*** 1 ~ 100  ������ �� ***');
    
    while e_su <= 100 loop
        e_sum := e_sum + e_su;
        e_su := e_su + 1;
    end loop;

    dbms_output.put_line('�� �� >>> ' || e_sum);
end;
/

-- for loop ����
declare
    e_tot number := 0;
begin
    
    dbms_output.put_line('*** for loop ���� �̿��� 1 ~ 100 ������ �� ***');
    
    for e_num in 1 .. 100 loop
        e_tot := e_tot + e_num;
    end loop;
    
    dbms_output.put_line('�� �� >>> ' || e_tot);
end;
/


select * from member order by memno desc;

select max(memno) from member;

