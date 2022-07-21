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

type NoStringConstraintsOnTypeAsRecordField record {
    NoStringConstraintsOnType value;
};

@test:Config {}
isolated function testNoStringConstraintsOnTypeAsRecordField() {
    NoStringConstraintsOnTypeAsRecordField rec = {value: "s3cr3t"};
    NoStringConstraintsOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type StringConstraintLengthOnTypeAsRecordField record {
    StringConstraintLengthOnType value;
};

@test:Config {}
isolated function testStringConstraintLengthOnTypeAsRecordFieldSuccess() {
    StringConstraintLengthOnTypeAsRecordField rec = {value: "s3cr3t"};
    StringConstraintLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintLengthOnTypeAsRecordFieldFailure1() {
    StringConstraintLengthOnTypeAsRecordField rec = {value: "s3cr3t1"};
    StringConstraintLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testStringConstraintLengthOnTypeAsRecordFieldFailure2() {
    StringConstraintLengthOnTypeAsRecordField rec = {value: "s3cr3"};
    StringConstraintLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraintMinLengthOnTypeAsRecordField record {
    StringConstraintMinLengthOnType value;
};

@test:Config {}
isolated function testStringConstraintMinLengthOnTypeAsRecordFieldSuccess1() {
    StringConstraintMinLengthOnTypeAsRecordField rec = {value: "s3cr3t"};
    StringConstraintMinLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMinLengthOnTypeAsRecordFieldSuccess2() {
    StringConstraintMinLengthOnTypeAsRecordField rec = {value: "s3cr3ts"};
    StringConstraintMinLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMinLengthOnTypeAsRecordFieldFailure() {
    StringConstraintMinLengthOnTypeAsRecordField rec = {value: "s3c"};
    StringConstraintMinLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraintMaxLengthOnTypeAsRecordField record {
    StringConstraintMaxLengthOnType value;
};

@test:Config {}
isolated function testStringConstraintMaxLengthOnTypeAsRecordFieldSuccess1() {
    StringConstraintMaxLengthOnTypeAsRecordField rec = {value: "s3cr3t"};
    StringConstraintMaxLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMaxLengthOnTypeAsRecordFieldSuccess2() {
    StringConstraintMaxLengthOnTypeAsRecordField rec = {value: "s3c"};
    StringConstraintMaxLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMaxLengthOnTypeAsRecordFieldFailure() {
    StringConstraintMaxLengthOnTypeAsRecordField rec = {value: "s3cr3ts"};
    StringConstraintMaxLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraintOnTypeAsRecordField record {
    StringConstraintOnType value;
};

@test:Config {}
isolated function testStringConstraintOnTypeAsRecordFieldSuccess1() {
    StringConstraintOnTypeAsRecordField rec = {value: "b@!s3cr3t"};
    StringConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnTypeAsRecordFieldSuccess2() {
    StringConstraintOnTypeAsRecordField rec = {value: "s3cr3t"};
    StringConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnTypeAsRecordFieldSuccess3() {
    StringConstraintOnTypeAsRecordField rec = {value: "s3cr3ts3cr3t"};
    StringConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnTypeAsRecordFieldFailure1() {
    StringConstraintOnTypeAsRecordField rec = {value: "s3crt"};
    StringConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnTypeAsRecordFieldFailure2() {
    StringConstraintOnTypeAsRecordField rec = {value: "s3cr3ts3cr3ts3cr3t"};
    StringConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
