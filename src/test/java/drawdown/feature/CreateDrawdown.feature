@ddr
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
@ddr
Scenario: [TC-ddr-01] To verify the create drawdown API

# Call the token-generating feature file

        * def fetchGenrateCsrftoken = call read('GenerateAdminUserAuth.feature@adminuserauth')
        * print fetchGenrateCsrftoken
        * karate.set('Authorization', fetchGenrateCsrftoken.storedtoken)