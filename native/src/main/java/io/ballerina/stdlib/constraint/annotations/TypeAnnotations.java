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
import io.ballerina.runtime.api.types.ArrayType;
import io.ballerina.runtime.api.types.RecordType;
import io.ballerina.runtime.api.types.ReferenceType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;

import java.util.Set;

/**
 * Extern functions for validating constraints on types.
 */
public class TypeAnnotations extends AbstractAnnotations {

    private final Set<String> failedConstraints;

    public TypeAnnotations(Set<String> failedConstraints) {
        super(failedConstraints);
        this.failedConstraints = failedConstraints;
    }

    @Override
    public void validate(Object value, AnnotatableType type) {
        BMap<BString, Object> typeAnnotations = type.getAnnotations();
        Object fieldValue = getFieldValue(value);
        super.validateAnnotations(typeAnnotations, fieldValue);
        if (type instanceof ReferenceType) {
            validateReferredType(value, (ReferenceType) type);
        }
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

    private void validateReferredType(Object value, ReferenceType type) {
        Type referredType = type.getReferredType();
        if (referredType instanceof ReferenceType) {
            if (referredType instanceof RecordType) {
                RecordFieldAnnotations recordFieldAnnotations = new RecordFieldAnnotations(this.failedConstraints);
                recordFieldAnnotations.validate(value, (AnnotatableType) referredType);
            } else if (referredType instanceof ArrayType) {
                validateArrayType((ArrayType) referredType, (BArray) value);
            } else {
                validate(value, (AnnotatableType) referredType);
            }
        }
    }

    @SuppressWarnings("unchecked")
    private void validateArrayType(ArrayType referredType, BArray value) {
        Type elementType = referredType.getElementType();
        if (elementType instanceof ReferenceType && elementType instanceof AnnotatableType) {
            if (elementType instanceof RecordType) {
                RecordFieldAnnotations recordFieldAnnotations = new RecordFieldAnnotations(this.failedConstraints);
                for (int i = 0; i < value.getLength(); i++) {
                    BMap<BString, Object> map = (BMap<BString, Object>) value.getRefValue(i);
                    recordFieldAnnotations.validate(map, (AnnotatableType) elementType);
                }
            } else {
                for (int i = 0; i < value.getLength(); i++) {
                    validate(value.getRefValue(i), (AnnotatableType) elementType);
                }
            }
        }
    }
}
