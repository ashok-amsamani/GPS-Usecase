# GPS-Usecase

Calculate distance based on the given input coordinates in the file (gps_data) and return output as below.

Output:
------
{"temp_id":[184,323],"group_id":"default_group"}
{"temp_id":[102,112,113,116,118,107,128,133,148,200,129,203,218,234,240,187,246,262,303,226,336,340,314,347,351,357,369,183,322,330,372,382,384,391,400,404,412,422,429,431,445],"group_id":"g1"}
{"temp_id":[107,109,112,116,126,127,128,129,133,138,144,148,200,187,203,206,209,211,218,226,229,232,233,240,242,245,246,247,253,163,262,166,260,271,279,288,289,292,283,300,303,306,309,314,160,162,169,173,177,183,185,322,164,324,326,330,332,335,336,340,353,357,359,362,367,369,371,372,376,382,383,384,323,391,400,404,412,415,422,431,429,436,445,446,449,451],"group_id":"g2"}

Distance Formula:
----------------
"60*1.1515*(180*(acos(((sin(radians(split(person_cood,',')[0]))*sin(radians(split(person_cood,',')[2]))) + 
(cos(radians(split(person_cood,',')[0]))*cos(radians(split(person_cood,',')[2])
)*cos(radians(split(person_cood,',')[1]-split(person_cood,',')[3]))))))/PI())"


Refer Script.hql file for solution.

