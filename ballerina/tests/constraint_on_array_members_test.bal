// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

@String {length: 4}
type UserId string;

@Array {length: 4}
type UserIdArray UserId[];

type App1 record {|
    UserIdArray ids;
|};

type App2 record {|
    UserId[] ids;
|};

@Array {maxLength: 2}
type Users User[];

@test:Config {}
function testConstraintsOnArrayBasicMembersSuccess() {
    UserId[] ids = ["1234", "4356", "9834", "3214"];
    do {
        ids = check validate(ids);
    } on fail {
        test:assertFail("Unexpected error found.");
    }

    UserIdArray|error validation = validate(ids);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testConstraintsOnArrayBasicMembersFailure() {
    UserId[] ids = ["1234", "43", "9834", "3214"];

    UserId[]|error validation1 = validate(ids);
    if validation1 is error {
        test:assertEquals(validation1.message(), "Validation failed for '$[1]:length' constraint(s).");
    } else {
        test:assertFail("Unexpected error found.");
    }

    UserIdArray|error validation2 = validate([...ids]);
    if validation2 is error {
        test:assertEquals(validation2.message(), "Validation failed for '$[1]:length' constraint(s).");
    } else {
        test:assertFail("Unexpected error found.");
    }

    UserIdArray|error validation3 = validate([...ids, "32"]);
    if validation3 is error {
        test:assertEquals(validation3.message(), "Validation failed for '$:length','$[1]:length','$[4]:length' constraint(s).");
    } else {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testConstraintsOnRecordFieldArrayMembersSuccess() {
    UserId[] ids = ["1234", "4356", "9834", "3214"];

    App1|error validation1 = validate({ids: ids});
    if validation1 is error {
        test:assertFail("Unexpected error found.");
    }

    App2|error validation2 = validate({ids: ids});
    if validation2 is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testConstraintsOnRecordFieldArrayMembersFailure() {
    UserId[] ids = ["1234", "43", "9834", "3214"];

    App1|error validation1 = validate({ids: ids});
    if validation1 is error {
        test:assertEquals(validation1.message(), "Validation failed for '$.ids[1]:length' constraint(s).");
    } else {
        test:assertFail("Unexpected error found.");
    }

    App2|error validation2 = validate({ids: ids});
    if validation2 is error {
        test:assertEquals(validation2.message(), "Validation failed for '$.ids[1]:length' constraint(s).");
    } else {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testConstraintsOnRecordArrayMemberSuccess() {
    User[] users = [
        {id: 1, name: "John"},
        {id: 2, name: "Joyce"}
    ];

    do {
        users = check validate(users);
    } on fail {
        test:assertFail("Unexpected error found.");
    }

    Users|error validation = validate(users);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testConstraintsOnRecordArrayMemberFailure() {
    User[] users = [
        {id: 1, name: "John"},
        {id: 2, name: "a"}
    ];

    User[]|error validation1 = validate(users);
    if validation1 is error {
        test:assertEquals(validation1.message(), "Validation failed for '$[1].name:minLength' constraint(s).");
    } else {
        test:assertFail("Unexpected error found.");
    }

    Users|error validation2 = validate([...users]);
    if validation2 is error {
        test:assertEquals(validation2.message(), "Validation failed for '$[1].name:minLength' constraint(s).");
    } else {
        test:assertFail("Unexpected error found.");
    }

    Users|error validation3 = validate([...users, {id: 3, name: "Joyce"}]);
    if validation3 is error {
        test:assertEquals(validation3.message(), "Validation failed for '$:maxLength','$[1].name:minLength' constraint(s).");
    } else {
        test:assertFail("Unexpected error found.");
    }
}
