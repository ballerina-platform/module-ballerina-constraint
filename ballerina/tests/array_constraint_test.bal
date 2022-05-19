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

type NoArrayConstraints record {
    anydata[] value;
};

@test:Config {}
isolated function testNoArrayConstraints() {
    NoArrayConstraints rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    NoArrayConstraints|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

type ArrayConstraintLength record {
    @Array {
        length: 6
    }
    anydata[] value;
};

@test:Config {}
isolated function testArrayConstraintLengthSuccess() {
    ArrayConstraintLength rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintLength|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthFailure1() {
    ArrayConstraintLength rec = {value: [(), true, 123]};
    ArrayConstraintLength|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintLengthFailure2() {
    ArrayConstraintLength rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintLength|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintMinLength record {
    @Array {
        minLength: 6
    }
    anydata[] value;
};

@test:Config {}
isolated function testArrayConstraintMinLengthSuccess1() {
    ArrayConstraintMinLength rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintMinLength|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMinLengthSuccess2() {
    ArrayConstraintMinLength rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintMinLength|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMinLengthFailure() {
    ArrayConstraintMinLength rec = {value: [(), true, 123]};
    ArrayConstraintMinLength|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraintMaxLength record {
    @Array {
        maxLength: 6
    }
    anydata[] value;
};

@test:Config {}
isolated function testArrayConstraintMaxLengthSuccess1() {
    ArrayConstraintMaxLength rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraintMaxLength|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMaxLengthSuccess2() {
    ArrayConstraintMaxLength rec = {value: [(), true, 123]};
    ArrayConstraintMaxLength|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintMaxLengthFailure() {
    ArrayConstraintMaxLength rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraintMaxLength|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ArrayConstraint record {
    @Array {
        minLength: 6,
        maxLength: 12
    }
    anydata[] value;
};

@test:Config {}
isolated function testArrayConstraintSuccess1() {
    ArrayConstraint rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", xml `<book>The Lost World</book>`, {foo: "bar"}, table key('key) [{'key: 1, value: "foo"}]]};
    ArrayConstraint|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintSuccess2() {
    ArrayConstraint rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraint|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintSuccess3() {
    ArrayConstraint rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraint|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testArrayConstraintFailure1() {
    ArrayConstraint rec = {value: [(), true, 123]};
    ArrayConstraint|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testArrayConstraintFailure2() {
    ArrayConstraint rec = {value: [(), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t", (), true, 123, 123.45, 123.45d, "s3cr3t"]};
    ArrayConstraint|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
