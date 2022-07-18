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

type NoArrayConstraintsOnType anydata[];

@test:Config {}
isolated function testNoArrayConstraintsOnType() {
    NoArrayConstraintsOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]];
    NoArrayConstraintsOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, typ);
    }
}

@Array {
    length: 6
}
type ArrayConstraintLengthOnType anydata[];

@test:Config {}
isolated function testArrayConstraintLengthOnTypeSuccess() {
    ArrayConstraintLengthOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t"];
    ArrayConstraintLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthOnTypeFailure1() {
    ArrayConstraintLengthOnType typ = [(), true, 123];
    ArrayConstraintLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthOnTypeFailure2() {
    ArrayConstraintLengthOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]];
    ArrayConstraintLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Array {
    minLength: 6
}
type ArrayConstraintMinLengthOnType anydata[];

@test:Config {}
isolated function testArrayConstraintMinLengthOnTypeSuccess1() {
    ArrayConstraintMinLengthOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t"];
    ArrayConstraintMinLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMinLengthOnTypeSuccess2() {
    ArrayConstraintMinLengthOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]];
    ArrayConstraintMinLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMinLengthOnTypeFailure() {
    ArrayConstraintMinLengthOnType typ = [(), true, 123];
    ArrayConstraintMinLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Array {
    maxLength: 6
}
type ArrayConstraintMaxLengthOnType anydata[];

@test:Config {}
isolated function testArrayConstraintMaxLengthOnTypeSuccess1() {
    ArrayConstraintMaxLengthOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t"];
    ArrayConstraintMaxLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMaxLengthOnTypeSuccess2() {
    ArrayConstraintMaxLengthOnType typ = [(), true, 123];
    ArrayConstraintMaxLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMaxLengthOnTypeFailure() {
    ArrayConstraintMaxLengthOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]];
    ArrayConstraintMaxLengthOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Array {
    minLength: 6,
    maxLength: 12
}
type ArrayConstraintOnType anydata[];

@test:Config {}
isolated function testArrayConstraintOnTypeSuccess1() {
    ArrayConstraintOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]];
    ArrayConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnTypeSuccess2() {
    ArrayConstraintOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t"];
    ArrayConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnTypeSuccess3() {
    ArrayConstraintOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"];
    ArrayConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnTypeFailure1() {
    ArrayConstraintOnType typ = [(), true, 123];
    ArrayConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnTypeFailure2() {
    ArrayConstraintOnType typ = [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"];
    ArrayConstraintOnType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Array {
    minLength: 6,
    maxLength: 12
}
type ArrayConstraintOnUnionType int[]|string[];

// TODO: Following test cases are disabled due to https://github.com/ballerina-platform/ballerina-lang/issues/36543

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeSuccess1() {
    ArrayConstraintOnUnionType typ = [1, 2, 3, 4, 5, 6, 7, 8];
    ArrayConstraintOnUnionType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeSuccess2() {
    ArrayConstraintOnUnionType typ = ["a", "b", "c", "d", "e", "f", "g", "h"];
    ArrayConstraintOnUnionType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeFailure1() {
    ArrayConstraintOnUnionType typ = [1, 2, 3];
    ArrayConstraintOnUnionType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeFailure2() {
    ArrayConstraintOnUnionType typ = ["a", "b", "c"];
    ArrayConstraintOnUnionType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeFailure3() {
    ArrayConstraintOnUnionType typ = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
    ArrayConstraintOnUnionType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeFailure4() {
    ArrayConstraintOnUnionType typ = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o"];
    ArrayConstraintOnUnionType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
