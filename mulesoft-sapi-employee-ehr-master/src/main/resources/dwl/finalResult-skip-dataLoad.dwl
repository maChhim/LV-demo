%dw 2.0
output application/json skipNullOn="everywhere"
---
[null] ++ flatten([vars.finalResult])