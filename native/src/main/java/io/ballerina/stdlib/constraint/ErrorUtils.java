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

package io.ballerina.stdlib.constraint;

import io.ballerina.runtime.api.creators.ErrorCreator;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BError;

import java.util.Set;

/**
 * Utility functions related to errors.
 */
public class ErrorUtils {

    static BError buildError(Set<String> failedConstraints) {
        StringBuilder errorMsg = new StringBuilder("Validation failed for ");
        for (String constraint : failedConstraints) {
            errorMsg.append("'").append(constraint).append("',");
        }
        errorMsg.deleteCharAt(errorMsg.length() - 1);
        errorMsg.append(" constraint(s).");
        return createError(errorMsg.toString());
    }

    private static BError createError(String errMsg) {
        return ErrorCreator.createDistinctError(Constants.CONSTRAINT_ERROR, ModuleUtils.getModule(),
                StringUtils.fromString(errMsg));
    }
}
