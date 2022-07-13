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

type NoNumberConstraintsOnTypeAsRecordField record {
    NoNumberConstraintsOnType value;
};

@test:Config {}
isolated function testNoNumberConstraintsOnTypeAsRecordField() {
    NoNumberConstraintsOnTypeAsRecordField rec = {value: 20};
    NoNumberConstraintsOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    } else {
        test:assertEquals(validation, rec);
    }
}

type NumberConstraintMinValueOnTypeAsRecordField record {
    NumberConstraintMinValueOnIntType intValue;
    NumberConstraintMinValueOnFloatType floatValue;
    NumberConstraintMinValueOnDecimalType decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeAsRecordFieldSuccess1() {
    NumberConstraintMinValueOnTypeAsRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeAsRecordFieldSuccess2() {
    NumberConstraintMinValueOnTypeAsRecordField rec = {intValue: 19, floatValue: 18.5, decimalValue: 18.5d};
    NumberConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeAsRecordFieldFailure1() {
    NumberConstraintMinValueOnTypeAsRecordField rec = {intValue: 19, floatValue: 20.5, decimalValue: 16.5d};
    NumberConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeAsRecordFieldFailure2() {
    NumberConstraintMinValueOnTypeAsRecordField rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    NumberConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMaxValueOnTypeAsRecordField record {
    NumberConstraintMaxValueOnIntType intValue;
    NumberConstraintMaxValueOnFloatType floatValue;
    NumberConstraintMaxValueOnDecimalType decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeAsRecordFieldSuccess1() {
    NumberConstraintMaxValueOnTypeAsRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeAsRecordFieldSuccess2() {
    NumberConstraintMaxValueOnTypeAsRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    NumberConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeAsRecordFieldFailure1() {
    NumberConstraintMaxValueOnTypeAsRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 120.5d};
    NumberConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeAsRecordFieldFailure2() {
    NumberConstraintMaxValueOnTypeAsRecordField rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    NumberConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMinValueExclusiveOnTypeAsRecordField record {
    NumberConstraintMinValueExclusiveOnIntType intValue;
    NumberConstraintMinValueExclusiveOnFloatType floatValue;
    NumberConstraintMinValueExclusiveOnDecimalType decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeAsRecordFieldSuccess() {
    NumberConstraintMinValueExclusiveOnTypeAsRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeAsRecordFieldFailure1() {
    NumberConstraintMinValueExclusiveOnTypeAsRecordField rec = {intValue: 20, floatValue: 18.5, decimalValue: 18.5d};
    NumberConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeAsRecordFieldFailure2() {
    NumberConstraintMinValueExclusiveOnTypeAsRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 16.5d};
    NumberConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeAsRecordFieldFailure3() {
    NumberConstraintMinValueExclusiveOnTypeAsRecordField rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    NumberConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintMaxValueExclusiveOnTypeAsRecordField record {
    NumberConstraintMaxValueExclusiveOnIntType intValue;
    NumberConstraintMaxValueExclusiveOnFloatType floatValue;
    NumberConstraintMaxValueExclusiveOnDecimalType decimalValue;
};

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeAsRecordFieldSuccess() {
    NumberConstraintMaxValueExclusiveOnTypeAsRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeAsRecordFieldFailure1() {
    NumberConstraintMaxValueExclusiveOnTypeAsRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    NumberConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeAsRecordFieldFailure2() {
    NumberConstraintMaxValueExclusiveOnTypeAsRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 120.5d};
    NumberConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeAsRecordFieldFailure3() {
    NumberConstraintMaxValueExclusiveOnTypeAsRecordField rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    NumberConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintOnTypeAsRecordField record {
    NumberConstraintOnIntType intValue;
    NumberConstraintOnFloatType floatValue;
    NumberConstraintOnDecimalType decimalValue;
};

@test:Config {}
isolated function testNumberConstraintOnTypeAsRecordFieldSuccess1() {
    NumberConstraintOnTypeAsRecordField rec = {intValue: 20, floatValue: 20.5, decimalValue: 20.5d};
    NumberConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeAsRecordFieldSuccess2() {
    NumberConstraintOnTypeAsRecordField rec = {intValue: 19, floatValue: 18.5, decimalValue: 18.5d};
    NumberConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeAsRecordFieldSuccess3() {
    NumberConstraintOnTypeAsRecordField rec = {intValue: 100, floatValue: 100.5, decimalValue: 100.5d};
    NumberConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeAsRecordFieldFailure1() {
    NumberConstraintOnTypeAsRecordField rec = {intValue: 16, floatValue: 16.5, decimalValue: 16.5d};
    NumberConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeAsRecordFieldFailure2() {
    NumberConstraintOnTypeAsRecordField rec = {intValue: 120, floatValue: 120.5, decimalValue: 120.5d};
    NumberConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeAsRecordFieldFailure3() {
    NumberConstraintOnTypeAsRecordField rec = {intValue: 16, floatValue: 120.5, decimalValue: 16.5d};
    NumberConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue','maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type NumberConstraintOnUnionTypeAsRecordField record {|
    NumberConstraintOnUnionIntFloatType intFloatValue;
    NumberConstraintOnUnionIntDecimalType intDecimalValue;
    NumberConstraintOnUnionFloatDecimalType floatDecimalValue;
    NumberConstraintOnUnionIntFloatDecimalType intFloatDecimalValue;
|};

// TODO: Following test cases are disabled due to https://github.com/ballerina-platform/ballerina-lang/issues/36543

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldSuccess1() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 20, intDecimalValue: 100, floatDecimalValue: 20.5, intFloatDecimalValue: 100};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldSuccess2() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 20.5, intDecimalValue: 100.5d, floatDecimalValue: 20.5d, intFloatDecimalValue: 99.5d};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldFailure1() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 16, intDecimalValue: 100, floatDecimalValue: 20.5, intFloatDecimalValue: 100};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldFailure2() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 20, intDecimalValue: 120, floatDecimalValue: 20.5, intFloatDecimalValue: 100};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldFailure3() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 20, intDecimalValue: 20, floatDecimalValue: 16.5, intFloatDecimalValue: 100};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldFailure4() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 20, intDecimalValue: 20, floatDecimalValue: 20.5, intFloatDecimalValue: 120};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldFailure5() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 16.5, intDecimalValue: 100.5d, floatDecimalValue: 20.5d, intFloatDecimalValue: 99.5d};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldFailure6() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 20.5, intDecimalValue: 120.5d, floatDecimalValue: 20.5d, intFloatDecimalValue: 99.5d};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldFailure7() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 20.5, intDecimalValue: 100.5d, floatDecimalValue: 18.5d, intFloatDecimalValue: 99.5d};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {enable: false}
isolated function testNumberConstraintOnUnionTypeAsRecordFieldFailure8() {
    NumberConstraintOnUnionTypeAsRecordField rec = {intFloatValue: 20.5, intDecimalValue: 100.5d, floatDecimalValue: 20.5d, intFloatDecimalValue: 100.5d};
    NumberConstraintOnUnionTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
