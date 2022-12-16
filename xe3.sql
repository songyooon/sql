create table member(id varchar2(12) PRIMARY KEY, -- 회원아이디
password varchar2(12) not null, -- 비밀번호
name varchar2(20) not null,
address varchar2(100),
tel varchar2(20) not null,
reg_date date default sysdate);

create table book(bookid number(10) primary key,
bookkind varchar2(3) not null,
booktitle VARCHAR(50) not null,
boolprice NUMBER(10) not null,
bookcount NUMBER(5) not null,
author varchar2(40),
pubcom varchar2(40),
pubdate date);

create table sales(sno number primary key,
bno number(10) not null,
id varchar2(12) not null,
amount NUMBER(5) default 1,
money number,
salesday date default sysdate);

commit;

insert into member values('ykh','a1234','유광현','도내동 13','010-111-2222','2022-09-13');
insert into member values('lhy','a3421','이하영','마두동 888','031-2222-3333','2022-09-13');
insert into member values('lhn','b1111','이해나','백석동 777','010-3333-4444','2022-09-14');
insert into member values('jbj','c456','정병진','성사동 178','010-4444-5555','2022-090-15');
insert into member values('jjs','z675','정진석','원흥동 75','031-4444-2222','2022-09-11');
insert into member values('cmj','q789','조민재','창릉동 1004','010-5555-6666','2022-09-13');
insert into member values('hsy','g478','한시연','창신동 128','010-6666-7777','2022-09-13');
insert into member values('hth','d666','한태헌','행신동 67','010-7777-8888','2022-09-14');
insert into member values('kyj','e964','고유진','화정동 912','031-5555-2222','2022-09-05');
insert into member values('nsy','h369','남송윤','흥도동 37','010-8888-9999','2022-09-16');

insert into book values(bseq.nextval, 'IT', '이것이 자바다', 30000, 10, '신용권','한빛미디어','2021-08-20');
insert into book values(bseq.nextval, 'IT', '자바웹개발워크북', 31500, 19, '구멍가게코딩단', '남가람북스','2022-08-04');
insert into book values(bseq.nextval, 'NV', '하얼빈', 14400, 15, '김훈', '문학동네', '2022-08-03');
insert into book values(bseq.nextval, 'NV', '불편한편의점', 12600, 10, '김호연', '나무옆의자', '2022-08-10');
insert into book values(bseq.nextval, 'DV', '역행자', 15750, 8, '자청', '웅진출판', '2022-05-30');
insert into book values(bseq.nextval, 'DV', '자소서바이블', 18000, 15, '이형', '엔알디', '2022-08-25');
insert into book values(bseq.nextval, 'HC', '벌거벗은한국사', 17500, 10, 'tvn', '프런트페이지', '2022-08-22');
insert into book values(bseq.nextval, 'HC', '난중일기', 14000, 30, '이순신','스타북스','2022-07-27');
insert into book values(bseq.nextval, 'TC', '진짜쓰는실무엑셀', 20000, 10,'전진권', '제이펍', '2022-02-15');
insert into book values(bseq.nextval, 'TC', '빅데이터인공지능', 25000, 15, '박해선', '한빛미디어', '2020-12-21');

commit;

create sequence sseq increment by 1 start with 1;

--sales 테이블 데이터 입력해야함 아직 안함 밑의 데이터 바꿔서 넣고 실행하기 아직 실행 안함--
insert into sales values(sseq.nextval, 1, ‘lhy’, 1, (select bookprice from book where bookid=1)*1, sysdate); 
insert into sales values(sseq.nextval, 2, ‘ykh’, 1, (select bookprice from book where bookid=2)*1, sysdate); 
insert into sales values(sseq.nextval, 1, ‘jjs’, 2, (select bookprice from book where bookid=1)*2, sysdate); 
insert into sales values(sseq.nextval, 9, ‘lhy’, 1, (select bookprice from book where bookid=9)*1, sysdate); 
insert into sales values(sseq.nextval, 2, ‘cmj’, 5, (select bookprice from book where bookid=2)*5, sysdate); 
insert into sales values(sseq.nextval, 2, ‘jjs’, 3, (select bookprice from book where bookid=2)*3, sysdate); 
insert into sales values(sseq.nextval, 3, ‘yjh’, 2, (select bookprice from book where bookid=3)*2, sysdate); 
insert into sales values(sseq.nextval, 5, ‘hsy’, 4, (select bookprice from book where bookid=5)*4, sysdate); 
insert into sales values(sseq.nextval, 4, ‘nsy’, 8, (select bookprice from book where bookid=4)*8, sysdate); 
insert into sales values(sseq.nextval, 1, ‘jbj’, 3, (select bookprice from book where bookid=1)*3, sysdate); 
insert into sales values(sseq.nextval, 2, ‘kyj’, 4, (select bookprice from book where bookid=2)*4, sysdate); 
insert into sales values(sseq.nextval, 7, ‘lhn’, 1, (select bookprice from book where bookid=7)*1, sysdate); 
insert into sales values(sseq.nextval, 8, ‘hth’, 2, (select bookprice from book where bookid=8)*2, sysdate); 
insert into sales values(sseq.nextval, 10, ‘cmj’, 5, (select bookprice from book where bookid=10)*5, sysdate); 
insert into sales values(sseq.nextval, 1, ‘lhy’, 3, (select bookprice from book where bookid=1)*3, sysdate); 
insert into sales values(sseq.nextval, 2, ‘cmj’, 2, (select bookprice from book where bookid=2)*2, sysdate); 
insert into sales values(sseq.nextval, 2, ‘lhy’, 1, (select bookprice from book where bookid=2)*1, sysdate); 
insert into sales values(sseq.nextval, 1, ‘ykh’, 3, (select bookprice from book where bookid=1)*3, sysdate); 

