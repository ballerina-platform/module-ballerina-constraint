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

type NoStringConstraintsOnType string;

@test:Config {}
isolated function testNoStringConstraintsOnType() {
    NoStringConstraintsOnType typ = "s3cr3t";
    NoStringConstraintsOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, typ);
    }
}

@String {
    length: 6
}
type StringConstraintLengthOnType string;

@test:Config {}
isolated function testStringConstraintLengthOnTypeSuccess() {
    StringConstraintLengthOnType typ = "s3cr3t";
    StringConstraintLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintLengthOnTypeFailure1() {
    StringConstraintLengthOnType typ = "s3cr3t1";
    StringConstraintLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$=>length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testStringConstraintLengthOnTypeFailure2() {
    StringConstraintLengthOnType typ = "s3cr3";
    StringConstraintLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$=>length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@String {
    minLength: 6
}
type StringConstraintMinLengthOnType string;

@test:Config {}
isolated function testStringConstraintMinLengthOnTypeSuccess1() {
    StringConstraintMinLengthOnType typ = "s3cr3t";
    StringConstraintMinLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMinLengthOnTypeSuccess2() {
    StringConstraintMinLengthOnType typ = "s3cr3ts";
    StringConstraintMinLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMinLengthOnTypeFailure() {
    StringConstraintMinLengthOnType typ = "s3c";
    StringConstraintMinLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$=>minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@String {
    maxLength: 6
}
type StringConstraintMaxLengthOnType string;

@test:Config {}
isolated function testStringConstraintMaxLengthOnTypeSuccess1() {
    StringConstraintMaxLengthOnType typ = "s3cr3t";
    StringConstraintMaxLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMaxLengthOnTypeSuccess2() {
    StringConstraintMaxLengthOnType typ = "s3c";
    StringConstraintMaxLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintMaxLengthOnTypeFailure() {
    StringConstraintMaxLengthOnType typ = "s3cr3ts";
    StringConstraintMaxLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$=>maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@String {
    minLength: 6,
    maxLength: 12
}
type StringConstraintOnType string;

@test:Config {}
isolated function testStringConstraintOnTypeSuccess1() {
    StringConstraintOnType typ = "b@!s3cr3t";
    StringConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnTypeSuccess2() {
    StringConstraintOnType typ = "s3cr3t";
    StringConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnTypeSuccess3() {
    StringConstraintOnType typ = "s3cr3ts3cr3t";
    StringConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnTypeFailure1() {
    StringConstraintOnType typ = "s3crt";
    StringConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$=>minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testStringConstraintOnTypeFailure2() {
    StringConstraintOnType typ = "s3cr3ts3cr3ts3cr3t";
    StringConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$=>maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
