%dw 2.0
output application/json skipNullOn="everywhere"
---
[payload] ++ flatten([vars.finalResult])