SET serveroutput ON;

BEGIN
    dbms_output.put_line('Hello PL');
END;
/

DECLARE
    name varchar2(20) := '김기태';
    age number := 38;
    gender varchar(20) default '남';
    
BEGIN
    dbms_output.put_line('이름' ||':'|| name);
    dbms_output.put_line('나이' ||':'|| age);
    dbms_output.put_line('성별' ||':'|| gender);
END;
/

DECLARE
    DATA MEMBER%ROWTYPE;
BEGIN
    SELECT * INTO DATA 
    from member 
    where id='jbj';
    dbms_output.put_line(data.id ||','|| data.password);
END;
/

commit;

DECLARE
    V_NAME MEMBER.name%TYPE;
    V_ID MEMBER.id%TYPE;
BEGIN
    select name, id into V_NAME, V_ID
    from MEMBER
    where id='jbj';
    dbms_output.put_line(v_NAME ||','||v_ID);
END;
/

BEGIN
    for i in 1..10 loop
        if mod(i, 2) = 0 then
            dbms_output.put_line(i || '는 짝수~!');
        else
            dbms_output.put_line(i || '는 홀수~!');
        end if;
    end loop;
END;
/

DECLARE
    v_num number := 6;
    v_cnt number:= 0;
BEGIN
    LOOP
        dbms_output.put_line('현재 숫자' ||':'|| v_num);
        v_num := v_num + 1;
        v_cnt := v_cnt + 1;
        EXIT WHEN v_num > 10;
    END LOOP;
    dbms_output.put_line('출력한 개수 : '|| v_cnt);
END;
/

DECLARE
    v_num number := 6;
    v_cnt number := 0;
BEGIN
    WHILE v_num < 11 LOOP
        dbms_output.put_line('현재 숫자 : '|| v_num);
        v_num := v_num +1;
        v_cnt := v_cnt +1;
    END LOOP;
    dbms_output.put_line('출력한 개수 : '|| v_cnt);
END;
/

DECLARE
    v_score number := 82;
BEGIN
    IF v_score >= 90 then
        dbms_output.put_line('점수' || v_score ||', 학점 : A');
    ELSIF v_score >= 80 then
        dbms_output.put_line('점수' || v_score ||', 학점 : B');
    ELSIF v_score >= 70 then
        dbms_output.put_line('점수' || v_score ||', 학점 : C');
    ElSIF v_score >= 60 then
        dbms_output.put_line('점수' || v_score ||', 학점 : D');
    ELSE
        dbms_output.put_line('점수' || v_score ||', 학점 : F');
    END IF;
END;
/

DECLARE
    v_grade CHAR(1) := 'B';
    v_msg VARCHAR2(40);
BEGIN
    case v_grade
        when 'A' then
            v_msg := 'Excellent';
        when 'B' then
            v_msg := 'Very Good';
        when 'C' then
            v_msg := 'Good';
        ELSE
            v_msg := 'Bad Grade';
        END CASE;
        dbms_output.put_line('GRADE : ' || v_grade);
        dbms_output.put_line('MESSAGE : ' || v_msg);
END;
/

