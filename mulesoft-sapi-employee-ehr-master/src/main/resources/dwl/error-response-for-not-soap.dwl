%dw 2.0
output application/json
---
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