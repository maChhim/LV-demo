%dw 2.0
output application/json indent = false
---
flatten(( [vars.responseList] map((responsePerUser, i) -> [
    success: responsePerUser filterObject ((value, key, index) -> (value.d)[0].status contains("OK")),
    error: responsePerUser filterObject ((value, key, index) -> (value.d)[0].status contains("ERROR"))
])))