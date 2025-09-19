%dw 2.0
output application/json indent = false
---
using (query = if (not isEmpty(payload.body.queryResponse)) 
		payload.body.queryResponse 
	else 
		payload.body.queryMoreResponse
)
{
	querySessionId: query.result.querySessionId,
	recordCount: query.result.numResults,
	morePages: query.result.hasMore
}