@ccomp
Feature: To Check Create Company API
Background:
    #Declarations and file read of headers/ cookies
        * def fetchDataFromPrerequisiteFile = read('../other/prerequsite.json')
        * def getUrl = fetchDataFromPrerequisiteFile.config
        * def getHeaders = fetchDataFromPrerequisiteFile.actualHeaders
    
    #Declarations and file read of "json" request body
        * def getRequestBodyLogin = read('../request/requestBodyLogin.json')
    #Declarations and file read of 'json' response body
        * def getResponseBodyLogin = read('../response/responseBodyLogin.json')

@ccomp
Scenario:[TC-Comp-01] To verify the Create Company with sending mandatory parameters for company type:Proprietorship
     
# Step 1: Genrating random Pan
                * def business_pan = Array(3).fill(0).map(() => String.fromCharCode(65 + Math.floor(Math.random() * 26))).join('') + 'P' + String.fromCharCode(65 + Math.floor(Math.random() * 26)) + Math.floor(1000 + Math.random() * 9000) + String.fromCharCode(65 + Math.floor(Math.random() * 26))
                * def gst_number = '33' + business_pan + '2ZV'
                * def mobile_number = '9' + Math.floor(100000000 + Math.random() * 900000000) // Random 10-digit mobile number
                * def business_name = Array(2).fill(0).map(() => String.fromCharCode(65 + Math.floor(Math.random() * 26))).join('') + 'STAR Enterprises' // Random business name with numeric suffix
                * def business_email = 'admin' + Math.floor(1000 + Math.random() * 9000) + '@yopmail.com' // Random email


# Step 2: Fetch CSRF token and print it for debugging
                * def fetchGenerateCsrftoken = call read('AnchorAuth.feature@anchorauth')
                * print fetchGenerateCsrftoken
    
# Step 3: Set Authorization token
                * def Authorization = fetchGenerateCsrftoken.authToken
                * print 'Authorization token:', Authorization
    
# Step 4: Define the base URL
    
                Given url getUrl.mintifiAnchorBaseUrl + getUrl.typeCreateCompany
                And headers { "Content-Type": "application/json" }
                And headers { "Accept": "application/vnd.anchor_dashboard.com; version=2" }
                And headers { "Host": "anchors5.test.mintifi.com" }
                And header Authorization = Authorization
                And def requestBody =
                """
                {
                    "data": {
                        "type": "company",
                        "attributes": {
                            "business_name": "#(business_name)",
                            "business_email": "#(business_email)",
                            "mobile_number": "#(mobile_number)",
                            "business_pan": "#(business_pan)",
                            "number_of_directors": 1,
                            "business_type": "Proprietorship",
                            "inc_date": "2014-07-19",
                            "gst_number": "#(gst_number)"
                        },
                        "relationships": {
                            "company_address": {
                                "data": [
                                    {
                                        "id": "1",
                                        "type": "company_address"
                                    }
                                ]
                            },
                            "company_anchor": {
                                "data": [
                                    {
                                        "id": "1",
                                        "type": "company_anchor"
                                    }
                                ]
                            }
                        }
                    },
                    "included": [
                        {
                            "id": "1",
                            "type": "company_address",
                            "attributes": {
                                "address_line1": "Mant Sub Post Office, MANT RAJA, Mat Mula Bangar, Mathura, Uttar Pradesh, 281202",
                                "address_line2": "Test 2",
                                "city": "Mathura",
                                "state": "Uttar Pradesh",
                                "pincode": "281202",
                                "address_type": "business",
                                "ownership_type": "owned",
                                "years_in_address": 6,
                                "years_in_city": 6
                            }
                        },
                        {
                            "id": "1",
                            "type": "company_anchor",
                            "attributes": {
                                "anchor_id": 62,
                                "customer_code": "abc",
                                "company_code": "test1"
                            }
                        }
                    ]
                }
                """
                And request requestBody
                When method post
                Then status 200
                And print response
# Step 5: Storing company Id :
                * def proprietorshipCompId = response.data.id
                * print "Company Id for Prop:" , proprietorshipCompId

@ccomp
Scenario:[TC-Comp-02] To verify the Create Company with sending mandatory parameters for company type:Private Limited
     
    # Step 1: Genrating random Pan
                * def business_pan = Array(3).fill(0).map(() => String.fromCharCode(65 + Math.floor(Math.random() * 26))).join('') + 'C' + String.fromCharCode(65 + Math.floor(Math.random() * 26)) + Math.floor(1000 + Math.random() * 9000) + String.fromCharCode(65 + Math.floor(Math.random() * 26))
                * def gst_number = '33' + business_pan + '2ZV'
                * def mobile_number = '8' + Math.floor(100000000 + Math.random() * 900000000) // Random 10-digit mobile number
                * def business_name = Array(2).fill(0).map(() => String.fromCharCode(65 + Math.floor(Math.random() * 26))).join('') + 'STAR Enterprises' // Random business name with numeric suffix
                * def business_email = 'admin' + Math.floor(1000 + Math.random() * 9000) + '@yopmail.com' // Random email
                
        
# Step 2: Fetch CSRF token and print it for debugging
                * def fetchGenerateCsrftoken = call read('AnchorAuth.feature@anchorauth')
                * print fetchGenerateCsrftoken
            
# Step 3: Set Authorization token
                * def Authorization = fetchGenerateCsrftoken.authToken
                * print 'Authorization token:', Authorization
            
