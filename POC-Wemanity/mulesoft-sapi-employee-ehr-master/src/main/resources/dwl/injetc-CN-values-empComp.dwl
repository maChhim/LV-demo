%dw 2.0
output application/json skipNullOn = "everywhere"
fun stringToDateTime(data) = (data  default "") ++ "T00:00:00Z"
---
{
		"__metadata": {
			"uri": "EmpCompensation(seqNumber=1L,startDate=datetime'" ++ stringToDateTime((payload.startDate) default "") ++ "',userId='" ++ vars.person_id_external ++ "')",
			"type": "SFOData.EmpCompensation"
		},
		"customDouble2": payload.custom_double2,
		"customString1": vars.globalValues.Rsnforpaychange default "", // PIKLIST
		"customString3": vars.globalValues.Commission default "", // PIKLIST
		"eventReason": payload.event_reason,
		"isEligibleForCar": payload.is_eligible_for_car as Boolean,
		"payGroup": payload.pay_group,
		"payrollId": vars.backgroundUserId,
		"customString12": payload.custom_string12 default "CHN",
		"startDate": payload.start_date default ""
	}
