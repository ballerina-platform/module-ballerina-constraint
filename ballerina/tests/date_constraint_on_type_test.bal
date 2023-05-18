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

import ballerina/time;
import ballerina/test;

type NoDateConstraintOnTimeDateType time:Date;

@test:Config {}
function testNoDateConstraintsOnType() {
    NoDateConstraintOnTimeDateType date = {
        year: 2018,
        month: 10,
        day: 10
    };
    NoDateConstraintOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }

    date.month = 20;
    validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@Date
type DateConstraintSimpleOnTimeDateType time:Date;

@test:Config {}
function testDateConstraintSimpleOnTypeSuccess1() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 2018,
        month: 10,
        day: 10
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeSuccess2() {
    DateConstraintSimpleOnTimeDateType date = {
        year: -2018, // BC year
        month: 1,
        day: 1
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeSuccess3() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 2016, // leap year
        month: 2,
        day: 29
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeFailure1() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 2018,
        month: 10,
        day: 32
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.day:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeFailure2() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 2018,
        month: 15,
        day: 15
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.month:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeFailure3() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 1000000000, // limit is 999999999
        month: 1,
        day: 15
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.year:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeFailure4() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 2022,
        month: 6,
        day: 31 // June has 30 days
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.day:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeFailure5() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 2022,
        month: 2,
        day: 29 // 2022 is not a leap year
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.day:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeMultipleFailure1() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 2022,
        month: 20,
        day: 48
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.day:validDate','$.month:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeMultipleFailure2() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 1000000000000000, // Arithmetic overflow for java:Integer
        month: 12,
        day: 48
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.day:validDate','$.year:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintSimpleOnTypeMultipleFailure3() {
    DateConstraintSimpleOnTimeDateType date = {
        year: 1000000000,
        month: 0,
        day: 0
    };
    DateConstraintSimpleOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.day:validDate','$.month:validDate','$.year:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date {
    option: PAST
}
type DateConstraintPastOnTimeDateType time:Date;

@test:Config {}
function testDateConstraintPastOnTypeSuccess1() {
    DateConstraintPastOnTimeDateType date = {
        year: 2018,
        month: 10,
        day: 10
    };
    DateConstraintPastOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintPastOnTypeSuccess2() {
    DateConstraintPastOnTimeDateType date = {
        year: -2018, // BC year
        month: 1,
        day: 1
    };
    DateConstraintPastOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintPastOnTypeSuccess3() {
    time:Utc utcNow = time:utcNow();
    // Decrement by a day
    DateConstraintPastOnTimeDateType date = time:utcToCivil(time:utcAddSeconds(utcNow, -86400));
    DateConstraintPastOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintPastOnTypeFailure1() {
    DateConstraintPastOnTimeDateType date = {
        year: 10000,
        month: 10,
        day: 3
    };
    DateConstraintPastOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintPastOnTypeFailure2() {
    DateConstraintPastOnTimeDateType date = time:utcToCivil(time:utcNow());
    DateConstraintPastOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintPastOnTypeFailure3() {
    time:Utc utcNow = time:utcNow();
    // Increment by a day from today
    DateConstraintPastOnTimeDateType date = time:utcToCivil(time:utcAddSeconds(utcNow, 86640));
    DateConstraintPastOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date {
    option: FUTURE
}
type DateConstraintFutureOnTimeDateType time:Date;

@test:Config {}
function testDateConstraintFutureOnTypeSuccess1() {
    DateConstraintFutureOnTimeDateType date = {
        year: 10000,
        month: 10,
        day: 3
    };
    DateConstraintFutureOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintFutureOnTypeSuccess2() {
    time:Utc utcNow = time:utcNow();
    // Increment by a day from today
    DateConstraintFutureOnTimeDateType date = time:utcToCivil(time:utcAddSeconds(utcNow, 86640));
    DateConstraintFutureOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintFutureOnTypeFailure1() {
    DateConstraintFutureOnTimeDateType date = {
        year: 2018,
        month: 10,
        day: 10
    };
    DateConstraintFutureOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:futureDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintFutureOnTypeFailure2() {
    DateConstraintFutureOnTimeDateType date = time:utcToCivil(time:utcNow());
    DateConstraintFutureOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:futureDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date {
    option: PAST_OR_PRESENT
}
type DateConstraintPastOrPresentOnTimeDateType time:Date;

@test:Config {}
function testDateConstraintPastOrPresentOnTypeSuccess1() {
    DateConstraintPastOrPresentOnTimeDateType date = {
        year: 2018,
        month: 10,
        day: 10
    };
    DateConstraintPastOrPresentOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintPastOrPresentOnTypeSuccess2() {
    DateConstraintPastOrPresentOnTimeDateType date = time:utcToCivil(time:utcNow());
    DateConstraintPastOrPresentOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintPastOrPresentOnTypeFailure1() {
    DateConstraintPastOrPresentOnTimeDateType date = {
        year: 10000,
        month: 1,
        day: 1
    };
    DateConstraintPastOrPresentOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:pastOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateConstraintPastOrPresentOnTypeFailure2() {
    time:Utc utcNow = time:utcNow();
    // Increment by a day from today
    DateConstraintPastOrPresentOnTimeDateType date = time:utcToCivil(time:utcAddSeconds(utcNow, 86640));
    DateConstraintPastOrPresentOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:pastOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date {
    option: FUTURE_OR_PRESENT
}
type DateConstraintFutureOrPresentOnTimeDateType time:Date;

@test:Config {}
function testDateConstraintFutureOrPresentOnTypeSuccess1() {
    DateConstraintFutureOrPresentOnTimeDateType date = {
        year: 10000,
        month: 1,
        day: 1
    };
    DateConstraintFutureOrPresentOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintFutureOrPresentOnTypeSuccess2() {
    DateConstraintFutureOrPresentOnTimeDateType date = time:utcToCivil(time:utcNow());
    DateConstraintFutureOrPresentOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintFutureOrPresentOnTypeSuccess3() {
    time:Utc utcNow = time:utcNow();
    // Increment by a day from today
    DateConstraintFutureOrPresentOnTimeDateType date = time:utcToCivil(time:utcAddSeconds(utcNow, 86640));
    DateConstraintFutureOrPresentOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateConstraintFutureOrPresentOnTypeFailure() {
    DateConstraintFutureOrPresentOnTimeDateType date = {
        year: 2018,
        month: 10,
        day: 10
    };
    DateConstraintFutureOrPresentOnTimeDateType|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:futureOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date
type DateSimple record {|
    int year;
    int month;
    int day;
|};

@test:Config {}
function testDateSimpleSuccess() {
    DateSimple date = {
        year: 2018,
        month: 10,
        day: 10
    };
    DateSimple|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateSimpleFailure() {
    DateSimple date = {
        year: 2018,
        month: 10,
        day: 32
    };
    DateSimple|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.day:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date {
    option: PAST
}
type DatePast record {|
    int year;
    int month;
    int day;
|};

@test:Config {}
function testDatePastSuccess() {
    DatePast date = {
        year: 2018,
        month: 1,
        day: 1
    };
    DatePast|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDatePastFailure() {
    DatePast date = {
        year: 10000,
        month: 10,
        day: 10
    };
    DatePast|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date {
    option: FUTURE
}
type DateFuture record {|
    @Int {
        maxValue: 3000
    }
    int year;
    int month;
    int day;
|};

@test:Config {}
function testDateFutureSuccess() {
    DateFuture date = {
        year: 2500,
        month: 1,
        day: 1
    };
    DateFuture|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDateFutureFailure1() {
    DateFuture date = {
        year: 10000,
        month: 10,
        day: 10
    };
    DateFuture|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.year:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDateFutureFailure2() {
    DateFuture date = {
        year: 2000,
        month: 10,
        day: 10
    };
    DateFuture|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:futureDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date {
    option: PAST_OR_PRESENT
}
type DatePastOrPresent record {
    @Int {
        minValue: 1000
    }
    int year;
    int month;
    int day;
};

@test:Config {}
function testDatePastOrPresentSuccess1() {
    DatePastOrPresent date = time:utcToCivil(time:utcNow());
    DatePastOrPresent|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDatePastOrPresentSuccess2() {
    DatePastOrPresent date = {
        year: 1980,
        month: 1,
        day: 1
    };
    DatePastOrPresent|error validation = validate(date);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, date);
    }
}

@test:Config {}
function testDatePastOrPresentFailure1() {
    DatePastOrPresent date = {
        year: 100,
        month: 10,
        day: 10
    };
    DatePastOrPresent|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.year:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testDatePastOrPresentFailure2() {
    DatePastOrPresent date = {
        year: 3000,
        month: 10,
        day: 10
    };
    DatePastOrPresent|error validation = validate(date);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$:pastOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
