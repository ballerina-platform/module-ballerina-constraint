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

type NoNumberConstraintsOnRecordField record {
    decimal value;
};

@test:Config {}
isolated function testNoNumberConstraintsOnRecordField() {
    NoNumberConstraintsOnRecordField rec = {value: 20};
    NoNumberConstraintsOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

type NumberConstraintMinValueOnRecordField record {
    @Number {
        minValue: 18.5
    }
    int intValue;
    @Number {
        minValue: 18.5
    }
    float floatValue;
    @Number {
        minValue: 18.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMinValueOnRecordFieldSuccess1() {
    NumberConstraintMinValueOnRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnRecordFieldSuccess2() {
    NumberConstraintMinValueOnRecordField rec = {intValue: 19, floatValue: 18.5, decimalValue: 18.5d};
    NumberConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnRecordFieldFailure1() {
    NumberConstraintMinValueOnRecordField rec = {intValue: 19, floatValue: 20.5, decimalValue: 16.5d};
    NumberConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnRecordFieldFailure2() {
    NumberConstraintMinValueOnRecordField rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    NumberConstraintMinValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMaxValueOnRecordField record {
    @Number {
        maxValue: 100.5
    }
    int intValue;
    @Number {
        maxValue: 100.5
    }
    float floatValue;
    @Number {
        maxValue: 100.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMaxValueOnRecordFieldSuccess1() {
    NumberConstraintMaxValueOnRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnRecordFieldSuccess2() {
    NumberConstraintMaxValueOnRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    NumberConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnRecordFieldFailure1() {
    NumberConstraintMaxValueOnRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 120.5d};
    NumberConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnRecordFieldFailure2() {
    NumberConstraintMaxValueOnRecordField rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    NumberConstraintMaxValueOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMinValueExclusiveOnRecordField record {
    @Number {
        minValueExclusive: 18.5
    }
    int intValue;
    @Number {
        minValueExclusive: 18.5
    }
    float floatValue;
    @Number {
        minValueExclusive: 18.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnRecordFieldSuccess() {
    NumberConstraintMinValueExclusiveOnRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnRecordFieldFailure1() {
    NumberConstraintMinValueExclusiveOnRecordField rec = {intValue: 20, floatValue: 18.5, decimalValue: 18.5d};
    NumberConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnRecordFieldFailure2() {
    NumberConstraintMinValueExclusiveOnRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 16.5d};
    NumberConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnRecordFieldFailure3() {
    NumberConstraintMinValueExclusiveOnRecordField rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    NumberConstraintMinValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMaxValueExclusiveOnRecordField record {
    @Number {
        maxValueExclusive: 100.5
    }
    int intValue;
    @Number {
        maxValueExclusive: 100.5
    }
    float floatValue;
    @Number {
        maxValueExclusive: 100.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnRecordFieldSuccess() {
    NumberConstraintMaxValueExclusiveOnRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnRecordFieldFailure1() {
    NumberConstraintMaxValueExclusiveOnRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    NumberConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnRecordFieldFailure2() {
    NumberConstraintMaxValueExclusiveOnRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 120.5d};
    NumberConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnRecordFieldFailure3() {
    NumberConstraintMaxValueExclusiveOnRecordField rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    NumberConstraintMaxValueExclusiveOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintOnRecordField record {
    @Number {
        minValue: 18.5,
        maxValue: 100.5
    }
    int intValue;
    @Number {
        minValue: 18.5,
        maxValue: 100.5
    }
    float floatValue;
    @Number {
        minValue: 18.5,
        maxValue: 100.5
    }
    decimal decimalValue;
};

@test:Config {}
isolated function testNumberConstraintOnRecordFieldSuccess1() {
    NumberConstraintOnRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnRecordFieldSuccess2() {
    NumberConstraintOnRecordField rec = {intValue: 19, floatValue: 18.5, decimalValue: 18.5d};
    NumberConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnRecordFieldSuccess3() {
    NumberConstraintOnRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    NumberConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnRecordFieldFailure1() {
    NumberConstraintOnRecordField rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    NumberConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnRecordFieldFailure2() {
    NumberConstraintOnRecordField rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    NumberConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnRecordFieldFailure3() {
    NumberConstraintOnRecordField rec = {intValue: 16, floatValue: 120.5, decimalValue: 16.5d};
    NumberConstraintOnRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue','maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