# Step 4: Define the base URL
            
                Given url getUrl.mintifiAnchorBaseUrl + getUrl.typeCreateCompany
                And headers { "Content-Type": "application/json" }
                And headers { "Accept": "application/vnd.anchor_dashboard.com; version=2" }
                And headers { "Host": "anchors5.test.mintifi.com" }
                And header Authorization = Authorization
                And def requestBody =
                """
                {
                    "data": {
                        "type": "company",
                        "attributes": {
                            "business_name": "#(business_name)",
                            "business_email": "#(business_email)",
                            "mobile_number": "#(mobile_number)",
                            "business_pan": "#(business_pan)",
                            "number_of_directors": 1,
                            "business_type": "private_limited",
                            "inc_date": "2014-07-19",
                            "gst_number": "#(gst_number)"
                        },
                        "relationships": {
                            "company_address": {
                                "data": [
                                    {
                                        "id": "1",
                                        "type": "company_address"
                                    }
                                ]
                            },
                            "company_anchor": {
                                "data": [
                                    {
                                        "id": "1",
                                        "type": "company_anchor"
                                    }
                                ]
                            }
                        }
                    },
                    "included": [
                        {
                            "id": "1",
                            "type": "company_address",
                            "attributes": {
                                "address_line1": "Mant Sub Post Office, MANT RAJA, Mat Mula Bangar, Mathura, Uttar Pradesh, 281202",
                                "address_line2": "Test 2",
                                "city": "Mathura",
                                "state": "Uttar Pradesh",
                                "pincode": "281202",
                                "address_type": "business",
                                "ownership_type": "owned",
                                "years_in_address": 6,
                                "years_in_city": 6
                            }
                        },
                        {
                            "id": "1",
                            "type": "company_anchor",
                            "attributes": {
                                "anchor_id": 62,
                                "customer_code": "abc",
                                "company_code": "test1"
                            }
                        }
                    ]
                }
                """
                And request requestBody
                When method post
                Then status 200
                And print response

# Step 5: Storing company Id :
                * def privatelimitedCompId = response.data.id
                * print "Company Id for Prop:" , privatelimitedCompId

@ccomp
Scenario:[TC-Comp-03] To verify the Create Company with sending mandatory parameters for company type:Partnership
     
 # Step 1: Genrating random Pan
                * def business_pan = Array(3).fill(0).map(() => String.fromCharCode(65 + Math.floor(Math.random() * 26))).join('') + 'F' + String.fromCharCode(65 + Math.floor(Math.random() * 26)) + Math.floor(1000 + Math.random() * 9000) + String.fromCharCode(65 + Math.floor(Math.random() * 26))
                * def gst_number = '27' + business_pan + '2ZV'
                * def mobile_number = '7' + Math.floor(100000000 + Math.random() * 900000000) // Random 10-digit mobile number
                * def business_name = Array(2).fill(0).map(() => String.fromCharCode(65 + Math.floor(Math.random() * 26))).join('') + 'STAR Enterprises' // Random business name with numeric suffix
                * def business_email = 'ogrmanager' + Math.floor(1000 + Math.random() * 9000) + '@yopmail.com' // Random email
                            
                    
# Step 2: Fetch CSRF token and print it for debugging
                * def fetchGenerateCsrftoken = call read('AnchorAuth.feature@anchorauth')
                * print fetchGenerateCsrftoken
                        
# Step 3: Set Authorization token
                * def Authorization = fetchGenerateCsrftoken.authToken
                            * print 'Authorization token:', Authorization
                        
# Step 4: Define the base URL
                        
                Given url getUrl.mintifiAnchorBaseUrl + getUrl.typeCreateCompany
                And headers { "Content-Type": "application/json" }
                And headers { "Accept": "application/vnd.anchor_dashboard.com; version=2" }
                And headers { "Host": "anchors5.test.mintifi.com" }
                And header Authorization = Authorization
                And def requestBody =
                """
                {
                    "data": {
                        "type": "company",
                        "attributes": {
                            "business_name": "#(business_name)",
                            "business_email": "#(business_email)",
                            "mobile_number": "#(mobile_number)",
                            "business_pan": "#(business_pan)",
                            "number_of_directors": 1,
                            "business_type": "partnership",
                            "inc_date": "2014-07-19",
                            "gst_number": "#(gst_number)"
                        },
                        "relationships": {
                            "company_address": {
                                "data": [
                                    {
                                        "id": "1",
                                        "type": "company_address"
                                    }
                                ]
                            },
                            "company_anchor": {
                                "data": [
                                    {
                                        "id": "1",
                                        "type": "company_anchor"
                                    }
                                ]
                            }
                        }
                    },
                    "included": [
                        {
                            "id": "1",
                            "type": "company_address",
                            "attributes": {
                                "address_line1": "Mant Sub Post Office, MANT RAJA, Mat Mula Bangar, Mathura, Uttar Pradesh, 281202",
                                "address_line2": "Test 2",
                                "city": "Mathura",
                                "state": "Uttar Pradesh",
                                "pincode": "281202",
                                "address_type": "business",
                                "ownership_type": "owned",
                                "years_in_address": 6,
                                "years_in_city": 6
                            }
                        },
                        {
                            "id": "1",
                            "type": "company_anchor",
                            "attributes": {
                                "anchor_id": 62,
                                "customer_code": "abc",
                                "company_code": "test1"
                            }
                        }
                    ]
                }
                """
                And request requestBody
                When method post
                Then status 200
                And print response
            
# Step 5: Storing company Id :
            * def partnershipCompId = response.data.id
            * print "Company Id for Prop:" , partnershipCompId
