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
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.stdlib.constraint.ConstraintErrorInfo;
import io.ballerina.stdlib.constraint.validators.ArrayConstraintValidator;
import io.ballerina.stdlib.constraint.validators.DateConstraintValidator;
import io.ballerina.stdlib.constraint.validators.FloatConstraintValidator;
import io.ballerina.stdlib.constraint.validators.IntConstraintValidator;
import io.ballerina.stdlib.constraint.validators.NumberConstraintValidator;
import io.ballerina.stdlib.constraint.validators.StringConstraintValidator;

import java.util.List;
import java.util.Map;

import static io.ballerina.stdlib.constraint.Constants.ANNOTATION_RECORD_REGEX;
import static io.ballerina.stdlib.constraint.Constants.ANNOTATION_TAG_ARRAY;
import static io.ballerina.stdlib.constraint.Constants.ANNOTATION_TAG_DATE;
import static io.ballerina.stdlib.constraint.Constants.ANNOTATION_TAG_FLOAT;
import static io.ballerina.stdlib.constraint.Constants.ANNOTATION_TAG_INT;
import static io.ballerina.stdlib.constraint.Constants.ANNOTATION_TAG_NUMBER;
import static io.ballerina.stdlib.constraint.Constants.ANNOTATION_TAG_STRING;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SEPARATOR;

/**
 * The abstract class to represent the annotation attachment points.
 */
public abstract class AbstractAnnotations {

    private final IntConstraintValidator intConstraintValidator;
    private final FloatConstraintValidator floatConstraintValidator;
    private final NumberConstraintValidator numberConstraintValidator;
    private final StringConstraintValidator stringConstraintValidator;
    private final ArrayConstraintValidator arrayConstraintValidator;
    private final DateConstraintValidator dateConstraintValidator;

    public AbstractAnnotations(List<ConstraintErrorInfo> failedConstraintsInfo) {
        this.intConstraintValidator = new IntConstraintValidator(failedConstraintsInfo);
        this.floatConstraintValidator = new FloatConstraintValidator(failedConstraintsInfo);
        this.numberConstraintValidator = new NumberConstraintValidator(failedConstraintsInfo);
        this.stringConstraintValidator = new StringConstraintValidator(failedConstraintsInfo);
        this.arrayConstraintValidator = new ArrayConstraintValidator(failedConstraintsInfo);
        this.dateConstraintValidator = new DateConstraintValidator(failedConstraintsInfo);
    }

    public abstract void validate(Object value, AnnotatableType type, String path, boolean isMemberValue);

    @SuppressWarnings("unchecked")
    public void validateAnnotations(BMap<BString, Object> annotations, Object fieldValue, String path,
                                    boolean isMemberValue) {
        for (Map.Entry<BString, Object> annotationRecord : annotations.entrySet()) {
            if (fromConstraintModule(annotationRecord)) {
                String annotationTag = annotationRecord.getKey().getValue().split(SYMBOL_SEPARATOR, 3)[2];
                BMap<BString, Object> constraints = (BMap<BString, Object>) annotationRecord.getValue();
                validateAnnotationTags(annotationTag, constraints, fieldValue, path, isMemberValue);
            }
        }
    }

    public static boolean fromConstraintModule(Map.Entry<BString, Object> annotationRecord) {
        return annotationRecord.getKey().getValue().matches(ANNOTATION_RECORD_REGEX);
    }

    private void validateAnnotationTags(String annotationTag, BMap<BString, Object> constraints, Object fieldValue,
                                        String path, boolean isMemberValue) {
        switch (annotationTag) {
            case ANNOTATION_TAG_INT:
                this.intConstraintValidator.validate(constraints, (Number) fieldValue, path, isMemberValue);
                break;
            case ANNOTATION_TAG_FLOAT:
                this.floatConstraintValidator.validate(constraints, (Number) fieldValue, path, isMemberValue);
                break;
            case ANNOTATION_TAG_NUMBER:
                this.numberConstraintValidator.validate(constraints, (Number) fieldValue, path, isMemberValue);
                break;
            case ANNOTATION_TAG_STRING:
                this.stringConstraintValidator.validate(constraints, (String) fieldValue, path, isMemberValue);
                break;
            case ANNOTATION_TAG_ARRAY:
                this.arrayConstraintValidator.validate(constraints, (Long) fieldValue, path, isMemberValue);
                break;
            case ANNOTATION_TAG_DATE:
                this.dateConstraintValidator.validate(constraints, fieldValue, path, isMemberValue);
                break;
            default:
                break;
        }
    }
}
