%dw 2.0
output application/xml
ns ns0 urn:sfobject.sfapi.successfactors.com
var queryBuilder = if(isEmpty(vars.condition)) "select $(vars.query) from compoundemployee"  else "select $(vars.query) from compoundemployee where $(vars.condition)"
---
{
	ns0#query: {
		ns0#queryString: queryBuilder,
		(vars.queryParamsList default [] map using(item = $ splitBy "=") ns0#param: {
                ns0#name: 	item[0],
                ns0#value: 	item[1],
        })
	}
}
