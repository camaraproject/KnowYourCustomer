Feature: CAMARA KYC Age Verification API, v0.1.0 - Operation verifyAge
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    #
    # Testing assets:
    # * A mobile line identified by its phone number "phoneNumber"
    #
    # References to OAS spec schemas refer to schemas specifies in kyc-age-verification.yaml, version 0.1.0

    Background: Common verifyAge setup
        Given an environment at "apiRoot"
        And the resource "/kyc-age-verification/v0.1/verify"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" is set to a UUID value
        And the request body is set by default to a request body compliant with the schema

    # Happy path scenarios

    @verifyAge_1_verify_age_true
    Scenario Outline: Validate successful response when ageCheck is true
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.ageThreshold" is set to a valid value compliant with the OAS schema at "#/components/schemas/AgeThreshold"
        And the age information associated with the mobile subscription is equal or greater that the age threshold provided
        And the request body optionally contains the property "<request_body_property>" with a value compliant with OAS schema at "<oas_spec_schema>"
        When the HTTP "POST" request is sent
        Then the response status code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/VerifyResponseBody"
        And the response property "$.ageCheck" is "true"
        And if the response contains property "$.verifiedStatus", the value is one of [true, false]
        And if the response contains property "$.identityMatchScore", the value is compliant with OAS schema at "#/components/schemas/IdentityMatchScore"

        Examples:
            | request_body_property | oas_spec_schema                       |
            | $.idDocument          | /components/schemas/IdDocument        |
            | $.name                | /components/schemas/Name              |
            | $.givenName           | /components/schemas/GivenName         |
            | $.familyName          | /components/schemas/FamilyName        |
            | $.middleNames         | /components/schemas/MiddleNames       |
            | $.familyNameAtBirth   | /components/schemas/FamilyNameAtBirth |
            | $.birthdate           | /components/schemas/Birthdate         |
            | $.email               | /components/schemas/Email             |
    
    
    @verifyAge_2_verify_age_false
    Scenario Outline: Validate successful response when ageCheck is false
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.ageThreshold" is set to a valid value compliant with the OAS schema at "#/components/schemas/AgeThreshold"
        And the age information associated with the mobile subscription is lower that the age threshold provided
        And the request body optionally contains the property "<request_body_property>" with a value compliant with OAS schema at "<oas_spec_schema>"
        When the HTTP "POST" request is sent
        Then the response status code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/VerifyResponseBody"
        And the response property "$.ageCheck" is "false"
        And if the response contains property "$.verifiedStatus", the value is one of [true, false]
        And if the response contains property "$.identityMatchScore", the value is compliant with OAS schema at "#/components/schemas/IdentityMatchScore"

        Examples:
            | request_body_property | oas_spec_schema                       |
            | $.idDocument          | /components/schemas/IdDocument        |
            | $.name                | /components/schemas/Name              |
            | $.givenName           | /components/schemas/GivenName         |
            | $.familyName          | /components/schemas/FamilyName        |
            | $.middleNames         | /components/schemas/MiddleNames       |
            | $.familyNameAtBirth   | /components/schemas/FamilyNameAtBirth |
            | $.birthdate           | /components/schemas/Birthdate         |
            | $.email               | /components/schemas/Email             |

    @verifyAge_3_verify_age_not_available
    Scenario Outline: Validate successful response when ageCheck is not available
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.ageThreshold" is set to a valid value compliant with the OAS schema at "#/components/schemas/AgeThreshold"
        And the API Provider cannot verify the age information
        And the request body optionally contains the property "<request_body_property>" with a value compliant with OAS schema at "<oas_spec_schema>"
        When the HTTP "POST" request is sent
        Then the response status code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/VerifyResponseBody"
        And the response property "$.ageCheck" is "not_available"
        And if the response contains property "$.verifiedStatus", the value is one of [true, false]
        And if the response contains property "$.identityMatchScore", the value is compliant with OAS schema at "#/components/schemas/IdentityMatchScore"

        Examples:
            | request_body_property | oas_spec_schema                       |
            | $.idDocument          | /components/schemas/IdDocument        |
            | $.name                | /components/schemas/Name              |
            | $.givenName           | /components/schemas/GivenName         |
            | $.familyName          | /components/schemas/FamilyName        |
            | $.middleNames         | /components/schemas/MiddleNames       |
            | $.familyNameAtBirth   | /components/schemas/FamilyNameAtBirth |
            | $.birthdate           | /components/schemas/Birthdate         |
            | $.email               | /components/schemas/Email             |

    @verifyAge_4_verify_age_contentLock
    Scenario: Validate successful response when contentLock is requested
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.ageThreshold" is set to a valid value compliant with the OAS schema at "#/components/schemas/AgeThreshold"
        And the request body property "$.includeContentLock" is set to true
        When the HTTP "POST" request is sent
        Then the response status code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/VerifyResponseBody"
        And the response contains property "$.ageCheck" whose value is one of ["true", "false", "not_available"]
        And the response contains property "$.contentLock" whose value is one of ["true", "false", "not_available"]
    
    @verifyAge_5_verify_age_parentalControl
    Scenario: Validate successful response when parentalControl is requested
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.ageThreshold" is set to a valid value compliant with the OAS schema at "#/components/schemas/AgeThreshold"
        And the request body property "$.includeParentalControl" is set to true
        When the HTTP "POST" request is sent
        Then the response status code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/VerifyResponseBody"
        And the response contains property "$.ageCheck" whose value is one of ["true", "false", "not_available"]
        And the response contains property "$.parentalControl" whose value is one of ["true", "false", "not_available"]


    # Generic 400 errors

    @verifyAge_400.1_no_request_body
    Scenario: Missing request body
        Given the request body is not included
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @verifyAge_400.2_empty_request_body
    Scenario: Empty object as request body
        Given the request body is set to "{}"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @verifyAge_400.3_out_of_range
    Scenario: Error when ageThreshold is out of range
        Given the request body property "$.ageThreshold" is set to a value that is not withing the range defined in OAS schema "#/components/schemas/AgeThreshold"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "OUT_OF_RANGE"
        And the response property "$.message" contains a user friendly text

    @verifyAge_400.4_invalid_argument
    Scenario: Invalid Argument. Generic Syntax Exception
        Given the request body is set to any value which is not compliant with the OAS schema at "/components/schemas/VerifyRequestBody"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    
    # Generic 401 errors

    @verifyAge_401.1_expired_access_token
    Scenario: Error response for expired access token
        Given the header "Authorization" is set to an expired access token
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @verifyAge_401.2_invalid_access_token
    Scenario: Error response for invalid access token
        Given the header "Authorization" is set to an invalid access token which is invalid for reasons other than lifetime expiry
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @verifyAge_401.3_no_header_authorization
    Scenario: Error response for no header "Authorization"
        Given the header "Authorization" is not sent
        When the HTTP "POST" request is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401

    
    # Error scenarios for management of input parameter phoneNumber

    @verifyAge_C02.01_phone_number_not_schema_compliant
    Scenario: Phone number value does not comply with the schema
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text
    
    # Typically with a 2-legged access token
    @verifyAge_C02.02_phone_number_not_found
    Scenario: Phone number not found
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
        When the HTTP "POST" request is sent
        Then the response status code is 404
        And the response property "$.status" is 404
        And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    # Only with a 3-legged access token
    @verifyAge_C02.03_unnecessary_phone_number
    Scenario: Phone number not to be included when it can be deduced from the access token
        Given the header "Authorization" is set to a valid access token identifying a phone number
        And  the request body property "$.phoneNumber" is set to a valid phone number
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
        And the response property "$.message" contains a user friendly text

    @verifyAge_C02.04_missing_phone_number
    Scenario: Phone number not included and cannot be deducted from the access token
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And the request body property "$.phoneNumber" is not included
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "MISSING_IDENTIFIER"
        And the response property "$.message" contains a user friendly text

    @verifyAge_C02.05_phone_number_not_supported
    Scenario: Service not available for the phone number
        Given that the service is not available for all phone numbers commercialized by the operator
        And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
        And the response property "$.message" contains a user friendly text
