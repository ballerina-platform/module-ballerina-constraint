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

type NoFloatConstraints record {
    float value;
};

@test:Config {}
isolated function testNoFloatConstraints() {
    NoFloatConstraints rec = {value: 20.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

type FloatConstraintMinValue record {
    @Float {
        minValue: 18.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintMinValueSuccess1() {
    FloatConstraintMinValue rec = {value: 20.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueSuccess2() {
    FloatConstraintMinValue rec = {value: 18.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueFailure() {
    FloatConstraintMinValue rec = {value: 16.5};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMaxValue record {
    @Float {
        maxValue: 100.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintMaxValueSuccess1() {
    FloatConstraintMaxValue rec = {value: 20.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueSuccess2() {
    FloatConstraintMaxValue rec = {value: 100.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueFailure() {
    FloatConstraintMaxValue rec = {value: 120.5};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMinValueExclusive record {
    @Float {
        minValueExclusive: 18.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveSuccess() {
    FloatConstraintMinValueExclusive rec = {value: 20.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveFailure1() {
    FloatConstraintMinValueExclusive rec = {value: 18.5};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveFailure2() {
    FloatConstraintMinValueExclusive rec = {value: 16.5};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMaxValueExclusive record {
    @Float {
        maxValueExclusive: 100.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveSuccess() {
    FloatConstraintMaxValueExclusive rec = {value: 20.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveFailure1() {
    FloatConstraintMaxValueExclusive rec = {value: 100.5};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveFailure2() {
    FloatConstraintMaxValueExclusive rec = {value: 120.5};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraint record {
    @Float {
        minValue: 18.5,
        maxValue: 100.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintSuccess1() {
    FloatConstraint rec = {value: 20.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintSuccess2() {
    FloatConstraint rec = {value: 18.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintSuccess3() {
    FloatConstraint rec = {value: 100.5};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintFailure1() {
    FloatConstraint rec = {value: 16.5};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintFailure2() {
    FloatConstraint rec = {value: 120.5};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
