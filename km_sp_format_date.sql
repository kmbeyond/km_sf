//USE ROLE xx;
//USE WAREHOUSE xx;
//USE DATABASE xx;
//USE SCHEMA xx;

create or replace procedure km_sp_format_date(STR_DATE VARCHAR )
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    COMMENT = "KM Test Stored Proc to return date"
    EXECUTE AS CALLER
AS
$$

 function stringToDate(_date,_format,_delimiter)
 {
	var formatLowerCase = _format.toLowerCase();
	var formatItems = formatLowerCase.split(_delimiter);
	var dateItems = _date.split(_delimiter);
	var monthIndex = formatItems.indexOf("mm");
	var dayIndex = formatItems.indexOf("dd");
	var yearIndex = formatItems.indexOf("yyyy");
	var month = parseInt(dateItems[monthIndex]);
	return new Date(dateItems[yearIndex], month-1, dateItems[dayIndex]);
 }
 return stringToDate(STR_DATE, "yyyy-mm-dd", "-");
$$



call km_sp_format_date('2022-02-04');
=> Fri Feb 04 2022 00:00:00 GMT-0800 (Pacific Standard Time)
