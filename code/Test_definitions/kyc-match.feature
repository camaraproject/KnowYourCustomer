Feature: CAMARA Know Your Customer Match API, v0.3.0 - Operation KYC_Match
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * Whether or not the idDocument request body property is mandatory.
    #
    # Testing assets:
    # * A mobile line identified by its phone number "phoneNumber"
    #
    # References to OAS spec schemas refer to schemas specifies in kyc-match.yaml, version 0.3.0

    Background: Common KYC_Match setup
        Given an environment at "apiRoot"
        And the resource "/kyc-match/v0.3/match"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" is set to a UUID value
        And the request body is set by default to a request body compliant with the schema


    # Happy path scenarios

    @KYC_Match_1_success_request_response
    Scenario: Validate successful response
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body is set to a valid parameter combination
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"

    @KYC_Match_2_success_specific_property
    Scenario Outline: Validate success response when providing specific property
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body is set to a valid parameter combination
        And the request body property "<request_property_path>" is set to a valid value that complies with the OAS schema at "/components/schemas/KYC_MatchRequestBody"
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"
        And the response contains the property "<response_property_path>"

        Examples:
            | request_property_path     | response_property_path        |
            | $.idDocument              | $.idDocumentMatch             |
            | $.name                    | $.nameMatch                   |
            | $.givenName               | $.givenNameMatch              |
            | $.familyName              | $.familyNameMatch             |
            | $.nameKanaHankaku         | $.nameKanaHankakuMatch        |
            | $.nameKanaZenkaku         | $.nameKanaZenkakuMatch        |
            | $.middleNames             | $.middleNamesMatch            |
            | $.familyNameAtBirth       | $.familyNameAtBirthMatch      |
            | $.address                 | $.addressMatch                |
            | $.streetName              | $.streetNameMatch             |
            | $.streetNumber            | $.streetNumberMatch           |
            | $.postalCode              | $.postalCodeMatch             |
            | $.region                  | $.regionMatch                 |
            | $.locality                | $.localityMatch               |
            | $.country                 | $.countryMatch                |
            | $.houseNumberExtension    | $.houseNumberExtensionMatch   |
            | $.birthdate               | $.birthdateMatch              |
            | $.email                   | $.emailMatch                  |
            | $.gender                  | $.genderMatch                 |


    @KYC_Match_3_success_specific_property_score
    # Note: This test scenario is optional, as implementation of 'score' feature is optional to network operators/ API providers.
    Scenario Outline: Validate success response when providing specific property with false value
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body is set to a valid parameter combination with property "<request_property_path>" set to a valid formatted value that does not match the value stored in the MNO system
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"
        And the response property "<response_property_path>" is equal to "false"
        And the response property "<response_score_property_path>" is equal to an integer value between 0 and 99

        Examples:
            | request_property_path     | response_property_path        | response_score_property_path  |
            | $.idDocument              | $.idDocumentMatch             | $.idDocumentMatchScore        |
            | $.name                    | $.nameMatch                   | $.nameMatchScore              |
            | $.givenName               | $.givenNameMatch              | $.givenNameMatchScore         |
            | $.familyName              | $.familyNameMatch             | $.familyNameMatchScore        |
            | $.nameKanaHankaku         | $.nameKanaHankakuMatch        | $.nameKanaHankakuMatchScore   |
            | $.nameKanaZenkaku         | $.nameKanaZenkakuMatch        | $.nameKanaZenkakuMatchScore   |
            | $.middleNames             | $.middleNamesMatch            | $.middleNamesScore            |
            | $.familyNameAtBirth       | $.familyNameAtBirthMatch      | $.familyNameAtBirthMatchScore |
            | $.address                 | $.addressMatch                | $.addressMatchScore           |
            | $.streetName              | $.streetNameMatch             | $.streetNameMatchScore        |
            | $.streetNumber            | $.streetNumberMatch           | $.streetNumberMatchScore      |
            | $.region                  | $.regionMatch                 | $.regionMatchScore            |
            | $.locality                | $.localityMatch               | $.localityMatchScore          |
            | $.birthdate               | $.birthdateMatch              | $.birthdateMatchScore         |
            | $.email                   | $.emailMatch                  | $.emailMatchScore             |

    @KYC_Match_4_perfect_match_no_scores_provided
    Scenario Outline: Validate success response when providing specific property with true value
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body is set to a valid parameter combination with property "<request_property_path>" set to a valid formatted value that does perfectly match the value stored in the MNO system
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"
        And the response property "<response_property_path>" is equal to "true"
        And the response property "<response_score_property_path>" is not existing

        Examples:
            | request_property_path     | response_property_path        | response_score_property_path  |
            | $.idDocument              | $.idDocumentMatch             | $.idDocumentMatchScore        |
            | $.name                    | $.nameMatch                   | $.nameMatchScore              |
            | $.givenName               | $.givenNameMatch              | $.givenNameMatchScore         |
            | $.familyName              | $.familyNameMatch             | $.familyNameMatchScore        |
            | $.nameKanaHankaku         | $.nameKanaHankakuMatch        | $.nameKanaHankakuMatchScore   |
            | $.nameKanaZenkaku         | $.nameKanaZenkakuMatch        | $.nameKanaZenkakuMatchScore   |
            | $.middleNames             | $.middleNamesMatch            | $.middleNamesScore            |
            | $.familyNameAtBirth       | $.familyNameAtBirthMatch      | $.familyNameAtBirthMatchScore |
            | $.address                 | $.addressMatch                | $.addressMatchScore           |
            | $.streetName              | $.streetNameMatch             | $.streetNameMatchScore        |
            | $.streetNumber            | $.streetNumberMatch           | $.streetNumberMatchScore      |
            | $.region                  | $.regionMatch                 | $.regionMatchScore            |
            | $.locality                | $.localityMatch               | $.localityMatchScore          |
            | $.birthdate               | $.birthdateMatch              | $.birthdateMatchScore         |
            | $.email                   | $.emailMatch                  | $.emailMatchScore             |

    @KYC_Match_5_success_multiple_optional_parameter_combinations
    Scenario: Validate success response when providing different optional parameter combinations
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.idDocument" is set to a valid identity document
        And the request body property "$.name" is set to a valid name
        And the request body property "$.givenName" is set to a valid given name
        And the request body property "$.familyName" is set to a valid family name
        And the request body property "$.nameKanaHankaku" is set to a valid name
        And the request body property "$.nameKanaZenkaku" is set to a valid name
        And the request body property "$.middleNames" is set to a valid middle names
        And the request body property "$.familyNameAtBirth" is set to a valid family name at birth
        And the request body property "$.address" is set to a valid address
        And the request body property "$.streetName" is set to a valid street name of the address
        And the request body property "$.streetNumber" is set to a valid street number of the address
        And the request body property "$.postalCode" is set to a valid postal code of the address
        And the request body property "$.region" is set to a valid region of the address
        And the request body property "$.locality" is set to a valid locality of the address
        And the request body property "$.country" is set to the country of the address value that complies with the ISO 3166-1 alpha-2 format
        And the request body property "$.houseNumberExtension" is set to a valid house number extension of the address
        And the request body property "$.birthdate" is set to a birthdate value that complies with the ISO 8601 calendar date format "YYYY-MM-DD"
        And the request body property "$.email" is set to a email value that complies with the RFC format "{local-part}@{domain}"
        And the request body property "$.gender" is set to a valid gender value that belongs to the enumeration ("MALE", "FEMALE", "OTHER")
        And the given request body is populated with any random combination of afore mention optional parameters
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"

    @KYC_Match_6_success_id_document_required
    # Note: This test scenario is optional, as idDocument parameter and Second Level Validation is optional to network operators/ API providers.
    Scenario: Validate success when idDocument is required to perform the match validation for any other property
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.idDocument" is set to a valid identity document associated with the identified phoneNumber
        And the request body is set to a valid parameter combination
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"

    # Generic 401 errors

    @KYC_Match_401.1_expired_access_token
    Scenario: Error response for expired access token
        Given the header "Authorization" is set to an expired access token
        When the request "KYC_Match" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @KYC_Match_401.2_invalid_access_token
    Scenario: Error response for invalid access token
        Given the header "Authorization" is set to an invalid access token
        When the request "KYC_Match" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @KYC_Match_401.3_no_header_authorization
    Scenario: Error response for no header "Authorization"
        Given the header "Authorization" is not sent
        When the request "KYC_Match" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    # Generic 400 errors

    @KYC_Match_400.1_no_request_body
    Scenario: Missing request body
        Given the request body is not included
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @KYC_Match_400.2_empty_request_body
    Scenario: Empty object as request body
        Given the request body is set to "{}"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @KYC_Match_400.3_invalid_argument
    Scenario: Invalid Argument. Generic Syntax Exception
        Given the request body is set to any value which is not compliant with the OAS schema at "/components/schemas/VerifyRequestBody"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text


    # API Specific Errors

    @KYC_Match_10_invalid_param_combination
    Scenario: Error 400 when body does not contain any fields other than phone number
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.phoneNumber" set to a valid formatted value
        And the request body contains only the property "$.phoneNumber"
        When the request "KYC_Match" is sent
        Then the response status code is 400
        And the response property "$.code" is "KNOW_YOUR_CUSTOMER.INVALID_PARAM_COMBINATION"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 400


    @KYC_Match_11_phone_number_provided_does_not_match_the_token
    Scenario: Error when the phone number provided in the request body does not match the phone number associated with the access token
        # To test this, a token has to be obtained for a different phoneNumber
        Given the request body property "$.phoneNumber" is set to a valid testing phone number 
        And the header "Authorization" is set to a valid access token emitted for a different phone number
        When the request "KYC_Match" is sent
        Then the response status code is 403
        And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 403


    @KYC_Match_12_idDocument_required
    # Note: This test scenario is optional, as idDocument parameter and Second Level Validation is optional to network operators/ API providers.
    Scenario: Error 403 when body does not contain idDocument when this is required
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body is set to a valid parameter combination without property "$.idDocument"
        When the request "KYC_Match" is sent
        Then the response status code is 403
        And the response property "$.code" is "KNOW_YOUR_CUSTOMER.ID_DOCUMENT_REQUIRED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 403


    @KYC_Match_13_idDocument_mismatch_when_idDocument_is_required
    # Note: This test scenario is optional, as idDocument parameter and Second Level Validation is optional to network operators/ API providers.
    Scenario: Error 403 when the idDocument included in the request does not match the one saved in the MNO system when the idDocument is required
        Given a valid testing phone number supported by the service, identified by the access token or provided in the request body
        And the request body property "$.idDocument" is set to a valid idDocument that is not associated with the identified phone number
        When the request "KYC_Match" is sent
        Then the response status code is 403
        And the response property "$.code" is "KNOW_YOUR_CUSTOMER.ID_DOCUMENT_MISMATCH"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 403

    # Error scenarios for management of input parameter phoneNumber

    @KYC_Match_C02.01_phone_number_not_schema_compliant
    Scenario: Phone number value does not comply with the schema
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @KYC_Match_C02.02_phone_number_not_found
    Scenario: Phone number not found
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
        When the HTTP "POST" request is sent
        Then the response status code is 404
        And the response property "$.status" is 404
        And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    @KYC_Match_C02.04_missing_phone_number
    Scenario: Phone number not included and cannot be deducted from the access token
        Given the header "Authorization" is set to a valid access token which does not identify a single phone number
        And the request body property "$.phoneNumber" is not included
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "MISSING_IDENTIFIER"
        And the response property "$.message" contains a user friendly text

    # When the service is only offered to certain type of subscriptions, e.g. IoT, , B2C, etc
    @KYC_Match_C02.05_phone_number_not_supported
    Scenario: Service not available for the phone number
        Given that the service is not available for all phone numbers commercialized by the operator
        And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
        And the response property "$.message" contains a user friendly text
