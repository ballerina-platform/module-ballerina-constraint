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

type A record {
    @constraint:Int {
        maxValue: 100
    }
    int? value1;
    @constraint:Int {
        maxValue: 100
    }
    int|float value2;
};

type B record {
    @constraint:Float {
        maxValue: 99.9
    }
    float? value1;
    @constraint:Float {
        maxValue: 99.9
    }
    float|int value2;
};

type C record {
    @constraint:Number {
        maxValue: 99.9d
    }
    decimal? value1;
    @constraint:Number {
        maxValue: 99.9d
    }
    decimal|float value2;
    @constraint:Number {
        maxValue: 99.9d
    }
    decimal|float? value3;
    @constraint:Number {
        maxValue: 99.9d
    }
    decimal|float|int value4;
    @constraint:Number {
        maxValue: 99.9d
    }
    decimal|float|int? value5;
};

type D record {
    @constraint:String {
        minLength: 8
    }
    string? value1;
    @constraint:String {
        minLength: 8
    }
    string|int value2;
};

type E record {
    @constraint:Array {
        maxLength: 10
    }
    anydata[]? value1;
    @constraint:Array {
        maxLength: 10
    }
    int[]|float[] value2;
    @constraint:Array {
        maxLength: 10
    }
    int[]|float[]? value3;
};

@constraint:Int {
    maxValue: 100
}
type UnionIntType1 int?;

@constraint:Int {
    maxValue: 100
}
type UnionIntType2 int|float;

@constraint:Float {
    maxValue: 99.9
}
type UnionFloatType1 float?;

@constraint:Float {
    maxValue: 99.9
}
type UnionFloatType2 float|int;

@constraint:Number {
    maxValue: 99.9d
}
type UnionDecimalType1 decimal?;

@constraint:Number {
    maxValue: 99.9d
}
type UnionDecimalType2 decimal|float;

@constraint:Number {
    maxValue: 99.9d
}
type UnionDecimalType3 decimal|float?;

@constraint:Number {
    maxValue: 99.9d
}
type UnionDecimalType4 decimal|float|int;

@constraint:Number {
    maxValue: 99.9d
}
type UnionDecimalType5 decimal|float|int?;

@constraint:String {
    minLength: 8
}
type UnionStringType1 string?;

@constraint:String {
    minLength: 8
}
type UnionStringType2 string|int;

@constraint:Array {
    maxLength: 10
}
type UnionArrayType1 anydata[]?;

@constraint:Array {
    maxLength: 10
}
type UnionArrayType2 int[]|float[];

@constraint:Array {
    maxLength: 10
}
type UnionArrayType3 int[]|float[]?;
