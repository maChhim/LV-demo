%dw 2.0
%dw 2.0
output application/json
---
 {"__metadata": {
        "uri": "Background_Education(backgroundElementId=0,userId='"++  vars.person_id_external ++"')",
        "type": "SFOData.Background_Education"
      }, 
      "userId": vars.person_id_external,
      "country": vars.globalValues.ISOCountryList , // à mapper
      "degreeTitle": payload.degreeTitle,
      "other":payload.other,
      "major": vars.globalValues.major, //à mapper
      "endDate": payload.endDate,
      "school": vars.globalValues.school, //à mapper
      "degree": vars.globalValues.degree //à mapper

 }
