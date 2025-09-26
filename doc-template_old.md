
# Dummy - sAPI

## Overview

The Dummy - EHR - sAPI enables a user to do the following:

- Call GET /employees - Get all Employees (delta/period-base) based on last successful run date time
- Call GET /employees/{ID} - Get Employee by ID
- Call POST /employees/{ID} - Create the whole Employee File
- Call PUT/employees/{ID} - Modification of Employee, Includes Update on Local Payroll ID
- Call PATCH /employees/{ID} - Partial Update of Employee
- Call POST /logExecutionManager - Log integration status to Execution Manager
- Call GET /cities - Retrieve cities by code
- Call GET /degree - Retrieve degree by userId
- Call GET /workExperience - Retrieve external work experience by userId
- Call GET /legalEntity -  Retrieve legal entity details by code and start date.
- Call GET /employees/advanced-search - Get Employees following criterias indicated as inputFilters


**Short API Name**: dummy-sapi

## Environment and Testing

### URLs

- DEV : [https://dev-eu-api.dummy.net/hr-eu/dummy-sapi/v1/](https://dev-eu-api.dummy.net/hr-eu/dummy-sapi/v1/)
- INT : [https://int-eu-api.dummy.net/hr-eu/dummy-sapi/v1/](https://int-eu-api.dummy.net/hr-eu/dummy-sapi/v1/)

## Security and Policies


### Security

1. Identification : Client ID enforcement enabled on Basic Authent | in HTTP headers

### Policies

1. JSON Threat Protection (if possible with values)

      Example : 

```
{
   "maxContainerDepth": -1,
   "maxStringValueLength": -1,
   "maxObjectEntryNameLength": -1,
   "maxObjectEntryCount": -1,
   "maxArrayElementCount": -1
}
```

## Backend Information

### Backend name :

- HR

### Backend Exchange URL Name :

NA

### Backend URL’s:

DEV: https://api55.sapsf.eu:443/sfapi/v1/soap

INT: https://xxxx.sapsf.eu:443/sfapi/v1/soap

### Backend Authentication :

Username and Password set for Basic Authentication passed thru HTTP Headers 
 
