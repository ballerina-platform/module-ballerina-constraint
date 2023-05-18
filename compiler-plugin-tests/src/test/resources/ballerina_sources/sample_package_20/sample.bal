// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
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
import ballerina/time;

// Valid cases

@constraint:Date
type Date1 time:Date;

@constraint:Date {}
type Date2 time:Date;

@constraint:Date {
}
type Date3 Date1;

@constraint:Date
type Date4 record {
    int year;
    int month;
    int day;
};

@constraint:Date {}
type Date5 record {|
    int year;
    int month;
    int day;
|};

@constraint:Date { option: constraint:PAST }
type Date6 record {|
    int year;
    int month;
    int day;
    int hour;
    int minute;
    int second;
|};

@constraint:Date { option: "PAST_OR_PRESENT" }
type Date7 record {|
    int year;
    int month;
    int day;
    int...;
|};

@constraint:Date {
    option: constraint:FUTURE
}
type Date8 time:Civil;


type User1 record {
    string name;
    @constraint:Date
    time:Date dob;
};

type User2 record {
    string name;
    @constraint:Date {}
    time:Date dob;
};

type User3 record {
    string name;
    @constraint:Date {
        option: constraint:PAST
    }
    time:Date dob;
};

type CustomDate record {
    int year;
    int month;
    int day;
};

type User4 record {
    string name;
    @constraint:Date {
        option: "PAST_OR_PRESENT"
    }
    CustomDate dob;
};

type User5 record {
    string name;
    @constraint:Date {
        option: constraint:FUTURE
    }
    time:Civil dob;
};

type User6 readonly & record {
    string name;
    @constraint:Date {
        option: "FUTURE_OR_PRESENT"
    }
    record {
        int year;
        int month;
        int day;
    } dob;
};

type User7 readonly & record {
    string name;
    @constraint:Date {
        option: "FUTURE_OR_PRESENT"
    }
    record {|
        int year;
        int month;
        int day;
        int...;
    |} dob;
};

// Invalid cases

@constraint:Date
type Date9 int;

@constraint:Date {
    option: constraint:PAST
}
type Date10 record {
    int year;
    int month;
    int date;
};

@constraint:Date {
    option: "PAST_OR_PRESENT"
}
type Date11 record {};

type CustomRecord record {
    int year;
    int month;
};

type User8 record {
    string name;
    @constraint:Date {
        option: constraint:FUTURE
    }
    CustomRecord dob;
};

type User9 record {
    string name;
    @constraint:Date {
        option: "FUTURE_OR_PRESENT"
    }
    record {
        int year;
        int month;
        string ref;
    } dob;
};
