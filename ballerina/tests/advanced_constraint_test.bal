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

// Testing multiple types of annotations in a single record

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
    Person|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintFailure1() {
    Person rec = {name: "John", age: 18};
    Person|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintFailure2() {
    Person rec = {name: "John Steve", age: 18};
    Person|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintFailure3() {
    Person rec = {name: "Steve", age: 16};
    Person|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintFailure4() {
    Person rec = {name: "John", age: 16};
    Person|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue','minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

// Testing multiple types of annotations in a single record field

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
    Student|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintOnSingleFieldSuccess2() {
    Student rec = {name: "Steve", age: 50};
    Student|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintOnSingleFieldFailure1() {
    Student rec = {name: "Steve", age: 16};
    Student|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testMultipleConstraintOnSingleFieldFailure2() {
    Student rec = {name: "Steve", age: 55};
    Student|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

// Testing multiple types of annotations on nested records

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
    @Array {
        minLength: 2
    }
    Baz[] baz;
|};

type Baz record {|
    @Int {
        maxValue: 100
    }
    int value;
|};

@test:Config {}
isolated function testNestedRecordSuccess() {
    Foo foo = {value: "Alice", bar: {value: "Steve", baz: [{value: 50}, {value: 75}]}};
    Foo|error validation = validate(foo);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure1() {
    Foo foo = {value: "Bob", bar: {value: "Steve", baz: [{value: 50}, {value: 75}]}};
    Foo|error validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure2() {
    Foo foo = {value: "Alice", bar: {value: "Bob", baz: [{value: 50}, {value: 75}]}};
    Foo|error validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure3() {
    Foo foo = {value: "Alice", bar: {value: "Steve", baz: [{value: 50}]}};
    Foo|error validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure4() {
    Foo foo = {value: "Alice", bar: {value: "Steve", baz: [{value: 50}, {value: 125}]}};
    Foo|error validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedRecordFailure5() {
    Foo foo = {value: "Eve", bar: {value: "Bob", baz: [{value: 125}]}};
    Foo|error validation = validate(foo);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue','minLength','length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

// Testing annotations on nested types

@Int {
    minValue: 0
}
type PositiveInt int;

@Array {
    maxLength: 10
}
type PositiveIntArray PositiveInt[];

@test:Config {}
isolated function testNestedTypeSuccess() {
    PositiveIntArray arr = [1, 2, 3, 4, 5];
    PositiveIntArray|error validation = validate(arr);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNestedTypeFailure1() {
    PositiveIntArray arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    PositiveIntArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedTypeFailure2() {
    PositiveIntArray arr = [1, 2, 3, 4, -5, 6, 7, 8, 9, -10];
    PositiveIntArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNestedTypeFailure3() {
    PositiveIntArray arr = [1, 2, 3, 4, -5, 6, 7, 8, 9, -10, 11];
    PositiveIntArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue','maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

// Testing annotations on types and records recursively

@String {
    length: 3
}
type QualificationType string;

@Int {
    minValue: 18
}
type Age int;

type Teacher record {|
    @String {
        length: 5
    }
    string name;
    Age age;
    @Array {
        minLength: 1
    }
    QualificationType[] qualifications;
|};

@Array {
    minLength: 2
}
type TeacherArray Teacher[];

@test:Config {}
isolated function testRecursiveAnnotationsOnRecordAndTypeSuccess() {
    TeacherArray arr = [{name: "Alice", age: 20, qualifications: ["BSc"]}, {name: "Peter", age: 30, qualifications: ["BSc", "MSc"]}];
    TeacherArray|error validation = validate(arr);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnRecordAndTypeFailure1() {
    TeacherArray arr = [{name: "Alice", age: 20, qualifications: ["BSC"]}];
    TeacherArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnRecordAndTypeFailure2() {
    TeacherArray arr = [{name: "Alice", age: 20, qualifications: ["BSc"]}, {name: "Bob", age: 30, qualifications: ["BSc", "MSc"]}];
    TeacherArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnRecordAndTypeFailure3() {
    TeacherArray arr = [{name: "Alice", age: 15, qualifications: ["BSc"]}, {name: "Peter", age: 30, qualifications: ["BSc", "MSc"]}];
    TeacherArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnRecordAndTypeFailure4() {
    TeacherArray arr = [{name: "Alice", age: 20, qualifications: ["BSc"]}, {name: "Peter", age: 30, qualifications: []}];
    TeacherArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnRecordAndTypeFailure5() {
    TeacherArray arr = [{name: "Alice", age: 20, qualifications: ["BSc"]}, {name: "Peter", age: 30, qualifications: ["Bachelors", "MSc"]}];
    TeacherArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnRecordAndTypeFailure6() {
    TeacherArray arr = [{name: "Alice", age: 15, qualifications: ["Bachelors"]}, {name: "Bob", age: 16, qualifications: []}];
    TeacherArray|error validation = validate(arr);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue','minLength','length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

// Testing annotations on records and types recursively

type Qualification record {|
    @String {
        length: 3
    }
    string name;
|};

type Employee record {
    @String {
        maxLength: 3
    }
    string username;
    @Array {
        minLength: 2
    }
    Qualification[] qualifications;
};

@test:Config {}
isolated function testRecursiveAnnotationsOnTypeAndRecordSuccess() {
    Employee rec = {username: "Bob", qualifications: [{name: "BSc"}, {name: "MSc"}, {name: "PhD"}]};
    Employee|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnTypeAndRecordFailure1() {
    Employee rec = {username: "Alice", qualifications: [{name: "BSc"}, {name: "MSc"}]};
    Employee|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnTypeAndRecordFailure2() {
    Employee rec = {username: "Bob", qualifications: [{name: "BSc"}]};
    Employee|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnTypeAndRecordFailure3() {
    Employee rec = {username: "Bob", qualifications: [{name: "Bachelors"}, {name: "Masters"}]};
    Employee|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testRecursiveAnnotationsOnTypeAndRecordFailure4() {
    Employee rec = {username: "Alice", qualifications: [{name: "Bachelors"}]};
    Employee|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minLength','length','maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

// Testing annotation validations by passing invalid typedesc

type ValidRecord record {
    @String {
        length: 5
    }
    string value;
};

type InvalidRecord record {
    @Int {
        minValue: 16
    }
    int value;
};

@test:Config {}
isolated function testInvalidTypeDescForRecord() {
    ValidRecord rec = {value: "Alice"};
    InvalidRecord|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Unexpected error found due to typedesc and value mismatch.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@String {
    length: 5
}
type ValidType string;

@Int {
    minValue: 16
}
type InvalidType int;

@test:Config {}
isolated function testInvalidTypeDescForType() {
    ValidType typ = "Alice";
    InvalidType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Unexpected error found due to typedesc and value mismatch.");
    } else {
        test:assertFail("Expected error not found.");
    }
}
