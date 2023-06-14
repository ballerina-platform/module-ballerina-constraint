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

string:RegExp regExp = re `[0-9]*`;

@constraint:String {
    length: 10,
    pattern: {
        value: regExp,
        message: "Invalid value"
    }
}
type PhoneNumber string;

@constraint:String {
    pattern:  re `^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$`
}
type MailAddress string;

type User record {|
    string name;
    int age;
    @constraint:String {
        pattern: re `([0-9]{9}[v|V]|[0-9]{12})`
    }
    string nic;
    string address;
    PhoneNumber contactNumber;
    MailAddress email;
|};

type Foo record {
    @constraint:String {
        length: 10
    }
    () n;
    @constraint:String {
        length: 10
    }
    boolean b;
    @constraint:String {
        length: 10
    }
    int i;
    @constraint:String {
        length: 10
    }
    float f;
    @constraint:String {
        length: 10
    }
    decimal d;
    @constraint:String {
        length: 10
    }
    string s;
    @constraint:String {
        length: 10
    }
    xml x;
    @constraint:String {
        length: 10
    }
    anydata[] a;
    @constraint:String {
        length: 10
    }
    map<anydata> m;
    @constraint:String {
        length: 10
    }
    table<map<anydata>> t;
};

@constraint:String {
    length: 10
}
type NilType ();

@constraint:String {
    length: 10
}
type BooleanType boolean;

@constraint:String {
    length: 10
}
type IntType int;

@constraint:String {
    length: 10
}
type FloatType float;

@constraint:String {
    length: 10
}
type DecimalType decimal;

@constraint:String {
    length: {
        value: 10,
        message: "Invalid length"
    }
}
type StringType string;

@constraint:String {
    length: 10
}
type XmlType xml;

@constraint:String {
    length: 10
}
type ArrayType anydata[];

@constraint:String {
    length: 10
}
type MapType map<anydata>;

@constraint:String {
    length: 10
}
type TableType table<map<anydata>>;
