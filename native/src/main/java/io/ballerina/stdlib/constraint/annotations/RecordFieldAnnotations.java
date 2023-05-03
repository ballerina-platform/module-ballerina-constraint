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
import io.ballerina.runtime.api.types.Field;
import io.ballerina.runtime.api.types.RecordType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.utils.IdentifierUtils;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;

import java.util.List;
import java.util.Map;

import static io.ballerina.stdlib.constraint.Constants.PREFIX_RECORD_FIELD;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_CLOSE_SQUARE_BRACKET;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_DOT;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_OPEN_SQUARE_BRACKET;

/**
 * Extern functions for validating constraints on record fields.
 */
public class RecordFieldAnnotations extends AbstractAnnotations {

    private final List<String> failedConstraints;

    public RecordFieldAnnotations(List<String> failedConstraints) {
        super(failedConstraints);
        this.failedConstraints = failedConstraints;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void validate(Object value, AnnotatableType type, String path) {
        BMap<BString, Object> record = (BMap<BString, Object>) value;
        BMap<BString, Object> recordAnnotations = type.getAnnotations();
        for (Map.Entry<BString, Object> entry : recordAnnotations.entrySet()) {
            if (entry.getKey().getValue().startsWith(PREFIX_RECORD_FIELD)) {
                String fieldName = IdentifierUtils.unescapeBallerina(
                        entry.getKey().getValue().substring(PREFIX_RECORD_FIELD.length() + 1));
                BMap<BString, Object> recordFieldAnnotations = (BMap<BString, Object>) entry.getValue();
                Object fieldValue = getFieldValue(record, fieldName);
                if (fieldValue != null) { // This can be null due to optional fields
                    super.validateAnnotations(recordFieldAnnotations, fieldValue, path + SYMBOL_DOT + fieldName);
                }
            }
        }
        validateReferredType(record, (RecordType) type, path);
    }

    private Object getFieldValue(BMap<BString, Object> record, String fieldName) {
        Object obj = record.get(StringUtils.fromString(fieldName));
        if (obj instanceof BDecimal) {
            return ((BDecimal) record.get(StringUtils.fromString(fieldName))).value();
        } else if (obj instanceof BString) {
            return ((BString) record.get(StringUtils.fromString(fieldName))).getValue();
        } else if (obj instanceof BArray) {
            return ((BArray) obj).getLength();
        }
        return obj;
    }

    private void validateReferredType(BMap<BString, Object> record, RecordType type, String path) {
        for (Field recordField : type.getFields().values()) {
            Type fieldType = recordField.getFieldType();
            String fieldName = recordField.getFieldName();
            Object fieldValue = record.get(StringUtils.fromString(fieldName));
            if (fieldValue != null) { // This can be null due to optional fields
                if (fieldType instanceof AnnotatableType) {
                    if (fieldType instanceof RecordType) {
                        validate(fieldValue, (AnnotatableType) fieldType, path + SYMBOL_DOT + fieldName);
                    } else {
                        TypeAnnotations typeAnnotations = new TypeAnnotations(this.failedConstraints);
                        typeAnnotations.validate(fieldValue, (AnnotatableType) fieldType,
                                path + SYMBOL_DOT + fieldName);
                    }
                } else if (fieldType instanceof ArrayType) {
                    validateArrayType((ArrayType) fieldType, (BArray) fieldValue, path + SYMBOL_DOT + fieldName);
                }
            }
        }
    }

    @SuppressWarnings("unchecked")
    private void validateArrayType(ArrayType fieldType, BArray fieldValue, String path) {
        Type elementType = fieldType.getElementType();
        if (elementType instanceof AnnotatableType) {
            if (elementType instanceof RecordType) {
                for (int i = 0; i < fieldValue.getLength(); i++) {
                    BMap<BString, Object> map = (BMap<BString, Object>) fieldValue.getRefValue(i);
                    validate(map, (AnnotatableType) elementType,
                            path + SYMBOL_OPEN_SQUARE_BRACKET + i + SYMBOL_CLOSE_SQUARE_BRACKET);
                }
            } else {
                TypeAnnotations typeAnnotations = new TypeAnnotations(this.failedConstraints);
                for (int i = 0; i < fieldValue.getLength(); i++) {
                    typeAnnotations.validate(fieldValue.getRefValue(i), (AnnotatableType) elementType,
                            path + SYMBOL_OPEN_SQUARE_BRACKET + i + SYMBOL_CLOSE_SQUARE_BRACKET);
                }
            }
        }
    }
}
