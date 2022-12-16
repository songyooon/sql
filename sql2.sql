create sequence bseq start with 1 increment by 1;

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

select * from book;

insert into member values('ykh','a1234','유광현','도내동 13','010-111-2222','2022-09-13');
insert into member values('lhy','a3421','이하영','마두동 888','031-2222-3333','2022-09-13');
insert into member values('lhn','b1111','이해나','백석동 777','010-3333-4444','2022-09-14');
insert into member values('jbj','c456','정병진','성사동 178','010-4444-5555','2022-09-15');
insert into member values('jjs','z675','정진석','원흥동 75','031-4444-2222','2022-09-11');
insert into member values('cmj','q789','조민재','창릉동 1004','010-5555-6666','2022-09-13');
insert into member values('hsy','g478','한시연','창신동 128','010-6666-7777','2022-09-13');
insert into member values('hth','d666','한태헌','행신동 67','010-7777-8888','2022-09-14');
insert into member values('kyj','e964','고유진','화정동 912','031-5555-2222','2022-09-05');
insert into member values('nsy','h369','남송윤','흥도동 37','010-8888-9999','2022-09-16');

select * from member;

alter table member add pt number default 0;


select * from member;

update member set pt=pt+100;

select * from member;

delete from member where name='한시연';

select * from member;

alter table member rename column pt to mempoint;

select * from member;









































