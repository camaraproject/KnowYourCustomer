Feature: CAMARA Know Your Customer Match API, v0.2.0 - Operation KYC_Match
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * 
    #
    # Testing assets:
    # * A mobile line identified by its phone number "phoneNumber"
    #
    # References to OAS spec schemas refer to schemas specifies in kyc-match.yaml, version 0.2.0

    Background: Common KYC_Match setup
        Given an environment at "apiRoot"
        And the resource "/kyc-match/v0/match"
        And the method "post"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" is set to a UUID value
        And the request body is set by default to a request body compliant with the schema


    # Happy path scenarios

    @KYC_Match_01_success_request_response
    Scenario: Validate successful response
        And the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"
        And the response body has a valid JSON format


    @KYC_Match_02_success_non_existing_query_param
    Scenario Outline: Success with a non-existing query param
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination
        And the query params are set to
            | param_name          | param_value |
            | invalid_query_param | whatever    |
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"


    @KYC_Match_03_success_non_existing_property_in_request
    Scenario: Validate success response when request contains a property not defined in schema
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination with a property "$.additionalProperty" is set to "foo_value"
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"


    @KYC_Match_04_success_response_when_phone_number_is_not_provided
    Scenario: Validate success response when phoneNumber is not provided
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination without property "$.phoneNumber"
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"


    @KYC_Match_05_success_specific_property
    Scenario Outline: Validate success response when providing <property>
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination 
        And the request body property "<request_property_path>" set to a valid value that complies with the OAS schema at "/components/schemas/KYC_MatchRequestBody"
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"
        And the response contains the property "<response_property_path>"

        Examples:
            | property              | request_property_path     | response_property_path        |
            | idDocument            | $.idDocument              | $.idDocumentMatch             |
            | name                  | $.name                    | $.nameMatch                   |
            | givenName             | $.givenName               | $.givenNameMatch              |
            | familyName            | $.familyName              | $.familyNameMatch             |
            | nameKanaHankaku       | $.nameKanaHankaku         | $.nameKanaHankakuMatch        |
            | nameKanaZenkaku       | $.nameKanaZenkaku         | $.nameKanaZenkakuMatch        |
            | middleNames           | $.middleNames             | $.middleNamesMatch            |
            | familyNameAtBirth     | $.familyNameAtBirth       | $.familyNameAtBirthMatch      |
            | address               | $.address                 | $.addressMatch                |
            | streetName            | $.streetName              | $.streetNameMatch             |
            | streetNumber          | $.streetNumber            | $.streetNumberMatch           |
            | postalCode            | $.postalCode              | $.postalCodeMatch             |
            | region                | $.region                  | $.regionMatch                 |
            | locality              | $.locality                | $.localityMatch               |
            | country               | $.country                 | $.countryMatch                |
            | houseNumberExtension  | $.houseNumberExtension    | $.houseNumberExtensionMatch   |
            | birthdate             | $.birthdate               | $.birthdateMatch              |
            | email                 | $.email                   | $.emailMatch                  |
            | gender                | $.gender                  | $.genderMatch                 |


    @KYC_Match_6_success_multiple_optional_parameter_combinations
    Scenario: Validate success response when providing different optional parameter combinations
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body property "$.idDocument" is set to a valid identify document
        And the request body property "$.name" is set to a valid name
        And the request body property "$.givenName" is set to a valid given name
        And the request body property "$.familyName" is set to a valid family name
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
        And the request body property "$.gender" is set to a valid gender value that
        And the given request body is populated with any random combination of afore mention optional parameters
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"


    @KYC_Match_7_success_specific_property_score
    Scenario Outline: Validate success response when providing <property> with false value
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination with property "<request_body_path>" set to a valid formatted value that does not match the value stored in the MNO system
        When the request "KYC_Match" is sent
        Then the response status code is 200
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response body complies with the OAS schema at "/components/schemas/KYC_MatchResponse"
        And the response property "<response_property_path>" is equal to "false"
        And the response property "<response_score_property_path>" is equal to a value between 0 and 100

        Examples:
            | property              | request_property_path     | response_property_path        | response_score_property_path  |
            | idDocument            | $.idDocument              | $.idDocumentMatch             | $.idDocumentMatchScore        |
            | name                  | $.name                    | $.nameMatch                   | $.nameMatchScore              |
            | givenName             | $.givenName               | $.givenNameMatch              | $.givenNameMatchScore         |
            | familyName            | $.familyName              | $.familyNameMatch             | $.familyNameMatchScore        |
            | nameKanaHankaku       | $.nameKanaHankaku         | $.nameKanaHankakuMatch        | $.nameKanaHankakuMatchScore   |
            | nameKanaZenkaku       | $.nameKanaZenkaku         | $.nameKanaZenkakuMatch        | $.nameKanaZenkakuMatchScore   |
            | middleNames           | $.middleNames             | $.middleNamesMatch            | $.middleNamesMatchScore       |
            | familyNameAtBirth     | $.familyNameAtBirth       | $.familyNameAtBirthMatch      | $.familyNameAtBirthMatchScore |
            | address               | $.address                 | $.addressMatch                | $.addressMatchScore           |
            | streetName            | $.streetName              | $.streetNameMatch             | $.streetNameMatchScore        |
            | streetNumber          | $.streetNumber            | $.streetNumberMatch           | $.streetNumberMatchScore      |
            | region                | $.region                  | $.regionMatch                 | $.regionMatchScore            |
            | locality              | $.locality                | $.localityMatch               | $.localityMatchScore          |
            | birthdate             | $.birthdate               | $.birthdateMatch              | $.birthdateMatchScore         |
            | email                 | $.email                   | $.emailMatch                  | $.emailMatchScore             |


    # Generic 401 errors

    @KYC_Match_401.01_expired_access_token
    Scenario: Error response for expired access token
        Given the header "Authorization" is set to an expired access token
        When the request "KYC_Match" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @KYC_Match_401.02_invalid_access_token
    Scenario: Error response for invalid access token
        Given the header "Authorization" is set to an invalid access token
        When the request "KYC_Match" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    @KYC_Match_401.03_no_header_authorization
    Scenario: Error response for no header "Authorization"
        Given the header "Authorization" is not sent
        When the request "KYC_Match" is sent
        Then the response status code is 401
        And the response property "$.code" is "UNAUTHENTICATED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 401


    # Generic 400 errors

    @KYC_Match_400.01_invalid_phoneNumber
    Scenario Outline: Error 400 when phone number is not valid due to the format
        Given I want to test "KYC_Match"
        And the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination with property "$.phoneNumber" set to "<invalid_phone_number>"
        When the request "KYC_Match" is sent
        Then the response status code is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 400

        Examples:
            | invalid_phone_number                       |
            |                                            |
            | 1233aaa4456                                |
            | 348768491273895718927589172895789127293785 |

    @KYC_Match_400.02_invalid_country
    Scenario Outline: Error 400 when the country does not comply with the ISO 3166-1 alpha-2 format
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination with property "$.country" set to "<invalid_country>"
        When the request "KYC_Match" is sent
        Then the response status code is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 400

        Examples:
            | invalid_country |
            |                 |
            | 34              |
            | USA             |
            | S               |


    @KYC_Match_400.03_invalid_birthdate
    Scenario Outline: Error 400 when the birthdate does not comply with the ISO 8601 calendar date "YYYY-MM-DD" format
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination with property "$.birthdate" set to "<invalid_birthdate>"
        When the request "KYC_Match" is sent
        Then the response status code is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 400

        Examples:
            | invalid_birthdate |
            |                   |
            | 22-08-1978        |
            | 1978/08/22        |
            | 1978-99-99        |


    @KYC_Match_400.04_invalid_email
    Scenario Outline: Error 400 when the email does not comply with the RFC format "{local-part}@{domain}" format
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination with property "$.email" set to "<invalid_email>"
        When the request "KYC_Match" is sent
        Then the response status code is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 400

        Examples:
            | invalid_email |
            |               |
            | invalid_value |


    @KYC_Match_400.05_invalid_gender
    Scenario Outline: Error 400 when the gender takes a value that is outside the enum values
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination with property "$.gender" set to "<invalid_gender>"
        When the request "KYC_Match" is sent
        Then the response status code is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 400

        Examples:
            | invalid_gender |
            |                |
            | invalid_value  |


    # API Specific Errors

    @KYC_Match_10_invalid_param_combination
    Scenario: Error 400 when body does not contain any fields other than phone number
        Given I want to test "KYC_Match"
        And the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination with property "$.phoneNumber" set to a value formatted value
        When the request "KYC_Match" is sent
        Then the response status code is 400
        And the response property "$.code" is "KNOW_YOUR_CUSTOMER.INVALID_PARAM_COMBINATION"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 400


    @KYC_Match_11_phone_number_does_not_exist_in_access_token
    Scenario: Error 403 when phone number cannot be deducted from access token
        Given the header "Authorization" is set to an access token from which a valid testing phoneNumber cannot be deducted
        And the request body is set to a valid parameter combination
        When the request "KYC_Match" is sent
        Then the response status code is 403
        And the response property "$.code" is "KNOW_YOUR_CUSTOMER.INVALID_TOKEN_CONTEXT"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 403


    @KYC_Match_12_idDocument_required
    Scenario: Error 403 when body does not contain idDocument when this is required
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body is set to a valid parameter combination without property "$.idDocument"
        When the request "KYC_Match" is sent
        Then the response status code is 403
        And the response property "$.code" is "KNOW_YOUR_CUSTOMER.ID_DOCUMENT_REQUIRED"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 403


    @KYC_Match_13_idDocument_mismatch_when_idDocument_is_required
    Scenario: Error 403 when the idDocument included in the request does not match the one saved in the MNO system when the idDocument is required
        Given the request header "Authorization" is set to a valid access token from which a valid testing phoneNumber can be deducted
        And the request body property "$.idDocument" is set to a valid idDocument that does not belong to the user
        When the request "KYC_Match" is sent
        Then the response status code is 403
        And the response property "$.code" is "KNOW_YOUR_CUSTOMER.ID_DOCUMENT_MISMATCH"
        And the response property "$.message" contains a user friendly text
        And the response property "$.status" is 403
