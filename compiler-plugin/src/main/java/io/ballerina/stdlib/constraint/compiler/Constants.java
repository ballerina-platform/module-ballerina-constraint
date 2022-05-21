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

    static final String MODULE_NAME = "constraint";
    static final String SYMBOL_COLON = ":";
    static final String SYMBOL_ARRAY = "[]";
    static final String SYMBOL_NEW_LINE = "\n";

    static final String ANNOTATION_TAG_INT = "Int";
    static final String ANNOTATION_TAG_FLOAT = "Float";
    static final String ANNOTATION_TAG_NUMBER = "Number";
    static final String ANNOTATION_TAG_STRING = "String";
    static final String ANNOTATION_TAG_ARRAY = "Array";

    static final String TYPE_INT = "int";
    static final String TYPE_FLOAT = "float";
    static final String TYPE_DECIMAL = "decimal";
    static final String TYPE_STRING = "string";

    static final String CONSTRAINT_MIN_VALUE = "minValue";
    static final String CONSTRAINT_MAX_VALUE = "maxValue";
    static final String CONSTRAINT_MIN_VALUE_EXCLUSIVE = "minValueExclusive";
    static final String CONSTRAINT_MAX_VALUE_EXCLUSIVE = "maxValueExclusive";
    static final String CONSTRAINT_LENGTH = "length";
    static final String CONSTRAINT_MIN_LENGTH = "minLength";
    static final String CONSTRAINT_MAX_LENGTH = "maxLength";
}
