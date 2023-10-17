-- �м��Լ�
-- 1) row_number() �Լ�
--    ������ �Ǿ� �ִ� ����� ���Ͽ� ��ȣ�� �Ҵ��ϴ� �Լ�.
--    ����) row_number() over(order by ���Ľ�ų �÷���)
select * from
(select row_number() over(order by sal desc) as "��������", e.* from emp e)
-- where "��������" >= 1 and "��������" <= 5;
-- where "��������" between 1 and 5;
where "��������" <= 5;

select * from emp order by sal desc;

-- 2) rank() �Լ�
--    rank() �Լ� ��� �� ����� ������ �� ���� ���� ������
--    1��, 2��, 2��, 4�� ���� ǥ���ϴ� �Լ�.
select rank() over(order by sal desc) as rank, e.* from emp e;

-- 3) dense_rank() �Լ�
--    dense_rank() �Լ� ��� �� ����� ������ �� ���� ���� ������
--    1��, 2��, 2��, 3�� ���� ǥ���ϴ� �Լ�.
select dense_rank() over(order by sal desc) as rank, e.* from emp e;


-- [����1] products ���̺��� ��ǰ ������� ���� ���� 
--        ���� 5���� ��ǰ ����� ȭ�鿡 �����ּ���.
select * from
(select row_number() over(order by output_price desc) 
    as rnum, p.* from products p)
where rnum >= 1 and rnum <= 5;

-- [����2] member10 ���̺��� ȸ���� ���ϸ����� ���� ����
--        ���� 3���� ȸ���� ��� ������ ȭ�鿡 �����ּ���.
select * from
(select row_number() over(order by mileage desc) 
                as rnum, m.* from member10 m)
where rnum between 1 and 3;

-- [����3] emp ���̺��� �޿��� ���� �޴� ������� ȭ�鿡 �����ּ���.
--        ��, ��ŷ�� rank() over �Լ��� �̿��ϼ���.
select rank() over(order by sal desc) as rank, e.* from emp e;

-- [����4] products ���̺��� ����� ���� ������� ȭ�鿡 �����ּ���.
--        ��, ��ŷ�� rank() over �Լ��� �̿�.
select rank() over(order by output_price desc) 
                    as rank, p.* from products p;

-- [����5] member10 ���̺��� ȸ���� ���ϸ����� ū ������� ȭ�鿡 �����ּ���.
--        ��, ��ŷ�� dense_rank() over �Լ��� �̿�.
select dense_rank() over(order by mileage desc) as rank, m.* from member10 m;

-- [����6] member10 ���̺��� ȸ���� ���̰� ū ������� ȭ�鿡 �����ּ���.
--        ��, ��ŷ�� dense_rank() over �Լ��� �̿�.
select dense_rank() over(order by age desc) as rank, m.* from member10 m;
