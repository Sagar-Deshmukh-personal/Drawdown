@sanity @adminuserauth
Feature: To Check the Admin User Auth API
Background:
    #Declarations and file read of headers/ cookies
         * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of "json" request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    #Declarations and file read of 'json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json')

@adminuserauth
Scenario:[TC-MB-01] To verify the Admin User Auth API with sending mandatory parameters and ensure the response matches the expected success structure
        
        Given url getUrl.mintifiBaseUrl + getUrl.typeAdminUser
        And headers getHeaders
        And def requestBody = getRequestBodyLogin.validateAdminUser
        And request requestBody
        When method post
        Then status 200
        And print response
        And assert responseStatus == 200
# Storing the token value for futher use
        * def storedtoken = response.auth.token
        * print 'Store Token: ', storedtoken