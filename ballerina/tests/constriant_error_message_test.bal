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
import ballerina/time;

@String {
    minLength : {
        value : 5,
        message : "Name should be at least 5 characters long"
    },
    maxLength : {
        value : 10,
        message : "Name should be at most 10 characters long"
    },
    pattern : {
        value : re `^[a-zA-Z0-9]+$`,
        message : "Only alpha numeric characters are allowed in the name"
    }
}
type TraineeName string;

@test:Config {}
function testErrorMessageInStringType() {
    TraineeName str = "abc";
    TraineeName|error validation = validate(str);
    if validation is error {
        test:assertEquals(validation.message(), "Name should be at least 5 characters long.");
    } else {
        test:assertFail("Expected error not found.");
    }

    str = "abcdef123456";
    validation = validate(str);
    if validation is error {
        test:assertEquals(validation.message(), "Name should be at most 10 characters long.");
    } else {
        test:assertFail("Expected error not found.");
    }

    str = "abc123!";
    validation = validate(str);
    if validation is error {
        test:assertEquals(validation.message(), "Only alpha numeric characters are allowed in the name.");
    } else {
        test:assertFail("Expected error not found.");
    }

    str = "a1*";
    validation = validate(str);
    if validation is error {
        test:assertEquals(validation.message(), "Name should be at least 5 characters long and Only alpha numeric " +
                          "characters are allowed in the name.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date {
    option: {
        value: PAST,
        message: "Date of birth should be in the past"
    },
    message: "Invalid date found for date of birth"
}
type DateOfBirth time:Date;

@test:Config {}
function testErrorMessageInDateType() {
    DateOfBirth dob = {
        year: 2055,
        month: 10,
        day: 10
    };
    DateOfBirth|error validation = validate(dob);
    if validation is error {
        test:assertEquals(validation.message(), "Date of birth should be in the past.");
    } else {
        test:assertFail("Expected error not found.");
    }

    dob = {
        year: 1990,
        month: 2,
        day: 30
    };
    validation = validate(dob);
    if validation is error {
        test:assertEquals(validation.message(), "Invalid date found for date of birth.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@String {
    minLength : {
        value : 5,
        message : "Badge should be at least 5 characters long"
    }
}
type Badge string;

type Trainee record {|
    TraineeName TraineeName;
    DateOfBirth dob;
    @Number {
        minValue: {
            value: 0,
            message: "Weight should be a positive value"
        }
    }
    decimal weight;
    @Number {
        minValue: {
            value: 0,
            message: "Height should be a positive value"
        }
    }
    decimal height;
    @Date {
        message: "Invalid date found for date of joining"
    }
    time:Date dateOfJoining;
    @Array {
        maxLength: {
            value: 5,
            message: "Maximum 5 badges are allowed"
        }
    }
    Badge[] badges;
|};

const Trainee TRAINEE = {
    TraineeName: "JohnDoe",
    dob: {
        year: 1999,
        month: 4,
        day: 3
    },
    weight: 50.5,
    height: 150.5,
    dateOfJoining: {
        year: 2022,
        month: 10,
        day: 10
    },
    badges: ["badge1", "badge2"]
};

@test:Config {}
function testErrorMessageInRecordTypePositive() returns error? {
    Trainee trainee = check TRAINEE.cloneWithType();
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, trainee);
    }
}

@test:Config {}
function testErrorMessageInRecordTypeNegative1() returns error? {
    Trainee trainee = check TRAINEE.cloneWithType();
    trainee.TraineeName = "abc";
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Name should be at least 5 characters long.");
    } else {
        test:assertFail("Expected error not found.");
    }

    trainee.TraineeName = "ab*";
    validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Name should be at least 5 characters long and Only alpha numeric characters are allowed in the name.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInRecordTypeNegative2() returns error? {
    Trainee trainee = check TRAINEE.cloneWithType();
    trainee.dob = {
        year: 2055,
        month: 10,
        day: 10
    };
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Date of birth should be in the past.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInRecordTypeNegative3() returns error? {
    Trainee trainee = check TRAINEE.cloneWithType();
    trainee.weight = -50.5;
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Weight should be a positive value.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInRecordTypeNegative4() returns error? {
    Trainee trainee = check TRAINEE.cloneWithType();
    trainee.height = -150.5;
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Height should be a positive value.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInRecordTypeNegative5() returns error? {
    Trainee trainee = check TRAINEE.cloneWithType();
    trainee.dateOfJoining = {
        year: 2022,
        month: 2,
        day: 30
    };
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Invalid date found for date of joining.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInRecordTypeNegative6() returns error? {
    Trainee trainee = check TRAINEE.cloneWithType();
    trainee.badges = ["badge1", "badge2", "badge3", "badge4", "badge5", "badge6"];
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Maximum 5 badges are allowed.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInRecordTypeNegative7() returns error? {
    Trainee trainee = check TRAINEE.cloneWithType();
    trainee.badges = ["badge1", "badge2", "bad"];
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "'$.badges[2]':Badge should be at least 5 characters long.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInRecordTypeAllNegative() {
    Trainee trainee = {
        TraineeName: "abc",
        dob: {
            year: 2055,
            month: 10,
            day: 10
        },
        weight: -50.5,
        height: -150.5,
        dateOfJoining: {
            year: 2022,
            month: 2,
            day: 30
        },
        badges: ["badge1", "badge2", "bad", "badge4", "badge5", "badge6"]
    };
    Trainee|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Weight should be a positive value, Height should be a positive value," +
                          " Invalid date found for date of joining, Maximum 5 badges are allowed, Name should be at" +
                          " least 5 characters long, Date of birth should be in the past and '$.badges[2]':Badge " +
                          "should be at least 5 characters long.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type Trainee0 record {|
    TraineeName TraineeName;
    DateOfBirth dob;
    @Number {
        minValueExclusive: 0
    }
    decimal weight;
    @Number {
        minValueExclusive: 0,
        maxValueExclusive: 250
    }
    decimal height;
    @Date
    time:Date dateOfJoining;
    @Array {
        maxLength: 5
    }
    Badge[] badges;
|};

@test:Config {}
function testErrorMessageInMixedRecordTypePositive() returns error? {
    Trainee0 trainee = check TRAINEE.cloneWithType();
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, trainee);
    }
}

@test:Config {}
function testErrorMessageInMixedRecordTypeNegative1() returns error? {
    Trainee0 trainee = check TRAINEE.cloneWithType();
    trainee.TraineeName = "abc";
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Name should be at least 5 characters long.");
    } else {
        test:assertFail("Expected error not found.");
    }

    trainee.TraineeName = "ab*";
    validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Name should be at least 5 characters long and Only alpha numeric characters are allowed in the name.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInMixedRecordTypeNegative2() returns error? {
    Trainee0 trainee = check TRAINEE.cloneWithType();
    trainee.dob = {
        year: 2055,
        month: 10,
        day: 10
    };
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Date of birth should be in the past.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInMixedRecordTypeNegative3() returns error? {
    Trainee0 trainee = check TRAINEE.cloneWithType();
    trainee.weight = -50.5;
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.weight:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInMixedRecordTypeNegative4() returns error? {
    Trainee0 trainee = check TRAINEE.cloneWithType();
    trainee.height = -150.5;
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.height:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInMixedRecordTypeNegative5() returns error? {
    Trainee0 trainee = check TRAINEE.cloneWithType();
    trainee.height = 300;
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.height:maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInMixedRecordTypeNegative6() returns error? {
    Trainee0 trainee = check TRAINEE.cloneWithType();
    trainee.dateOfJoining = {
        year: 2022,
        month: 2,
        day: 30
    };
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dateOfJoining.day:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInMixedRecordTypeNegative7() returns error? {
    Trainee0 trainee = check TRAINEE.cloneWithType();
    trainee.badges = ["badge1", "badge2", "bad"];
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "'$.badges[2]':Badge should be at least 5 characters long.");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testErrorMessageInMixedRecordTypeAllNegative() {
    Trainee0 trainee = {
        TraineeName: "abc",
        dob: {
            year: 2055,
            month: 10,
            day: 10
        },
        weight: -50.5,
        height: -150.5,
        dateOfJoining: {
            year: 2022,
            month: 2,
            day: 30
        },
        badges: ["badge1", "badge2", "bad", "badge4", "badge5", "badge6"]
    };
    Trainee0|error validation = validate(trainee);
    if validation is error {
        test:assertEquals(validation.message(), "Name should be at least 5 characters long, Date of birth should be " +
                          "in the past, '$.badges[2]':Badge should be at least 5 characters long and Validation failed" +
                          " for '$.badges:maxLength','$.dateOfJoining.day:validDate','$.height:minValueExclusive'," +
                          "'$.weight:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
