/*
 * Copyright (c) 2022, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.stdlib.constraint;

import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BString;

/**
 * Constants related to constraint module.
 */
public class Constants {

    public static final String PREFIX_RECORD_FIELD = "$field$";
    public static final String ANNOTATION_RECORD_REGEX = "^ballerina/constraint:[0-9]+:.+";

    public static final String SYMBOL_DOLLAR_SIGN = "$";
    public static final String SYMBOL_DOT = ".";
    public static final String SYMBOL_SINGLE_QUOTE = "'";
    public static final String SYMBOL_COMMA = ",";
    public static final String SYMBOL_OPEN_SQUARE_BRACKET = "[";
    public static final String SYMBOL_CLOSE_SQUARE_BRACKET = "]";
    public static final String SYMBOL_SEPARATOR = ":";

    public static final String ANNOTATION_TAG_INT = "Int";
    public static final String ANNOTATION_TAG_FLOAT = "Float";
    public static final String ANNOTATION_TAG_NUMBER = "Number";
    public static final String ANNOTATION_TAG_STRING = "String";
    public static final String ANNOTATION_TAG_ARRAY = "Array";
    public static final String ANNOTATION_TAG_DATE = "Date";

    public static final String CONSTRAINT_MIN_VALUE = "minValue";
    public static final String CONSTRAINT_MAX_VALUE = "maxValue";
    public static final String CONSTRAINT_MIN_VALUE_EXCLUSIVE = "minValueExclusive";
    public static final String CONSTRAINT_MAX_VALUE_EXCLUSIVE = "maxValueExclusive";
    public static final String CONSTRAINT_LENGTH = "length";
    public static final String CONSTRAINT_MIN_LENGTH = "minLength";
    public static final String CONSTRAINT_MAX_LENGTH = "maxLength";
    public static final String CONSTRAINT_PATTERN = "pattern";
    public static final String CONSTRAINT_DATE_OPTION = "option";
    public static final String PAST = "PAST";
    public static final String PAST_OR_PRESENT = "PAST_OR_PRESENT";
    public static final String FUTURE = "FUTURE";
    public static final String FUTURE_OR_PRESENT = "FUTURE_OR_PRESENT";
    public static final String PAST_DATE = "pastDate";
    public static final String PAST_OR_PRESENT_DATE = "pastOrPresentDate";
    public static final String FUTURE_DATE = "futureDate";
    public static final String FUTURE_OR_PRESENT_DATE = "futureOrPresentDate";
    public static final String CONSTRAINT_VALID_DATE = "validDate";

    public static final String YEAR = "year";
    public static final String MONTH = "month";
    public static final String DAY = "day";

    public static final BString DATE_RECORD_YEAR_BSTRING = StringUtils.fromString(YEAR);
    public static final BString DATE_RECORD_MONTH_BSTRING = StringUtils.fromString(MONTH);
    public static final BString DATE_RECORD_DAY_BSTRING = StringUtils.fromString(DAY);

    static final String GENERIC_ERROR = "Error";
    static final String VALIDATION_ERROR = "ValidationError";
    static final String TYPE_CONVERSION_ERROR = "TypeConversionError";
}
