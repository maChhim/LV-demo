%dw 2.0
		output text/xml
		ns soap http://schemas.xmlsoap.org/soap/envelope/
		---
		{
		    soap#Envelope: {
		    soap#Body: {
		        soap#Fault: {
		                faultcode: vars.errCode,
		                faultstring: error.detailedDescription,
		                detail: 
		                	{
							  status: vars.httpStatus,
							  responseId: correlationId,
							  transactionDate: now(),
							  data: {
							  		errorCode: vars.errCode,
									errorType: error.errorType.identifier as String,
									errorDescription: error.detailedDescription
							  }
							}
		            }   
		        }
		    }
		}