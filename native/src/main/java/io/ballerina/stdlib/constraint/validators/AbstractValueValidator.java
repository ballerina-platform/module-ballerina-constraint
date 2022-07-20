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

import io.ballerina.runtime.api.values.BString;

import java.util.List;
import java.util.Map;

import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MAX_VALUE;
import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MAX_VALUE_EXCLUSIVE;
import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MIN_VALUE;
import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MIN_VALUE_EXCLUSIVE;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SEPARATOR;

/**
 * The abstract class to validate the value related constraints.
 */
public abstract class AbstractValueValidator {

    public void validate(Map.Entry<BString, Object> constraint, Number fieldValue, Number constraintValue,
                         List<String> failedConstraints, String path) {
        switch (constraint.getKey().getValue()) {
            case CONSTRAINT_MIN_VALUE:
                if (!validateMinValue(fieldValue, constraintValue)) {
                    failedConstraints.add(path + SYMBOL_SEPARATOR + CONSTRAINT_MIN_VALUE);
                }
                break;
            case CONSTRAINT_MAX_VALUE:
                if (!validateMaxValue(fieldValue, constraintValue)) {
                    failedConstraints.add(path + SYMBOL_SEPARATOR + CONSTRAINT_MAX_VALUE);
                }
                break;
            case CONSTRAINT_MIN_VALUE_EXCLUSIVE:
                if (!validateMinValueExclusive(fieldValue, constraintValue)) {
                    failedConstraints.add(path + SYMBOL_SEPARATOR + CONSTRAINT_MIN_VALUE_EXCLUSIVE);
                }
                break;
            case CONSTRAINT_MAX_VALUE_EXCLUSIVE:
                if (!validateMaxValueExclusive(fieldValue, constraintValue)) {
                    failedConstraints.add(path + SYMBOL_SEPARATOR + CONSTRAINT_MAX_VALUE_EXCLUSIVE);
                }
                break;
            default:
                break;
        }
    }

    abstract boolean validateMinValue(Number fieldValue, Number constraintValue);

    abstract boolean validateMaxValue(Number fieldValue, Number constraintValue);

    abstract boolean validateMinValueExclusive(Number fieldValue, Number constraintValue);

    abstract boolean validateMaxValueExclusive(Number fieldValue, Number constraintValue);
}
