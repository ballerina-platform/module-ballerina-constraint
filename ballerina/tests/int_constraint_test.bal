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

type NoIntConstraints record {
    int value;
};

@test:Config {}
isolated function testNoIntConstraints() {
    NoIntConstraints rec = {value: 20};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

type IntConstraintMinValue record {
    @Int {
        minValue: 18
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintMinValueSuccess1() {
    IntConstraintMinValue rec = {value: 20};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueSuccess2() {
    IntConstraintMinValue rec = {value: 18};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueFailure() {
    IntConstraintMinValue rec = {value: 16};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMaxValue record {
    @Int {
        maxValue: 100
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintMaxValueSuccess1() {
    IntConstraintMaxValue rec = {value: 20};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueSuccess2() {
    IntConstraintMaxValue rec = {value: 100};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueFailure() {
    IntConstraintMaxValue rec = {value: 120};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMinValueExclusive record {
    @Int {
        minValueExclusive: 18
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintMinValueExclusiveSuccess() {
    IntConstraintMinValueExclusive rec = {value: 20};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueExclusiveFailure1() {
    IntConstraintMinValueExclusive rec = {value: 18};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueExclusiveFailure2() {
    IntConstraintMinValueExclusive rec = {value: 16};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMaxValueExclusive record {
    @Int {
        maxValueExclusive: 100
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveSuccess() {
    IntConstraintMaxValueExclusive rec = {value: 20};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveFailure1() {
    IntConstraintMaxValueExclusive rec = {value: 100};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveFailure2() {
    IntConstraintMaxValueExclusive rec = {value: 120};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraint record {
    @Int {
        minValue: 18,
        maxValue: 100
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintSuccess1() {
    IntConstraint rec = {value: 20};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintSuccess2() {
    IntConstraint rec = {value: 18};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintSuccess3() {
    IntConstraint rec = {value: 100};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintFailure1() {
    IntConstraint rec = {value: 16};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintFailure2() {
    IntConstraint rec = {value: 120};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
