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

import io.ballerina.stdlib.constraint.ConstraintErrorInfo;

import java.util.List;

/**
 * Extern functions for validating int constraints `@constraint:Int` of Ballerina.
 */
public class IntConstraintValidator extends NumberConstraintValidator {

    public IntConstraintValidator(List<ConstraintErrorInfo> failedConstraintsInfo) {
        super(failedConstraintsInfo);
    }

    @Override
    public boolean validateMinValue(Object fieldValue, Object constraintValue) {

        return ((Number) fieldValue).longValue() >= (Long) constraintValue;
    }

    @Override
    public boolean validateMaxValue(Object fieldValue, Object constraintValue) {
        return ((Number) fieldValue).longValue() <= (Long) constraintValue;
    }

    @Override
    public boolean validateMinValueExclusive(Object fieldValue, Object constraintValue) {
        return ((Number) fieldValue).longValue() > (Long) constraintValue;
    }

    @Override
    public boolean validateMaxValueExclusive(Object fieldValue, Object constraintValue) {
        return ((Number) fieldValue).longValue() < (Long) constraintValue;
    }

    @Override
    public boolean validateMaxDigits(Object fieldValue, Object constraintValue) {
        long fieldNumericValue = ((Number) fieldValue).longValue();
        String numericString = Long.toString(fieldNumericValue);
        int length = fieldNumericValue < 0 ? numericString.length() - 1 : numericString.length();
        return length <= (Long) constraintValue;
    }

    @Override
    public boolean validateMaxIntegerDigits(Object fieldValue, Object constraintValue) {
        return true;
    }

    @Override
    public boolean validateMaxFractionDigits(Object fieldValue, Object constraintValue) {
        return true;
    }
}
