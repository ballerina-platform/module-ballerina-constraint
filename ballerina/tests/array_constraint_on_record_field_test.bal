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

type NoArrayConstraintsOnRecordField record {
    anydata[] value;
};

@test:Config {}
isolated function testNoArrayConstraintsOnRecordField() {
    // TODO : Add table - `table key('key) [{'key: 1, value: "foo"}]` after the fix of this issue: 
    // https://github.com/ballerina-platform/ballerina-lang/issues/39383
    NoArrayConstraintsOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}]};
    NoArrayConstraintsOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type ArrayConstraintLengthOnRecordField record {
    @Array {
        length: 6
    }
    anydata[] value;
};

@test:Config {}
isolated function testArrayConstraintLengthOnRecordFieldSuccess() {
    ArrayConstraintLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthOnRecordFieldFailure1() {
    ArrayConstraintLengthOnRecordField rec = {value: [(), true, 123]};
    ArrayConstraintLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthOnRecordFieldFailure2() {
    // TODO : Add table - `table key('key) [{'key: 1, value: "foo"}]` after the fix of this issue: 
    // https://github.com/ballerina-platform/ballerina-lang/issues/39383
    ArrayConstraintLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}]};
    ArrayConstraintLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintMinLengthOnRecordField record {
    @Array {
        minLength: 6
    }
    anydata[] value;
};

@test:Config {}
isolated function testArrayConstraintMinLengthOnRecordFieldSuccess1() {
    ArrayConstraintMinLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintMinLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMinLengthOnRecordFieldSuccess2() {
    // TODO : Add table - `table key('key) [{'key: 1, value: "foo"}]` after the fix of this issue: 
    // https://github.com/ballerina-platform/ballerina-lang/issues/39383
    ArrayConstraintMinLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}]};
    ArrayConstraintMinLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMinLengthOnRecordFieldFailure() {
    ArrayConstraintMinLengthOnRecordField rec = {value: [(), true, 123]};
    ArrayConstraintMinLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintMaxLengthOnRecordField record {
    @Array {
        maxLength: 6
    }
    anydata[] value;
};

@test:Config {}
isolated function testArrayConstraintMaxLengthOnRecordFieldSuccess1() {
    ArrayConstraintMaxLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintMaxLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMaxLengthOnRecordFieldSuccess2() {
    ArrayConstraintMaxLengthOnRecordField rec = {value: [(), true, 123]};
    ArrayConstraintMaxLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMaxLengthOnRecordFieldFailure() {
    // TODO : Add table - `table key('key) [{'key: 1, value: "foo"}]` after the fix of this issue: 
    // https://github.com/ballerina-platform/ballerina-lang/issues/39383
    ArrayConstraintMaxLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}]};
    ArrayConstraintMaxLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintOnRecordField record {
    @Array {
        minLength: 6,
        maxLength: 12
    }
    anydata[] value;
};

@test:Config {}
isolated function testArrayConstraintOnRecordFieldSuccess1() {
    // TODO : Add table - `table key('key) [{'key: 1, value: "foo"}]` after the fix of this issue: 
    // https://github.com/ballerina-platform/ballerina-lang/issues/39383
    ArrayConstraintOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}]};
    ArrayConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnRecordFieldSuccess2() {
    ArrayConstraintOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnRecordFieldSuccess3() {
    ArrayConstraintOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnRecordFieldFailure1() {
    ArrayConstraintOnRecordField rec = {value: [(), true, 123]};
    ArrayConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnRecordFieldFailure2() {
    ArrayConstraintOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintOnUnionRecordField record {
    @Array {
        minLength: 6,
        maxLength: 12
    }
    int[]|string[] value;
};

@test:Config {}
isolated function testArrayConstraintOnUnionRecordFieldSuccess1() {
    ArrayConstraintOnUnionRecordField rec = {value: [1, 2, 3, 4, 5, 6, 7, 8]};
    ArrayConstraintOnUnionRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnUnionRecordFieldSuccess2() {
    ArrayConstraintOnUnionRecordField rec = {value: ["a", "b", "c", "d", "e", "f", "g", "h"]};
    ArrayConstraintOnUnionRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnUnionRecordFieldFailure1() {
    ArrayConstraintOnUnionRecordField rec = {value: [1, 2, 3]};
    ArrayConstraintOnUnionRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnUnionRecordFieldFailure2() {
    ArrayConstraintOnUnionRecordField rec = {value: ["a", "b", "c"]};
    ArrayConstraintOnUnionRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnRecordFieldFailure3() {
    ArrayConstraintOnUnionRecordField rec = {value: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]};
    ArrayConstraintOnUnionRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnRecordFieldFailure4() {
    ArrayConstraintOnUnionRecordField rec = {value: ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o"]};
    ArrayConstraintOnUnionRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.value:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
