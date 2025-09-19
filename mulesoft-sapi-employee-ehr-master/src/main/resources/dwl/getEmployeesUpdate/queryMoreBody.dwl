%dw 2.0
output application/xml
ns ns0 urn:sfobject.sfapi.successfactors.com
---
{
	ns0#queryMore: {
		ns0#querySessionId: vars.querySessionId
	}
}