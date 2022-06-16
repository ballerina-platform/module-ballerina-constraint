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

type NoNumberConstraintsOnType decimal;

@test:Config {}
isolated function testNoNumberConstraintsOnType() {
    NoNumberConstraintsOnType typ = 20;
    NoNumberConstraintsOnType|error validation = validate(typ);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@Number {
    minValue: 18.5
}
type NumberConstraintMinValueOnIntType int;

@Number {
    minValue: 18.5
}
type NumberConstraintMinValueOnFloatType float;

@Number {
    minValue: 18.5
}
type NumberConstraintMinValueOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeSuccess1() {
    NumberConstraintMinValueOnIntType typInt = 20;
    NumberConstraintMinValueOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueOnFloatType typFloat = 20.5;
    NumberConstraintMinValueOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueOnDecimalType typDecimal = 20.5d;
    NumberConstraintMinValueOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeSuccess2() {
    NumberConstraintMinValueOnIntType typInt = 19;
    NumberConstraintMinValueOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueOnFloatType typFloat = 18.5;
    NumberConstraintMinValueOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueOnDecimalType typDecimal = 18.5d;
    NumberConstraintMinValueOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeFailure1() {
    NumberConstraintMinValueOnIntType typ = 18;
    NumberConstraintMinValueOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeFailure2() {
    NumberConstraintMinValueOnFloatType typ = 16.5;
    NumberConstraintMinValueOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueOnTypeFailure3() {
    NumberConstraintMinValueOnDecimalType typ = 16.5d;
    NumberConstraintMinValueOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    maxValue: 100.5
}
type NumberConstraintMaxValueOnIntType int;

@Number {
    maxValue: 100.5
}
type NumberConstraintMaxValueOnFloatType float;

@Number {
    maxValue: 100.5
}
type NumberConstraintMaxValueOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeSuccess1() {
    NumberConstraintMaxValueOnIntType typInt = 20;
    NumberConstraintMaxValueOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueOnFloatType typFloat = 20.5;
    NumberConstraintMaxValueOnIntType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueOnDecimalType typDecimal = 20.5d;
    NumberConstraintMaxValueOnIntType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeSuccess2() {
    NumberConstraintMaxValueOnIntType typInt = 100;
    NumberConstraintMaxValueOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueOnFloatType typFloat = 100.5;
    NumberConstraintMaxValueOnIntType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueOnDecimalType typDecimal = 100.5d;
    NumberConstraintMaxValueOnIntType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeFailure1() {
    NumberConstraintMaxValueOnIntType typ = 101;
    NumberConstraintMaxValueOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}


@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeFailure2() {
    NumberConstraintMaxValueOnFloatType typ = 101;
    NumberConstraintMaxValueOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueOnTypeFailure3() {
    NumberConstraintMaxValueOnDecimalType typ = 101;
    NumberConstraintMaxValueOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    minValueExclusive: 18.5
}
type NumberConstraintMinValueExclusiveOnIntType int;

@Number {
    minValueExclusive: 18.5
}
type NumberConstraintMinValueExclusiveOnFloatType float;

@Number {
    minValueExclusive: 18.5
}
type NumberConstraintMinValueExclusiveOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeSuccess() {
    NumberConstraintMinValueExclusiveOnIntType typInt = 20;
    NumberConstraintMinValueExclusiveOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueExclusiveOnFloatType typFloat = 20.5;
    NumberConstraintMinValueExclusiveOnIntType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMinValueExclusiveOnDecimalType typDecimal = 20.5d;
    NumberConstraintMinValueExclusiveOnIntType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeFailure1() {
    NumberConstraintMinValueExclusiveOnIntType typ = 18;
    NumberConstraintMinValueExclusiveOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeFailure2() {
    NumberConstraintMinValueExclusiveOnFloatType typ = 18.5;
    NumberConstraintMinValueExclusiveOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMinValueExclusiveOnTypeFailure3() {
    NumberConstraintMinValueExclusiveOnDecimalType typ = 18.5d;
    NumberConstraintMinValueExclusiveOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    maxValueExclusive: 100.5
}
type NumberConstraintMaxValueExclusiveOnIntType int;

@Number {
    maxValueExclusive: 100.5
}
type NumberConstraintMaxValueExclusiveOnFloatType float;

@Number {
    maxValueExclusive: 100.5
}
type NumberConstraintMaxValueExclusiveOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeSuccess() {
    NumberConstraintMaxValueExclusiveOnIntType typInt = 20;
    NumberConstraintMaxValueExclusiveOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueExclusiveOnFloatType typFloat = 20.5;
    NumberConstraintMaxValueExclusiveOnIntType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintMaxValueExclusiveOnDecimalType typDecimal = 20.5d;
    NumberConstraintMaxValueExclusiveOnIntType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeFailure1() {
    NumberConstraintMaxValueExclusiveOnIntType typ = 101;
    NumberConstraintMaxValueExclusiveOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeFailure2() {
    NumberConstraintMaxValueExclusiveOnFloatType typ = 100.5;
    NumberConstraintMaxValueExclusiveOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintMaxValueExclusiveOnTypeFailure3() {
    NumberConstraintMaxValueExclusiveOnDecimalType typ = 100.5d;
    NumberConstraintMaxValueExclusiveOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    minValue: 18.5,
    maxValue: 100.5
}
type NumberConstraintOnIntType int;

@Number {
    minValue: 18.5,
    maxValue: 100.5
}
type NumberConstraintOnFloatType float;

@Number {
    minValue: 18.5,
    maxValue: 100.5
}
type NumberConstraintOnDecimalType decimal;

@test:Config {}
isolated function testNumberConstraintOnTypeSuccess1() {
    NumberConstraintOnIntType typInt = 20;
    NumberConstraintOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnFloatType typFloat = 20.5;
    NumberConstraintOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnDecimalType typDecimal = 20.5d;
    NumberConstraintOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeSuccess2() {
    NumberConstraintOnIntType typInt = 19;
    NumberConstraintOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnFloatType typFloat = 18.5;
    NumberConstraintOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnDecimalType typDecimal = 18.5d;
    NumberConstraintOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeSuccess3() {
    NumberConstraintOnIntType typInt = 100;
    NumberConstraintOnIntType|error validationInt = validate(typInt);
    if validationInt is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnFloatType typFloat = 100.5;
    NumberConstraintOnFloatType|error validationFloat = validate(typFloat);
    if validationFloat is error {
        test:assertFail("Unexpected error found.");
    }
    NumberConstraintOnDecimalType typDecimal = 100.5d;
    NumberConstraintOnDecimalType|error validationDecimal = validate(typDecimal);
    if validationDecimal is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure1() {
    NumberConstraintOnIntType typ = 18;
    NumberConstraintOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure2() {
    NumberConstraintOnFloatType typ = 16.5;
    NumberConstraintOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure3() {
    NumberConstraintOnDecimalType typ = 16.5d;
    NumberConstraintOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure4() {
    NumberConstraintOnIntType typ = 101;
    NumberConstraintOnIntType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure5() {
    NumberConstraintOnFloatType typ = 101.5;
    NumberConstraintOnFloatType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testNumberConstraintOnTypeFailure6() {
    NumberConstraintOnDecimalType typ = 101.5d;
    NumberConstraintOnDecimalType|error validation = validate(typ);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Number {
    minValue: 18.5d
}
type NumberConstraintOnUnionIntFloatType int|float;

@Number {
    maxValue: 100.5d
}
type NumberConstraintOnUnionIntDecimalType int|decimal;

@Number {
    minValueExclusive: 18.5d
}
type NumberConstraintOnUnionFloatDecimalType float|decimal;

@Number {
    maxValueExclusive: 100.5d
}
type NumberConstraintOnUnionIntFloatDecimalType int|float|decimal;

// TODO: Disabled due to https://github.com/ballerina-platform/ballerina-lang/issues/36543

//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeSuccess1() {
//    NumberConstraintOnUnionIntFloatType typIntFloat = 20;
//    NumberConstraintOnUnionIntFloatType|error validationIntFloat = validate(typIntFloat);
//    if validationIntFloat is error {
//        test:assertFail("Unexpected error found.");
//    }
//    NumberConstraintOnUnionIntDecimalType typIntDecimal = 100;
//    NumberConstraintOnUnionIntFloatType|error validationIntDecimal = validate(typIntDecimal);
//    if validationIntDecimal is error {
//        test:assertFail("Unexpected error found.");
//    }
//    NumberConstraintOnUnionFloatDecimalType typFloatDecimal = 20.5;
//    NumberConstraintOnUnionIntFloatType|error validationFloatDecimal = validate(typFloatDecimal);
//    if validationFloatDecimal is error {
//        test:assertFail("Unexpected error found.");
//    }
//    NumberConstraintOnUnionIntFloatDecimalType typIntFloatDecimal = 100;
//    NumberConstraintOnUnionIntFloatType|error validationIntFloatDecimal = validate(typIntFloatDecimal);
//    if validationIntFloatDecimal is error {
//        test:assertFail("Unexpected error found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeSuccess2() {
//    NumberConstraintOnUnionIntFloatType typIntFloat = 20.5;
//    NumberConstraintOnUnionIntFloatType|error validationIntFloat = validate(typIntFloat);
//    if validationIntFloat is error {
//        test:assertFail("Unexpected error found.");
//    }
//    NumberConstraintOnUnionIntDecimalType typIntDecimal = 100.5d;
//    NumberConstraintOnUnionIntFloatType|error validationIntDecimal = validate(typIntDecimal);
//    if validationIntDecimal is error {
//        test:assertFail("Unexpected error found.");
//    }
//    NumberConstraintOnUnionFloatDecimalType typFloatDecimal = 20.5d;
//    NumberConstraintOnUnionIntFloatType|error validationFloatDecimal = validate(typFloatDecimal);
//    if validationFloatDecimal is error {
//        test:assertFail("Unexpected error found.");
//    }
//    NumberConstraintOnUnionIntFloatDecimalType typIntFloatDecimal = 99.5d;
//    NumberConstraintOnUnionIntFloatType|error validationIntFloatDecimal = validate(typIntFloatDecimal);
//    if validationIntFloatDecimal is error {
//        test:assertFail("Unexpected error found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeFailure1() {
//    NumberConstraintOnUnionIntFloatType typ = 16;
//    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
//    if validation is error {
//        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
//    } else {
//        test:assertFail("Expected error not found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeFailure2() {
//    NumberConstraintOnUnionIntDecimalType typ = 120;
//    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
//    if validation is error {
//        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
//    } else {
//        test:assertFail("Expected error not found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeFailure3() {
//    NumberConstraintOnUnionFloatDecimalType typ = 16.5;
//    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
//    if validation is error {
//        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
//    } else {
//        test:assertFail("Expected error not found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeFailure4() {
//    NumberConstraintOnUnionIntFloatDecimalType typ = 120;
//    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
//    if validation is error {
//        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
//    } else {
//        test:assertFail("Expected error not found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeFailure5() {
//    NumberConstraintOnUnionIntFloatType typ = 16.5;
//    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
//    if validation is error {
//        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
//    } else {
//        test:assertFail("Expected error not found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeFailure6() {
//    NumberConstraintOnUnionIntDecimalType typ = 120.5d;
//    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
//    if validation is error {
//        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
//    } else {
//        test:assertFail("Expected error not found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeFailure7() {
//    NumberConstraintOnUnionFloatDecimalType typ = 18.5d;
//    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
//    if validation is error {
//        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
//    } else {
//        test:assertFail("Expected error not found.");
//    }
//}
//
//@test:Config {}
//isolated function testNumberConstraintOnUnionTypeFailure8() {
//    NumberConstraintOnUnionIntFloatDecimalType typ = 100.5d;
//    NumberConstraintOnUnionIntFloatType|error validation = validate(typ);
//    if validation is error {
//        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
//    } else {
//        test:assertFail("Expected error not found.");
//    }
//}
