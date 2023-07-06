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

import io.ballerina.runtime.api.TypeTags;
import io.ballerina.runtime.api.types.AnnotatableType;
import io.ballerina.runtime.api.types.ArrayType;
import io.ballerina.runtime.api.types.IntersectionType;
import io.ballerina.runtime.api.types.RecordType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.stdlib.constraint.ConstraintErrorInfo;

import java.util.List;

import static io.ballerina.stdlib.constraint.Constants.SYMBOL_CLOSE_SQUARE_BRACKET;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_OPEN_SQUARE_BRACKET;

/**
 * Extern functions for validating constraints on types.
 */
public class TypeAnnotations extends AbstractAnnotations {

    private final List<ConstraintErrorInfo> failedConstraintsInfo;

    public TypeAnnotations(List<ConstraintErrorInfo> failedConstraintsInfo) {
        super(failedConstraintsInfo);
        this.failedConstraintsInfo = failedConstraintsInfo;
    }

    @Override
    public void validate(Object value, AnnotatableType type, String path, boolean isMemberValue) {
        BMap<BString, Object> typeAnnotations = type.getAnnotations();
        Object fieldValue = getFieldValue(value);
        super.validateAnnotations(typeAnnotations, fieldValue, path, isMemberValue);
        if (type.getTag() == TypeTags.TYPE_REFERENCED_TYPE_TAG) {
            validateReferredType(value, type, path, isMemberValue);
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

    private void validateReferredType(Object value, Type type, String path, boolean isMemberValue) {
        Type referredType = TypeUtils.getReferredType(type, false);
        if (referredType.isReadOnly() && referredType instanceof IntersectionType) {
            List<Type> constituentTypes = ((IntersectionType) referredType).getConstituentTypes();
            if (constituentTypes.size() == 2) {
                if (constituentTypes.get(0).getTag() == TypeTags.READONLY_TAG) {
                    referredType = TypeUtils.getReferredType(constituentTypes.get(1));
                } else {
                    referredType = TypeUtils.getReferredType(constituentTypes.get(0));
                }
            }
        }
        if (referredType instanceof AnnotatableType) {
            if (referredType instanceof RecordType) {
                RecordFieldAnnotations recordFieldAnnotations = new RecordFieldAnnotations(this.failedConstraintsInfo);
                recordFieldAnnotations.validate(value, (AnnotatableType) referredType, path, isMemberValue);
            } else {
                validate(value, (AnnotatableType) referredType, path, isMemberValue);
            }
        } else if (referredType instanceof ArrayType) {
            validateArrayType((ArrayType) referredType, (BArray) value, path);
        }
    }

    @SuppressWarnings("unchecked")
    private void validateArrayType(ArrayType referredType, BArray value, String path) {
        Type elementType = referredType.getElementType();
        if (elementType.getTag() == TypeTags.TYPE_REFERENCED_TYPE_TAG && elementType instanceof AnnotatableType) {
            if (elementType instanceof RecordType) {
                RecordFieldAnnotations recordFieldAnnotations = new RecordFieldAnnotations(this.failedConstraintsInfo);
                for (int i = 0; i < value.getLength(); i++) {
                    BMap<BString, Object> map = (BMap<BString, Object>) value.getRefValue(i);
                    recordFieldAnnotations.validate(map, (AnnotatableType) elementType,
                            path + SYMBOL_OPEN_SQUARE_BRACKET + i + SYMBOL_CLOSE_SQUARE_BRACKET, true);
                }
            } else {
                for (int i = 0; i < value.getLength(); i++) {
                    validate(value.getRefValue(i), (AnnotatableType) elementType,
                            path + SYMBOL_OPEN_SQUARE_BRACKET + i + SYMBOL_CLOSE_SQUARE_BRACKET, true);
                }
            }
        }
    }
}
