Table Creation:
--------------
use custdb;

CREATE EXTERNAL TABLE IF NOT EXISTS GPS_INPUT_EXT (Temp_Id INT, Tango_Id VARCHAR(20), Store_Date CHAR(10),Client_Id INT, Person_Status CHAR(1),
Inserted_At VARCHAR(20), Camera_Num VARCHAR(18), TIME VARCHAR(9), Person_Cood STRING, Last_Processed VARCHAR(20),
Phone_Boxes VARCHAR(10), Face_Align_Pos VARCHAR(20), Store_Id VARCHAR(5))
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
TBLPROPERTIES ("skip.header.line.count"="1");

Load Data:
---------
LOAD DATA LOCAL INPATH "/home/hduser/gps_data" INTO TABLE GPS_INPUT_EXT;

Transformation:
---------------
WITH TEMP1 AS (
select temp_id, 60*1.1515*(180*(acos(((sin(radians(split(person_cood,',')[0]))*sin(radians(split(person_cood,',')[2]))) + 
(cos(radians(split(person_cood,',')[0]))*cos(radians(split(person_cood,',')[2])
)*cos(radians(split(person_cood,',')[1]-split(person_cood,',')[3]))))))/PI()) as dist from GPS_INPUT_EXT),
TEMP2 AS (
select temp_id, 
case when dist > 1000 and dist <= 5000 then 'g1'
     when dist > 5000 and dist <= 10000 then 'g2'
     when dist > 10000 and dist <= 30000 then 'g3'
else 'default_group'
end as group_id
from TEMP1)
select named_struct("temp_id",collect_set(temp_id),"group_id",group_id) from TEMP2 group by group_id;


Output:
------
{"temp_id":[184,323],"group_id":"default_group"}
{"temp_id":[102,112,113,116,118,107,128,133,148,200,129,203,218,234,240,187,246,262,303,226,336,340,314,347,351,357,369,183,322,330,372,382,384,391,400,404,412,422,429,431,445],"group_id":"g1"}
{"temp_id":[107,109,112,116,126,127,128,129,133,138,144,148,200,187,203,206,209,211,218,226,229,232,233,240,242,245,246,247,253,163,262,166,260,271,279,288,289,292,283,300,303,306,309,314,160,162,169,173,177,183,185,322,164,324,326,330,332,335,336,340,353,357,359,362,367,369,371,372,376,382,383,384,323,391,400,404,412,415,422,431,429,436,445,446,449,451],"group_id":"g2"}
{"temp_id":[101,109,118,107,128,129,144,148,187,203,206,211,224,226,229,232,234,240,245,246,260,271,279,283,289,291,292,300,303,306,309,162,163,164,169,177,185,198,200,323,330,332,335,324,340,347,353,357,359,362,367,322,371,372,376,183,382,383,385,166,398,400,409,412,415,422,429,436],"group_id":"g3"}
