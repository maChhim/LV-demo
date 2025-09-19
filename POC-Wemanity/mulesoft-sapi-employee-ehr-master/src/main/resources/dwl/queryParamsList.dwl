%dw 2.0
output application/json indent = false

var queryParamsList = ["maxRows=400"]
var periodBasedParams = ["queryMode=periodDelta","resultOptions=renderPreviousTags, configuredFieldsOnly"]
var fieldsOnlyParams = ["queryMode=delta","resultOptions=changedsegmentsonly, changedfieldsonly, renderPreviousTags, configuredFieldsOnly"]
var segmentsOnlyParams = ["queryMode=delta","resultOptions=changedsegmentsonly, renderPreviousTags, configuredFieldsOnly"]
var defaultParams = ["queryMode=delta","resultOptions=renderPreviousTags, configuredFieldsOnly"]
var RomanianParams = ["resultOptions=allJobChangesPerDay, allCompensationChangesPerDay, configuredFieldsOnly"]
 
var appendParams =

        if(!isEmpty(vars.queryType) and (!isEmpty(vars.lastModifiedDateTime))) queryParamsList ++ periodBasedParams
        else if(!isEmpty(vars.employeeId) and (!isEmpty(vars.lastModifiedDateTime))) queryParamsList ++ defaultParams
        else if(vars.region == "ROU" and !isEmpty(vars.employeeId)) queryParamsList ++ RomanianParams
        else if(vars.employeeId != null and vars.employeeId != "") queryParamsList
        else if(vars.transmission == "fieldsOnly") queryParamsList ++ fieldsOnlyParams
        else if(vars.transmission == "segmentsOnly") queryParamsList ++ segmentsOnlyParams
        else if(vars.company startsWith "PT") queryParamsList //SPAD-9128
        else queryParamsList ++ defaultParams 
        
        
---
appendParams
