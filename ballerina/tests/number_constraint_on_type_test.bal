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

type NoNumberConstraintsOnType decimal;

@test:Config {}
isolated function testNoNumberConstraintsOnType() {
    NoNumberConstraintsOnType typ = 20;
    NoNumberConstraintsOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, typ);
    }
}

@Number {
    minValue: 18.5
}
type NumberConstraintMinValueOnIntType int;

@Number {
    minValue: 18.5
}
type NumberConstraintMinValueOnFloatType float;

@Number {
    minValue: 18.5
}
type NumberConstraintMinValueOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeSuccess1() {
    NumberConstraintMinValueOnIntType typInt = 20;
    NumberConstraintMinValueOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueOnFloatType typFloat = 20.5;
    NumberConstraintMinValueOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueOnDecimalType typDecimal = 20.5d;
    NumberConstraintMinValueOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeSuccess2() {
    NumberConstraintMinValueOnIntType typInt = 19;
    NumberConstraintMinValueOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueOnFloatType typFloat = 18.5;
    NumberConstraintMinValueOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueOnDecimalType typDecimal = 18.5d;
    NumberConstraintMinValueOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeFailure1() {
    NumberConstraintMinValueOnIntType typ = 18;
    NumberConstraintMinValueOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeFailure2() {
    NumberConstraintMinValueOnFloatType typ = 16.5;
    NumberConstraintMinValueOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeFailure3() {
    NumberConstraintMinValueOnDecimalType typ = 16.5d;
    NumberConstraintMinValueOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    maxValue: 100.5
}
type NumberConstraintMaxValueOnIntType int;

@Number {
    maxValue: 100.5
}
type NumberConstraintMaxValueOnFloatType float;

@Number {
    maxValue: 100.5
}
type NumberConstraintMaxValueOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeSuccess1() {
    NumberConstraintMaxValueOnIntType typInt = 20;
    NumberConstraintMaxValueOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueOnFloatType typFloat = 20.5;
    NumberConstraintMaxValueOnIntType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueOnDecimalType typDecimal = 20.5d;
    NumberConstraintMaxValueOnIntType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeSuccess2() {
    NumberConstraintMaxValueOnIntType typInt = 100;
    NumberConstraintMaxValueOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueOnFloatType typFloat = 100.5;
    NumberConstraintMaxValueOnIntType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueOnDecimalType typDecimal = 100.5d;
    NumberConstraintMaxValueOnIntType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeFailure1() {
    NumberConstraintMaxValueOnIntType typ = 101;
    NumberConstraintMaxValueOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeFailure2() {
    NumberConstraintMaxValueOnFloatType typ = 101;
    NumberConstraintMaxValueOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeFailure3() {
    NumberConstraintMaxValueOnDecimalType typ = 101;
    NumberConstraintMaxValueOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    minValueExclusive: 18.5
}
type NumberConstraintMinValueExclusiveOnIntType int;

@Number {
    minValueExclusive: 18.5
}
type NumberConstraintMinValueExclusiveOnFloatType float;

@Number {
    minValueExclusive: 18.5
}
type NumberConstraintMinValueExclusiveOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeSuccess() {
    NumberConstraintMinValueExclusiveOnIntType typInt = 20;
    NumberConstraintMinValueExclusiveOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueExclusiveOnFloatType typFloat = 20.5;
    NumberConstraintMinValueExclusiveOnIntType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueExclusiveOnDecimalType typDecimal = 20.5d;
    NumberConstraintMinValueExclusiveOnIntType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeFailure1() {
    NumberConstraintMinValueExclusiveOnIntType typ = 18;
    NumberConstraintMinValueExclusiveOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeFailure2() {
    NumberConstraintMinValueExclusiveOnFloatType typ = 18.5;
    NumberConstraintMinValueExclusiveOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeFailure3() {
    NumberConstraintMinValueExclusiveOnDecimalType typ = 18.5d;
    NumberConstraintMinValueExclusiveOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    maxValueExclusive: 100.5
}
type NumberConstraintMaxValueExclusiveOnIntType int;

@Number {
    maxValueExclusive: 100.5
}
type NumberConstraintMaxValueExclusiveOnFloatType float;

@Number {
    maxValueExclusive: 100.5
}
type NumberConstraintMaxValueExclusiveOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeSuccess() {
    NumberConstraintMaxValueExclusiveOnIntType typInt = 20;
    NumberConstraintMaxValueExclusiveOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueExclusiveOnFloatType typFloat = 20.5;
    NumberConstraintMaxValueExclusiveOnIntType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueExclusiveOnDecimalType typDecimal = 20.5d;
    NumberConstraintMaxValueExclusiveOnIntType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeFailure1() {
    NumberConstraintMaxValueExclusiveOnIntType typ = 101;
    NumberConstraintMaxValueExclusiveOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeFailure2() {
    NumberConstraintMaxValueExclusiveOnFloatType typ = 100.5;
    NumberConstraintMaxValueExclusiveOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeFailure3() {
    NumberConstraintMaxValueExclusiveOnDecimalType typ = 100.5d;
    NumberConstraintMaxValueExclusiveOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    minValue: 18.5,
    maxValue: 100.5
}
type NumberConstraintOnIntType int;

@Number {
    minValue: 18.5,
    maxValue: 100.5
}
type NumberConstraintOnFloatType float;

@Number {
    minValue: 18.5,
    maxValue: 100.5
}
type NumberConstraintOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintOnTypeSuccess1() {
    NumberConstraintOnIntType typInt = 20;
    NumberConstraintOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnFloatType typFloat = 20.5;
    NumberConstraintOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnDecimalType typDecimal = 20.5d;
    NumberConstraintOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeSuccess2() {
    NumberConstraintOnIntType typInt = 19;
    NumberConstraintOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnFloatType typFloat = 18.5;
    NumberConstraintOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnDecimalType typDecimal = 18.5d;
    NumberConstraintOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeSuccess3() {
    NumberConstraintOnIntType typInt = 100;
    NumberConstraintOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnFloatType typFloat = 100.5;
    NumberConstraintOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnDecimalType typDecimal = 100.5d;
    NumberConstraintOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure1() {
    NumberConstraintOnIntType typ = 18;
    NumberConstraintOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure2() {
    NumberConstraintOnFloatType typ = 16.5;
    NumberConstraintOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure3() {
    NumberConstraintOnDecimalType typ = 16.5d;
    NumberConstraintOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure4() {
    NumberConstraintOnIntType typ = 101;
    NumberConstraintOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure5() {
    NumberConstraintOnFloatType typ = 101.5;
    NumberConstraintOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure6() {
    NumberConstraintOnDecimalType typ = 101.5d;
    NumberConstraintOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    minValue: 18.5d
}
type NumberConstraintOnUnionIntFloatType int|float;

@Number {
    maxValue: 100.5d
}
type NumberConstraintOnUnionIntDecimalType int|decimal;

@Number {
    minValueExclusive: 18.5d
}
type NumberConstraintOnUnionFloatDecimalType float|decimal;

@Number {
    maxValueExclusive: 100.5d
}
type NumberConstraintOnUnionIntFloatDecimalType int|float|decimal;

// TODO: Following test cases are disabled due to https://github.com/ballerina-platform/ballerina-lang/issues/36543

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeSuccess1() {
    NumberConstraintOnUnionIntFloatType typIntFloat = 20;
    NumberConstraintOnUnionIntFloatType|error validationIntFloat = validate(typIntFloat);
    if validationIntFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnUnionIntDecimalType typIntDecimal = 100;
    NumberConstraintOnUnionIntFloatType|error validationIntDecimal = validate(typIntDecimal);
    if validationIntDecimal is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnUnionFloatDecimalType typFloatDecimal = 20.5;
    NumberConstraintOnUnionIntFloatType|error validationFloatDecimal = validate(typFloatDecimal);
    if validationFloatDecimal is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnUnionIntFloatDecimalType typIntFloatDecimal = 100;
    NumberConstraintOnUnionIntFloatType|error validationIntFloatDecimal = validate(typIntFloatDecimal);
    if validationIntFloatDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeSuccess2() {
    NumberConstraintOnUnionIntFloatType typIntFloat = 20.5;
    NumberConstraintOnUnionIntFloatType|error validationIntFloat = validate(typIntFloat);
    if validationIntFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnUnionIntDecimalType typIntDecimal = 100.5d;
    NumberConstraintOnUnionIntFloatType|error validationIntDecimal = validate(typIntDecimal);
    if validationIntDecimal is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnUnionFloatDecimalType typFloatDecimal = 20.5d;
    NumberConstraintOnUnionIntFloatType|error validationFloatDecimal = validate(typFloatDecimal);
    if validationFloatDecimal is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnUnionIntFloatDecimalType typIntFloatDecimal = 99.5d;
    NumberConstraintOnUnionIntFloatType|error validationIntFloatDecimal = validate(typIntFloatDecimal);
    if validationIntFloatDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeFailure1() {
    NumberConstraintOnUnionIntFloatType typ = 16;
    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeFailure2() {
    NumberConstraintOnUnionIntDecimalType typ = 120;
    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeFailure3() {
    NumberConstraintOnUnionFloatDecimalType typ = 16.5;
    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeFailure4() {
    NumberConstraintOnUnionIntFloatDecimalType typ = 120;
    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeFailure5() {
    NumberConstraintOnUnionIntFloatType typ = 16.5;
    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeFailure6() {
    NumberConstraintOnUnionIntDecimalType typ = 120.5d;
    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeFailure7() {
    NumberConstraintOnUnionFloatDecimalType typ = 18.5d;
    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeFailure8() {
    NumberConstraintOnUnionIntFloatDecimalType typ = 100.5d;
    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    maxIntegerDigits: 5,
    maxFractionDigits: 4
}
type MaxDigitNumberType decimal;

@test:Config {}
function testMaxDigitNumberPositive() {
    MaxDigitNumberType|error validation = validate(1.234d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 1.234d);
    }

    validation = validate(-1.2345d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, -1.2345d);
    }

    validation = validate(+12345.1234000d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 12345.1234d);
    }

    validation = validate(1.23e+2d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 123.0d);
    }

    validation = validate(1.23e-2d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.0123d);
    }

    validation = validate(0d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.0d);
    }

    validation = validate(0.0d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.0d);
    }

    validation = validate(-0.000000d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.0d);
    }
}

@test:Config {}
function testMaxDigitNumberNegative() {
    MaxDigitNumberType|error validation = validate(1.234568d);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(123456.1234d);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxIntegerDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(1.2342698756788e+6d);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits','$:maxIntegerDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(0.00001d);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxFractionDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(100000.00000d);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxIntegerDigits' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type DigitNumber decimal;

@Number {
    maxIntegerDigits: {
        value: 4,
        message: "Integer digits should be less than or equal to 4"
    }
}
type MaxIntegerDigitNumberRefType DigitNumber;

@test:Config {}
function testMaxIntegerDigitsNumberRefType() {
    MaxIntegerDigitNumberRefType|error validation = validate(-1234.12345d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, -1234.12345d);
    }

    validation = validate(12.1234000d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 12.1234d);
    }

    validation = validate(123456d);
    if validation is error {
        test:assertEquals(validation.message(), "Integer digits should be less than or equal to 4.");
    } else {
        test:assertFail("Expected error not found.");
    }

    validation = validate(1234456.001d);
    if validation is error {
        test:assertEquals(validation.message(), "Integer digits should be less than or equal to 4.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    maxFractionDigits: {
        value: 3,
        message: "Fraction digits should be less than or equal to 3"
    }
}
type MaxFractionDigitNumberRefType DigitNumber;

@test:Config {}
function testMaxFractionDigitsNumberRefType() {
    MaxFractionDigitNumberRefType|error validation = validate(1234.12d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 1234.12d);
    }

    validation = validate(0.001d);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, 0.001d);
    }

    validation = validate(1234.1234d);
    if validation is error {
        test:assertEquals(validation.message(), "Fraction digits should be less than or equal to 3.");
    } else {
        test:assertFail("Expected error not found.");
    }
}
