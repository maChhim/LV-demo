%dw 2.0
output application/json
import * from dw::util::Timer
var eventAttributes = payload.eventAttributes
var process = payload.process
---
{
    "eventName": payload.eventName,
    "eventType": payload.eventType,
    "eventDescription": payload.eventDescription,
    "eventTime": "/Date(" ++ currentMilliseconds() ++ ")/",
    "eventAttributes": {
        "__metadata": {
            "uri": p('request.metadata.uri')
        },
        "name": eventAttributes.name,
        "value": eventAttributes.value
    },
    "process": {
        "processDefinitionId": process.definitionId,
        "processInstanceId": process.instanceId,
        "processType": p('request.processType'),
        "processDefinitionName": process.definitionName,
        "processInstanceName": process.instanceName
    }
}