@anchorauth
Feature: To Check the Anchor Admin User Auth API
Background:
    #Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of "json" request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    #Declarations and file read of 'json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json')

@anchorauth
Scenario:[TC-MB-01] To verify the Anchor Admin User Auth API with sending mandatory parameters.
        
        Given url getUrl.mintifiAnchorBaseUrl + getUrl.typeAuthAnchor
        And headers { "Content-Type": "application/json" }
        And headers { "Accept": "application/vnd.anchor_dashboard.com; version=1" }
        And headers { "Host": "anchors5.test.mintifi.com" }
        And def requestBody = getRequestBodyLogin.verifyAnchorAuth
        And request requestBody
        When method post
        Then status 200
        And print response
        * def authToken = response.auth_token
        * print "Auth Token is: ", authToken