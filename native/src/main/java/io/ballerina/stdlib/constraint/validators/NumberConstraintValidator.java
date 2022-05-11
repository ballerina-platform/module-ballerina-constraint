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

import java.math.BigDecimal;
import java.util.Map;
import java.util.Set;

/**
 * Extern functions for validating number constraints `@constraint:Number` of Ballerina.
 */
public class NumberConstraintValidator extends AbstractValueValidator {

    public void validate(BMap<BString, Object> constraints, Number fieldValue, Set<String> failedConstraints) {
        for (Map.Entry<BString, Object> constraint : constraints.entrySet()) {
            BigDecimal constraintValue = ((BDecimal) constraint.getValue()).value();
            super.validate(constraint, fieldValue, constraintValue, failedConstraints);
        }
    }

    @Override
    boolean validateMinValue(Number fieldValue, Number constraintValue) {
        return fieldValue.doubleValue() >= constraintValue.doubleValue();
    }

    @Override
    boolean validateMaxValue(Number fieldValue, Number constraintValue) {
        return fieldValue.doubleValue() <= constraintValue.doubleValue();
    }

    @Override
    boolean validateMinValueExclusive(Number fieldValue, Number constraintValue) {
        return fieldValue.doubleValue() > constraintValue.doubleValue();
    }

    @Override
    boolean validateMaxValueExclusive(Number fieldValue, Number constraintValue) {
        return fieldValue.doubleValue() < constraintValue.doubleValue();
    }
}
