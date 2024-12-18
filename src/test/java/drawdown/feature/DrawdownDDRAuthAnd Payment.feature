@sanity @ddrSCFAuthPay
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
@ddrSCFAuthPay
Scenario: [TC-ddr-01] To validate the Authrization drawdown and and Update Payment API for Manual Case.

# Call the create drawdown feature and extract dynamic parameters
        * def createDrawdownResponse = call read('CreateDrawdownSCF.feature')
        * def drawdown_Id = createDrawdownResponse.drawdown_Id
        * def anchorName = createDrawdownResponse.anchor_Name
# Trim the anchorName (removes leading and trailing spaces)
        * def anchorNameTrimmed = anchorName.trim()
        * print 'Drawdown ID:', drawdown_Id
        * print 'Anchor Name:', anchorName
    
# Fetch CSRF token and set Authorization
        * def fetchGenerateCsrftoken = call read('ExecutionHelper/GenerateAdminUserAuth.feature@adminuserauth')
        * def Authorization = fetchGenerateCsrftoken.storedtoken
    
# Construct the URL dynamically with drawdown ID
        * def fullUrl = "https://test-collections-api.mintifi.com/api/ddr/v1/drawdown_requests/" + drawdown_Id + "/authorize_drawdown"
        * print 'Constructed URL:', fullUrl
        Given url fullUrl
        And header Authorization = Authorization

# Base payload template with dynamic values
        Given def requestPayload =
        """
                {
                        "data": {
                          "type": "disbursal_request",
                          "attributes": {
                            "pin_number": "123456",
                            "status": "authorised",
                            "bank_account_id": "33141",
                            "question3": "#(anchorNameTrimmed)",
                            "disbursement_type": "manual"
                            
                          }
                        }
                      }
        """

# Print the final request payload
        * print 'Final Request Payload:', requestPayload
        And request requestPayload
# Wait for a specific amount of time before calling the authorize_drawdown API
        * def sleep = Java.type('java.lang.Thread').sleep
        * sleep(40000)

# Make the PATCH request to the API
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
                        "disbursement_date": "2024-12-14"
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
