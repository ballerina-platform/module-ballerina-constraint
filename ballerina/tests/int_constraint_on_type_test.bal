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

type NoIntConstraintsOnType int;

@test:Config {}
isolated function testNoIntConstraintsOnType() {
    NoIntConstraintsOnType typ = 20;
    NoIntConstraintsOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, typ);
    }
}

@Int {
    minValue: 18
}
type IntConstraintMinValueOnType int;

@test:Config {}
isolated function testIntConstraintMinValueOnTypeSuccess1() {
    IntConstraintMinValueOnType typ = 20;
    IntConstraintMinValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueOnTypeSuccess2() {
    IntConstraintMinValueOnType typ = 18;
    IntConstraintMinValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueOnTypeFailure() {
    IntConstraintMinValueOnType typ = 16;
    IntConstraintMinValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Int {
    maxValue: 100
}
type IntConstraintMaxValueOnType int;

@test:Config {}
isolated function testIntConstraintMaxValueOnTypeSuccess1() {
    IntConstraintMaxValueOnType typ = 20;
    IntConstraintMaxValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueOnTypeSuccess2() {
    IntConstraintMaxValueOnType typ = 100;
    IntConstraintMaxValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueOnTypeFailure() {
    IntConstraintMaxValueOnType typ = 120;
    IntConstraintMaxValueOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Int {
    minValueExclusive: 18
}
type IntConstraintMinValueExclusiveOnType int;

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnTypeSuccess() {
    IntConstraintMinValueExclusiveOnType typ = 20;
    IntConstraintMinValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnTypeFailure1() {
    IntConstraintMinValueExclusiveOnType typ = 18;
    IntConstraintMinValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnTypeFailure2() {
    IntConstraintMinValueExclusiveOnType typ = 16;
    IntConstraintMinValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Int {
    maxValueExclusive: 100
}
type IntConstraintMaxValueExclusiveOnType int;

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnTypeSuccess() {
    IntConstraintMaxValueExclusiveOnType typ = 20;
    IntConstraintMaxValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnTypeFailure1() {
    IntConstraintMaxValueExclusiveOnType typ = 100;
    IntConstraintMaxValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnTypeFailure2() {
    IntConstraintMaxValueExclusiveOnType typ = 120;
    IntConstraintMaxValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Int {
    minValue: 18,
    maxValue: 100
}
type IntConstraintOnType int;

@test:Config {}
isolated function testIntConstraintOnTypeSuccess1() {
    IntConstraintOnType typ = 20;
    IntConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnTypeSuccess2() {
    IntConstraintOnType typ = 18;
    IntConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnTypeSuccess3() {
    IntConstraintOnType typ = 100;
    IntConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnTypeFailure1() {
    IntConstraintOnType typ = 16;
    IntConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnTypeFailure2() {
    IntConstraintOnType typ = 120;
    IntConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
