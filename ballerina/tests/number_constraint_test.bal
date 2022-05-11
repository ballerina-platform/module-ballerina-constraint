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

type NoNumberConstraints record {
    decimal value;
};

@test:Config {}
isolated function testNoNumberConstraints() {
    NoNumberConstraints rec = {value: 20};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

type NumberConstraintMinValue record {
    @Number {
        minValue: 18.5
    }
    int intValue;
    @Number {
        minValue: 18.5
    }
    float floatValue;
    @Number {
        minValue: 18.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMinValueSuccess1() {
    NumberConstraintMinValue rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueSuccess2() {
    NumberConstraintMinValue rec = {intValue: 19, floatValue: 18.5, decimalValue: 18.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueFailure1() {
    NumberConstraintMinValue rec = {intValue: 19, floatValue: 20.5, decimalValue: 16.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueFailure2() {
    NumberConstraintMinValue rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMaxValue record {
    @Number {
        maxValue: 100.5
    }
    int intValue;
    @Number {
        maxValue: 100.5
    }
    float floatValue;
    @Number {
        maxValue: 100.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMaxValueSuccess1() {
    NumberConstraintMaxValue rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueSuccess2() {
    NumberConstraintMaxValue rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueFailure1() {
    NumberConstraintMaxValue rec = {intValue: 100, floatValue: 100.5, decimalValue: 120.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueFailure2() {
    NumberConstraintMaxValue rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMinValueExclusive record {
    @Number {
        minValueExclusive: 18.5
    }
    int intValue;
    @Number {
        minValueExclusive: 18.5
    }
    float floatValue;
    @Number {
        minValueExclusive: 18.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveSuccess() {
    NumberConstraintMinValueExclusive rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveFailure1() {
    NumberConstraintMinValueExclusive rec = {intValue: 20, floatValue: 18.5, decimalValue: 18.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveFailure2() {
    NumberConstraintMinValueExclusive rec = {intValue: 20, floatValue: 20.5, decimalValue: 16.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveFailure3() {
    NumberConstraintMinValueExclusive rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMaxValueExclusive record {
    @Number {
        maxValueExclusive: 100.5
    }
    int intValue;
    @Number {
        maxValueExclusive: 100.5
    }
    float floatValue;
    @Number {
        maxValueExclusive: 100.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveSuccess() {
    NumberConstraintMaxValueExclusive rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveFailure1() {
    NumberConstraintMaxValueExclusive rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveFailure2() {
    NumberConstraintMaxValueExclusive rec = {intValue: 100, floatValue: 100.5, decimalValue: 120.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveFailure3() {
    NumberConstraintMaxValueExclusive rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraint record {
    @Number {
        minValue: 18.5,
        maxValue: 100.5
    }
    int intValue;
    @Number {
        minValue: 18.5,
        maxValue: 100.5
    }
    float floatValue;
    @Number {
        minValue: 18.5,
        maxValue: 100.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintSuccess1() {
    NumberConstraint rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintSuccess2() {
    NumberConstraint rec = {intValue: 19, floatValue: 18.5, decimalValue: 18.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintSuccess3() {
    NumberConstraint rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintFailure1() {
    NumberConstraint rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintFailure2() {
    NumberConstraint rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintFailure3() {
    NumberConstraint rec = {intValue: 16, floatValue: 120.5, decimalValue: 16.5d};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue','maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
