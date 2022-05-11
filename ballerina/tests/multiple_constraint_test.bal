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

// Multiple type of annotations in a single record
type Person record {
    @String {
        minLength: 5,
        maxLength: 8
    }
    string name;
    @Int {
        minValue: 18
    }
    int age;
};

@test:Config {}
isolated function testMultipleConstraintSuccess() {
    Person rec = {name: "Steve", age: 18};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintFailure1() {
    Person rec = {name: "John", age: 18};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintFailure2() {
    Person rec = {name: "John Steve", age: 18};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintFailure3() {
    Person rec = {name: "Steve", age: 16};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintFailure4() {
    Person rec = {name: "John", age: 16};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue','minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

// Multiple type of annotations in a single record
type Student record {
    string name;
    @Number {
        maxValue: 50
    }
    @Int {
        minValue: 18
    }
    int age;
};

@test:Config {}
isolated function testMultipleConstraintOnSingleFieldSuccess1() {
    Student rec = {name: "Steve", age: 18};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintOnSingleFieldSuccess2() {
    Student rec = {name: "Steve", age: 50};
    error? validation = validate(rec);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintOnSingleFieldFailure1() {
    Student rec = {name: "Steve", age: 16};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintOnSingleFieldFailure2() {
    Student rec = {name: "Steve", age: 55};
    error? validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

// Annotations on nested records
type Foo record {
    @String {
        length: 5
    }
    string value;
    Bar bar;
};

type Bar record {|
    @String {
        minLength: 5
    }
    string value;
    Baz baz;
|};

type Baz record {|
    @Int {
        maxValue: 100
    }
    int value;
|};

@test:Config {}
isolated function testNestedRecordSuccess() {
    Foo foo = {value: "Alice", bar: {value: "Steve", baz: {value: 50}}};
    error? validation = validate(foo);
    if validation !is () {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure1() {
    Foo foo = {value: "Bob", bar: {value: "Steve", baz: {value: 50}}};
    error? validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure2() {
    Foo foo = {value: "Alice", bar: {value: "Bob", baz: {value: 50}}};
    error? validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure3() {
    Foo foo = {value: "Alice", bar: {value: "Steve", baz: {value: 120}}};
    error? validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure4() {
    Foo foo = {value: "Eve", bar: {value: "Bob", baz: {value: 120}}};
    error? validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue','minLength','length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
