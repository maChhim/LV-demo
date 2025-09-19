%dw 2.0
output application/json skipNullOn = "everywhere"
fun dateToUnix(data) = (((data) ++ "T00:00:00Z") as DateTime) as Number {
	unit: "milliseconds"
} default ""
fun stringToDateTime(data) = (data  default "") ++ "T00:00:00Z"
---
	{
		"__metadata": {
			"uri": "PerPersonal(personIdExternal='" ++ vars.person_id_external ++ "',startDate=datetime'" ++ stringToDateTime((payload.startDate) default "") ++ "')",
			"type": "SFOData.PerPersonal"
		},
		"birthName": payload.birth_name,
		"customString1": if ( payload.customString1 == null ) payload.last_name else payload.customString1,
		"firstName": payload.firstName,
		"firstNameAlt1": payload.firstNameAlt1,
		"gender": payload.gender,
		"lastName": payload.lastName,
		"lastNameAlt1": payload.lastNameAlt1,
		"maritalStatus": vars.globalValues.ecMaritalStatus, // Picklist
		"middleName": payload.middleName,
		"middleNameAlt1": payload.middleNameAlt1,
		"nationality": vars.globalValues.*ISOCountryList[0], // Picklist
		"preferredName": payload.preferredName,
		"customString7": if ( payload.gender == "M" ) "Male" else "Female",
		"customString6": payload.customString6 default "China",
		"secondNationality": vars.globalValues.*ISOCountryList[1], // Picklist
		"startDate": "/Date(" ++ dateToUnix(payload.startDate default "") ++ ")/"
	}