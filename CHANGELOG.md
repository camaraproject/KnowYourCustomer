# Changelog Know Your Customer

## Table of Contents

- [r1.3](#r13)
- [r1.2](#r12)
- [r1.1](#r11)
- [v0.1.1](#v011)
- [v0.1.0](#v010)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for each first alpha or release-candidate API version, all changes since the release of the previous public API version
* for subsequent alpha or release-candidate API versions, the delta with respect to the previous pre-release
* for a public API version, the consolidated changes since the release of the previous public API version

# r1.3

## Release Notes

This release contains the definition and documentation of
* kyc-match v0.2.1
* kyc-fill-in v0.2.0

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## kyc-match v0.2.1

**NOTE: kyc-match v0.2.0 has been revoked and should not be considered due to a bug found in matchScore response property that makes this version not suitable. It is fixed in v0.2.1**

**kyc-match v0.2.1 is the first initial version for the CAMARA KnowYourCustomer Match API**

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/KnowYourCustomer/blob/r1.3/code/API_definitions/kyc-match.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r1.3/code/API_definitions/kyc-match.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r1.3/code/API_definitions/kyc-match.yaml&nocors)

**Main changes**
- Includes Score functionality
- Includes updated endpoint and API documentation
- Includes test plan

### Added

- Include test plan for kyc-match operation by @fernandopradocabrillo in https://github.com/camaraproject/KnowYourCustomer/pull/140

### Changed

- Remove countryMatchScore property by @fernandopradocabrillo in https://github.com/camaraproject/KnowYourCustomer/pull/137
- Update endpoint description to reflect all use cases by @fernandopradocabrillo in https://github.com/camaraproject/KnowYourCustomer/pull/138

### Fixed

* Fix score type and change version by @fernandopradocabrillo in https://github.com/camaraproject/KnowYourCustomer/pull/148

### Removed

* n/a

## kyc-fill-in v0.2.0

**kyc-fill-in v0.2.0 is the first initial version for the CAMARA KnowYourCustomer Fill-in API**

- API definition **with inline documentation**:
    - OpenAPI [YAML spec file](https://github.com/camaraproject/KnowYourCustomer/blob/r1.3/code/API_definitions/kyc-fill-in.yaml)
    - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r1.3/code/API_definitions/kyc-fill-in.yaml&nocors)
    - [View it on Swagger Editor](https://editor.swagger.io/?url=https://raw.githubusercontent.com/camaraproject/KnowYourCustomer/r1.3/code/API_definitions/kyc-fill-in.yaml&nocors)

**Main Changes**

* API definition updated to conform to the Commonalities v0.4.0 and Identity and Consent Management v0.2.0 guidelines included in the CAMARA Fall24 meta-release. No new features were added.

### Added

- Include test plan for kyc-match operation by @ToshiWakayama-KDDI in https://github.com/camaraproject/KnowYourCustomer/pull/142

### Changed

* n/a

### Fixed

* n/a

### Removed

* n/a

## New Contributors

* n/a

# r1.2

**NOTE: Release r1.2 has been revoked due to a bug found in kyc-match v0.2.0 code. It is fixed in kyc-match v0.2.1 as part of r1.3 release.**

# r1.1

## Release Notes

This release contains the definition and documentation of
* kyc-match v0.2.0-rc.1
* kyc-fill-in v0.2.0-rc.1

The API definition(s) are based on
* Commonalities v0.4.0
* Identity and Consent Management v0.2.0

## kyc-match v0.2.0-rc.1

### Added

* Include score functionality by @fernandopradocabrillo in https://github.com/camaraproject/KnowYourCustomer/pull/104

### Changed

* Alignment of info, servers objects and security scope names by @rartych in https://github.com/camaraproject/KnowYourCustomer/pull/114

### Fixed

* n/a

### Removed

* n/a

## kyc-fill-in v0.2.0-rc.1

**Main Changes**

* API definition updated to conform to the Commonalities v0.4.0 and Identity and Consent Management v0.2.0 guidelines included in the CAMARA Fall24 meta-release. No new features were added.

### Added

* n/a

### Changed

* Scope changed from `know-your-customer:fill-in` to `kyc-fill-in:fill-in`

### Fixed

* n/a

### Removed

* n/a

## New Contributors
* @rartych made their first contribution in https://github.com/camaraproject/KnowYourCustomer/pull/114
* @jgarciahospital made their first contribution in https://github.com/camaraproject/KnowYourCustomer/pull/111

# v0.1.1

**This is a bugfix release for the first version of the KYC APIs.**

- API [definition](https://github.com/camaraproject/KnowYourCustomer/tree/main/code/API_definitions)

## Please note

- This is an alpha version, it should be considered as a draft.

## What's changed

### Added

- Update the description of the `country` field to reflect that the ISO 3166-1 alpha-2 format should be used.

### Changed

N/A

### Fixed

N/A

### Removed

N/A

# v0.1.0

**This is the first alpha version of the KYC APIs.** 

- API [definition](https://github.com/camaraproject/KnowYourCustomer/tree/main/code/API_definitions)

* Note: API documentation is embedded in the YAML files.

## Please note:

- This is an alpha version, it should be considered as a draft.

## What's changed

* New API `KYC Match`, v0.1.0, with a single operation for Match Identity:
    - compare the information it (Service Provider, SP) has for a particular mobile phone user with that on file (and verified) by the mobile phone user's Operator in their own KYC records, in order for the SP to confirm the accuracy of the information and provide a specific service to the mobile phone use.  
    
*  New API `KYC Fill-In`, v0.1.0, with a single operation for Fill-In identity form:
    - request and receive the information for a particular user, which on file (and verified) by the user's Operator in their own KYC records, in order for the SP to confirm the accuracy of the information and provide a specific service to the user. 

