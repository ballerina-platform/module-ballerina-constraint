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
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.runtime.api.values.BTypedesc;
import io.ballerina.stdlib.constraint.Constants;

import java.util.Map;

/**
 * Extern functions for validating constraints on record fields.
 */
public class RecordFieldAnnotations extends AbstractAnnotations {

    @SuppressWarnings("unchecked")
    @Override
    public void validate(Object value, BTypedesc typedesc) {
        BMap<BString, Object> record = (BMap<BString, Object>) value;
        validateRecordAnnotations(record, typedesc);
        for (BString key : record.getKeys()) {
            if (record.get(key) instanceof BMap) {
                record = ((BMap<BString, Object>) record.get(key));
                typedesc = record.getTypedesc();
                validate(record, typedesc);
            }
        }
    }

    @SuppressWarnings("unchecked")
    private void validateRecordAnnotations(BMap<BString, Object> record, BTypedesc typedesc) {
        BMap<BString, Object> recordAnnotations = ((AnnotatableType) typedesc.getDescribingType()).getAnnotations();
        for (Map.Entry<BString, Object> entry : recordAnnotations.entrySet()) {
            if (entry.getKey().getValue().startsWith(Constants.PREFIX_RECORD_FILED)) {
                String fieldName = entry.getKey().getValue().substring(Constants.PREFIX_RECORD_FILED.length() + 1);
                Object fieldValue = getFieldValue(record, fieldName);
                BMap<BString, Object> constraintAnnotations = (BMap<BString, Object>) entry.getValue();
                for (Map.Entry<BString, Object> annotationRecord : constraintAnnotations.entrySet()) {
                    String annotationTag = annotationRecord.getKey().getValue().
                            substring(Constants.PREFIX_ANNOTATION_RECORD.length());
                    BMap<BString, Object> constraints = (BMap<BString, Object>) annotationRecord.getValue();
                    validateRecordAnnotationTags(annotationTag, constraints, fieldValue);
                }
            }
        }
    }

    private void validateRecordAnnotationTags(String annotationTag, BMap<BString, Object> constraints,
                                              Object fieldValue) {
        switch (annotationTag) {
            case Constants.ANNOTATION_TAG_INT:
                super.intConstraintValidator.validate(constraints, (Number) fieldValue);
                break;
            case Constants.ANNOTATION_TAG_FLOAT:
                super.floatConstraintValidator.validate(constraints, (Number) fieldValue);
                break;
            case Constants.ANNOTATION_TAG_NUMBER:
                super.numberConstraintValidator.validate(constraints, (Number) fieldValue);
                break;
            case Constants.ANNOTATION_TAG_STRING:
                super.stringConstraintValidator.validate(constraints, (String) fieldValue);
                break;
            case Constants.ANNOTATION_TAG_ARRAY:
                super.arrayConstraintValidator.validate(constraints, (Long) fieldValue);
                break;
            default:
                break;
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
