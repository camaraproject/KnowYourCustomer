Feature: CAMARA Know Your Customer Fill-in API, v0.3.0-rc.1 - Operation KYC_Fill-in

# Input to be provided by the implementation to the tester
#
# Testing assets:
# * A mobile line identified by its phone number "phoneNumber"
#
# References to OAS spec schemas refer to schemas specifies in kyc-fill-in.yaml, version v0.3.0-rc.1


Background: Common KYC_Fill-in_API setup
    Given an environment at "apiRoot"
    And the resource "/kyc-fill-in/v0.3rc1/fill-in"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema



    ############################################
    # Happy path scenarios for fill-in operation
    ############################################

    @KYC_Fill-in_01_success_request_response
    Scenario: Validation for success fill-in request and response scenario
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the resource "/kyc-fill-in/v0.3rc1"
        When the HTTP "POST" request "KYC_Fill-In" is sent
        Then the response property "$.status" is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator" 
        And the response body complies with the OAS schema at "/components/schemas/KYC_FillinResponse"

    # Generic 400 errors

    @KYC_Fill_400.1_no_request_body
    Scenario: Missing request body
        Given the request body is not included
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    # Generic 401 errors

    @KYC_Fill-in_401.01_expired_access_token
    Scenario: Error response for expired access token
        Given the header "Authorization" is set to an expired access token
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @KYC_Fill-in_401.02_invalid_access_token
    Scenario: Error response for invalid access token
        Given the header "Authorization" is set to an invalid access token
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @KYC_Fill-in_401.03_no_header_authorization
    Scenario: Error response for no header "Authorization"
        Given the header "Authorization" is not sent
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401

    # Error scenarios for management of input parameter phoneNumber

    @KYC_Fill_C02.01_phone_number_not_schema_compliant
    Scenario: Phone number value does not comply with the schema
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text
    
    # Typically with a 2-legged access token
    @KYC_Fill_C02.02_phone_number_not_found
    Scenario: Phone number not found
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
        When the HTTP "POST" request is sent
        Then the response status code is 404
        And the response property "$.status" is 404
        And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    # Only with a 3-legged access token
    @KYC_Fill_C02.03_unnecessary_phone_number
    Scenario: Phone number not to be included when it can be deduced from the access token
        Given the header "Authorization" is set to a valid access token identifying a phone number
        And  the request body property "$.phoneNumber" is set to a valid phone number
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
        And the response property "$.message" contains a user friendly text

    @KYC_Fill_C02.04_missing_phone_number
    Scenario: Phone number not included and cannot be deducted from the access token
        Given the header "Authorization" is set to a valid access which does not identify a single phone number
        And the request body property "$.phoneNumber" is not included
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "MISSING_IDENTIFIER"
        And the response property "$.message" contains a user friendly text

    @KYC_Fill_C02.05_phone_number_not_supported
    Scenario: Service not available for the phone number
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
        And the response property "$.message" contains a user friendly text
