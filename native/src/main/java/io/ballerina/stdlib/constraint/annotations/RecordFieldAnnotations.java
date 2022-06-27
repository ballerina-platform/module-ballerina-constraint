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
import io.ballerina.runtime.api.types.Field;
import io.ballerina.runtime.api.types.RecordType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.stdlib.constraint.Constants;

import java.util.Map;
import java.util.Set;

/**
 * Extern functions for validating constraints on record fields.
 */
public class RecordFieldAnnotations extends AbstractAnnotations {

    private final Set<String> failedConstraints;

    public RecordFieldAnnotations(Set<String> failedConstraints) {
        super(failedConstraints);
        this.failedConstraints = failedConstraints;
    }

    @SuppressWarnings("unchecked")
    @Override
    public void validate(Object value, Type type) {
        BMap<BString, Object> record = (BMap<BString, Object>) value;
        BMap<BString, Object> recordAnnotations = ((AnnotatableType) type).getAnnotations();
        for (Map.Entry<BString, Object> entry : recordAnnotations.entrySet()) {
            if (entry.getKey().getValue().startsWith(Constants.PREFIX_RECORD_FILED)) {
                String fieldName = entry.getKey().getValue().substring(Constants.PREFIX_RECORD_FILED.length() + 1);
                BMap<BString, Object> recordFieldAnnotations = (BMap<BString, Object>) entry.getValue();
                Object fieldValue = getFieldValue(record, fieldName);
                super.validateAnnotations(recordFieldAnnotations, fieldValue);
            }
        }
        validateReferredTypeAnnotations(record, type);
    }

    private void validateReferredTypeAnnotations(BMap<BString, Object> record, Type type) {
        for (Field recordField : ((RecordType) type).getFields().values()) {
            Type fieldType = recordField.getFieldType();
            Type referredType = TypeUtils.getReferredType(fieldType);
            if (fieldType instanceof AnnotatableType) {
                String fieldName = recordField.getFieldName();
                Object fieldValue = record.get(StringUtils.fromString(fieldName));
                if (referredType instanceof RecordType) {
                    validate(fieldValue, referredType);
                } else {
                    TypeAnnotations typeAnnotations = new TypeAnnotations(this.failedConstraints);
                    typeAnnotations.validate(fieldValue, fieldType);
                }
            }
        }
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
}
