Feature: CAMARA Know Your Customer Fill-in API, v0.2.0 - Operation KYC_Fill-in

# Environment variables:
# * api_root: API root of the server URL
#
# References to OAS spec schemas refer to schemas specifies in kyc-fill-in.yaml, version v0.2.0
#


Background: Common KYC_Fill-in_API setup
    Given an environment at "apiRoot"-
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema



############################################
# Happy path scenarios for fill-in operation
############################################


  @KYC_Fill-in_API_01_fill-in_request_success_scenario
  Scenario: Validation for success fill-in request and response scenario
    Given the request body does not have any property
    And the resource "/kyc-fill-in/v0.2"
    When the HTTP "POST" request "KYC_Fill-In" is sent
    Then the response property "$.status" is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator" 
    And the response body complies with the OAS schema at "/components/schemas/KYC_FillinResponse"

    # Generic 401 errors

    @KYC_Fill-in_401.01_expired_access_token
    Scenario: Error response for expired access token
        Given the header "Authorization" is set to an expired access token
        And the resource "/kyc-fill-in/v0.2"
        When the HTTP "POST" request "KYC_Fill-In" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @KYC_Fill-in_401.02_invalid_access_token
    Scenario: Error response for invalid access token
        Given the header "Authorization" is set to an invalid access token
        And the resource "/kyc-fill-in/v0.2"
        When the HTTP "POST" request "KYC_Fill-In" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @KYC_Fill-in_401.03_no_header_authorization
    Scenario: Error response for no header "Authorization"
        Given the header "Authorization" is not sent
        And the resource "/kyc-fill-in/v0.2"
        When the HTTP "POST" request "KYC_Fill-In" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401

        
[END]
