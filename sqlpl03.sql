select * from boarda;
desc boarda;
drop sequence bseq;
create sequence bseq;
select * from membera;
insert into boarda values (bseq.nextval, '�׽�Ʈ ��1', '�׽�Ʈ ��1�� �����Դϴ�.', 'kkt', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��2', '�׽�Ʈ ��2�� �����Դϴ�.', 'kkt', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��3', '�׽�Ʈ ��3�� �����Դϴ�.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��4', '�׽�Ʈ ��4�� �����Դϴ�.', 'kkt09072', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��5', '�׽�Ʈ ��5�� �����Դϴ�.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��6', '�׽�Ʈ ��6�� �����Դϴ�.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��7', '�׽�Ʈ ��7�� �����Դϴ�.', 'kkt09072', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��8', '�׽�Ʈ ��8�� �����Դϴ�.', 'kkt', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��9', '�׽�Ʈ ��9�� �����Դϴ�.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��10', '�׽�Ʈ ��10�� �����Դϴ�.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '�׽�Ʈ ��11', '�׽�Ʈ ��11�� �����Դϴ�.', 'kkt', sysdate);

drop table memberb;
create table memberb as select * from membera;
select * from memberb;
alter table memberb add pt number default 0;
create table boardb as select * from boarda;
select * from boardb;

-- 1. ���ڵ� ���� ���ν��� �Ǵ� �Լ�

-- ���ν���
-- ���ν��� ���Ǻ�1
-- �̸� : member_del, ��� : ȸ��(memberb) ���̺��� ��� ���ڵ带 �����Ѵ�.
CREATE OR REPLACE PROCEDURE member_del
IS
BEGIN
    delete from memberb;    
END;
/

-- ���ν��� ȣ���1
EXECUTE member_del;


-- �Լ� ���Ǻ�1
-- �̸� : board_del(�Ű�����)
-- �Ű����� : aut varchar2(20)
-- ��� : �ۼ��� ���̵� �Ű������� �Է¹޾� �ش� �ۼ��ڰ� �ۼ��� ���� �����϶�.
CREATE OR REPLACE FUNCTION board_del(aut in boardb.author%TYPE)
RETURN NUMBER
IS
BEGIN
    delete from boardb where author = aut;
    return 1;
END;
/

-- �Լ� ȣ���1
VARIABLE x number;
EXECUTE :x := board_del('kkt');


-- 2. ���ڵ� �����ϴ� ���ν��� �Ǵ� �Լ�
-- ���� ���ν���
-- �̸� : update_point, ��� : �α��� �� �� ���� ����Ʈ�� 5 ����Ʈ�� �������Ѷ�
-- �������� : data_up - ����ġ 5�� �⺻�� ����
CREATE OR REPLACE PROCEDURE update_point
IS
    data_up number := 5;
BEGIN
    update memberb set pt=pt+data_up;
END;
/

EXECUTE update_point;
select * from memberb;
    
-- ���� �Լ�
-- �̸� : up_point, �Ű����� : Ư�����̵�, ��� : �α��� �� �� ���� ����Ʈ�� 5 ����Ʈ�� �������Ѷ�
-- �������� : data_up - ����ġ 5�� �⺻�� ����
CREATE OR REPLACE FUNCTION up_point(userid in memberb.id%TYPE)
RETURN NUMBER
IS
    data_up number := 5;
BEGIN
    update memberb set pt=pt+5 where id = userid;
    return data_up;
END;
/

VARIABLE x number;
EXECUTE :x := up_point('kkt');
select * from memberb;

-- 3. �߰�(����) ���ν��� �Ǵ� �Լ�
-- �߰� ���ν���
-- �̸� : insert_pro
-- �Ű����� : pid, ppw, pname, pemail, ptel, pregdate, ppt
-- ��� : ���̵�, ��й�ȣ, �̸�, �̸���, ��ȭ��ȣ, �������� �Ű������� �޾� memberb�� Ʃ�÷� �߰�
CREATE OR REPLACE PROCEDURE insert_pro(pid memberb.id%TYPE,
ppw memberb.pw%TYPE, pname memberb.name%TYPE,
pemail memberb.email%TYPE, ptel memberb.tel%TYPE, 
pregdate memberb.regdate%TYPE, ppt memberb.pt%TYPE)
AS
BEGIN
    insert into memberb(id, pw, name, email, tel, regdate, pt) 
    values (pid, ppw, pname, pemail, ptel, pregdate, ppt);
