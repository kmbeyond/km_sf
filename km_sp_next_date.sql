//USE ROLE xx;
//USE WAREHOUSE xx;
//USE DATABASE xx;
//USE SCHEMA xx;

create or replace procedure km_sp_next_date(STR_DATE VARCHAR )
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    COMMENT = "KM Test Stored Proc to return next day"
    EXECUTE AS CALLER
AS
$$
 function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [year, month, day].join('-');
 }

 let date_next = new Date(STR_DATE+"T12:00:00Z");
 date_next.setDate(date_next.getDate() + 1);
 return formatDate(date_next);
$$


--call km_sp_next_date('2022-01-04');
--=> 2022-01-05


--call km_sp_next_date('2022-01-31');
--=> 2022-02-01

--call km_sp_next_date('2022-12-31');
---> 2023-01-01


