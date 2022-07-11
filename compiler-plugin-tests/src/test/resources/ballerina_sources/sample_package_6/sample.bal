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
    @constraint:Array {
        length: 10
    }
    () n;
    @constraint:Array {
        length: 10
    }
    boolean b;
    @constraint:Array {
        length: 10
    }
    int i;
    @constraint:Array {
        length: 10
    }
    float f;
    @constraint:Array {
        length: 10
    }
    decimal d;
    @constraint:Array {
        length: 10
    }
    string s;
    @constraint:Array {
        length: 10
    }
    xml x;
    @constraint:Array {
        length: 10
    }
    anydata[] a;
    @constraint:Array {
        length: 10
    }
    map<anydata> m;
    @constraint:Array {
        length: 10
    }
    table<map<anydata>> t;
};

@constraint:Array {
    length: 10
}
type NilType ();

@constraint:Array {
    length: 10
}
type BooleanType boolean;

@constraint:Array {
    length: 10
}
type IntType int;

@constraint:Array {
    length: 10
}
type FloatType float;

@constraint:Array {
    length: 10
}
type DecimalType decimal;

@constraint:Array {
    length: 10
}
type StringType string;

@constraint:Array {
    length: 10
}
type XmlType xml;

@constraint:Array {
    length: 10
}
type ArrayType anydata[];

@constraint:Array {
    length: 10
}
type MapType map<anydata>;

@constraint:Array {
    length: 10
}
type TableType table<map<anydata>>;
