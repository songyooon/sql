create table faqa(no number primary key, title varchar2(100) not null, content varchar2(600), author varchar2(16), resdate date default sysdate, gubun number not null, parno number not null);

create sequence fseq;

insert into faqa values (fseq.nextval, '질문1', '내용', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '질문2', '내용', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '질문3', '내용', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '답변1', '내용', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '답변2', '내용', 'admin', sysdate, 0, fseq.currval);
insert into faqa values (fseq.nextval, '답변3', '내용', 'admin', sysdate, 0, fseq.currval);

select * from faqa;