%dw 2.0
output application/json indent = false
---
{
	"queryResponse": {
		"result": {
			"sfobject": flatten(vars.queryResult)
		}
	}
}
