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

type NoIntConstraintsOnTypeAsRecordField record {
    NoIntConstraintsOnType value;
};

@test:Config {}
isolated function testNoIntConstraintsOnTypeAsRecordField() {
    NoIntConstraintsOnTypeAsRecordField rec = {value: 20};
    NoIntConstraintsOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type IntConstraintMinValueOnTypeAsRecordField record {
    IntConstraintMinValueOnType value;
};

@test:Config {}
isolated function testIntConstraintMinValueOnTypeAsRecordFieldSuccess1() {
    IntConstraintMinValueOnTypeAsRecordField rec = {value: 20};
    IntConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueOnTypeAsRecordFieldSuccess2() {
    IntConstraintMinValueOnTypeAsRecordField rec = {value: 18};
    IntConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueOnTypeAsRecordFieldFailure() {
    IntConstraintMinValueOnTypeAsRecordField rec = {value: 16};
    IntConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMaxValueOnTypeAsRecordField record {
    IntConstraintMaxValueOnType value;
};

@test:Config {}
isolated function testIntConstraintMaxValueOnTypeAsRecordFieldSuccess1() {
    IntConstraintMaxValueOnTypeAsRecordField rec = {value: 20};
    IntConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueOnTypeAsRecordFieldSuccess2() {
    IntConstraintMaxValueOnTypeAsRecordField rec = {value: 100};
    IntConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueOnTypeAsRecordFieldFailure() {
    IntConstraintMaxValueOnTypeAsRecordField rec = {value: 120};
    IntConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMinValueExclusiveOnTypeAsRecordField record {
    IntConstraintMinValueExclusiveOnType value;
};

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnTypeAsRecordFieldSuccess() {
    IntConstraintMinValueExclusiveOnTypeAsRecordField rec = {value: 20};
    IntConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnTypeAsRecordFieldFailure1() {
    IntConstraintMinValueExclusiveOnTypeAsRecordField rec = {value: 18};
    IntConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintMinValueExclusiveOnTypeAsRecordFieldFailure2() {
    IntConstraintMinValueExclusiveOnTypeAsRecordField rec = {value: 16};
    IntConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintMaxValueExclusiveOnTypeAsRecordField record {
    IntConstraintMaxValueExclusiveOnType value;
};

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnTypeAsRecordFieldSuccess() {
    IntConstraintMaxValueExclusiveOnTypeAsRecordField rec = {value: 20};
    IntConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnTypeAsRecordFieldFailure1() {
    IntConstraintMaxValueExclusiveOnTypeAsRecordField rec = {value: 100};
    IntConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintMaxValueExclusiveOnTypeAsRecordFieldFailure2() {
    IntConstraintMaxValueExclusiveOnTypeAsRecordField rec = {value: 120};
    IntConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type IntConstraintOnTypeAsRecordField record {
    IntConstraintOnType value;
};

@test:Config {}
isolated function testIntConstraintOnTypeAsRecordFieldSuccess1() {
    IntConstraintOnTypeAsRecordField rec = {value: 20};
    IntConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnTypeAsRecordFieldSuccess2() {
    IntConstraintOnTypeAsRecordField rec = {value: 18};
    IntConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnTypeAsRecordFieldSuccess3() {
    IntConstraintOnTypeAsRecordField rec = {value: 100};
    IntConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnTypeAsRecordFieldFailure1() {
    IntConstraintOnTypeAsRecordField rec = {value: 16};
    IntConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testIntConstraintOnTypeAsRecordFieldFailure2() {
    IntConstraintOnTypeAsRecordField rec = {value: 120};
    IntConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value=>maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
