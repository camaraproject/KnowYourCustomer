# CAMARA KnowYourCustomer KYC Match API

(NOTE: This API description is supposed to be incorporated into the YAML definition file in a future release.)

This API provides the customer with the ability to compare the information it (Service Provider, SP) has for a particular mobile phone user with that on file (and verified) by the mobile phone user's Operator in their own KYC records, in order for the SP to confirm the accuracy of the information and provide a specific service to the mobile phone user.

## Relevant Definitions and concepts

* **KYC**: stands for Know Your Customer and it is the process of a business verifying the identity of their clients and assessing their suitability, along with the potential risks of illegal intentions towards the business relationship.

## API Functionality

This API allows API clients to verify the matching of a number of attributes related to a customer identity against the account data bound to their phone number.  The API is intended to be used in the following scenarios, for example:

* To verify the user personal data during the digital registration of an account to a 3rd party service.

* To prevent fraud, wrong or imprecise information, and/or facilitate the onboarding of a mobile phone user to a 3rd party service.

The following figure is the generic high-level flows of this API.  

<img width="848" alt="KYC_Match_flow" src="https://github.com/ToshiWakayama-KDDI/KnowYourCustomer-Toshi/assets/53090722/3f9acdcb-9f8d-4177-a586-7e426b8ac33d">

Note:

* Before calling this API, 3rd parties / enterprise customers who want to use this API should make contact with API provider/ MNO for use of this API.  As that will depend on each API provider / MNO's business process as well as GSMA Open Gateway standard process, it is out of scope of this API definition.

* When calling this API, at the beginning, there should be required processes for Authentication / Authorisation / End User Consent capturing.  As those processes are defined as CAMARA commonality standards, they are out of scope of this API definition, however, use of the OpenID Connect (OIDC) is stated as security scheme.

## Resources and Operations overview

The API provides the following endpoint:

* An endpoint to verify the matching of a number of attributes related to a mobile phone user identity against the acount data bound to their phone number.


