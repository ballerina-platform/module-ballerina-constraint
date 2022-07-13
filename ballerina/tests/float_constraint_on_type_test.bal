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
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
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
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
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
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnTypeFailure2() {
    FloatConstraintMinValueExclusiveOnType typ = 16.5;
    FloatConstraintMinValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
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
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnTypeFailure2() {
    FloatConstraintMaxValueExclusiveOnType typ = 120.5;
    FloatConstraintMaxValueExclusiveOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
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
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeFailure2() {
    FloatConstraintOnType typ = 120.5;
    FloatConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
