%dw 2.0
output application/json
---
    {
      "__metadata": {
        "uri": "Background_InsideWorkExperience(backgroundElementId=0,userId='" ++ vars.person_id_external ++ "')",
        "type": "SFOData.Background_InsideWorkExperience"
      },
      "userId": vars.person_id_external,
      "country": vars.globalValues.ISOCountryList,
      "endDate": payload.endDate,
      "WorkLocation": payload.WorkLocation,
      "function": vars.globalValues.jobJohnDoe,
      "legal_entity": payload.legal_entity,
      "title": payload.title,
      "startDate": payload.startDate
    }