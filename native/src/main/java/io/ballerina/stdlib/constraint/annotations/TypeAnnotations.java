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

package io.ballerina.stdlib.constraint.annotations;

import io.ballerina.runtime.api.types.AnnotatableType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;

/**
 * Extern functions for validating constraints on types.
 */
public class TypeAnnotations extends AbstractAnnotations {

    @Override
    public void validate(Object value, Type type) {
        validateTypeAnnotations(value, type);
    }

    private void validateTypeAnnotations(Object value, Type type) {
        BMap<BString, Object> typeAnnotations = ((AnnotatableType) type).getAnnotations();
        Object fieldValue = getFieldValue(value);
        super.validateAnnotations(typeAnnotations, fieldValue);
    }

    private Object getFieldValue(Object value) {
        if (value instanceof BDecimal) {
            return ((BDecimal) value).value();
        } else if (value instanceof BString) {
            return ((BString) value).getValue();
        } else if (value instanceof BArray) {
            return ((BArray) value).getLength();
        }
        return value;
    }
}
