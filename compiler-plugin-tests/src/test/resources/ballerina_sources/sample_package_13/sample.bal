// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import ballerina/constraint;

type Foo record {
    @constraint:Int {
        minValue: 1,
        minValueExclusive: {
            value: 0,
            message: "value should be greater than 0"
        }
    }
    int value1;
    @constraint:Int {
        maxValue: {
            value: 10,
            message: "value should be less than 10"
        },
        maxValueExclusive: 11
    }
    int value2;
};

@constraint:Int {
    minValue: 1,
    minValueExclusive: 0
}
type IntType1 int;

@constraint:Int {
    maxValue: 10,
    maxValueExclusive: 11
}
type IntType2 int;
