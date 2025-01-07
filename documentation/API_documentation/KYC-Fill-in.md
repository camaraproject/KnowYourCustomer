# CAMARA KnowYourCustomer KYC Fill-in API

(NOTE: This API description is supposed to be incorporated into the YAML definition file in the future releases.)

This API provides the customer with the ability request and receive the information for a particular user, which on file (and verified) by the user's Operator in their own KYC records, in order for the SP to confirm the accuracy of the information and provide a specific service to the user.

## Relevant Definitions and concepts

* **KYC**: stands for Know Your Customer and it is the process of a business verifying the identity of their clients and assessing their suitability, along with the potential risks of illegal intentions towards the business relationship.

## API Functionality

This API allows API clients to request for API provider / MNO to provide information related to a mobile phone user, derived from the account data bound to their phone number.  The API is intended to be used in the following scenario, for example:

* To fill-in the user personal data during the digital registration of an account to a 3rd party service.

The following figure is the generic high-level flows of this API.  

<img width="854" alt="KYC_Fill-in_flow" src="https://github.com/ToshiWakayama-KDDI/KnowYourCustomer-Toshi/assets/53090722/f23daa52-bb28-4236-b90d-0184d303f907">

Note:

* Before calling this API, 3rd parties / enterprise customers who want to use this API should make contract with API provider/ Operator for use of this API.  As that will depend on each API provider / MNO's business processes as well as GSMA Open Gateway standard process, it is out of scope of this API definition.

* When calling this API, at the beginning, there should be required processes for Authentication / Authorisation / End User Consent capturing.  As those processes are to be defined as CAMARA commonality standards, they are out of scope of this API definition, however, use of the OpenID Connect (OIDC) is stated as security scheme.  **As an important note**, capturing end user consent is necessary, because this API provides end user information (PII).

* For this version of the KYC Fill-in API, the request body of the Fill-in Request does not include any parameters/attributes.  The above mentioned AuthN/AuthZ/End User consent capturing processes can give the API provider/ MNO the 3rd party identity (with the Access Token) and the end user identity (with the ID Token), so the API provider/ MNO can identify the 3rd party / enterprise customer and the end user.  Then, it is up to API provider/ MNO to decide which information the 3rd party will receive by calling the API, and also the API provider / MNO is responsible for security and privacy issues.

* For example, below is a potential operation:
  * when making contract with API provider/ MNO, a 3rd party / enterprise customer receives its 3rd party identity and also decide which information (attributes) it will receive for its API call
  * when calling this API, the client of a 3rd party / enterprise customer put its 3rd party identity (only) in the request body
  * then, API provider / MNO will provide information (attributes) which the 3rd party / enterprise customer is allowed to receive by the contract.


## Resources and Operations overview

The API provides the following endpoint:

* An endpoint to request information related to an end user against the acount data bound to their phone number.

## Examples

As always examples are non-normative.

### Get user consent for a set of scopes and purpose

Example OIDC authorization code flow request requesting consent for all user-attributes and purpose dpv:FraudPreventionAndDetection.
This consent  collection using OIDC authorization code flow can happen at any time the API consumer seems fit e.g. a user account creation time at the API consumer's website or when the API consumer's mobile app is installed on the end user's mobile device.

```
GET /authorize?
    response_type=code
    &prompt=consent
    &scope=openid%20dpv%3AFraudPreventionAndDetection%20kyc-fill-in%3Aset-all
    &client_id=s6BhdRkqt3
    &state=af0ifjsldkj
    &redirect_uri=https%3A%2F%2Fclient.example.org%2Fcb HTTP/1.1
Host: authserver.example.com
```

### Get an access token for a set of scopes and purpose

#### Getting the code

Assuming consent was granted and not revoked or is not needed, an access token is returned

```
GET /authorize?
    response_type=code
    &prompt=none
    &scope=openid%20dpv%3AFraudPreventionAndDetection%20kyc-fill-in%3Aset-all
    &client_id=s6BhdRkqt3
    &state=af0ifjsldkj
    &redirect_uri=https%3A%2F%2Fclient.example.org%2Fcb HTTP/1.1
Host: authserver.example.com
```

