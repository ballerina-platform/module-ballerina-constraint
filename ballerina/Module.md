## Overview

This module provides features to validate the values with respect to the constraints defined to the respective Ballerina types.

The Ballerina `constraint` module facilitates APIs to do validations on the Ballerina types further with the use of annotations.

### Constraint annotations

This library provides the following annotations on Ballerina types to validate the values created with the respective types.

| Annotation           | Supported Constraints                                                                                                  | Associated Ballerina Type(s) |
|----------------------|------------------------------------------------------------------------------------------------------------------------|------------------------------|
| `@constraint:Int`    | `minValue`, `maxValue`, `minValueExclusive`, `maxValueExclusive`, `maxDigits`, `maxIntegerDigits`, `maxFractionDigits` | `int`                        |
| `@constraint:Float`  | `minValue`, `maxValue`, `minValueExclusive`, `maxValueExclusive`, `maxDigits`, `maxIntegerDigits`, `maxFractionDigits` | `float`                      |
| `@constraint:Number` | `minValue`, `maxValue`, `minValueExclusive`, `maxValueExclusive`, `maxDigits`, `maxIntegerDigits`, `maxFractionDigits` | `int`, `float`, `decimal`    |
| `@constraint:String` | `length`, `minLength`, `maxLength`, `pattern`                                                                          | `string`                     |
| `@constraint:Array`  | `length`, `minLength`, `maxLength`                                                                                     | `any[]`                      |
| `@constraint:Date`   | `option` - `PAST` or `FUTURE` or `PAST_OR_PRESENT` or `FUTURE_OR_PRESENT`                                              | `constraint:Date`            |

The following example demonstrates how to apply constraint annotations to types.

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

The `validate` function in this library can be used to validate the values with respect to the constraints defined in the respective types.

The following example demonstrates how to validate a value with respect to constraints in the type. The respective type is automatically inferred from the expression context.

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
