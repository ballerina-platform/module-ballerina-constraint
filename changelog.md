# Change Log
This file contains all the notable changes done to the Ballerina Constraint package through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- [Add support to overwrite default error message for constraint violations](https://github.com/ballerina-platform/ballerina-standard-library/issues/3211)

## [1.2.0] - 2023-06-01

### Added

- [Introduce `@constriant:Date` to validate date structures](https://github.com/ballerina-platform/ballerina-standard-library/issues/3960)
- [Allow constraints on subtypes](https://github.com/ballerina-platform/ballerina-standard-library/issues/4349)

### Changed
- [Use `ValueUtils.convert` API instead of `CloneWithType` method](https://github.com/ballerina-platform/ballerina-standard-library/issues/3933)

## [1.1.0] - 2023-02-20

### Fixed
- [Fix unexpected errors due to custom annotations](https://github.com/ballerina-platform/ballerina-standard-library/issues/3817)
- [Ensure value type after constraint validation](https://github.com/ballerina-platform/ballerina-standard-library/issues/3976)
- [Fix constraint validation on array members](https://github.com/ballerina-platform/ballerina-standard-library/issues/3974)

### Added
- [Add `@pattern` constraint on string types](https://github.com/ballerina-platform/ballerina-standard-library/issues/3179)
- [Add constraint support for readonly types](https://github.com/ballerina-platform/ballerina-standard-library/issues/3742)

## [1.0.1] - 2022-11-29

### Fixed
- [Fix compiler plugin failure when value is provided through a variable](https://github.com/ballerina-platform/ballerina-standard-library/issues/3580)

### Changed
- [API docs updated](https://github.com/ballerina-platform/ballerina-standard-library/issues/3463)

## [1.0.0] - 2022-09-08

### Added
- [Implement Ballerina Constraint Package - Phase 1](https://github.com/ballerina-platform/ballerina-standard-library/issues/2861)
- [Publish the constraint native API](https://github.com/ballerina-platform/ballerina-standard-library/issues/3109)
- [Add support for constraint validation on union typedesc](https://github.com/ballerina-platform/ballerina-standard-library/issues/3130)
- [Improve constraint error message as JsonPath expression](https://github.com/ballerina-platform/ballerina-standard-library/issues/3143)

### Fixed
- [Passing the typedesc as a param to the constraint() method returns () in success case ](https://github.com/ballerina-platform/ballerina-standard-library/issues/3107)
- [Fix a bug in validation of AnnotatableType types as referred types](https://github.com/ballerina-platform/ballerina-standard-library/issues/3113)
