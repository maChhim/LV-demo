%dw 2.0
output application/json indent = false 
fun formatValues(key,value) =  value match {
    case is Array -> (key): value map((item,index) -> item mapObject ((value, key, index) -> if (typeOf(value) == Object) formatValues(key,value) else (key):value ) ) 
    case is Object -> 
        (key) : [value mapObject ((value, key, index) -> if (typeOf(value) == Object) formatValues(key,value) else (key): value )]
    case is String -> (key): (value)
} 
---
{ "technicalResponse" : {
        "hasMoreResult": payload..hasMore[0],
        "querySessionId": payload..querySessionId[0]
    },
    "employees": "person": payload..person map ((item, index) -> item mapObject ((value, key, index) -> formatValues(key,value) )) }