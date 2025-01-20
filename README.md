<a href="https://github.com/camaraproject/KnowYourCustomer/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/KnowYourCustomer?style=plastic"></a>
<a href="https://github.com/camaraproject/KnowYourCustomer/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/KnowYourCustomer?style=plastic"></a>
<a href="https://github.com/camaraproject/KnowYourCustomer/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/KnowYourCustomer?style=plastic"></a>
<a href="https://github.com/camaraproject/KnowYourCustomer/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/KnowYourCustomer?style=plastic"></a>
<a href="https://github.com/camaraproject/KnowYourCustomer" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/KnowYourCustomer?style=plastic"></a>
<a href="https://github.com/camaraproject/KnowYourCustomer/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/KnowYourCustomer/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/KnowYourCustomer?style=plastic"></a>

# KnowYourCustomer

Repository to describe, develop, document and test the KnowYourCustomer API family

## Scope

* Service APIs for “KnowYourCustomer” (see APIBacklog.md)  
* It provides the customer with the ability to:  
  * compare the information it (Service Provider, SP) has for a particular user with that on file (and verified) by the user's Operator in their own KYC records, in order for the SP to confirm the accuracy of the information and provide a specific service to the user. (KYC Match)
  * request and receive the information for a particular user, which on file (and verified) by the user's Operator in their own KYC records, in order for the SP to confirm the accuracy of the information and provide a specific service to the user. (KYC Fill-in)
  * check if the user of the line is older than a provided age, in order to provide API customer's age-restricted services, access to its age-restricted website etc. (KYC Age Verification)
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
* Started: September 2023

## Release Information

* Note: Please be aware that the project will have updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. For best results, use the latest available release

* `NEW`:**The latest release of CAMARA Know Your customer is [r2.1](https://github.com/camaraproject/KnowYourCustomer/tree/r2.1)**. The Release Tag is [r2.1](https://github.com/camaraproject/KnowYourCustomer/releases/tag/r2.1).
  - Contains the following API definitions **with inline documentation**:
    - kyc-match: [YAML spec file](https://github.com/camaraproject/KnowYourCustomer/blob/r2.1/code/API_definitions/kyc-match.yaml) | [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r2.1/code/API_definitions/kyc-match.yaml&nocors) | [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r2.1/code/API_definitions/kyc-match.yaml&nocors)
    - kyc-fill-in: [YAML spec file](https://github.com/camaraproject/KnowYourCustomer/blob/r2.1/code/API_definitions/kyc-fill-in.yaml) | [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r2.1/code/API_definitions/kyc-fill-in.yaml&nocors) | [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r2.1/code/API_definitions/kyc-fill-in.yaml&nocors)
    - kyc-age-verification: [YAML spec file](https://github.com/camaraproject/KnowYourCustomer/blob/r2.1/code/API_definitions/kyc-age-verification.yaml) | [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r2.1/code/API_definitions/kyc-age-verification.yaml&nocors) | [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r2.1/code/API_definitions/kyc-age-verification.yaml&nocors)

## Contributing

* Meetings
  * Schedule: Bi-weekly, Tuesday, 09:00 CEST (07:00 UTC) (till October 27th 2024)
  * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/96235150735?password=7e3fea67-a76e-4941-8a70-392cf5545917)
  * Access [Meeting Minutes](https://github.com/camaraproject/KnowYourCustomer/tree/main/documentation/MeetingMinutes)
* Mailing List
  * Subscribe / Unsubscribe to the mailing list of this Sub Project https://lists.camaraproject.org/g/sp-kyc
  * A message to the community of this Sub Project can be sent using <https://lists.camaraproject.org/g/sp-kyc>
