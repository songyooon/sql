create sequence bseq start with 1 increment by 1;

insert into book values(bseq.nextval, 'IT', '�̰��� �ڹٴ�', 30000, 10, '�ſ��','�Ѻ��̵��','2021-08-20');
insert into book values(bseq.nextval, 'IT', '�ڹ������߿�ũ��', 31500, 19, '���۰����ڵ���', '�������Ͻ�','2022-08-04');
insert into book values(bseq.nextval, 'NV', '�Ͼ��', 14400, 15, '����', '���е���', '2022-08-03');
insert into book values(bseq.nextval, 'NV', '������������', 12600, 10, '��ȣ��', '����������', '2022-08-10');
insert into book values(bseq.nextval, 'DV', '������', 15750, 8, '��û', '��������', '2022-05-30');
insert into book values(bseq.nextval, 'DV', '�ڼҼ����̺�', 18000, 15, '����', '���˵�', '2022-08-25');
insert into book values(bseq.nextval, 'HC', '���Ź����ѱ���', 17500, 10, 'tvn', '����Ʈ������', '2022-08-22');
insert into book values(bseq.nextval, 'HC', '�����ϱ�', 14000, 30, '�̼���','��Ÿ�Ͻ�','2022-07-27');
insert into book values(bseq.nextval, 'TC', '��¥���½ǹ�����', 20000, 10,'������', '������', '2022-02-15');
insert into book values(bseq.nextval, 'TC', '�������ΰ�����', 25000, 15, '���ؼ�', '�Ѻ��̵��', '2020-12-21');

select * from book;

insert into member values('ykh','a1234','������','������ 13','010-111-2222','2022-09-13');
insert into member values('lhy','a3421','���Ͽ�','���ε� 888','031-2222-3333','2022-09-13');
insert into member values('lhn','b1111','���س�','�鼮�� 777','010-3333-4444','2022-09-14');
insert into member values('jbj','c456','������','���絿 178','010-4444-5555','2022-09-15');
insert into member values('jjs','z675','������','���ﵿ 75','031-4444-2222','2022-09-11');
insert into member values('cmj','q789','������','â���� 1004','010-5555-6666','2022-09-13');
insert into member values('hsy','g478','�ѽÿ�','â�ŵ� 128','010-6666-7777','2022-09-13');
insert into member values('hth','d666','������','��ŵ� 67','010-7777-8888','2022-09-14');
insert into member values('kyj','e964','������','ȭ���� 912','031-5555-2222','2022-09-05');
insert into member values('nsy','h369','������','�ﵵ�� 37','010-8888-9999','2022-09-16');

select * from member;

alter table member add pt number default 0;


select * from member;

update member set pt=pt+100;

select * from member;

delete from member where name='�ѽÿ�';

select * from member;

alter table member rename column pt to mempoint;

select * from member;









































