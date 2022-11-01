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
import io.ballerina.stdlib.constraint.validators.interfaces.LengthValidator;
import io.ballerina.stdlib.constraint.validators.interfaces.PatternValidator;

import java.util.List;
import java.util.Map;

/**
 * Extern functions for validating string constraints `@constraint:String` of Ballerina.
 */
public class StringConstraintValidator implements LengthValidator, PatternValidator {

    private final List<String> failedConstraints;

    public StringConstraintValidator(List<String> failedConstraints) {
        this.failedConstraints = failedConstraints;
    }

    public void validate(BMap<BString, Object> constraints, String fieldValue, String path) {
        for (Map.Entry<BString, Object> constraint : constraints.entrySet()) {
            validate(constraint, fieldValue, failedConstraints, path);
        }
    }

    @Override
    public void validate(Map.Entry<BString, Object> constraint, Object fieldValue, List<String> failedConstraints,
                         String path) {
        LengthValidator.super.validate(constraint, fieldValue, failedConstraints, path);
        PatternValidator.super.validate(constraint, fieldValue, failedConstraints, path);
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
