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

// Testing multiple types of annotations in a practical sample value

final json & readonly SAMPLE_PAYLOAD = {
    "app_id": 488472577,
    "buyer_accepts_marketing": false,
    "created_at": "2022-06-28T15:28:38+05:30",
    "currency": "LKR",
    "current_total_discounts": "0.00",
    "current_total_discounts_set": {
        "shop_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        }
    },
    "current_total_price": "2500.00",
    "current_total_price_set": {
        "shop_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        }
    },
    "current_subtotal_price": "2500.00",
    "current_subtotal_price_set": {
        "shop_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        }
    },
    "current_total_tax": "0.00",
    "current_total_tax_set": {
        "shop_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        }
    },
    "customer": {
        "accepts_marketing": false,
        "accepts_marketing_updated_at": "2022-06-02T14:33:08+05:30",
        "currency": "LKR",
        "created_at": "2022-06-02T13:50:48+05:30",
        "email": "roland.hewage@gmail.com",
        "id": 6239032443131,
        "last_order_id": 4797045473531,
        "last_order_name": "#1101",
        "orders_count": 90,
        "state": "disabled",
        "tags": "",
        "tax_exempt": false,
        "tax_exemptions": [

        ],
        "total_spent": "218215.41",
        "updated_at": "2022-06-28T15:28:39+05:30",
        "verified_email": true,
        "admin_graphql_api_id": "gid://shopify/Customer/6239032443131"
    },
    "discount_applications": [

    ],
    "discount_codes": [

    ],
    "email": "roland.hewage@gmail.com",
    "estimated_taxes": false,
    "financial_status": "paid",
    "fulfillments": [
        {
            "created_at": "2022-06-28T15:28:39+05:30",
            "id": 4290265317627,
            "line_items": [
                {
                    "id": 12244791755003,
                    "variant_id": 43095501734139,
                    "title": "Long sleeve t-shirt",
                    "quantity": 1,
                    "price": "2500.00",
                    "price_set": {
                        "shop_money": {
                            "amount": "2500.00",
                            "currency_code": "LKR"
                        },
                        "presentment_money": {
                            "amount": "2500.00",
                            "currency_code": "LKR"
                        }
                    },
                    "grams": 180,
                    "sku": "",
                    "variant_title": "Medium / Black",
                    "vendor": "zrhtwochak",
                    "fulfillment_service": "manual",
                    "product_id": 7721106571515,
                    "requires_shipping": true,
                    "taxable": false,
                    "gift_card": false,
                    "name": "Long sleeve t-shirt - Medium / Black",
                    "variant_inventory_management": "shopify",
                    "properties": [

                    ],
                    "product_exists": true,
                    "fulfillable_quantity": 0,
                    "total_discount": "0.00",
                    "fulfillment_status": "fulfilled",
                    "tax_lines": [

                    ],
                    "total_discount_set": {
                        "shop_money": {
                            "amount": "0.00",
                            "currency_code": "LKR"
                        },
                        "presentment_money": {
                            "amount": "0.00",
                            "currency_code": "LKR"
                        }
                    },
                    "discount_allocations": [

                    ],
                    "admin_graphql_api_id": "gid://shopify/LineItem/12244791755003",
                    "duties": [

                    ]
                }
            ],
            "location_id": 69263819003,
            "name": "#1101.1",
            "order_id": 4797045473531,
            "origin_address": {

            },
            "receipt": {

            },
            "service": "manual",
            "status": "success",
            "tracking_numbers": [

            ],
            "tracking_urls": [

            ],
            "updated_at": "2022-06-28T15:28:39+05:30",
            "admin_graphql_api_id": "gid://shopify/Fulfillment/4290265317627"
        }
    ],
    "fulfillment_status": "fulfilled",
    "gateway": "",
    "id": 4797045473531,
    "line_items": [
        {
            "id": 12244791755003,
            "variant_id": 43095501734139,
            "title": "Long sleeve t-shirt",
            "quantity": 1,
            "price": "2500.00",
            "price_set": {
                "shop_money": {
                    "amount": "2500.00",
                    "currency_code": "LKR"
                },
                "presentment_money": {
                    "amount": "2500.00",
                    "currency_code": "LKR"
                }
            },
            "grams": 180,
            "sku": "",
            "variant_title": "Medium / Black",
            "vendor": "zrhtwochak",
            "fulfillment_service": "manual",
            "product_id": 7721106571515,
            "requires_shipping": true,
            "taxable": false,
            "gift_card": false,
            "name": "Long sleeve t-shirt - Medium / Black",
            "variant_inventory_management": "shopify",
            "properties": [

            ],
            "product_exists": true,
            "fulfillable_quantity": 0,
            "total_discount": "0.00",
            "fulfillment_status": "fulfilled",
            "tax_lines": [

            ],
            "total_discount_set": {
                "shop_money": {
                    "amount": "0.00",
                    "currency_code": "LKR"
                },
                "presentment_money": {
                    "amount": "0.00",
                    "currency_code": "LKR"
                }
            },
            "discount_allocations": [

            ],
            "admin_graphql_api_id": "gid://shopify/LineItem/12244791755003",
            "duties": [

            ]
        }
    ],
    "name": "#1101",
    "note_attributes": [

    ],
    "number": 101,
    "order_number": 1101,
    "payment_gateway_names": [

    ],
    "phone": "+94123456789",
    "presentment_currency": "LKR",
    "processed_at": "2022-06-28T15:28:38+05:30",
    "processing_method": "",
    "refunds": [

    ],
    "shipping_lines": [

    ],
    "source_name": "488472577",
    "subtotal_price": "2500.00",
    "subtotal_price_set": {
        "shop_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        }
    },
    "tags": "",
    "tax_lines": [

    ],
    "taxes_included": false,
    "test": false,
    "token": "03dd268fd532d709a2ae7285fee54e85",
    "total_discounts": "0.00",
    "total_discounts_set": {
        "shop_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        }
    },
    "total_line_items_price": "2500.00",
    "total_line_items_price_set": {
        "shop_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        }
    },
    "total_outstanding": "2500.00",
    "total_price": "2500.00",
    "total_price_set": {
        "shop_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "2500.00",
            "currency_code": "LKR"
        }
    },
    "total_shipping_price_set": {
        "shop_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        }
    },
    "total_tax": "0.00",
    "total_tax_set": {
        "shop_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        },
        "presentment_money": {
            "amount": "0.00",
            "currency_code": "LKR"
        }
    },
    "total_tip_received": "0.00",
    "total_weight": 0d,
    "updated_at": "2022-06-28T15:28:38+05:30",
    "order_status_url": "https://zrhtwochak.myshopify.com/64625017083/orders/03dd268fd532d709a2ae7285fee54e85/authenticatekey=704bed3322a51f1f7414cf4c7340ec25",
    "total_price_usd": "6.96",
    "confirmed": true,
    "contact_email": "roland.hewage@gmail.com",
    "admin_graphql_api_id": "gid://shopify/Order/4797045473531"
};

