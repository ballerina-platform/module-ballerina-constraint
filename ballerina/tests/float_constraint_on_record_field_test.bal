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

type NoFloatConstraintsOnRecordField record {
    float value;
};

@test:Config {}
isolated function testNoFloatConstraintsOnRecordField() {
    NoFloatConstraintsOnRecordField rec = {value: 20.5};
    NoFloatConstraintsOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type FloatConstraintMinValueOnRecordField record {
    @Float {
        minValue: 18.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintMinValueOnRecordFieldSuccess1() {
    FloatConstraintMinValueOnRecordField rec = {value: 20.5};
    FloatConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueOnRecordFieldSuccess2() {
    FloatConstraintMinValueOnRecordField rec = {value: 18.5};
    FloatConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueOnRecordFieldFailure() {
    FloatConstraintMinValueOnRecordField rec = {value: 16.5};
    FloatConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMaxValueOnRecordField record {
    @Float {
        maxValue: 100.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintMaxValueOnRecordFieldSuccess1() {
    FloatConstraintMaxValueOnRecordField rec = {value: 20.5};
    FloatConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueOnRecordFieldSuccess2() {
    FloatConstraintMaxValueOnRecordField rec = {value: 100.5};
    FloatConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueOnRecordFieldFailure() {
    FloatConstraintMaxValueOnRecordField rec = {value: 120.5};
    FloatConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMinValueExclusiveOnRecordField record {
    @Float {
        minValueExclusive: 18.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnRecordFieldSuccess() {
    FloatConstraintMinValueExclusiveOnRecordField rec = {value: 20.5};
    FloatConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnRecordFieldFailure1() {
    FloatConstraintMinValueExclusiveOnRecordField rec = {value: 18.5};
    FloatConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnRecordFieldFailure2() {
    FloatConstraintMinValueExclusiveOnRecordField rec = {value: 16.5};
    FloatConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMaxValueExclusiveOnRecordField record {
    @Float {
        maxValueExclusive: 100.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnRecordFieldSuccess() {
    FloatConstraintMaxValueExclusiveOnRecordField rec = {value: 20.5};
    FloatConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnRecordFieldFailure1() {
    FloatConstraintMaxValueExclusiveOnRecordField rec = {value: 100.5};
    FloatConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnRecordFieldFailure2() {
    FloatConstraintMaxValueExclusiveOnRecordField rec = {value: 120.5};
    FloatConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintOnRecordField record {
    @Float {
        minValue: 18.5,
        maxValue: 100.5
    }
    float value;
};

@test:Config {}
isolated function testFloatConstraintOnRecordFieldSuccess1() {
    FloatConstraintOnRecordField rec = {value: 20.5};
    FloatConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnRecordFieldSuccess2() {
    FloatConstraintOnRecordField rec = {value: 18.5};
    FloatConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnRecordFieldSuccess3() {
    FloatConstraintOnRecordField rec = {value: 100.5};
    FloatConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnRecordFieldFailure1() {
    FloatConstraintOnRecordField rec = {value: 16.5};
    FloatConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnRecordFieldFailure2() {
    FloatConstraintOnRecordField rec = {value: 120.5};
    FloatConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
