Create database bootcamp_1;
 
create external table bootcamp_1.sales_1( 
salesid integer, 
listid integer, 
sellerid integer,
buyerid integer,
eventid integer,
dateid smallint, 
qtysold smallint,
pricepaid decimal(8,2),
commission decimal(8,2), 
saletime timestamp
) 
row format delimited 
fields terminated by "|" 
stored as textfile
location 's3://redshift-klr/output/';
 
SELECT * FROM sales_1;