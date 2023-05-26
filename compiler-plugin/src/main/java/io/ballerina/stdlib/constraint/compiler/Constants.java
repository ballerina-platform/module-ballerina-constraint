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

package io.ballerina.stdlib.constraint.compiler;

/**
 * The constants related to compiler plugin.
 */
public class Constants {

    public static final String PACKAGE_NAME = "ballerina";
    public static final String MODULE_NAME = "constraint";
    static final String SYMBOL_COLON = ":";
    public static final String SYMBOL_ARRAY = "[]";
    static final String SYMBOL_NEW_LINE = "\n";
    static final String SYMBOL_DECIMAL = "d";
    public static final String EMPTY = "";

    static final String ANNOTATION_TAG_INT = "Int";
    static final String ANNOTATION_TAG_FLOAT = "Float";
    static final String ANNOTATION_TAG_NUMBER = "Number";
    static final String ANNOTATION_TAG_STRING = "String";
    static final String ANNOTATION_TAG_ARRAY = "Array";
    static final String ANNOTATION_TAG_DATE = "Date";

    public static final String TYPE_INT = "int";
    public static final String TYPE_FLOAT = "float";
    public static final String TYPE_DECIMAL = "decimal";
    public static final String TYPE_STRING = "string";
    public static final String TYPE_DATE_RECORD = "DateRecord";
    public static final String RECORD = "record";

    public static final String CONSTRAINT_MIN_VALUE = "minValue";
    public static final String CONSTRAINT_MAX_VALUE = "maxValue";
    public static final String CONSTRAINT_MIN_VALUE_EXCLUSIVE = "minValueExclusive";
    public static final String CONSTRAINT_MAX_VALUE_EXCLUSIVE = "maxValueExclusive";
    public static final String CONSTRAINT_LENGTH = "length";
    public static final String CONSTRAINT_MIN_LENGTH = "minLength";
    public static final String CONSTRAINT_MAX_LENGTH = "maxLength";
    public static final String CONSTRAINT_VALUE = "value";
}
