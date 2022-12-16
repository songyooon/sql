select * from boarda;
desc boarda;
drop sequence bseq;
create sequence bseq;
select * from membera;
insert into boarda values (bseq.nextval, '테스트 글1', '테스트 글1의 내용입니다.', 'kkt', sysdate);
insert into boarda values (bseq.nextval, '테스트 글2', '테스트 글2의 내용입니다.', 'kkt', sysdate);
insert into boarda values (bseq.nextval, '테스트 글3', '테스트 글3의 내용입니다.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '테스트 글4', '테스트 글4의 내용입니다.', 'kkt09072', sysdate);
insert into boarda values (bseq.nextval, '테스트 글5', '테스트 글5의 내용입니다.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '테스트 글6', '테스트 글6의 내용입니다.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '테스트 글7', '테스트 글7의 내용입니다.', 'kkt09072', sysdate);
insert into boarda values (bseq.nextval, '테스트 글8', '테스트 글8의 내용입니다.', 'kkt', sysdate);
insert into boarda values (bseq.nextval, '테스트 글9', '테스트 글9의 내용입니다.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '테스트 글10', '테스트 글10의 내용입니다.', 'admin', sysdate);
insert into boarda values (bseq.nextval, '테스트 글11', '테스트 글11의 내용입니다.', 'kkt', sysdate);

drop table memberb;
create table memberb as select * from membera;
select * from memberb;
alter table memberb add pt number default 0;
create table boardb as select * from boarda;
select * from boardb;

-- 1. 레코드 삭제 프로시저 또는 함수

-- 프로시저
-- 프로시저 정의부1
-- 이름 : member_del, 기능 : 회원(memberb) 테이블의 모든 레코드를 삭제한다.
CREATE OR REPLACE PROCEDURE member_del
IS
BEGIN
    delete from memberb;    
END;
/

-- 프로시저 호출부1
EXECUTE member_del;


-- 함수 정의부1
-- 이름 : board_del(매개변수)
-- 매개변수 : aut varchar2(20)
-- 기능 : 작성자 아이디를 매개변수로 입력받아 해당 작성자가 작성한 글을 삭제하라.
CREATE OR REPLACE FUNCTION board_del(aut in boardb.author%TYPE)
RETURN NUMBER
IS
BEGIN
    delete from boardb where author = aut;
    return 1;
END;
/

-- 함수 호출부1
VARIABLE x number;
EXECUTE :x := board_del('kkt');


-- 2. 레코들 갱신하는 프로시저 또는 함수
-- 갱신 프로시저
-- 이름 : update_point, 기능 : 로그인 할 때 마다 포인트가 5 포인트씩 증가시켜라
-- 지역변수 : data_up - 증가치 5로 기본값 설정
CREATE OR REPLACE PROCEDURE update_point
IS
    data_up number := 5;
BEGIN
    update memberb set pt=pt+data_up;
END;
/

EXECUTE update_point;
select * from memberb;
    
-- 갱신 함수
-- 이름 : up_point, 매개변수 : 특정아이디, 기능 : 로그인 할 때 마다 포인트가 5 포인트씩 증가시켜라
-- 지역변수 : data_up - 증가치 5로 기본값 설정
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

-- 3. 추가(삽입) 프로시저 또는 함수
-- 추가 프로시저
-- 이름 : insert_pro
-- 매개변수 : pid, ppw, pname, pemail, ptel, pregdate, ppt
-- 기능 : 아이디, 비밀번호, 이름, 이메일, 전화번호, 가입일을 매개변수로 받아 memberb에 튜플로 추가
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
EXECUTE insert_pro('sbs','2222','김도연','kdy1004@gmail.com','010-1004-1004','2022-10-25',0);
select * from memberb;

-- 추가 함수
-- 이름 : insert_fnc
-- 매개변수 : pid, ppw, pname, pemail, ptel, pregdate, ppt
-- 기능 : 아이디, 비밀번호, 이름, 이메일, 전화번호, 가입일을 매개변수로 받아 memberb에 튜플로 추가
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
execute :data_in := insert_fnc('kbs','3333','박평화','pph7979@gmail.com','010-1234-7979','2022-10-25',0);
select * from memberb;


-- 4. 검색 프로시저 또는 함수
-- 검색 프로시저
-- 이름 : sel_pro
-- 매개변수 : sel_date, sel_id
-- 기능 : 가입일과 아이디를 입력받아 해당 회원을 검색하여 그 회원의 이름을 출력하라.
SET serveroutput ON;
CREATE OR REPLACE PROCEDURE sel_pro(sel_date in memberb.regdate%TYPE,
sel_id in memberb.id%TYPE)
IS
    k_name memberb.name%TYPE;
BEGIN
    dbms_output.enable;
    select name into k_name from memberb where regdate <= sel_date and id=sel_id;
    dbms_output.put_line('회원명' ||':'|| k_name);
END;
/
EXECUTE sel_pro('2022-10-24','admin');

-- 검색 함수
-- 이름 : sel_fnc
-- 매개변수 : sel_date, sel_id
-- 기능 : 가입일과 아이디를 입력받아 해당 회원을 검색하여 그 회원의 이름을 출력하라.
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

-- 5. 검색 프로시저2
/* memberb 테이블에서 REGDATE(가입일)을 기준으로 정렬하여 테이블의 회원아이디, 회원명, 출생년도, 가입일 컬럼을 표시되도록 하는
PL 프로시저 또는 함수를 작성하고, 실행하되, 프로시저 또는 함수이름 : memberb_sort
기타 필요한 변수 또는 요소는 임의로 할 것. */
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
        DBMS_OUTPUT.PUT_LINE( '아이디' || '   ' || '회원명' || '   ' || '출생년도' || '   ' || '가입일');
        /* %TYPE 데이터형 변수 사용 */
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

-- 6. 연산 프로시저
/* memberb 테이블에서 visited 컬럼별로 회원등급을 구하여 회원아이디, 회원이름, 등급을
출력하는 PL 프로시저 또는 함수를 작성하고, 실행하되, IF문, 반복실행문(WHILE, LOOP, FOR) 
를 사용하고, PL 프로시저 또는 함수를 작성하고, 실행하되, 프로시저 또는 함수이름은 : member_rank 
회원등급 : 100회 이상 방문시 우수회원, 50회 이상 방문시 정회원, 50회 미만 방문시 준회원 으로
하며, 회원등급의 컬럼은 방문횟수인 visited을 활용할 것. */
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
        DBMS_OUTPUT.PUT_LINE( '아이디' || '   ' || '회원명' || '   ' || '등급');
        /* %TYPE 데이터형 변수 사용 */
        FOR r IN (SELECT id, name, visited FROM memberb) LOOP
            i := i+1;
            v_id(i) := r.id;
            v_name(i) := r.name;
            v_visited(i) := r.visited;
            IF(v_visited(i) >= 100) THEN v_rank(i) := '우수회원';
            ELSIF(v_visited(i) >= 50) THEN v_rank(i) := '정회원';
            ELSE v_rank(i) := '준회원';
            END IF;
        END LOOP;
        
        FOR j IN 1..i LOOP
            dbms_output.put_line(v_id(j) || '   ' || v_name(j) || '   ' || v_rank(j));
        END LOOP;
END;
/
execute member_rank;


create table product(tno number primary key, pname varchar2(40), dan number); -- 상품 테이블
create table inventory(ino number, quant number, price number); -- 재고 테이블
create table wearing(ino number, quant number, price number); -- 입고 테이블
create table sales(ino number, quant number, price number); -- 판매 테이블

-- 더미 데이터 추가
INSERT INTO product VALUES(100,'새우깡',1500);
INSERT INTO product VALUES(200,'감자깡',1000);
INSERT INTO product VALUES(300,'맛동산',2000);
INSERT INTO product VALUES(400,'양파링',1800);
INSERT INTO product VALUES(500,'고구마깡',1600);
 


-- 7. 트랜잭션 트리거
/* 입고(wearing) 테이블에 상품을 입고시킬 때 만약, 새로운 상품일 경우와 이미 있는 재고 상품일 경우로 분류하여
재고(inventory) 테이블에 반영될 수 있도록 트리거를 작성하되, 트리거 이름은 wearing_trigger로 하고,
임의의 데이터를 입고 테이블에 튜플을 입력하여 자동 재고처리된 그 결과를 확인하시오.  */

-- 예시 데이터
-- 입고 
INSERT INTO wearing VALUES(100,2,1500);
-- 재고
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
  IF(v_cnt=0) THEN -- 재고가 없는 상품 
    INSERT INTO inventory VALUES(:NEW.ino,:NEW.quant,:NEW.price*:NEW.quant);
  ELSE  -- 재고에 있는 상품 
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

-- 8. 재고 자동계산 트리거
/* 판매가 되면 판매(sales) 테이블에 상품이 등록된다. 그렇다면 재고(inventory) 테이블에 반영되어 튜플이
변경 되도록 트리거를 작성하되, 트리거 이름은 sales_trigger로 하고,
임의의 데이터를 판매 테이블에 튜플을 입력하여 자동 재고계산된 그 결과를 확인하시오.  */

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



