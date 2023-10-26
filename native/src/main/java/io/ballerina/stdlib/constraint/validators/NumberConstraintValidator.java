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

import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.stdlib.constraint.ConstraintErrorInfo;
import io.ballerina.stdlib.constraint.validators.interfaces.DigitsValidator;
import io.ballerina.stdlib.constraint.validators.interfaces.ValueValidator;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Extern functions for validating number constraints `@constraint:Number` of Ballerina.
 */
public class NumberConstraintValidator implements ValueValidator, DigitsValidator {

    private final List<ConstraintErrorInfo> failedConstraintsInfo;
    private DigitParts digitParts;

    public NumberConstraintValidator(List<ConstraintErrorInfo> failedConstraintsInfo) {
        this.failedConstraintsInfo = failedConstraintsInfo;
    }

    public void validate(BMap<BString, Object> constraints, Number fieldValue, String path, boolean isMemberValue) {
        for (Map.Entry<BString, Object> constraint : constraints.entrySet()) {
            DigitsValidator.super.checkDigitsConstraintValue(constraint, path);
            validate(constraint, fieldValue, isMemberValue, failedConstraintsInfo, path);
        }
    }

    @Override
    public void validate(Map.Entry<BString, Object> constraint, Object fieldValue, boolean isMemberValue,
                         List<ConstraintErrorInfo> failedConstraintsInfo, String path) {
        DigitsValidator.super.validate(constraint, fieldValue, isMemberValue, failedConstraintsInfo, path);
        ValueValidator.super.validate(constraint, fieldValue, isMemberValue, failedConstraintsInfo, path);
    }

    @Override
    public boolean validateMinValue(Object fieldValue, Object constraintValue) {
        return ((Number) fieldValue).doubleValue() >= ((BDecimal) constraintValue).value().doubleValue();
    }

    @Override
    public boolean validateMaxValue(Object fieldValue, Object constraintValue) {
        return ((Number) fieldValue).doubleValue() <= ((BDecimal) constraintValue).value().doubleValue();
    }

    @Override
    public boolean validateMinValueExclusive(Object fieldValue, Object constraintValue) {
        return ((Number) fieldValue).doubleValue() > ((BDecimal) constraintValue).value().doubleValue();
    }

    @Override
    public boolean validateMaxValueExclusive(Object fieldValue, Object constraintValue) {
        return ((Number) fieldValue).doubleValue() < ((BDecimal) constraintValue).value().doubleValue();
    }

    @Override
    public boolean validateMaxDigits(Object fieldValue, Object constraintValue) {
        return true;
    }

    @Override
    public boolean validateMaxIntegerDigits(Object fieldValue, Object constraintValue) {
        double fieldNumericValue = ((Number) fieldValue).doubleValue();
        if (Objects.isNull(digitParts)) {
            digitParts = getDigitPartsFromDouble(fieldNumericValue);
        }
        return digitParts.integerDigits() <= (Long) constraintValue;
    }

    @Override
    public boolean validateMaxFractionDigits(Object fieldValue, Object constraintValue) {
        double fieldNumericValue = ((Number) fieldValue).doubleValue();
        if (Objects.isNull(digitParts)) {
            digitParts = getDigitPartsFromDouble(fieldNumericValue);
        }
        return digitParts.fractionDigits() <= (Long) constraintValue;
    }
}
