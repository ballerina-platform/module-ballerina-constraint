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
 * The constants related to compiler plugin tests.
 */
public class CompilerPluginTestConstants {

    static final String ANNOTATION_TAG_INT = "Int";
    static final String ANNOTATION_TAG_FLOAT = "Float";
    static final String ANNOTATION_TAG_NUMBER = "Number";
    static final String ANNOTATION_TAG_STRING = "String";
    static final String ANNOTATION_TAG_ARRAY = "Array";

    static final String TYPE_NIL = "()";
    static final String TYPE_BOOLEAN = "boolean";
    static final String TYPE_INT = "int";
    static final String TYPE_FLOAT = "float";
    static final String TYPE_DECIMAL = "decimal";
    static final String TYPE_STRING = "string";
    static final String TYPE_XML = "xml";
    static final String TYPE_ANYDATA_ARRAY = "anydata[]";
    static final String TYPE_MAP_OF_ANYDATA = "map<anydata>";
    static final String TYPE_TABLE_OF_ANYDATA = "table<map<anydata>>";
}
