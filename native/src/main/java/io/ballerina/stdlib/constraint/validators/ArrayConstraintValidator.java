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

import java.util.List;
import java.util.Map;

/**
 * Extern functions for validating array constraints `@constraint:Array` of Ballerina.
 */
public class ArrayConstraintValidator implements LengthValidator {

    private final List<ConstraintErrorInfo> failedConstraintsInfo;

    public ArrayConstraintValidator(List<ConstraintErrorInfo> failedConstraintsInfo) {
        this.failedConstraintsInfo = failedConstraintsInfo;
    }

    public void validate(BMap<BString, Object> constraints, Long fieldValue, String path, boolean isMemberValue) {
        for (Map.Entry<BString, Object> constraint : constraints.entrySet()) {
            LengthValidator.super.checkLengthConstraintValue(constraint, path);
            validate(constraint, fieldValue, isMemberValue, failedConstraintsInfo, path);
        }
    }

    @Override
    public boolean validateLength(Object fieldValue, long constraintValue) {
        return (Long) fieldValue == constraintValue;
    }

    @Override
    public boolean validateMinLength(Object fieldValue, long constraintValue) {
        return (Long) fieldValue >= constraintValue;
    }

    @Override
    public boolean validateMaxLength(Object fieldValue, long constraintValue) {
        return (Long) fieldValue <= constraintValue;
    }
}
