@sanity @ddr
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
Scenario: [TC-ddr-01] To validate the create drawdown API

# Step 1: Fetch CSRF token and print it for debugging

        * def fetchGenrateCsrftoken = call read('GenerateAdminUserAuth.feature@adminuserauth')
        * print fetchGenrateCsrftoken

# Step 2: Set Authorization token (either globally or locally)
        * def Authorization = fetchGenrateCsrftoken.storedtoken
        * print 'Authorization token:', Authorization

# Step 3: Define the base URL        
        Given url getUrl.mintifiDdrBaseUrl + getUrl.typeCreateDrawdown
        And header Authorization = Authorization
# Step 4: Define the request body
        And def requestBody = getRequestBodyLogin.validateCreateDradown

# Step 5: Include the request body in the request
        And request requestBody

# Step 6: Send the POST request
        When method post

# Step 7: Verify the status code and print the response
        Then status 200
        And print response
# Step 8: Storing the drwdown id
        * def drawdown_Id = response.data.attributes.id
        * karate.write({ drawdown_Id: drawdown_Id }, 'drawdown_data.json')
        * print 'Drawdown ID stored in file:', drawdown_Id