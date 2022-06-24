//USE ROLE xx;
//USE WAREHOUSE xx;
//USE DATABASE xx;
//USE SCHEMA xx;

create or replace procedure km_test_sp1(ARG1 VARCHAR, ARG2 VARCHAR )
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    COMMENT = "KM Test Stored Proc"
    EXECUTE AS CALLER
AS
$$

 const proc_name = Object.keys(this)[0];
 const param = {ARG1: ARG1, ARG2: ARG2};
 const param_str = JSON.stringify(param).replace(new RegExp('"', 'g'), '');
 return proc_name+param_str;
$$



//------
DESC procedure km_test_sp1(VARCHAR, VARCHAR );

call km_test_sp1('k1', 'k2');
=> KM_TEST_SP1{ARG1:k1,ARG2:k2}
