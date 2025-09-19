%dw 2.0
output text/xml
ns urn urn:sfobject.sfapi.successfactors.com
---
{	
	urn#login: {
	    urn#credential: {
	        urn#companyId: p('secure::ws.successfactors.companyId'),
	        urn#username: p('secure::ws.successfactors.username'),
	        urn#password: p('secure::ws.successfactors.password')
	    }
	}
}