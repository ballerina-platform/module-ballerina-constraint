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

type NoStringConstraintsOnRecordField record {
    string value;
};

@test:Config {}
isolated function testNoStringConstraintsOnRecordField() {
    NoStringConstraintsOnRecordField rec = {value: "s3cr3t"};
    NoStringConstraintsOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type StringConstraintLengthOnRecordField record {
    @String {
        length: 6
    }
    string value;
};

@test:Config {}
isolated function testStringConstraintLengthOnRecordFieldSuccess() {
    StringConstraintLengthOnRecordField rec = {value: "s3cr3t"};
    StringConstraintLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintLengthOnRecordFieldFailure1() {
    StringConstraintLengthOnRecordField rec = {value: "s3cr3t1"};
    StringConstraintLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testStringConstraintLengthOnRecordFieldFailure2() {
    StringConstraintLengthOnRecordField rec = {value: "s3cr3"};
    StringConstraintLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraintMinLengthOnRecordField record {
    @String {
        minLength: 6
    }
    string value;
};

@test:Config {}
isolated function testStringConstraintMinLengthOnRecordFieldSuccess1() {
    StringConstraintMinLengthOnRecordField rec = {value: "s3cr3t"};
    StringConstraintMinLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMinLengthOnRecordFieldSuccess2() {
    StringConstraintMinLengthOnRecordField rec = {value: "s3cr3ts"};
    StringConstraintMinLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMinLengthOnRecordFieldFailure() {
    StringConstraintMinLengthOnRecordField rec = {value: "s3c"};
    StringConstraintMinLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraintMaxLengthOnRecordField record {
    @String {
        maxLength: 6
    }
    string value;
};

@test:Config {}
isolated function testStringConstraintMaxLengthOnRecordFieldSuccess1() {
    StringConstraintMaxLengthOnRecordField rec = {value: "s3cr3t"};
    StringConstraintMaxLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMaxLengthOnRecordFieldSuccess2() {
    StringConstraintMaxLengthOnRecordField rec = {value: "s3c"};
    StringConstraintMaxLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMaxLengthOnRecordFieldFailure() {
    StringConstraintMaxLengthOnRecordField rec = {value: "s3cr3ts"};
    StringConstraintMaxLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraintOnRecordField record {
    @String {
        minLength: 6,
        maxLength: 12
    }
    string value;
};

@test:Config {}
isolated function testStringConstraintOnRecordFieldSuccess1() {
    StringConstraintOnRecordField rec = {value: "b@!s3cr3t"};
    StringConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnRecordFieldSuccess2() {
    StringConstraintOnRecordField rec = {value: "s3cr3t"};
    StringConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnRecordFieldSuccess3() {
    StringConstraintOnRecordField rec = {value: "s3cr3ts3cr3t"};
    StringConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnRecordFieldFailure1() {
    StringConstraintOnRecordField rec = {value: "s3crt"};
    StringConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnRecordFieldFailure2() {
    StringConstraintOnRecordField rec = {value: "s3cr3ts3cr3ts3cr3t"};
    StringConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
