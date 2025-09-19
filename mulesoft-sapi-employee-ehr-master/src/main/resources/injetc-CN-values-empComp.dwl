%dw 2.0
output application/json skipNullOn = "everywhere"
fun dateToUnix(data) = (((data) ++ "T00:00:00Z") as DateTime) as Number {
	unit: "milliseconds"
} default ""
fun stringToDateTime(data) = (data  default "") ++ "T00:00:00Z"
---
{
		"__metadata": {
			"uri": "EmpCompensation(seqNumber=1L,startDate=datetime'" ++ stringToDateTime((payload.startDate) default "") ++ "',userId='" ++ vars.person_id_external ++ "')",
			"type": "SFOData.EmpCompensation"
		},
		"customDouble2": payload.customDouble2,
		"customString1": vars.globalValues.Rsnforpaychange default "", // PIKLIST
		"customString3": vars.globalValues.Commission default "", // PIKLIST
		"eventReason": payload.eventReason,
		"isEligibleForCar": payload.isEligibleForCar,
		"payGroup": payload.payGroup,
		"payrollId": vars.backgroundUserId,
		"customString12": payload.customString12 default "CHN",
		"startDate": "/Date(" ++ dateToUnix(payload.startDate default "") ++ ")/"
	}
