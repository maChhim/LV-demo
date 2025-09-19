%dw 2.0
output application/json indent = false
---
{
	code: "400",
	message: 'Internal Server Error',
	details: error.description default ""
}