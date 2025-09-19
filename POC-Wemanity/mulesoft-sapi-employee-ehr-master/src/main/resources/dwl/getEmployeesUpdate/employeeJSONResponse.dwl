%dw 2.0
output application/json

fun responseFilter(filterField, excludeString) = (filterField == null) or 
							                        (filterField != null) and !(filterField contains excludeString)
---
{   sessionId: if (payload.body.queryResponse.result.querySessionId != null) payload.body.queryResponse.result.querySessionId else payload.body.queryMoreResponse.result.querySessionId,
    loginSessionId: vars.loginSessionId, 
    hasMore: if (payload.body.queryResponse.result.hasMore != null) payload.body.queryResponse.result.hasMore else payload.body.queryMoreResponse.result.hasMore,
	queryResponse: {
		result: sfobject: using (query = if (not isEmpty(payload.body.queryResponse)) 
		payload.body.queryResponse
	else 
		payload.body.queryMoreResponse
)  if(vars.payroll == "true") query.result.*sfobject filter responseFilter($...pay_group[0], "NON PAYROLL") map $ - "log" else query.result.*sfobject map $ - "log"
	},
}