@test:Config {}
isolated function testSampleSuccess() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    Order|error validation = validate(rec);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
isolated function testSampleFailure1() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.customer.currency = "INVALID";
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.customer.currency:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure2() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.presentment_currency = "INVALID";
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.presentment_currency:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure3() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.current_total_discounts_set.shop_money.currency_code = "INVALID";
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.current_total_discounts_set.shop_money.currency_code:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure4() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.fulfillments[0].line_items[0].price_set.shop_money.currency_code = "INVALID";
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.fulfillments[0].line_items[0].price_set.shop_money.currency_code:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure5() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.number = -1;
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.number:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure6() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.order_number = 1000;
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.order_number:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure7() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.customer.orders_count = 0;
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.customer.orders_count:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure8() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.fulfillments[0].line_items[0].quantity = -1;
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.fulfillments[0].line_items[0].quantity:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure9() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.fulfillments[0].line_items[0].grams = 0;
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.fulfillments[0].line_items[0].grams:minValueExclusive' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure10() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.fulfillments[0].line_items[0].fulfillable_quantity = -1;
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.fulfillments[0].line_items[0].fulfillable_quantity:minValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
isolated function testSampleFailure11() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.customer.currency = "INVALID";
    rec.presentment_currency = "INVALID";
    rec.current_total_discounts_set.shop_money.currency_code = "INVALID";
    rec.fulfillments[0].line_items[0].price_set.shop_money.currency_code = "INVALID";
    rec.number = -1;
    rec.order_number = 1000;
    rec.customer.orders_count = 0;
    rec.fulfillments[0].line_items[0].quantity = -1;
    rec.fulfillments[0].line_items[0].grams = 0;
    rec.fulfillments[0].line_items[0].fulfillable_quantity = -1;
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for " +
        "'$.current_total_discounts_set.shop_money.currency_code:length'," +
        "'$.customer.currency:length'," +
        "'$.customer.orders_count:minValueExclusive'," +
        "'$.fulfillments[0].line_items[0].fulfillable_quantity:minValue'," +
        "'$.fulfillments[0].line_items[0].grams:minValueExclusive'," +
        "'$.fulfillments[0].line_items[0].price_set.shop_money.currency_code:length'," +
        "'$.fulfillments[0].line_items[0].quantity:minValue'," +
        "'$.number:minValue'," +
        "'$.order_number:minValue'," +
        "'$.presentment_currency:length' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@test:Config {}
