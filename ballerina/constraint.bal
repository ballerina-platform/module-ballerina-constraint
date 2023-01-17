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

import ballerina/jballerina.java;

# The annotation, which is used for the constraints of the `int` type.
public annotation IntConstraints Int on type, record field;

# The annotation, which is used for the constraints of the `float` type.
public annotation FloatConstraints Float on type, record field;

# The annotation, which is used for the constraints of the `int`, `float`, and `decimal` types.
public annotation NumberConstraints Number on type, record field;

# The annotation, which is used for the constraints of the `string` type.
public annotation StringConstraints String on type, record field;

# The annotation, which is used for the constraints of the `anydata[]` type.
public annotation ArrayConstraints Array on type, record field;

# Represents the constraints associated with `int` type.
#
# + minValue - The inclusive lower bound of the constrained type
# + maxValue - The inclusive upper bound of the constrained type
# + minValueExclusive - The exclusive lower bound of the constrained type
# + maxValueExclusive - The exclusive upper bound of the constrained type
public type IntConstraints record {|
    int minValue?;
    int maxValue?;
    int minValueExclusive?;
    int maxValueExclusive?;
|};

# Represents the constraints associated with `float` type.
#
# + minValue - The inclusive lower bound of the constrained type
# + maxValue - The inclusive upper bound of the constrained type
# + minValueExclusive - The exclusive lower bound of the constrained type
# + maxValueExclusive - The exclusive upper bound of the constrained type
public type FloatConstraints record {|
    float minValue?;
    float maxValue?;
    float minValueExclusive?;
    float maxValueExclusive?;
|};

# Represents the constraints associated with `int`, `float` and `decimal` types.
#
# + minValue - The inclusive lower bound of the constrained type
# + maxValue - The inclusive upper bound of the constrained type
# + minValueExclusive - The exclusive lower bound of the constrained type
# + maxValueExclusive - The exclusive upper bound of the constrained type
public type NumberConstraints record {|
    decimal minValue?;
    decimal maxValue?;
    decimal minValueExclusive?;
    decimal maxValueExclusive?;
|};

# Represents the constraints associated with `string` type.
#
# + length - The number of characters of the constrained `string` type
# + minLength - The inclusive lower bound of the number of characters of the constrained `string` type
# + maxLength - The inclusive upper bound of the number of characters of the constrained `string` type
# + pattern - The regular expression to be matched with the constrained `string` type
public type StringConstraints record {|
    int length?;
    int minLength?;
    int maxLength?;
    string:RegExp pattern?;
|};

# Represents the constraints associated with `anydata[]` type.
#
# + length - The number of members of the constrained type
# + minLength - The inclusive lower bound of the number of members of the constrained type
# + maxLength - The inclusive upper bound of the number of members of the constrained type
public type ArrayConstraints record {|
    int length?;
    int minLength?;
    int maxLength?;
|};

# Validates the provided value against the configured annotations.
#
# + value - The `anydata` type value to be constrained
# + td - The type descriptor of the value to be constrained
# + return - The type descriptor of the value which is validated or else an `constraint:Error` in case of an error
public isolated function validate(anydata value, typedesc<anydata> td = <>) returns td|Error = @java:Method {
    'class: "io.ballerina.stdlib.constraint.Constraints"
} external;
