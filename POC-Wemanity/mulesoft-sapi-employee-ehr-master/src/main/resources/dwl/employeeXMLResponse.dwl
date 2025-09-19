%dw 2.0
output application/xml

fun responseFilter(filterField, excludeString) =    (filterField == null) or 
							                        (filterField != null) and !(filterField contains excludeString)
---
{
	queryResponse: {
		result: sfobject: using (query = if (not isEmpty(payload.body.queryResponse)) 
		payload.body.queryResponse
	else 
		payload.body.queryMoreResponse
) query.result.*sfobject filter responseFilter($...pay_group[0], "NON PAYROLL") and
                                responseFilter($...isContingentWorker, "true") map $ - "log"
	}
}