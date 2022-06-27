/*
SP to return String date in MM-DD-YYYY
Input:
 1.Date string
 2.Format of date string
 3.delimiter

*/

//USE ROLE xx;
//USE WAREHOUSE xx;
//USE DATABASE xx;
//USE SCHEMA xx;

create or replace procedure km_sp_format_date(STR_DATE VARCHAR, DT_FORMAT VARCHAR, DELIMITER VARCHAR )
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    COMMENT = "KM Test Stored Proc to return date in MM-DD-YYYY"
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
 function prefixZero(i) {
  if (i < 10) {i = "0" + i}
  return i;
 }
 function formatDate(date) {
    var d = new Date(date),
        month = prefixZero(d.getMonth() + 1),
        day = prefixZero(d.getDate()),
        year = d.getFullYear();

    return [month, day, year].join('-');
 }
 return "Date (MM-DD-YYYY): " + formatDate(stringToDate(STR_DATE, DT_FORMAT, DELIMITER));
$$


call km_sp_format_date('2022-04-01', 'yyyy-mm-dd', '-');
-> Date (MM-DD-YYYY): 04-01-2022

call km_sp_format_date('05/02/2022', 'mm/dd/yyyy', '/');
-> Date (MM-DD-YYYY): 05-02-2022


