create table qnaa(no number primary key, title varchar2(100) not null, content varchar2(1000) not null, author varchar2(20) not null, resdate date not null, lev number not null, parno number not null, sec char(1));

create sequence qseq;

insert into qnaa values (qseq.nextval, '����1', '����', 'test1test1', sysdate, 0, 1, 'Y');
insert into qnaa values (qseq.nextval, '����2', '����', 'test1test1', sysdate, 0, 2, 'Y');
insert into qnaa values (qseq.nextval, '����3', '����', 'test1test1', sysdate, 0, 3, 'N');
insert into qnaa values (qseq.nextval, '����1', '����', 'admin', sysdate, 1, 1, 'Y');
insert into qnaa values (qseq.nextval, '����2', '����', 'admin', sysdate, 1, 2, 'Y');
insert into qnaa values (qseq.nextval, '����3', '����', 'admin', sysdate, 1, 3, 'N');

delete from qnaa where no=6;

select * from qnaa;

commit;


--------test practice----------
