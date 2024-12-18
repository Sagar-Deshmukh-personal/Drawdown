@ddrSCF
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
@ddrSCF
Scenario: [TC-ddr-01] To verify the create invoice and create drawdown API for SCF product
# Step 1: Fetch CSRF token and print it for debugging
         * def fetchGenerateCsrftoken = call read('ExecutionHelper/GenerateAdminUserAuth.feature@adminuserauth')
         * print fetchGenerateCsrftoken
    
# Step 2: Set Authorization token
         * def Authorization = fetchGenerateCsrftoken.storedtoken
         * print 'Authorization token:', Authorization
    
         Given url getUrl.mintifiDdrBaseUrl + getUrl.typeAuthInvoice
         And header Content-Type = 'multipart/form-data'
         And header Authorization = Authorization
 
 #Step 3: Generate dynamic values for gstInvoiceId, invoiceDate, and dueDate
        * def dynamicInvoiceNumber = 'InvoiceId_' + Math.floor(Math.random() * 50000)  // Genrating dynamic Invoice ID
        * def LocalDate = Java.type('java.time.LocalDate')
        * def dynamicInvoiceDate = LocalDate.now().toString() // Current date as invoice date
        * print 'Dynamic Invoice Date:', dynamicInvoiceDate
        * def dynamicDueDate = LocalDate.now().plusDays(10).toString() // Due date 10 days from now
        * print 'Dynamic Invoice Due Date:', dynamicDueDate
        * print 'Dynamic Invoice Number:', dynamicInvoiceNumber
        * def StoreInvoiceValue = dynamicInvoiceNumber
 
 # Step 4: Define the invoice form data
        And multipart field data[type] = 'invoice'
        And multipart field data[attributes][loan_application_id] = 66692
        And multipart field data[attributes][invoice_date] = dynamicInvoiceDate
        And multipart field data[attributes][invoice_due_date] = dynamicDueDate
        And multipart field data[attributes][amount] = '500'
        And multipart field data[attributes][invoice_amount] = '500'
        And multipart field data[attributes][invoice_number] = dynamicInvoiceNumber
        
 # Step 5: Send the POST request with form data
         When method post
 # Step 6: Verify the response status code
         Then status 200
 # Step 7: Print the response for debugging
         Then print "Response: ", response
         
 # Step 8: Storing the invoice no
        * def invoiceId = response.data.id
        * print 'Invoice Number is:', invoiceId
        * def invoiceAmount =  response.data.attributes.invoice_amount
        * print 'invoice Amount is:', invoiceAmount
        * def invoiceDate = response.data.attributes.invoice_date
        * print 'invoice Date is:', invoiceDate
        * def invoiceNumber = response.data.attributes.invoice_number
        * print 'invoice Date is:', invoiceNumber
        * def anchorName = response.data.attributes.anchor_name
        * print 'Anchor Name:', anchorName

# Step 9: Define the base Create DDR URL        
        Given url getUrl.mintifiDdrBaseUrl + getUrl.typeCreateDrawdown
        And header Authorization = Authorization

# Step 10:Define the request body
        Given def requestPayload =
        """
        {
        "drawdown_request": {
                "loan_application_id": 66692,
                "product_type": "supply_chain",
                "drawdown_amount": #(invoiceAmount),
                "status": "verified",
                "source": "ddr_portal",
                "drawdown_invoices_attributes": [
                {
                        "invoice_id": #(invoiceId),
                        "amount": #(invoiceAmount)
                }
                ]
        }
        }
        """
        And request requestPayload

# Step 11: Send the POST request
        When method post

# Step 12: Verify the status code and print the response
        Then status 200
        And print response

# Step 13: Store the drawdown ID for subsequent use
        * def drawdown_Id = response.data.id
        * print 'Extracted drawdown_Id:', drawdown_Id
        * def anchor_Name = response.data.attributes.anchor_name
        * print 'Extracted anchor name:', anchor_Name
