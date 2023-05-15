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

package io.ballerina.stdlib.constraint.validators;

import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.stdlib.constraint.ConstraintErrorInfo;
import io.ballerina.stdlib.constraint.validators.interfaces.LengthValidator;
import io.ballerina.stdlib.constraint.validators.interfaces.PatternValidator;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MESSAGE;

/**
 * Extern functions for validating string constraints `@constraint:String` of Ballerina.
 */
public class StringConstraintValidator implements LengthValidator, PatternValidator {

    private final List<ConstraintErrorInfo> failedConstraintsInfo;

    public StringConstraintValidator(List<ConstraintErrorInfo> failedConstraintsInfo) {
        this.failedConstraintsInfo = failedConstraintsInfo;
    }

    public void validate(BMap<BString, Object> constraints, String fieldValue, String path, boolean isMemberValue) {
        List<String> constraintFailures = new ArrayList<>();
        String message = null;
        for (Map.Entry<BString, Object> constraint : constraints.entrySet()) {
            if (constraint.getKey().getValue().equals(CONSTRAINT_MESSAGE)) {
                message = ((BString) constraint.getValue()).getValue();
            }
            LengthValidator.super.checkLengthConstraintValue(constraint, path);
            validate(constraint, fieldValue, constraintFailures);
        }
        if (!constraintFailures.isEmpty()) {
            failedConstraintsInfo.add(new ConstraintErrorInfo(path, message, constraintFailures, isMemberValue));
        }
    }

    @Override
    public void validate(Map.Entry<BString, Object> constraint, Object fieldValue, List<String> failedConstraints) {
        LengthValidator.super.validate(constraint, fieldValue, failedConstraints);
        PatternValidator.super.validate(constraint, fieldValue, failedConstraints);
    }

    @Override
    public boolean validateLength(Object fieldValue, long constraintValue) {
        return ((String) fieldValue).length() == constraintValue;
    }

    @Override
    public boolean validateMinLength(Object fieldValue, long constraintValue) {
        return ((String) fieldValue).length() >= constraintValue;
    }

    @Override
    public boolean validateMaxLength(Object fieldValue, long constraintValue) {
        return ((String) fieldValue).length() <= constraintValue;
    }
}
