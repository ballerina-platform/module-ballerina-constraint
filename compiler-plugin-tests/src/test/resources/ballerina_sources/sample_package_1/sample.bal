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

type BankAccount record {
    @constraint:String {
        minLength: 5,
        maxLength: 8
    }
    string name;
    string number;
    @constraint:Number {
        maxValue: 50
    }
    @constraint:Int {
        minValue: 0
    }
    int age;
    @constraint:Float {
        minValue: 0
    }
    float amount;
    @constraint:Number {
        minValue: 0,
        maxValue: 1
    }
    decimal interest;
    @constraint:Array {
        maxLength: 10
    }
    float[] last10Transactions;
};

@constraint:String {
    minLength: 5,
    maxLength: 8
}
type AccountName string;

@constraint:Number {
    maxValue: 50
}
@constraint:Int {
    minValue: 0
}
type AccountAge int;

@constraint:Float {
    minValue: 0
}
type AccountAmount float;

@constraint:Number {
    minValue: 0,
    maxValue: 1
}
type AccountInterest decimal;

@constraint:Array {
    maxLength: 10
}
type AccountLast10Transactions float[];

int a = 5;

function getA() returns int {
    return a;
}

@constraint:String {
     length: a
}
type StringA string;

@constraint:Int {
    minValue: getA()
}
type IntA int;

@constraint:String {
    minLength: 2
}
type Name string;

@constraint:String {
    maxLength: 10
}
type NickName Name;

@constraint:Int {
    maxValue: 1000
}
type Id int:Signed32;

type FullName record {|
    @constraint:String {
        maxLength: 20
    }
    Name firstName;
    Name lastName;
|};

type UserNew record {
    @constraint:Int {
        minValue: 1
    }
    int:Signed32 id;
    FullName name;
    @constraint:String {
        minLength: 2
    }
    Name nickName?; 
    int age;
};
