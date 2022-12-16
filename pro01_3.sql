create table faqa(no number primary key, title varchar2(100) not null, content varchar2(600), author varchar2(16), resdate date default sysdate, gubun number not null, parno number not null);

create sequence fseq;

insert into faqa values (fseq.nextval, '����1', '����', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '����2', '����', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '����3', '����', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '�亯1', '����', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '�亯2', '����', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '�亯3', '����', 'admin', sysdate, 0, fseq.currval);

select * from faqa;