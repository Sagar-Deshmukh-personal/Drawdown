@sanity @ddrAuth
Feature: To Check the Authrization and Update Payment drawdown API

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
Scenario: [TC-ddr-01] To validate the Authrization drawdown and and Update Payment API for Manual Case.

# Call the create drawdown feature. 
            * def createDrawdownResponse = call read('CreateDrawdown.feature')
            * def drawdown_Id = createDrawdownResponse.drawdown_Id
            * print 'drawdown_Id from Drawdown feature:', drawdown_Id
        
# Fetch CSRF token and set Authorization
            * def fetchGenerateCsrftoken = call read('ExecutionHelper/GenerateAdminUserAuth.feature@adminuserauth')
            * def Authorization = fetchGenerateCsrftoken.storedtoken

# Construct the URL dynamically with drawdown ID
            * def fullUrl = "https://test-collections-api.mintifi.com/api/ddr/v1/drawdown_requests/" + drawdown_Id + "/authorize_drawdown"
            * print 'Constructed URL:', fullUrl
            Given url fullUrl
            And header Authorization = Authorization

# Define and send the request
            Given def requestPayload =
            """
                {
                    "data": {
                        "type": "disbursal_request",
                        "attributes": {
                            "pin_number": "123456",
                            "status": "authorised",
                            "bank_account_id": "33730",
                            "question1": "AMCO Batteries Limited",
                            "disbursement_type": "manual"
                        }
                    }
                }
            """
            And request requestPayload
            When method PATCH

# Verify response
            Then status 200
            And print 'DDR Authorization Successfully:', response

# Save DDR Id in response
            * def ddr_id = response.data.id
            * print "drawdown_Id:", ddr_id

# Use the URL Update Payment Details API call simnteniously call for the above ddr id
            * def fullUrl = 'https://test-collections-api.mintifi.com/api/ddr/v1/drawdown_requests/' + ddr_id + '/update_payment_details'
            * print 'Constructed URL:', fullUrl
            Given url fullUrl
            And header Authorization = Authorization
    
# Define and send the request with unique utr
            * def uniqueUtr = 'utr-' + java.util.UUID.randomUUID().toString().substring(0, 8)
            * def requestPayload =
            """
                {
                    "data": {
                        "type": "disbursnment_request",
                        "attributes": {
                            "utr": "#(uniqueUtr)",
                            "disbursement_date": "2024-12-05"
                        }
                    }
                }
            """
            * print requestPayload
            And request requestPayload
            When method POST
    
# Verify response
            Then status 200
            * print 'Update Payment Details for the DDR:', response
    