END;
/
EXECUTE insert_pro('sbs','2222','�赵��','kdy1004@gmail.com','010-1004-1004','2022-10-25',0);
select * from memberb;

-- �߰� �Լ�
-- �̸� : insert_fnc
-- �Ű����� : pid, ppw, pname, pemail, ptel, pregdate, ppt
-- ��� : ���̵�, ��й�ȣ, �̸�, �̸���, ��ȭ��ȣ, �������� �Ű������� �޾� memberb�� Ʃ�÷� �߰�
CREATE OR REPLACE FUNCTION insert_fnc(pid memberb.id%TYPE,
ppw memberb.pw%TYPE, pname memberb.name%TYPE,
pemail memberb.email%TYPE, ptel memberb.tel%TYPE, 
pregdate memberb.regdate%TYPE, ppt memberb.pt%TYPE) 
RETURN number
IS
    data1 number;
BEGIN
    insert into memberb(id, pw, name, email, tel, regdate, pt) 
    values (pid, ppw, pname, pemail, ptel, pregdate, ppt);
    commit;
    RETURN data1;
END;
/
variable data_in number;
execute :data_in := insert_fnc('kbs','3333','����ȭ','pph7979@gmail.com','010-1234-7979','2022-10-25',0);
select * from memberb;


-- 4. �˻� ���ν��� �Ǵ� �Լ�
-- �˻� ���ν���
-- �̸� : sel_pro
-- �Ű����� : sel_date, sel_id
-- ��� : �����ϰ� ���̵� �Է¹޾� �ش� ȸ���� �˻��Ͽ� �� ȸ���� �̸��� ����϶�.
SET serveroutput ON;
CREATE OR REPLACE PROCEDURE sel_pro(sel_date in memberb.regdate%TYPE,
sel_id in memberb.id%TYPE)
IS
    k_name memberb.name%TYPE;
BEGIN
    dbms_output.enable;
    select name into k_name from memberb where regdate <= sel_date and id=sel_id;
    dbms_output.put_line('ȸ����' ||':'|| k_name);
END;
/
EXECUTE sel_pro('2022-10-24','admin');

-- �˻� �Լ�
-- �̸� : sel_fnc
-- �Ű����� : sel_date, sel_id
-- ��� : �����ϰ� ���̵� �Է¹޾� �ش� ȸ���� �˻��Ͽ� �� ȸ���� �̸��� ����϶�.
CREATE OR REPLACE FUNCTION sel_fnc(sel_date in memberb.regdate%TYPE,
sel_id in memberb.id%TYPE)
RETURN varchar
IS
    u_id memberb.id%TYPE;
    u_name memberb.name%TYPE;
BEGIN
    select name into u_name from memberb where regdate <= sel_date and id=sel_id;
    return u_name;
END;
/
select sel_fnc('2022-10-24', 'admin') from dual;


alter table memberb add birth number;
select * from memberb;
update memberb set birth=1981 where id='kkt';
update memberb set birth=2022 where id='admin';
update memberb set birth=1983 where id='kkt09072';
update memberb set birth=1994 where id='sbs';
update memberb set birth=1990 where id='kbs';

