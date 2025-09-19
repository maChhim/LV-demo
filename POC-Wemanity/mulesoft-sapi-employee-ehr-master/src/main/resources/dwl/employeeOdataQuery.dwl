%dw 2.0
output application/json skipNullOn = "everywhere"
var userId = vars.user_id
var employee = payload.person
var perso = employee.*personal_information
var startDate = employee.employment_information.start_date
var personalIdExternal = vars.person_id_external
var jobInfo = employee.employment_information.*job_information
var empComp = employee.employment_information.*compensation_information
var payCompRec = empComp.*paycompensation_recurring
var jobRel = employee.employment_information.*job_relation
fun getItem(data)= payload.person."data"  default ""
fun dateToUnix(data) = (((data) ++ "T00:00:00Z") as DateTime) as Number {
	unit: "milliseconds"
} default ""
fun stringToDateTime(data) = (data  default "") ++ "T00:00:00Z"
---
{
	(userInfo: {
		"__metadata": {
			"uri": "User('" ++ personalIdExternal as String ++ "')",
			"type": "SFOData.User"
		},
		"username": employee.logon_user_name,
		"status": if ( employee.logon_user_is_active == "true" ) "active" else "inactive"
	}) if (employee.logon_user_id != null), 
	(personInfo: {
		"__metadata": {
			"uri": "PerPerson('" ++ personalIdExternal as String ++"')",
			"type": "SFOData.PerPerson"
		},
		"dateOfBirth": "/Date(" ++ dateToUnix(employee.date_of_birth default "") ++ ")/",
		"placeOfBirth": employee.place_of_birth,
		"countryOfBirth": employee.country_of_birth
	}) if (employee != null),
	(personalInfo: perso map ((item, index) ->  
{
		"__metadata": {
			"uri": "PerPersonal(personIdExternal='" ++ personalIdExternal ++ "',startDate=datetime'" ++ stringToDateTime((item.start_date) default "") ++ "')",
			"type": "SFOData.PerPersonal"
		},
		"birthName": item.birth_name,
		"customString1": if ( item.custom_string1 == null ) item.last_name else item.custom_string1,
		"firstName": item.first_name,
		"firstNameAlt1": item.first_name_alt1,
		"gender": item.gender,
		"lastName": item.last_name,
		"lastNameAlt1": item.last_name_alt1,
		"maritalStatus": item.marital_status, // Picklist
		"middleName": item.middle_name,
		"middleNameAlt1": item.middle_name_alt1,
		"nationality": item.nationality, // Picklist
		"preferredName": item.preferred_name,
		"customString7": if ( item.gender == "M" ) "Male" else "Female",
		"customString6": item.custom_string6 default "China",
		"secondNationality": item.second_nationality, // Picklist
		"startDate": item.start_date
	})) if (perso != null),
	(emailInfo: {
		"__metadata": {
			"uri": "PerEmail(emailType=" ++ (vars.globalValues.ecEmailType default "") ++ ",personIdExternal='" ++  personalIdExternal as String ++"')"
		},
		"emailAddress": employee.email_information.email_address,
		"emailType": vars.globalValues.ecEmailType,
		"isPrimary": employee.email_information.isPrimary as Boolean
	}) if (employee.email_information != null),
	(phoneInfo: {
		"__metadata": {
			"uri": "PerPhone(personIdExternal='" ++ personalIdExternal as String ++ "',phoneType= " ++ vars.globalValues.ecPhoneType ++ ")"
		},
		"countryCode": employee.phone_information.country_code,
		"phoneNumber": employee.phone_information.phone_number,
		"phoneType": vars.globalValues.ecPhoneType,
		"isPrimary": employee.phone_information.isPrimary  as Boolean
	}) if (employee.phone_information != null),
	(employment: {
		"__metadata": {
			"uri": "EmpEmployment(personIdExternal='" ++ personalIdExternal as String ++ "',userId='" ++ userId ++ "')",
			"type": "SFOData.EmpEmployment"
		},
		"customDate1": "/Date(" ++ dateToUnix(employee.employment_information.custom_date1 default "") ++ ")/",
		"seniorityDate": "/Date(" ++ dateToUnix(employee.employment_information.seniorityDate default "") ++ ")/",
		"startDate": "/Date(" ++ dateToUnix(employee.employment_information.start_date default "") ++ ")/",
		"userId": userId
	}) if (employee.employment_information != null),
	(termination: jobInfo map ((item, index) -> 
		if ((item.event_reason startsWith "TER") or (item.event_reason startsWith "NO_SHOW"))
    {
		"__metadata": {
			"uri": "EmpEmploymentTermination"
		},
		"personIdExternal" : personalIdExternal,
		("endDate": "/Date(" ++ dateToUnix(employee.employment_information.end_date default "") ++ ")/") if (employee.employment_information.end_date != null),
		"userId": userId,
		"eventReason": item.event_reason,
		("customString17": if (employee.employment_information.custom_string17 == "Unvoluntary") "Involuntary" else employee.employment_information.custom_string17 ) if (employee.employment_information.custom_string17 != null),
		("customString18": employee.employment_information.custom_string18) if (employee.employment_information.custom_string18 != null),
		"lastDateWorked" : if (employee.employment_information.lastDateWorked != null) ("/Date(" ++ dateToUnix(employee.employment_information.lastDateWorked) ++ ")/") else if (item.event_reason startsWith "NO_SHOW") ("/Date(" ++ dateToUnix(employee.employment_information.start_date default "") ++ ")/") else null,
		("regretTermination":  employee.employment_information.regretTermination as Boolean) if (employee.employment_information.regretTermination != null)
	} else null) ),
	
	(jobInfo: jobInfo map ((item, index) -> 
    {
		"__metadata": {
			"uri": "EmpJob(seqNumber=1L,startDate=datetime'" ++ stringToDateTime((item.start_date)) ++ "',userId='" ++ userId ++ "')",
			"type": "SFOData.EmpJob"
		},
		"businessUnit": item.business_unit,
		"company": item.company,
		"standardHours": item.standard_hours,
		"contractEndDate": item.contractEndDate,
		"contractType": vars.globalValues.*contractType[index],
		"costCenter": item.cost_center,
		"customString13": item.custom_string13,
		// "companyTerritoryCode": item.company_territory_code,
		"customDate3": "/Date(" ++ dateToUnix(item.custom_date3 default "") ++ ")/",
		"customDate4": "/Date(" ++ dateToUnix(item.custom_date4  default "") ++ ")/",
		// "customString10": item.custom_string10,
		"customString11": item.custom_string11,
		"customString12": item.custom_string12,
		"customString13": item.custom_string13,
		"customString14": item.custom_string14,
		"customString15": item.custom_string15,
		"customString20": item.custom_string20,
		"customString3": item.custom_string3,
		"customString4": item.custom_string4,
		"customString5": vars.globalValues.*LVJohnDoe[index],
		"customString7": item.custom_string7,
		"customString8": item.custom_string8,
		"customString9": item.custom_string9,
		"dataSource": item.dataSource,
		"department": item.department,
		"division": item.division,
		"eventReason": item.event_reason,
		"fte": item.fte,
		"localJobTitle": item.local_job_title,
		"location": item.location,
		"managerId": item.manager_person_id_external,
		"position": item.position,
		"positionEntryDate": "/Date(" ++ dateToUnix(item.positionEntryDate default "") ++ ")/",
		"startDate": "/Date(" ++ dateToUnix(item.start_date default "") ++ ")/",
		("probationPeriodEndDate":  "/Date(" ++ dateToUnix(item.probation_period_end_date) ++ ")/") if (item.probation_period_end_date != null),
      	"jobCode": item.job_code default "",
	})) if (jobInfo != null),
	(employmentCompensation: empComp map ((item, index) ->
    {
		"__metadata": {
			"uri": "EmpCompensation(seqNumber=1L,startDate=datetime'" ++ stringToDateTime((item.start_date) default "") ++ "',userId='" ++ userId ++ "')",
			"type": "SFOData.EmpCompensation"
		},
		"customDouble2": item.custom_double2 default null,
		"customString1": item.custom_string1 default "",
		"customString3": item.custom_string3 default "",
		"eventReason": item.event_reason,
		"isEligibleForCar": item.is_eligible_for_car as Boolean,
		"payGroup": item.pay_group,
		"payrollId": vars.backgroundUserId,
		"customString12": item.custom_string12 default "CHN",
		"startDate": item.start_date
	})) if (empComp != null),

    (employmentPayCompReccuring: payCompRec map ((item, index) -> 

     {
		"__metadata": {
			"uri": "EmpPayCompRecurring(payComponent='Base Salary',seqNumber=1L,startDate=datetime'" ++ stringToDateTime((item.start_date) default "") ++ "',userId='" ++ userId ++ "')",
			"type": "SFOData.EmpPayCompRecurring"
		},
		"currencyCode": item.currency_code,
		"frequency": item.frequency,
		"payComponent": item.pay_component,
		"paycompvalue": item.paycompvalue,
		"startDate": "/Date(" ++ dateToUnix((item.start_date default "")) ++ ")/"
	}))if (payCompRec != null),

    (jobRelationship: jobRel orderBy ((item, index) -> - index) map ((item, index) -> 
        
    {
		"__metadata": {
			"uri": "EmpJobRelationships(relationshipType='" ++ vars.globalValues.*jobRelType[index] ++ "',startDate=datetime'" ++ stringToDateTime((item.start_date) default "") ++ "',userId='" ++ userId ++ "')",
			"type": "SFOData.EmpJobRelationships"
		},
		"relUserId": item.managerPersonIdExternal,
		"relationshipType": vars.globalValues.*jobRelType[index] default "",
		"startDate": "/Date(" ++ dateToUnix(item.start_date default "") ++ ")/"
	})) if (employee.employment_information.job_relation != null)
} ++ 
({("Background_Education" : 

   payload.odata.Background_Education orderBy ((item, index) -> - index) map (item, idx) -> 
    {"__metadata": {
        "uri": "Background_Education(backgroundElementId=0,userId='"++ userId ++"')",
        "type": "SFOData.Background_Education"
      }, "userId": userId,
      "country": item.countryNav.externalCode , // Picklist
      "degreeTitle": item.degreeTitle,
      "other":item.other,
      "major": item.majorNav.externalCode, // Picklist
      "endDate": item.endDate,
      "school": item.schoolNav.externalCode, // Picklist
      "degree": item.degreeNav.externalCode // Picklist

       }) if (payload.odata.Background_Education."__metadata" != null),

("cust_Tax_ID_Information": 

    payload.odata.cust_Tax_ID_Information   map (item, idx) -> 

    {"__metadata": {
        "uri": "cust_Tax_ID_Information(backgroundElementId=0,userId='"++  userId ++"')",
        "type": "SFOData.cust_Tax_ID_Information"
      },
      "userId": userId,
      "cust_cardType": item.cust_cardType ,
      "cust_expireDate": item.cust_expireDate,
      "cust_taxID":item.cust_taxID,
   }) if (payload.odata.cust_Tax_ID_Information."__metadata" != null),

("cust_LeaveNotice": 

    payload.odata.cust_LeaveNotice   map (item, idx) -> 

    {"__metadata": {
        "uri": "cust_LeaveNotice(backgroundElementId=0,userId='"++  userId ++"')",
        "type": "SFOData.cust_LeaveNotice"
      },
      "userId": userId,
      "cust_leaveNoticeinProbation": item.cust_leaveNoticeinProbation , //à mapper
      "cust_leaveNotice": item.cust_leaveNotice // à mapper
   }) if (payload.odata.cust_LeaveNotice."__metadata" != null),


   ("Background_OutsideWorkExperience": 
   
   
   payload.odata.Background_OutsideWorkExperience orderBy ((item, index) -> - item.backgroundElementId) map (item, idx) -> 

    {"__metadata": {
        "uri": "Background_OutsideWorkExperience(backgroundElementId=0,userId='"++  userId ++"')",
        "type": "SFOData.Background_OutsideWorkExperience"
      },
      "userId": userId,
      "endDate": item.endDate,
      "custom3": item.custom3Nav.externalCode, // Picklist
      "custom4": item.custom4, 
      "custom1": item.custom1Nav.externalCode, // Picklist
      "custom2": item.custom2Nav.externalCode, // Picklist
      "department": item.department,
      "title": item.title,
      "startDate": item.startDate

   }) if (payload.odata.Background_OutsideWorkExperience."__metadata" != null),

("Background_InsideWorkExperience": 
   
   
   payload.odata.Background_InsideWorkExperience orderBy ((item, index) -> - item.backgroundElementId) map (item, idx) -> 

    {"__metadata": {
        "uri": "Background_InsideWorkExperience(backgroundElementId=0,userId='"++  userId ++"')",
        "type": "SFOData.Background_InsideWorkExperience"
      },
      "userId": userId,
      "country": item.countryNav.externalCode, // Picklist
      "endDate": item.endDate,
      "WorkLocation": item.WorkLocation,
      "function": item.functionNav.externalCode, // Picklist
      "legal_entity": item.legal_entity,
      "title": item.title,
      "startDate": item.startDate
      
   }) if (payload.odata.Background_InsideWorkExperience."__metadata" != null),
("Background_Languages":

      payload.odata.Background_Languages orderBy ((item, index) -> - item.backgroundElementId) map (item, idx) -> 

    {"__metadata": {
        "uri": "Background_Languages(backgroundElementId=0,userId='"++  userId ++"')",
        "type": "SFOData.Background_Languages"
      },
      "userId": userId,
      "language": item.languageNav.externalCode, // Picklist
      "speakingProf": item.speakingProfNav.externalCode // Picklist
      
   }) if (payload.odata.Background_Languages."__metadata" != null)
} default {})

