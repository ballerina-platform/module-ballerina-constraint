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
import io.ballerina.stdlib.constraint.validators.interfaces.ValueValidator;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MESSAGE;

/**
 * Extern functions for validating int constraints `@constraint:Int` of Ballerina.
 */
public class IntConstraintValidator implements ValueValidator {

    private final List<ConstraintErrorInfo> failedConstraintsInfo;

    public IntConstraintValidator(List<ConstraintErrorInfo> failedConstraintsInfo) {
        this.failedConstraintsInfo = failedConstraintsInfo;
    }

    public void validate(BMap<BString, Object> constraints, Number fieldValue, String path, boolean isMemberValue) {
        List<String> constraintFailures = new ArrayList<>();
        String message = null;
        for (Map.Entry<BString, Object> constraint : constraints.entrySet()) {
            if (constraint.getKey().getValue().equals(CONSTRAINT_MESSAGE)) {
                message = ((BString) constraint.getValue()).getValue();
            }
            validate(constraint, fieldValue, constraintFailures);
        }
        if (!constraintFailures.isEmpty()) {
            failedConstraintsInfo.add(new ConstraintErrorInfo(path, message, constraintFailures, isMemberValue));
        }
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
}
