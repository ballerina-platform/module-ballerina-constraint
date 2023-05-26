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

package io.ballerina.stdlib.constraint.validators.interfaces;

import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BRegexpValue;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.stdlib.constraint.ConstraintErrorInfo;
import org.ballerinalang.langlib.regexp.Matches;

import java.util.List;
import java.util.Map;

import static io.ballerina.stdlib.constraint.Constants.CONSTRAINT_PATTERN;
import static io.ballerina.stdlib.constraint.Constants.MESSAGE;
import static io.ballerina.stdlib.constraint.Constants.VALUE;

/**
 * The interface to validate the pattern related constraints.
 */
public interface PatternValidator {

    default void validate(Map.Entry<BString, Object> constraint, Object fieldValue, boolean isMemberValue,
                          List<ConstraintErrorInfo> failedConstraints, String path) {
        Object constraintValue = constraint.getValue();
        String message = null;
        if (constraintValue instanceof BMap) {
            message = ((BMap) constraintValue).getStringValue(MESSAGE).getValue();
            constraintValue = ((BMap) constraintValue).get(VALUE);
        }
        if (constraint.getKey().getValue().equals(CONSTRAINT_PATTERN)) {
            if (!validatePattern(fieldValue, constraintValue)) {
                failedConstraints.add(new ConstraintErrorInfo(path, message, CONSTRAINT_PATTERN, isMemberValue));
            }
        }
    }

    static boolean validatePattern(Object fieldValue, Object constraintValue) {
        return Matches.isFullMatch((BRegexpValue) constraintValue, StringUtils.fromString((String) fieldValue));
    }
}
