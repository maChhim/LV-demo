%dw 2.0
output application/json
---
{"__metadata": {
        "uri": "Background_OutsideWorkExperience(backgroundElementId=0,userId='"++  vars.person_id_external ++"')",
        "type": "SFOData.Background_OutsideWorkExperience"
      },
      "userId": vars.person_id_external,
      "endDate": payload.endDate,
      "custom3": vars.globalValues.jobJohnDoe, 
      "custom4": payload.custom4, 
      "custom1": vars.globalValues.industry, 
      "custom2": vars.globalValues.ISOCountryList,
      "department": payload.department,
      "title": payload.title,
      "startDate": payload.startDate

   }