-- 5. �˻� ���ν���2
/* memberb ���̺��� REGDATE(������)�� �������� �����Ͽ� ���̺��� ȸ�����̵�, ȸ����, ����⵵, ������ �÷��� ǥ�õǵ��� �ϴ�
PL ���ν��� �Ǵ� �Լ��� �ۼ��ϰ�, �����ϵ�, ���ν��� �Ǵ� �Լ��̸� : memberb_sort
��Ÿ �ʿ��� ���� �Ǵ� ��Ҵ� ���Ƿ� �� ��. */
CREATE OR REPLACE PROCEDURE memberb_sort
    IS
        TYPE m_id_type IS TABLE OF memberb.id%TYPE INDEX BY BINARY_INTEGER;
        TYPE m_name_type IS TABLE OF memberb.name%TYPE INDEX BY BINARY_INTEGER;
        TYPE m_birth_type IS TABLE OF memberb.birth%TYPE INDEX BY BINARY_INTEGER;
        TYPE m_regdate_type IS TABLE OF memberb.regdate%TYPE INDEX BY BINARY_INTEGER;
        i BINARY_INTEGER := 0;
        v_id m_id_type;
        v_name m_name_type;
        v_birth m_birth_type;
        v_regdate m_regdate_type;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        DBMS_OUTPUT.PUT_LINE( '���̵�' || '   ' || 'ȸ����' || '   ' || '����⵵' || '   ' || '������');
        /* %TYPE �������� ���� ��� */
        FOR r IN (SELECT id, name, birth, regdate FROM memberb ORDER BY regdate) LOOP
            i := i+1;
            v_id(i) := r.id;
            v_name(i) := r.name;
            v_birth(i) := r.birth;
            v_regdate(i) := r.regdate;
        END LOOP;
        
        FOR j IN 1..i LOOP
            dbms_output.put_line(v_id(j) || '   ' || v_name(j) || '   ' || v_birth(j) || '   ' || v_regdate(i));
        END LOOP;
END;
/
execute memberb_sort;

alter table memberb add visited number default 0;
select * from memberb; 
update memberb set visited=57 where id='kkt'; 
update memberb set visited=100 where id='admin';
update memberb set visited=84 where id='kkt09072';
update memberb set visited=48 where id='sbs';
update memberb set visited=27 where id='kbs';

-- 6. ���� ���ν���
/* memberb ���̺��� visited �÷����� ȸ������� ���Ͽ� ȸ�����̵�, ȸ���̸�, �����
����ϴ� PL ���ν��� �Ǵ� �Լ��� �ۼ��ϰ�, �����ϵ�, IF��, �ݺ����๮(WHILE, LOOP, FOR) 
�� ����ϰ�, PL ���ν��� �Ǵ� �Լ��� �ۼ��ϰ�, �����ϵ�, ���ν��� �Ǵ� �Լ��̸��� : member_rank 
ȸ����� : 100ȸ �̻� �湮�� ���ȸ��, 50ȸ �̻� �湮�� ��ȸ��, 50ȸ �̸� �湮�� ��ȸ�� ����
�ϸ�, ȸ������� �÷��� �湮Ƚ���� visited�� Ȱ���� ��. */
CREATE OR REPLACE PROCEDURE member_rank
    IS
        TYPE m_id_type IS TABLE OF memberb.id%TYPE INDEX BY BINARY_INTEGER;
        TYPE m_name_type IS TABLE OF memberb.name%TYPE INDEX BY BINARY_INTEGER;
        TYPE m_rank_type IS TABLE OF memberb.name%TYPE INDEX BY BINARY_INTEGER;
        TYPE m_visited_type IS TABLE OF memberb.visited%TYPE INDEX BY BINARY_INTEGER;
        i BINARY_INTEGER := 0;
        v_id m_id_type;
        v_name m_name_type;
        v_rank m_rank_type;
        v_visited m_visited_type;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        DBMS_OUTPUT.PUT_LINE( '���̵�' || '   ' || 'ȸ����' || '   ' || '���');
        /* %TYPE �������� ���� ��� */
        FOR r IN (SELECT id, name, visited FROM memberb) LOOP
            i := i+1;
            v_id(i) := r.id;
            v_name(i) := r.name;
            v_visited(i) := r.visited;
            IF(v_visited(i) >= 100) THEN v_rank(i) := '���ȸ��';
            ELSIF(v_visited(i) >= 50) THEN v_rank(i) := '��ȸ��';
            ELSE v_rank(i) := '��ȸ��';
            END IF;
        END LOOP;
        
        FOR j IN 1..i LOOP
            dbms_output.put_line(v_id(j) || '   ' || v_name(j) || '   ' || v_rank(j));
        END LOOP;
