@ddrAuth
Feature: To Check the Authrization drawdown API

Background:
    #Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of "json" request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    #Declarations and file read of 'json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json')
@ddrAuth
Scenario: [TC-ddr-01] To validate the Authrization drawdown API
# Step 1: Read the JSON file
        * def drawdownData = read('classpath:drawdown_data.json')

# Step 2: Extract the `drawdown_Id`
        * def drawdown_Id = drawdownData.drawdown_Id

# Step 3: Print or use the `drawdown_Id`
        * print 'Drawdown ID fetched from file:', drawdown_Id