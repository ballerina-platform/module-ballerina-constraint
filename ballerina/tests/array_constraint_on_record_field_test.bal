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
    NoArrayConstraintsOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    NoArrayConstraintsOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
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
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthOnRecordFieldFailure2() {
    ArrayConstraintLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
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
    ArrayConstraintMinLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
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
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
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
    ArrayConstraintMaxLengthOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintMaxLengthOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
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
    ArrayConstraintOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
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
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintOnRecordFieldFailure2() {
    ArrayConstraintOnRecordField rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