END;
/
execute member_rank;


create table product(tno number primary key, pname varchar2(40), dan number); -- ��ǰ ���̺�
create table inventory(ino number, quant number, price number); -- ��� ���̺�
create table wearing(ino number, quant number, price number); -- �԰� ���̺�
create table sales(ino number, quant number, price number); -- �Ǹ� ���̺�

-- ���� ������ �߰�
INSERT INTO product VALUES(100,'�����',1500);
INSERT INTO product VALUES(200,'���ڱ�',1000);
INSERT INTO product VALUES(300,'������',2000);
INSERT INTO product VALUES(400,'���ĸ�',1800);
INSERT INTO product VALUES(500,'������',1600);
 


-- 7. Ʈ����� Ʈ����
/* �԰�(wearing) ���̺� ��ǰ�� �԰��ų �� ����, ���ο� ��ǰ�� ���� �̹� �ִ� ��� ��ǰ�� ���� �з��Ͽ�
���(inventory) ���̺� �ݿ��� �� �ֵ��� Ʈ���Ÿ� �ۼ��ϵ�, Ʈ���� �̸��� wearing_trigger�� �ϰ�,
������ �����͸� �԰� ���̺� Ʃ���� �Է��Ͽ� �ڵ� ���ó���� �� ����� Ȯ���Ͻÿ�.  */

-- ���� ������
-- �԰� 
INSERT INTO wearing VALUES(100,2,1500);
-- ���
INSERT INTO inventory VALUES(100,2,3000);
COMMIT;


CREATE OR REPLACE TRIGGER wearing_trigger
AFTER INSERT ON wearing
FOR EACH ROW
DECLARE
  v_cnt NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_cnt
  FROM inventory 
  WHERE ino=:NEW.ino;
  IF(v_cnt=0) THEN -- ��� ���� ��ǰ 
    INSERT INTO inventory VALUES(:NEW.ino,:NEW.quant,:NEW.price*:NEW.quant);
  ELSE  -- ��� �ִ� ��ǰ 
    UPDATE inventory SET
    quant=quant+:NEW.quant,
    price=price+(:NEW.quant*:NEW.price)
    WHERE ino=:NEW.ino;
  END IF;
END;
/


INSERT INTO wearing VALUES(200,1,1000);
COMMIT;
 
SELECT * FROM wearing;
SELECT * FROM inventory;
INSERT INTO wearing VALUES(100,3,1500);
COMMIT;

-- 8. ��� �ڵ���� Ʈ����
/* �ǸŰ� �Ǹ� �Ǹ�(sales) ���̺� ��ǰ�� ��ϵȴ�. �׷��ٸ� ���(inventory) ���̺� �ݿ��Ǿ� Ʃ����
���� �ǵ��� Ʈ���Ÿ� �ۼ��ϵ�, Ʈ���� �̸��� sales_trigger�� �ϰ�,
������ �����͸� �Ǹ� ���̺� Ʃ���� �Է��Ͽ� �ڵ� ������ �� ����� Ȯ���Ͻÿ�.  */

CREATE OR REPLACE TRIGGER sales_trigger
AFTER INSERT ON sales
FOR EACH ROW
DECLARE
  v_cnt NUMBER;
BEGIN
  SELECT quant-:NEW.quant INTO v_cnt
  FROM inventory
  WHERE ino=:NEW.ino;
  
  IF (v_cnt=0) THEN
    DELETE FROM inventory 
    WHERE ino=:NEW.ino;
  ELSE
    UPDATE inventory SET
    quant=quant-:NEW.quant,
    quant=quant-(:NEW.quant*:NEW.price)
    WHERE ino=:NEW.ino;
  END IF;
  
END;
/

SELECT * FROM inventory;
INSERT INTO sales VALUES(200,1,1000);
SELECT * FROM sales;
SELECT * FROM inventory;
COMMIT;



