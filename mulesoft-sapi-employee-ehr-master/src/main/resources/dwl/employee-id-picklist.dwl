%dw 2.0
output application/json skipNullOn = "everywhere"
fun isNotNull(data)= (data != null and data != "")
var perso = payload.person 
---
flatten([
    (ecPhoneType : perso.phone_information.phone_type) if (isNotNull(perso.phone_information.phone_type)),
    (ecEmailType : perso.email_information.email_type) if (isNotNull(perso.email_information.email_type)),
    (ecMaritalStatus : perso.personal_information.marital_status) if (isNotNull(perso.personal_information.marital_status)),
    (ISOCountryList: perso.personal_information.nationality)  if (isNotNull(perso.personal_information.nationality)),
    (ISOCountryList: perso.personal_information.second_nationality)  if (isNotNull(perso.personal_information.second_nationality)),
        perso.employment_information.*job_information map ((item, index) -> 
    (contractType: item.contract_type) if( isNotNull(item.contract_type))),

        perso.employment_information.*job_information map ((item, index) -> 
    (LVJohnDoe: item.custom_string5) if (isNotNull(item.custom_string5))),

    	perso.employment_information.*job_relation orderBy ((item, index) -> - index) map ((item, index) -> 
    (jobRelType: item.relationship_type)if isNotNull(item.relationship_type)),

    (Rsnforpaychange: perso.employment_information.compensation_information.custom_string1) if isNotNull(perso.employment_information.compensation_information.custom_string1),
    (Commission: perso.employment_information.compensation_information.custom_string3) if isNotNull(perso.employment_information.compensation_information.custom_string3)

]) filter ($ != {})