function testSampleFailure12() returns error? {
    Order rec = check SAMPLE_PAYLOAD.cloneWithType();
    rec.phone = "1234abcd90";
    rec.email = "invalid_email?address@";
    rec.customer.email = "This is a invalid email";
    Order|error validation = validate(rec);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.customer.email:pattern','$.email:pattern','$.phone:pattern' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

public type Order record {
    int app_id?;
    CustomerAddress billing_address?;
    @String {minLength: 1}
    string browser_ip?;
    boolean buyer_accepts_marketing?;
    @String {minLength: 1}
    string cancel_reason?;
    string cancelled_at?;
    string cart_token?;
    string checkout_token?;
    ClientDetails client_details?;
    string closed_at?;
    string created_at?;
    @String {length: 3}
    string currency?;
    string current_total_discounts?;
    CurrentTotalDiscountsSet current_total_discounts_set?;
    CurrentTotalDutiesSet current_total_duties_set?;
    string current_total_price?;
    CurrentTotalPriceSet current_total_price_set?;
    string current_subtotal_price?;
    CurrentSubtotalPriceSet current_subtotal_price_set?;
    string current_total_tax?;
    CurrentTotalTaxSet current_total_tax_set?;
    Customer customer?;
    string customer_locale?;
    DiscountApplication[] discount_applications?;
    DiscountCode[] discount_codes?;
    @String {pattern: re `([a-zA-Z0-9._%\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,6})*`}
    string email?;
    boolean estimated_taxes?;
    string financial_status?;
    Fulfillment[] fulfillments?;
    string fulfillment_status?;
    string gateway?;
    int id?;
    string landing_site?;
    LineItem[] line_items?;
    int location_id?;
    string name?;
    string note?;
    NoteAttribute[] note_attributes?;
    @Int {minValue: 1}
    int number?;
    @Int {minValue: 1001}
    int order_number?;
    OriginalTotalDutiesSet original_total_duties_set?;
    string payment_details?;
    PaymentTerms payment_terms?;
    string[] payment_gateway_names?;
    @String {pattern: re `([0-9]{10})|(\+[0-9]{11})`}
    string phone?;
    @String {length: 3}
    string presentment_currency?;
    string processed_at?;
    string processing_method?;
    string referring_site?;
    Refund[] refunds?;
    CustomerAddress shipping_address?;
    ShippingLine[] shipping_lines?;
    string source_name?;
    string subtotal_price?;
    SubtotalPriceSet subtotal_price_set?;
    string tags?;
    TaxLine[] tax_lines?;
    boolean taxes_included?;
    boolean test?;
    string token?;
    string total_discounts?;
    TotalDiscountsSet total_discounts_set?;
    string total_line_items_price?;
    TotalLineItemsPriceSet total_line_items_price_set?;
    string total_outstanding?;
    string total_price?;
    TotalPriceSet total_price_set?;
    TotalShippingPriceSet total_shipping_price_set?;
    string total_tax?;
    TotalTaxSet total_tax_set?;
    string total_tip_received?;
    decimal total_weight?;
    string updated_at?;
    int user_id?;
    string order_status_url?;
};

public type CustomerAddress record {
    string address1?;
    string address2?;
    string city?;
    string company?;
    string country?;
    string country_code?;
    string first_name?;
    string last_name?;
    string latitude?;
    string longitude?;
    string name?;
    string phone?;
    string province?;
    string province_code?;
    string zip?;
};

public type ClientDetails record {
    string accept_language?;
    int browser_height?;
    string browser_ip?;
    int browser_width?;
    string session_hash?;
    string user_agent?;
};

public type CurrentTotalDiscountsSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type CurrentTotalDutiesSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type CurrentTotalPriceSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type CurrentSubtotalPriceSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type CurrentTotalTaxSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type Customer record {
    boolean accepts_marketing?;
    string accepts_marketing_updated_at?;
    Address[] addresses?;
    @String {length: 3}
    string currency?;
    string created_at?;
    string first_name?;
    @String {pattern: re `([a-zA-Z0-9._%\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,6})*`}
    string email?;
    Address default_address?;
    int id?;
    string last_name?;
    int last_order_id?;
    string last_order_name?;
    Metafield metafield?;
    string marketing_opt_in_level?;
    string multipass_identifier?;
    string note?;
    @Int {minValueExclusive: 0}
    int orders_count?;
    @String {pattern: re `([0-9]{10})|(\+[0-9]{11})`}
    string phone?;
    SmsMarketingConsent sms_marketing_consent?;
    string state?;
    string tags?;
    boolean tax_exempt?;
    string[] tax_exemptions?;
    string total_spent?;
    string updated_at?;
    boolean verified_email?;
};

public type DiscountApplication record {
    string allocation_method?;
    string code?;
    string description?;
    string target_selection?;
    string target_type?;
    string title?;
    string 'type?;
    string value?;
    string value_type?;
};

public type DiscountCode record {
    string amount?;
    string code?;
    string 'type?;
};

public type Fulfillment record {
    string created_at?;
    int id?;
    LineItem[] line_items?;
    int location_id?;
    string name?;
    string notify_customer?;
    int order_id?;
    Address origin_address?;
    Receipt receipt?;
    string 'service?;
    string shipment_status?;
    string status?;
    string tracking_company?;
    string[] tracking_numbers?;
    string[] tracking_urls?;
    string updated_at?;
    string variant_inventory_management?;
};

public type LineItem record {
    int id?;
    int variant_id?;
    string title?;
    @Int {minValue: 0}
    int quantity?;
    string price?;
    PriceSet price_set?;
    @Int {minValueExclusive: 0}
    int grams?;
    string sku?;
    string variant_title?;
    string vendor?;
    string fulfillment_service?;
    int product_id?;
    boolean requires_shipping?;
    boolean taxable?;
    boolean gift_card?;
    string name?;
    string variant_inventory_management?;
    Property[] properties?;
    boolean product_exists?;
    @Int {minValue: 0}
    int fulfillable_quantity?;
    string total_discount?;
    string fulfillment_status?;
    int fulfillment_line_item_id?;
    TaxLine[] tax_lines?;
    string tip_payment_gateway?;
    string tip_payment_method?;
    TotalDiscountSet total_discount_set?;
    DiscountAllocations[] discount_allocations?;
    Address origin_location?;
};

public type NoteAttribute record {
    string name?;
    string value?;
};

public type OriginalTotalDutiesSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type PaymentTerms record {
    @String {length: 3}
    string currency?;
    string payment_terms_name?;
    string payment_terms_type?;
    int due_in_days?;
    PaymentSchedule[] payment_schedules?;
};

public type Refund record {
    string created_at?;
    int id?;
    string note?;
    OrderAdjustment[] order_adjustments?;
    string processed_at?;
    RefundLineItem[] refund_line_items?;
    int user_id?;
};

public type ShippingLine record {
    string code?;
    string discounted_price?;
    DiscountedPriceSet discounted_price_set?;
    string price?;
    PriceSet price_set?;
    string 'source?;
    string title?;
    string carrier_identifier?;
    string requested_fulfillment_service_id?;
};

public type SubtotalPriceSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type TaxLine record {
    string price?;
    decimal rate?;
    string title?;
    boolean channel_liable?;
};

public type TotalDiscountsSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type TotalLineItemsPriceSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type TotalPriceSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type TotalShippingPriceSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type TotalTaxSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type Price record {
    string amount?;
    @String {length: 3}
    string currency_code?;
};

public type Address record {
    string address1?;
    string address2?;
    string city?;
    string company?;
    string country?;
    string country_code?;
    string country_name?;
    int customer_id?;
    boolean 'default?;
    string first_name?;
    int id?;
    string last_name?;
    string name?;
    string phone?;
    string province?;
    string province_code?;
    string zip?;
};

public type Metafield record {
    string 'key;
    string namespace;
    string value;
    string value_type;
    string description?;
};

public type SmsMarketingConsent record {
    string state?;
    string opt_in_level?;
    string consent_updated_at?;
    string consent_collected_from?;
};

public type Receipt record {
    boolean testcase?;
    string authorization?;
};

public type PriceSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type Property record {
    string name?;
    string value?;
};

public type TotalDiscountSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type DiscountAllocations record {
    string amount?;
    int discount_application_index?;
    AmountSet amount_set?;
};

public type PaymentSchedule record {
    int amount?;
    @String {length: 3}
    string currency?;
    string issued_at?;
    string due_at?;
    string completed_at?;
    string expected_payment_method?;
};

public type OrderAdjustment record {
    int id?;
    int order_id?;
    int refund_id?;
    int amount?;
    string tax_amount?;
    string kind?;
    string reason?;
};

public type RefundLineItem record {
    int id?;
    int line_item_id?;
    @Int {minValue: 0}
    int quantity?;
    string restock_type?;
    int location_id?;
    decimal subtotal?;
    decimal total_tax?;
};

public type DiscountedPriceSet record {
    Price shop_money?;
    Price presentment_money?;
};

public type AmountSet record {
    Price shop_money?;
    Price presentment_money?;
};
