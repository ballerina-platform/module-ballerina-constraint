Ballerina Constraint Library
===================

  [![Build](https://github.com/ballerina-platform/module-ballerina-constraint/actions/workflows/build-timestamped-master.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerina-constraint/actions/workflows/build-timestamped-master.yml)
  [![codecov](https://codecov.io/gh/ballerina-platform/module-ballerina-constraint/branch/main/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerina-constraint) 
  [![Trivy](https://github.com/ballerina-platform/module-ballerina-constraint/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerina-constraint/actions/workflows/trivy-scan.yml)
  [![GraalVM Check](https://github.com/ballerina-platform/module-ballerina-constraint/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerina-constraint/actions/workflows/build-with-bal-test-graalvm.yml)
  [![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerina-constraint.svg?label=Last%20Commit)](https://github.com/ballerina-platform/module-ballerina-constraint/commits/master)
  [![GitHub issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-standard-library/module/constraint.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-standard-library/labels/module%2Fconstraint)

The Ballerina `constraint` library facilitates APIs to do validations on the Ballerina types further with the use of annotations.

### Constraint annotations

This library provides the following annotations to validate the values that have been assigned to Ballerina types.

| Ballerina Type                    | Annotation           | Supported Constraints                                                                                                  |
|-----------------------------------|----------------------|------------------------------------------------------------------------------------------------------------------------|
| `int`                             | `@constraint:Int`    | `minValue`, `maxValue`, `minValueExclusive`, `maxValueExclusive`, `maxDigits`, `maxIntegerDigits`, `maxFractionDigits` |
| `float`                           | `@constraint:Float`  | `minValue`, `maxValue`, `minValueExclusive`, `maxValueExclusive`, `maxDigits`, `maxIntegerDigits`, `maxFractionDigits` |
| `int`&#124;`float`&#124;`decimal` | `@constraint:Number` | `minValue`, `maxValue`, `minValueExclusive`, `maxValueExclusive`, `maxDigits`, `maxIntegerDigits`, `maxFractionDigits` |
| `string`                          | `@constraint:String` | `length`, `minLength`, `maxLength`, `pattern`                                                                          |
| `any[]`                           | `@constraint:Array`  | `length`, `minLength`, `maxLength`                                                                                     |
| `constraint:Date`                 | `@constraint:Date`   | `option` - `PAST` or `FUTURE` or `PAST_OR_PRESENT` or `FUTURE_OR_PRESENT`                                              |

The following example demonstrates how to apply constraint annotations to Ballerina types.

```ballerina
@constraint:String { pattern: re `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$` }
public type Email string;

@constraint:Date { option: constraint:PAST }
public type DOB time:Date;

public type Person record {|
    @constraint:String { minLength: 5, maxLength: 10 }
    string name;
    @constraint:Int { minValue: 18, maxValue: 60 }
    int age;
    Email email;
    @constraint:Array { minLength: 1, maxLength: 5 }
    string[] phoneNumbers;
    DOB dob;
|};
```

### Constraint validation

The `validate` function in this library can be used to validate the values that have been assigned to Ballerina types with respect to the constraints defined using the annotations.

The following example demonstrates how to validate the values assigned to a Ballerina type.

```ballerina
public function main() returns error? {
    Person person = {
        name: "John",
        age: 25,
        email: "john@mail.com",
        phoneNumbers: ["1234567890", "0987654321"],
        dob: { year: 1996, month: 5, day: 15 }
    };
    
    Person|error personValidated = constraint:validate(person);
    if personValidated is error {
        io:println("Validation failed: " + personValidated.message());
    } else {
        io:println("Validation successful");
    }
}
```

### Custom error messages on validation failures

Optionally a custom error message can be provided for each constraint. The following example demonstrates how to provide custom error messages for constraints.

```ballerina
@constraint:String { 
    pattern: {
        value: re `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$`,
        message: "Invalid email address"
    }
}
public type Email string;

@constraint:Date {
    option: {
        value: constraint:PAST,
        message: "Date of birth should be in the past"
    },
    message: "Invalid date found"
}
public type DOB time:Date;

public type Person record {|
    @constraint:String { 
        minLength: 5, 
        maxLength: {
            value: 10,
            message: "Name should be less than 10 characters"
        }
    }
    string name;
    @constraint:Int {
        minValue: {
            value: 18,
            message: "Age should be greater than 18"
        },
        maxValue: 60
    }
    int age;
    Email email;
    @constraint:Array { 
        minLength: {
            value: 1,
            message: "At least one phone number should be provided"
        },
        maxLength: 5 
    }
    string[] phoneNumbers;
    DOB dob;
|};
```

## Issues and projects

Issues and Projects tabs are disabled for this repository as this is part of the Ballerina Standard Library. To report bugs, request new features, start new discussions, view project boards, etc., go to the [Ballerina Standard Library parent repository](https://github.com/ballerina-platform/ballerina-standard-library).

This repository only contains the source code for the module.

## Build from the source

### Set up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 17 (from one of the following locations).

   * [Oracle](https://www.oracle.com/java/technologies/downloads/)
   
   * [OpenJDK](https://adoptium.net)
   
        > **Note:** Set the `JAVA_HOME` environment variable to the path name of the directory into which you installed JDK.

2. Export your GitHub Personal Access Token (PAT) with the `read package` permission as follows:

    ```
    export packageUser=<Username>
    export packagePAT=<Personal Access Token>
    ```

3. Download and install [Docker](https://www.docker.com/).

### Build the source

Execute the commands below to build from the source.

1. To build the package:
    ```    
    ./gradlew clean build
    ```
2. To run the tests:
    ```
    ./gradlew clean test
    ```

3. To run a group of tests
    ```
    ./gradlew clean test -Pgroups=<test_group_names>
    ```

4. To build the without the tests:
    ```
    ./gradlew clean build -x test
    ```

5. To debug package implementation:
    ```
    ./gradlew clean build -Pdebug=<port>
    ```

6. To debug with Ballerina language:
    ```
    ./gradlew clean build -PbalJavaDebug=<port>
    ```

7. Publish the generated artifacts to the local Ballerina central repository:
    ```
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina central repository:
    ```
    ./gradlew clean build -PpublishToCentral=true
    ```

## Contribute to Ballerina

As an open source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`constraint` library](https://lib.ballerina.io/ballerina/constraint/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
