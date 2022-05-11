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

type NoStringConstraints record {
    string value;
};

@test:Config {}
isolated function testNoStringConstraints() {
    NoStringConstraints rec = {value: "s3cr3t"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

type StringConstraintLength record {
    @String {
        length: 6
    }
    string value;
};

@test:Config {}
isolated function testStringConstraintLengthSuccess() {
    StringConstraintLength rec = {value: "s3cr3t"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintLengthFailure1() {
    StringConstraintLength rec = {value: "s3cr3t1"};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testStringConstraintLengthFailure2() {
    StringConstraintLength rec = {value: "s3cr3"};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraintMinLength record {
    @String {
        minLength: 6
    }
    string value;
};

@test:Config {}
isolated function testStringConstraintMinLengthSuccess1() {
    StringConstraintMinLength rec = {value: "s3cr3t"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMinLengthSuccess2() {
    StringConstraintMinLength rec = {value: "s3cr3ts"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMinLengthFailure() {
    StringConstraintMinLength rec = {value: "s3c"};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraintMaxLength record {
    @String {
        maxLength: 6
    }
    string value;
};

@test:Config {}
isolated function testStringConstraintMaxLengthSuccess1() {
    StringConstraintMaxLength rec = {value: "s3cr3t"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMaxLengthSuccess2() {
    StringConstraintMaxLength rec = {value: "s3c"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMaxLengthFailure() {
    StringConstraintMaxLength rec = {value: "s3cr3ts"};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type StringConstraint record {
    @String {
        minLength: 6,
        maxLength: 12
    }
    string value;
};

@test:Config {}
isolated function testStringConstraintSuccess1() {
    StringConstraint rec = {value: "b@!s3cr3t"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintSuccess2() {
    StringConstraint rec = {value: "s3cr3t"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintSuccess3() {
    StringConstraint rec = {value: "s3cr3ts3cr3t"};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintFailure1() {
    StringConstraint rec = {value: "s3crt"};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testStringConstraintFailure2() {
    StringConstraint rec = {value: "s3cr3ts3cr3ts3cr3t"};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
