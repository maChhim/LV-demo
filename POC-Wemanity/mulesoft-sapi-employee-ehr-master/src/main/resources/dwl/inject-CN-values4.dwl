%dw 2.0
output application/json
---
    {
      "__metadata": {
        "uri": "Background_Languages(backgroundElementId=0,userId='" ++ vars.person_id_external ++ "')",
        "type": "SFOData.Background_Languages"
      },
        
        "userId": vars.person_id_external,
        "language": vars.globalValues.language,
        "speakingProf": vars.globalValues.fluency
      }