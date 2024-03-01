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

type NoDateConstraintsOnRecordField record {
    string name;
    time:Date dob;
};

@test:Config {}
isolated function testNoDateConstraintsOnRecordField() {
    NoDateConstraintsOnRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 1,
            day: 1
        }
    };
    NoDateConstraintsOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }

    rec.dob.month = 13;
    validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }

    rec.dob.day = 31;
    rec.dob.month = 11;
    validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }

    rec.dob.year = 2025;
    rec.dob.day = 3;
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type SimpleDateConstraintOnRecordField record {
    string name;
    @Date
    time:Date dob;
};

@test:Config {}
isolated function testSimpleDateConstraintOnRecordFieldSuccess1() {
    SimpleDateConstraintOnRecordField rec = {
        name: "John",
        dob: {
            year: 2029,
            month: 1,
            day: 1
        }
    };
    SimpleDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testSimpleDateConstraintOnRecordFieldSuccess2() {
    SimpleDateConstraintOnRecordField rec = {
        name: "Alexander the Great",
        dob: {
            year: -357,
            month: 6,
            day: 21
        }
    };
    SimpleDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testSimpleDateConstraintOnRecordFieldSuccess3() {
    SimpleDateConstraintOnRecordField rec = {
        name: "Alex",
        dob: time:utcToCivil(time:utcNow())
    };
    SimpleDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testSimpleDateConstraintOnRecordFieldFailure1() {
    SimpleDateConstraintOnRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 13,
            day: 32
        }
    };
    SimpleDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.day:validDate','$.dob.month:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSimpleDateConstraintOnRecordFieldFailure2() {
    SimpleDateConstraintOnRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 2,
            day: 29
        }
    };
    SimpleDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.day:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type PastDateConstraintOnRecordField record {
    string name;
    @Date {
        option: PAST
    }
    time:Date dob;
};

@test:Config {}
isolated function testPastDateConstraintOnRecordFieldSuccess1() {
    PastDateConstraintOnRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 1,
            day: 1
        }
    };
    PastDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testPastDateConstraintOnRecordFieldSuccess2() {
    PastDateConstraintOnRecordField rec = {
        name: "Alexander the Great",
        dob: {
            year: -357,
            month: 6,
            day: 21
        }
    };
    PastDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testPastDateConstraintOnRecordFieldFailure1() {
    PastDateConstraintOnRecordField rec = {
        name: "John",
        dob: time:utcToCivil(time:utcNow())
    };
    PastDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testPastDateConstraintOnRecordFieldFailure2() {
    PastDateConstraintOnRecordField rec = {
        name: "John",
        dob: {
            year: 10000,
            month: 1,
            day: 1
        }
    };
    PastDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FutureOrPresentDateConstraintOnRecordField record {
    string name;
    @Date {
        option: FUTURE_OR_PRESENT
    }
    time:Date dob;
};

@test:Config {}
isolated function testFutureOrPresentDateConstraintOnRecordFieldSuccess1() {
    FutureOrPresentDateConstraintOnRecordField rec = {
        name: "John",
        dob: time:utcToCivil(time:utcNow())
    };
    FutureOrPresentDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testFutureOrPresentDateConstraintOnRecordFieldSuccess2() {
    FutureOrPresentDateConstraintOnRecordField rec = {
        name: "Alex",
        dob: {
            year: 10000,
            month: 1,
            day: 1
        }
    };
    FutureOrPresentDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testFutureOrPresentDateConstraintOnRecordFieldFailure1() {
    FutureOrPresentDateConstraintOnRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 1,
            day: 1
        }
    };
    FutureOrPresentDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:futureOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFutureOrPresentDateConstraintOnRecordFieldFailure2() {
    FutureOrPresentDateConstraintOnRecordField rec = {
        name: "Alexander the Great",
        dob: {
            year: -357,
            month: 6,
            day: 21
        }
    };
    FutureOrPresentDateConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:futureOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type DateConstraintOnRecordRecordField record {
    string name;
    @Date {
        option: PAST_OR_PRESENT
    }
    record {|
        @Int {
            minValue: 1900
        }
        int year;
        int month;
        int day;
    |} dob;
};

@test:Config {}
isolated function testDateConstraintOnRecordRecordFieldSuccess1() {
    DateConstraintOnRecordRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 2,
            day: 28
        }
    };
    DateConstraintOnRecordRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testDateConstraintOnRecordRecordFieldSuccess2() {
    time:Date today = time:utcToCivil(time:utcNow());
    DateConstraintOnRecordRecordField rec = {
        name: "Alexander the Great",
        dob: {
            year: today.year,
            month: today.month,
            day: today.day
        }
    };
    DateConstraintOnRecordRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testDateConstraintOnRecordRecordFieldFailure1() {
    DateConstraintOnRecordRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 2,
            day: 29
        }
    };
    DateConstraintOnRecordRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.day:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnRecordRecordFieldFailure2() {
    DateConstraintOnRecordRecordField rec = {
        name: "Alex",
        dob: {
            year: 10000,
            month: 2,
            day: 2
        }
    };
    DateConstraintOnRecordRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:pastOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnRecordRecordFieldFailure3() {
    DateConstraintOnRecordRecordField rec = {
        name: "George",
        dob: {
            year: 1880,
            month: 6,
            day: 21
        }
    };
    DateConstraintOnRecordRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.year:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnRecordRecordFieldFailure4() {
    DateConstraintOnRecordRecordField rec = {
        name: "David",
        dob: {
            year: 1898,
            month: 13,
            day: 32
        }
    };
    DateConstraintOnRecordRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.day:validDate','$.dob.month:validDate','$.dob.year:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type CustomDate record {
    int year;
    int month;
    int day;
};

type DateConstraintOnTypedRecordField record {
    string name;
    @Date {
        option: PAST
    }
    CustomDate dob;
};

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldSuccess1() {
    DateConstraintOnTypedRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 2,
            day: 28
        }
    };
    DateConstraintOnTypedRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldSuccess2() {
    time:Date yesterday = time:utcToCivil(time:utcAddSeconds(time:utcNow(), -86400));
    DateConstraintOnTypedRecordField rec = {
        name: "Alex",
        dob: yesterday
    };
    DateConstraintOnTypedRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldFailure1() {
    DateConstraintOnTypedRecordField rec = {
        name: "John",
        dob: {
            year: 2019,
            month: 2,
            day: 29
        }
    };
    DateConstraintOnTypedRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.day:validDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldFailure2() {
    DateConstraintOnTypedRecordField rec = {
        name: "Alex",
        dob: {
            year: 10000,
            month: 2,
            day: 2
        }
    };
    DateConstraintOnTypedRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldFailure3() {
    time:Date tomorrow = time:utcToCivil(time:utcAddSeconds(time:utcNow(), 86400));
    DateConstraintOnTypedRecordField rec = {
        name: "George",
        dob: tomorrow
    };
    DateConstraintOnTypedRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldFailure4() {
    time:Date today = time:utcToCivil(time:utcNow());
    DateConstraintOnTypedRecordField rec = {
        name: "David",
        dob: today
    };
    DateConstraintOnTypedRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:pastDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Date
type CustomValidDate record {
    @Int {
        minValue: 1980,
        maxValue: 3000
    }
    int year;
    int month;
    int day;
};

type DateConstraintOnTypedRecordFieldWithCustomValidDate record {
    string name;
    @Date {
        option: PAST_OR_PRESENT
    }
    CustomValidDate dob;
};

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldWithCustomValidDateSuccess() {
    DateConstraintOnTypedRecordFieldWithCustomValidDate rec = {
        name: "John",
        dob: {
            year: 2020,
            month: 2,
            day: 29
        }
    };
    DateConstraintOnTypedRecordFieldWithCustomValidDate|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldWithCustomValidDateFailure1() {
    DateConstraintOnTypedRecordFieldWithCustomValidDate rec = {
        name: "John",
        dob: {
            year: 1979,
            month: 2,
            day: 29
        }
    };
    DateConstraintOnTypedRecordFieldWithCustomValidDate|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.day:validDate','$.dob.day:validDate','$.dob.year:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldWithCustomValidDateFailure2() {
    DateConstraintOnTypedRecordFieldWithCustomValidDate rec = {
        name: "John",
        dob: {
            year: 1975,
            month: 2,
            day: 2
        }
    };
    DateConstraintOnTypedRecordFieldWithCustomValidDate|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.year:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldWithCustomValidDateFailure3() {
    time:Date tomorrow = time:utcToCivil(time:utcAddSeconds(time:utcNow(), 86400));
    DateConstraintOnTypedRecordFieldWithCustomValidDate rec = {
        name: "John",
        dob: tomorrow
    };
    DateConstraintOnTypedRecordFieldWithCustomValidDate|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob:pastOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testDateConstraintOnTypedRecordFieldWithCustomValidDateFailure4() {
    DateConstraintOnTypedRecordFieldWithCustomValidDate rec = {
        name: "John",
        dob: {
            year: 10000,
            month: 2,
            day: 29
        }
    };
    DateConstraintOnTypedRecordFieldWithCustomValidDate|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.dob.year:maxValue','$.dob:pastOrPresentDate' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
