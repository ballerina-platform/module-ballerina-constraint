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
import io.ballerina.stdlib.constraint.InternalValidationException;

import java.util.List;
import java.util.Map;

import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_LENGTH;
import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MAX_LENGTH;
import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_MIN_LENGTH;
import static io.ballerina.stdlib.constraint.Constants.SYMBOL_SEPARATOR;

/**
 * The abstract class to validate the length related constraints.
 */
public abstract class AbstractLengthValidator {

    public void validate(BMap<BString, Object> constraints, Object fieldValue, List<String> failedConstraints,
                         String path) {
        for (Map.Entry<BString, Object> constraint : constraints.entrySet()) {
            long constraintValue = (long) constraint.getValue();
            String constraintFiled = constraint.getKey().getValue();
            checkLengthConstraintValue(constraintFiled, constraintValue, path);
            switch (constraintFiled) {
                case CONSTRAINT_LENGTH:
                    if (!validateLength(fieldValue, constraintValue)) {
                        failedConstraints.add(path + SYMBOL_SEPARATOR + CONSTRAINT_LENGTH);
                    }
                    break;
                case CONSTRAINT_MIN_LENGTH:
                    if (!validateMinLength(fieldValue, constraintValue)) {
                        failedConstraints.add(path + SYMBOL_SEPARATOR + CONSTRAINT_MIN_LENGTH);
                    }
                    break;
                case CONSTRAINT_MAX_LENGTH:
                    if (!validateMaxLength(fieldValue, constraintValue)) {
                        failedConstraints.add(path + SYMBOL_SEPARATOR + CONSTRAINT_MAX_LENGTH);
                    }
                    break;
                default:
                    break;
            }
        }
    }

    static void checkLengthConstraintValue(String constraintField, long constraintValue, String path) {
        if (constraintValue <= 0) {
            throw new InternalValidationException("invalid value found for " + path + SYMBOL_SEPARATOR +
                                                  constraintField + " constraint. Length constraints should be " +
                                                  "positive");
        }
    }

    abstract boolean validateLength(Object fieldValue, long constraintValue);

    abstract boolean validateMinLength(Object fieldValue, long constraintValue);

    abstract boolean validateMaxLength(Object fieldValue, long constraintValue);
}