Error Response

If consent is needed, then the authorization server returns an [error](https://openid.net/specs/openid-connect-core-1_0.html#AuthError) 

```
HTTP/1.1 302 Found
  Location: https://client.example.org/cb?
    error=consent_required
    &state=af0ifjsldkj
```

Sucessful Response:

```
HTTP/1.1 302 Found
  Location: https://client.example.org/cb?
    code=SplxlOBeZQQYbYS6WxSbIA
    &state=af0ifjsldkj
```

#### Token Request:

In CAMARA client authentication MUST be using private_key_jwt

```
POST /token HTTP/1.1

Host: server.example.com 
Content-Type: application/x-www-form-urlencoded 

grant_type=authorization_code&code=SplxlOBeZQQYbYS6WxSbIA
    &redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb
    &client_assertion_type=urn%3Aietf%3Aparams%3Aoauth%3Aclient-assertion-type%3Ajwt-bearer
    &client_assertion=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3Mi......
```

#### Successful Token Response

```
HTTP/1.1 200 OK
  Content-Type: application/json
  Cache-Control: no-store

  {
   "access_token": "SlAV32hkKG",
   "token_type": "Bearer",
   "refresh_token": "8xLOxBtZp8",
   "expires_in": 3600,
   "id_token": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFlOWdkazcifQ.ewogImlzc
     yI6ICJodHRwOi8vc2VydmVyLmV4YW1wbGUuY29tIiwKICJzdWIiOiAiMjQ4Mjg5
     NzYxMDAxIiwKICJhdWQiOiAiczZCaGRSa3F0MyIsCiAibm9uY2UiOiAibi0wUzZ
     fV3pBMk1qIiwKICJleHAiOiAxMzExMjgxOTcwLAogImlhdCI6IDEzMTEyODA5Nz
     AKfQ.ggW8hZ1EuVLuxNuuIJKX_V8a_OMXzR0EHR9R6jgdqrOOF4daGU96Sr_P6q
     Jp6IcmD3HP99Obi1PRs-cwh3LO-p146waJ8IhehcwL7F09JdijmBqkvPeB2T9CJ
     NqeGpe-gccMg4vfKjkM8FcGvnzZUN4_KSP0aAp1tOJ1zZwgjxqGByKHiOtX7Tpd
     QyHE5lcMiKPXfEIQILVq0pc_E2DzL7emopWoaoZTF_m0_N0YzFC6g6EJbOEoRoS
     K5hoDalrcvRYLSrQAZZKflyuVCyixEoV9GfNQC3_osjzw2PAithfubEEBLuVVk4
     XUVrWOLrLl0nx7RkKU8NXNHq-rvKMzqg"
  }
```

### Using an access token at the KYC-Fill-In API endpoint

API request:

The access token is associated with a subject identifier and all the scoces from the authorization request.
The subject identifier can be a MSISDN e.g. "+34629255833" or an MNO-internal user identifier or user account number e.g. `ba7315d5-04e2-4701-b3db-27824d50a97e`.
Because the access token is created by the MNO's authorization server and consumed by the MNO's resource server any subject identifier can be used.

```
GET /fill-in
Authorization: Bearer SlAV32hkKG
Host: resourceserver.example.com
```

API response:

```
HTTP/1.1 200 OK
  Content-Type: application/json
  Cache-Control: no-store

{
  "phoneNumber": "+34629255833",
  "idDocument": "66666666q",
  "name": "Federica Sanchez Arjona",
  "givenName": "Federica",
  "familyName": "Sanchez Arjona",
  "nameKanaHankaku": "federica",
  "nameKanaZenkaku": "Ｆｅｄｅｒｉｃａ",
  "middleNames": "Sanchez",
  "familyNameAtBirth": "YYYY",
  "address": "Tokyo-to Chiyoda-ku Iidabashi 3-10-10",
  "streetName": "Nicolas Salmeron",
  "streetNumber": "4",
  "postalCode": "1028460",
  "region": "Tokyo",
  "locality": "ZZZZ",
  "country": "JP",
  "houseNumberExtension": "36"
}
```
