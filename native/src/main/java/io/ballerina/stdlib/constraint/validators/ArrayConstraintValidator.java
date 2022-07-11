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

import java.util.Set;

/**
 * Extern functions for validating array constraints `@constraint:Array` of Ballerina.
 */
public class ArrayConstraintValidator extends AbstractLengthValidator {

    private final Set<String> failedConstraints;

    public ArrayConstraintValidator(Set<String> failedConstraints) {
        this.failedConstraints = failedConstraints;
    }

    public void validate(BMap<BString, Object> constraints, Long fieldValue) {
        super.validate(constraints, fieldValue, failedConstraints);
    }

    @Override
    boolean validateLength(Object fieldValue, long constraintValue) {
        return (Long) fieldValue == constraintValue;
    }

    @Override
    boolean validateMinLength(Object fieldValue, long constraintValue) {
        return (Long) fieldValue >= constraintValue;
    }

    @Override
    boolean validateMaxLength(Object fieldValue, long constraintValue) {
        return (Long) fieldValue <= constraintValue;
    }
}
