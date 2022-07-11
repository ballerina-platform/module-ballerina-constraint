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

type NoFloatConstraintsOnTypeAsRecordField record {
    NoFloatConstraintsOnType value;
};

@test:Config {}
isolated function testNoFloatConstraintsOnTypeAsRecordField() {
    NoFloatConstraintsOnTypeAsRecordField rec = {value: 20.5};
    NoFloatConstraintsOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

type FloatConstraintMinValueOnTypeAsRecordField record {
    FloatConstraintMinValueOnType value;
};

@test:Config {}
isolated function testFloatConstraintMinValueOnTypeAsRecordFieldSuccess1() {
    FloatConstraintMinValueOnTypeAsRecordField rec = {value: 20.5};
    FloatConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueOnTypeAsRecordFieldSuccess2() {
    FloatConstraintMinValueOnTypeAsRecordField rec = {value: 18.5};
    FloatConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueOnTypeAsRecordFieldFailure() {
    FloatConstraintMinValueOnTypeAsRecordField rec = {value: 16.5};
    FloatConstraintMinValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMaxValueOnTypeAsRecordField record {
    FloatConstraintMaxValueOnType value;
};

@test:Config {}
isolated function testFloatConstraintMaxValueOnTypeAsRecordFieldSuccess1() {
    FloatConstraintMaxValueOnTypeAsRecordField rec = {value: 20.5};
    FloatConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueOnTypeAsRecordFieldSuccess2() {
    FloatConstraintMaxValueOnTypeAsRecordField rec = {value: 100.5};
    FloatConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueOnTypeAsRecordFieldFailure() {
    FloatConstraintMaxValueOnTypeAsRecordField rec = {value: 120.5};
    FloatConstraintMaxValueOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMinValueExclusiveOnTypeAsRecordField record {
    FloatConstraintMinValueExclusiveOnType value;
};

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnTypeAsRecordFieldSuccess() {
    FloatConstraintMinValueExclusiveOnTypeAsRecordField rec = {value: 20.5};
    FloatConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnTypeAsRecordFieldFailure1() {
    FloatConstraintMinValueExclusiveOnTypeAsRecordField rec = {value: 18.5};
    FloatConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMinValueExclusiveOnTypeAsRecordFieldFailure2() {
    FloatConstraintMinValueExclusiveOnTypeAsRecordField rec = {value: 16.5};
    FloatConstraintMinValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintMaxValueExclusiveOnTypeAsRecordField record {
    FloatConstraintMaxValueExclusiveOnType value;
};

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnTypeAsRecordFieldSuccess() {
    FloatConstraintMaxValueExclusiveOnTypeAsRecordField rec = {value: 20.5};
    FloatConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnTypeAsRecordFieldFailure1() {
    FloatConstraintMaxValueExclusiveOnTypeAsRecordField rec = {value: 100.5};
    FloatConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintMaxValueExclusiveOnTypeAsRecordFieldFailure2() {
    FloatConstraintMaxValueExclusiveOnTypeAsRecordField rec = {value: 120.5};
    FloatConstraintMaxValueExclusiveOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type FloatConstraintOnTypeAsRecordField record {
    FloatConstraintOnType value;
};

@test:Config {}
isolated function testFloatConstraintOnTypeAsRecordFieldSuccess1() {
    FloatConstraintOnTypeAsRecordField rec = {value: 20.5};
    FloatConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeAsRecordFieldSuccess2() {
    FloatConstraintOnTypeAsRecordField rec = {value: 18.5};
    FloatConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeAsRecordFieldSuccess3() {
    FloatConstraintOnTypeAsRecordField rec = {value: 100.5};
    FloatConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeAsRecordFieldFailure1() {
    FloatConstraintOnTypeAsRecordField rec = {value: 16.5};
    FloatConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testFloatConstraintOnTypeAsRecordFieldFailure2() {
    FloatConstraintOnTypeAsRecordField rec = {value: 120.5};
    FloatConstraintOnTypeAsRecordField|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for 'maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
