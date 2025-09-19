%dw 2.0
output application/java
---
using 
	( query = if (not isEmpty(payload.body.queryResponse)) 
		payload.body.queryResponse else payload.body.queryMoreResponse
	)
query.result.hasMore as Boolean