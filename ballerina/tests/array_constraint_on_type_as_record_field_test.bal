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

type NoArrayConstraintsOnTypeAsRecordField record {
    NoArrayConstraintsOnType value;
};

@test:Config {}
isolated function testNoArrayConstraintsOnTypeAsRecordField() {
    NoArrayConstraintsOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    NoArrayConstraintsOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type ArrayConstraintLengthOnTypeAsRecordField record {
    ArrayConstraintLengthOnType value;
};

@test:Config {}
isolated function testArrayConstraintLengthOnTypeAsRecordFieldSuccess() {
    ArrayConstraintLengthOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthOnTypeAsRecordFieldFailure1() {
    ArrayConstraintLengthOnTypeAsRecordField rec = {value: [(), true, 123]};
    ArrayConstraintLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthOnTypeAsRecordFieldFailure2() {
    ArrayConstraintLengthOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintMinLengthOnTypeAsRecordField record {
    ArrayConstraintMinLengthOnType value;
};

@test:Config {}
isolated function testArrayConstraintMinLengthOnTypeAsRecordFieldSuccess1() {
    ArrayConstraintMinLengthOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintMinLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMinLengthOnTypeAsRecordFieldSuccess2() {
    ArrayConstraintMinLengthOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintMinLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMinLengthOnTypeAsRecordFieldFailure() {
    ArrayConstraintMinLengthOnTypeAsRecordField rec = {value: [(), true, 123]};
    ArrayConstraintMinLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintMaxLengthOnTypeAsRecordField record {
    ArrayConstraintMaxLengthOnType value;
};

@test:Config {}
isolated function testArrayConstraintMaxLengthOnTypeAsRecordFieldSuccess1() {
    ArrayConstraintMaxLengthOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintMaxLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMaxLengthOnTypeAsRecordFieldSuccess2() {
    ArrayConstraintMaxLengthOnTypeAsRecordField rec = {value: [(), true, 123]};
    ArrayConstraintMaxLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMaxLengthOnTypeAsRecordFieldFailure() {
    ArrayConstraintMaxLengthOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintMaxLengthOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintOnTypeAsRecordField record {
    ArrayConstraintOnType value;
};

@test:Config {}
isolated function testArrayConstraintOnTypeAsRecordFieldSuccess1() {
    ArrayConstraintOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnTypeAsRecordFieldSuccess2() {
    ArrayConstraintOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnTypeAsRecordFieldSuccess3() {
    ArrayConstraintOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnTypeAsRecordFieldFailure1() {
    ArrayConstraintOnTypeAsRecordField rec = {value: [(), true, 123]};
    ArrayConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnTypeAsRecordFieldFailure2() {
    ArrayConstraintOnTypeAsRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintOnUnionTypeAsRecordField record {
    ArrayConstraintOnUnionType value;
};

// TODO: Following test cases are disabled due to https://github.com/ballerina-platform/ballerina-lang/issues/36543

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeAsRecordFieldSuccess1() {
    ArrayConstraintOnUnionTypeAsRecordField rec = {value: [1, 2, 3, 4, 5, 6, 7, 8]};
    ArrayConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeAsRecordFieldSuccess2() {
    ArrayConstraintOnUnionTypeAsRecordField rec = {value: ["a", "b", "c", "d", "e", "f", "g", "h"]};
    ArrayConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeAsRecordFieldFailure1() {
    ArrayConstraintOnUnionTypeAsRecordField rec = {value: [1, 2, 3]};
    ArrayConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeAsRecordFieldFailure2() {
    ArrayConstraintOnUnionTypeAsRecordField rec = {value: ["a", "b", "c"]};
    ArrayConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeAsRecordFieldFailure3() {
    ArrayConstraintOnUnionTypeAsRecordField rec = {value: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]};
    ArrayConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testArrayConstraintOnUnionTypeAsRecordFieldFailure4() {
    ArrayConstraintOnUnionTypeAsRecordField rec = {value: ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o"]};
    ArrayConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
