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

type NoIntConstraintsOnRecordField record {
    int value;
};

@test:Config {}
isolated function testNoIntConstraintsOnRecordField() {
    NoIntConstraintsOnRecordField rec = {value: 20};
    NoIntConstraintsOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type IntConstraintMinValueOnRecordField record {
    @Int {
        minValue: 18
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintMinValueOnRecordFieldSuccess1() {
    IntConstraintMinValueOnRecordField rec = {value: 20};
    IntConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueOnRecordFieldSuccess2() {
    IntConstraintMinValueOnRecordField rec = {value: 18};
    IntConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueOnRecordFieldFailure() {
    IntConstraintMinValueOnRecordField rec = {value: 16};
    IntConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMaxValueOnRecordField record {
    @Int {
        maxValue: 100
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintMaxValueOnRecordFieldSuccess1() {
    IntConstraintMaxValueOnRecordField rec = {value: 20};
    IntConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueOnRecordFieldSuccess2() {
    IntConstraintMaxValueOnRecordField rec = {value: 100};
    IntConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueOnRecordFieldFailure() {
    IntConstraintMaxValueOnRecordField rec = {value: 120};
    IntConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMinValueExclusiveOnRecordField record {
    @Int {
        minValueExclusive: 18
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnRecordFieldSuccess() {
    IntConstraintMinValueExclusiveOnRecordField rec = {value: 20};
    IntConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnRecordFieldFailure1() {
    IntConstraintMinValueExclusiveOnRecordField rec = {value: 18};
    IntConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnRecordFieldFailure2() {
    IntConstraintMinValueExclusiveOnRecordField rec = {value: 16};
    IntConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMaxValueExclusiveOnRecordField record {
    @Int {
        maxValueExclusive: 100
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnRecordFieldSuccess() {
    IntConstraintMaxValueExclusiveOnRecordField rec = {value: 20};
    IntConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnRecordFieldFailure1() {
    IntConstraintMaxValueExclusiveOnRecordField rec = {value: 100};
    IntConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnRecordFieldFailure2() {
    IntConstraintMaxValueExclusiveOnRecordField rec = {value: 120};
    IntConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintOnRecordField record {
    @Int {
        minValue: 18,
        maxValue: 100
    }
    int value;
};

@test:Config {}
isolated function testIntConstraintOnRecordFieldSuccess1() {
    IntConstraintOnRecordField rec = {value: 20};
    IntConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnRecordFieldSuccess2() {
    IntConstraintOnRecordField rec = {value: 18};
    IntConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnRecordFieldSuccess3() {
    IntConstraintOnRecordField rec = {value: 100};
    IntConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnRecordFieldFailure1() {
    IntConstraintOnRecordField rec = {value: 16};
    IntConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnRecordFieldFailure2() {
    IntConstraintOnRecordField rec = {value: 120};
    IntConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
