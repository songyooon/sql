

--�Ʒ��� ��� ������ ���� ������ ��¥ ������
DECLARE

BEGIN
    DELETE from member where id like 'k';
    dbms_ouput.put_line('ó�� �Ǽ� : ' || SQL%ROWCOUNT);
END;
/

--

declare
    cursor mem_cur is select * from member;
    mem_c member%rowtype;
begin
    open mem_cur;
    loop
        fetch mem_cur into mem_c;
        exit when mem_cur%notfound;
        dbms_output.put_line(mem_c.id || ',' || mem_c.name);
    end loop;
    close mem_cur;
end;
/

create table usera(id varchar2(20), name varchar2(40));
create table userb(ud varchar2(20), uname varchar2(40), pt number);

insert into usera values ('abc', '���̺�');
insert into usera values ('bcd', '�񾾵�');
insert into usera values ('cde', '������');

insert into userb values ('bcd', '�񾾵�', 50);
insert into userb values ('abc', '���̺�', 90);
insert into userb values ('def', '���̿���', 80);

create table producta(pid varchar2(8), pname varchar2(100), price number);
insert into producta values ('001','������',30000);
insert into producta values ('002','��û����',35000);
insert into producta values ('003','ª�������',28000);
insert into producta values ('004','ª��û����',32000);
insert into producta values ('005','ĥ�θ����',33000);
create table salesa(sno number primary key, id varchar2(20) not null, pid varchar2(8) not null, amount number not null, pid varchar2(8) not null, amount number not null);
create sequence seq;
insert into salesa values (seq.nextval, 'abc','003',8);
insert into salesa values (seq.nextval, 'bcd','001', 5);
insert into salesa values (seq.nextval, 'cde','002', 6);
insert into sales values (seq.nextval, 'abc','004', 4);
insert into sales values (seq.nextval, 'bcd', '005', 7);
select * from sales;
select a.sno, b.name, c.pname, a.amount from salesa a inner join usera b on a.id=b.id;
select a.sno, a.id, b.pname, a.smount from salesa a inner join producta b on a.pid=b.pid;
select a.sno, b.name, c.pname, a.amount from usera b inner join salesa a on a.id = b.id inner join producta c on a.pid = c.pid order by a.sno;
select a.sno, b.name, c.pname, a.smount from salesa a, usera b, producta c where a.id = b.id and a.pid = c.pid order by a.sno;
select a.sno, b.name, c.pname, c.price*a.amount from salesa a, usera b, producta c where a.id = b.id and a.pid = c.pid order by a.sno;


create view uni_view as select id, name from usera union select ud, uname from userb;
create view inter_view as select id, name from usera intersect select ud, uname from userb;
create view minus_view as select id, name from usera minus select ud, uname from userb;
select * from uni_view;
select * from inter_view;
select * from minus_view;

select * from usera, userb;

commit;

