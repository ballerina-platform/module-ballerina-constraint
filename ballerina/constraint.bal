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

public annotation IntConstraints Int on record field;
public annotation FloatConstraints Float on record field;
public annotation NumberConstraints Number on record field;
public annotation StringConstraints String on record field;
public annotation ArrayConstraints Array on record field;

// invalid combinations (compiler plugin validations):
// 1. minValue + minValueExclusive
// 2. maxValue + maxValueExclusive
public type IntConstraints record {|
   int minValue?;
   int maxValue?;
   int minValueExclusive?;
   int maxValueExclusive?;
|};

public type FloatConstraints record {|
   float minValue?;
   float maxValue?;
   float minValueExclusive?;
   float maxValueExclusive?;
|};

public type NumberConstraints record {|
   decimal minValue?;
   decimal maxValue?;
   decimal minValueExclusive?;
   decimal maxValueExclusive?;
|};

// invalid combinations (compiler plugin validations):
// 1. length + minLength
// 2. length + maxLength
// 3. length + minLength + maxLength
public type StringConstraints record {|
   int length?;
   int minLength?;
   int maxLength?;
|};

public type ArrayConstraints record {|
   int length?;
   int minLength?;
   int maxLength?;
|};

public isolated function validate(anydata value, typedesc<anydata> td = <>) returns td|Error = @java:Method {
    'class: "io.ballerina.stdlib.constraint.Constraints"
} external;
