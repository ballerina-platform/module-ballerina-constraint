// Copyright (c) 2022 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;

type NoFloatConstraintsOnType float;

@test:Config {}
isolated function testNoFloatConstraintsOnType() {
    NoFloatConstraintsOnType typ = 20.5;
    NoFloatConstraintsOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@Float {
    minValue: 18.5
}
type FloatConstraintMinValueOnType float;

@test:Config {}
isolated function testFloatConstraintMinValueOnTypeSuccess1() {
    FloatConstraintMinValueOnType typ = 20.5;
    FloatConstraintMinValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueOnTypeSuccess2() {
    FloatConstraintMinValueOnType typ = 18.5;
    FloatConstraintMinValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueOnTypeFailure() {
    FloatConstraintMinValueOnType typ = 16.5;
    FloatConstraintMinValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Float {
    maxValue: 100.5
}
type FloatConstraintMaxValueOnType float;

@test:Config {}
isolated function testFloatConstraintMaxValueOnTypeSuccess1() {
    FloatConstraintMaxValueOnType typ = 20.5;
    FloatConstraintMaxValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueOnTypeSuccess2() {
    FloatConstraintMaxValueOnType typ = 100.5;
    FloatConstraintMaxValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueOnTypeFailure() {
    FloatConstraintMaxValueOnType typ = 120.5;
    FloatConstraintMaxValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Float {
    minValueExclusive: 18.5
}
type FloatConstraintMinValueExclusiveOnType float;

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnTypeSuccess() {
    FloatConstraintMinValueExclusiveOnType typ = 20.5;
    FloatConstraintMinValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnTypeFailure1() {
    FloatConstraintMinValueExclusiveOnType typ = 18.5;
    FloatConstraintMinValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnTypeFailure2() {
    FloatConstraintMinValueExclusiveOnType typ = 16.5;
    FloatConstraintMinValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Float {
    maxValueExclusive: 100.5
}
type FloatConstraintMaxValueExclusiveOnType float;

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnTypeSuccess() {
    FloatConstraintMaxValueExclusiveOnType typ = 20.5;
    FloatConstraintMaxValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, typ);
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnTypeFailure1() {
    FloatConstraintMaxValueExclusiveOnType typ = 100.5;
    FloatConstraintMaxValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnTypeFailure2() {
    FloatConstraintMaxValueExclusiveOnType typ = 120.5;
    FloatConstraintMaxValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Float {
    minValue: 18.5,
    maxValue: 100.5
}
type FloatConstraintOnType float;

@test:Config {}
isolated function testFloatConstraintOnTypeSuccess1() {
    FloatConstraintOnType typ = 20.5;
    FloatConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeSuccess2() {
    FloatConstraintOnType typ = 18.5;
    FloatConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeSuccess3() {
    FloatConstraintOnType typ = 100.5;
    FloatConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeFailure1() {
    FloatConstraintOnType typ = 16.5;
    FloatConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeFailure2() {
    FloatConstraintOnType typ = 120.5;
    FloatConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Float {
    maxIntegerDigits: 5,
    maxFractionDigits: 4
}
type MaxDigitFloatType float;

@test:Config {}
isolated function testMaxDigitFloatPositive() {
    MaxDigitFloatType|error validation = validate(12934.8065);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 12934.8065);
    }

    validation = validate(12.80);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 12.80);
    }

    validation = validate(0.0);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.0);
    }

    validation = validate(-12934.8065);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, -12934.8065);
    }

    validation = validate(-12.80);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, -12.80);
    }

    validation = validate(-0.0);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, -0.0);
    }

    validation = validate(1234);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 1234.0);
    }

    validation = validate(1234.00000000);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 1234.0);
    }

    validation = validate(0.0001);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.0001);
    }

    validation = validate(-0.0001);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, -0.0001);
    }

    validation = validate(0);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.0);
    }

    validation = validate(+1234.456);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 1234.456);
    }

    validation = validate(1.2345e3);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 1234.5);
    }

    validation = validate(1.2345e+3);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 1234.5);
    }

    validation = validate(101234.2e-3);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 101.2342);
    }

    validation = validate(.2345);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.2345);
    }
}

@test:Config {}
isolated function testMaxDigitFloatNegative() {
    MaxDigitFloatType|error validation = validate(1234567.435);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxIntegerDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(1234.12345);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(1234567.12345);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits','$:maxIntegerDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(0.00001);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(-0.00001);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(1.23e6);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxIntegerDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(1.234e-6);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(.123456);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type DigitFloat float;

@Float {
    maxIntegerDigits: {
        value: 4,
        message: "Integer digits should be less than or equal to 4"
    }
}
type MaxIntegerDigitFloatRefType DigitFloat;

@test:Config {}
isolated function testMaxIntegerDigitsRefType() {
    MaxIntegerDigitFloatRefType|error validation = validate(-1234.12345);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, -1234.12345);
    }

    validation = validate(12.1234000);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 12.1234);
    }

    validation = validate(123456);
    if validation is error {
        test:assertEquals(validation.message(), "Integer digits should be less than or equal to 4.");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(1234456.001);
    if validation is error {
        test:assertEquals(validation.message(), "Integer digits should be less than or equal to 4.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Float {
    maxFractionDigits: {
        value: 3,
        message: "Fraction digits should be less than or equal to 3"
    }
}
type MaxFractionDigitFloatRefType DigitFloat;

@test:Config {}
isolated function testMaxFractionDigitsRefType() {
    MaxFractionDigitFloatRefType|error validation = validate(1234.12);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 1234.12);
    }

    validation = validate(0.001);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.001);
    }

    validation = validate(1234.1234);
    if validation is error {
        test:assertEquals(validation.message(), "Fraction digits should be less than or equal to 3.");
    } else {
        test:assertFail("Expected error not found.");
    }
}
