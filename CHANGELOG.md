# Changelog Know Your Customer

## Table of Contents

- [v0.1.1](#v011)
- [v0.1.0](#v010)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

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

